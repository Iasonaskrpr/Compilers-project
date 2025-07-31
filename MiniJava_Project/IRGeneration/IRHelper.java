package IRGeneration;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
public class IRHelper{
    private OutputStream f;
    private int iflabelcount; 
    private int ooblabelcount;
    private int looplabelcount;
    private int varcount;
    private final Map<String,ClassVariables> Vars;
    private final Map<String ,Map<String , FunctionVInfo>> vtable;
    private int block_count; //Used to keep track of blocks 
    private Map<String,String> VariableTypes; //Used to store variables of the method
    // Initializes variables and opens a new output stream
    public IRHelper(String filename,Map<String ,Map<String , FunctionVInfo>> vtable,Map<String,ClassVariables> Vars) {
        iflabelcount = 0;
        looplabelcount = 0;
        ooblabelcount = 0;
        varcount = 0;
        block_count = 0;
        VariableTypes = new HashMap<>();
        this.vtable = vtable;
        if (!filename.endsWith(".ll")) {
            throw new IllegalArgumentException("Filename must end with .ll");
        }
        try {
            f = new FileOutputStream(filename);
        } catch (IOException e) {
            e.printStackTrace();
        }
        this.Vars = Vars;
        this.startGeneration(vtable);
    }
    public String getLLVMType(String var){
        String retType;
        switch(var) {
            case "int":
                retType = "i32";
                break;
            case "boolean":
                retType = "i1";
                break;
            case "boolean[]":
                retType = "%BooleanArray*";
                break;
            case "int[]":
                retType = "%IntArray*";
                break;
            default:
                // Returns a class pointer
                retType = "i8*";
                break;
        }
        return retType;
    }
    // Emits command to the .ll file
    public void emit(String command){
        command = "\t".repeat(this.block_count)+command;
        try{
            f.write(command.getBytes());
        }
        catch(IOException e){
            e.printStackTrace();
        }
    }
    //Emit without the tabs
    public void emitlabel(String label){
        label = "\n"+label+":\n"; //Added spaces to make block easier to spot
        try{
            f.write(label.getBytes());
        }
        catch(IOException e){
            e.printStackTrace();
        }
    }
    // Generates a new if label
    public String new_if_label(){
        String label = "if"+iflabelcount;
        iflabelcount += 1;
        return label;
    }
    public String new_oob_label(){
        String label = "oob"+ooblabelcount;
        ooblabelcount += 1;
        return label;
    }
    public String new_loop_label(){
        String label = "loop"+looplabelcount;
        looplabelcount += 1;
        return label;
    }
    // Generates a new variable
    public String new_var(){
        String var = "%_"+varcount;
        varcount += 1;
        return var;
    }
    // Emits vtable and necessary functions
    private void startGeneration(Map<String ,Map<String , FunctionVInfo>> vtable){
        //TODO: Extract all class and variables and create a type for each one
        for(Map.Entry<String, Map<String, FunctionVInfo>> classEntry : vtable.entrySet()){
            String entries = Integer.toString(classEntry.getValue().size());
            String tablename = "@."+classEntry.getKey()+"_vtable = global [" + entries +" x i8*] [";
            Map<String, FunctionVInfo> functions = classEntry.getValue();
            for (Map.Entry<String, FunctionVInfo> methodEntry : functions.entrySet()){
                tablename= tablename + "i8* bitcast (";
                String type = getLLVMType(methodEntry.getValue().getRet());
                tablename += type+(" (i8*");
                List<String> argList = methodEntry.getValue().getArguments();
                for(String arg : argList){
                    type = getLLVMType(arg);
                    tablename += ","+type;
                }
                tablename+=")* ";
                if(methodEntry.getValue().isInherited()){
                    tablename+= "@"+ methodEntry.getValue().getParent();
                }
                else{
                    tablename+= "@"+ classEntry.getKey();
                }
                tablename+="."+methodEntry.getKey()+" to i8*),";
            }
            tablename = tablename.substring(0,tablename.length()-1); //Drop last comma
            tablename = tablename+ "]\n";
            this.emit(tablename);
        }
        for(Map.Entry<String,ClassVariables> cls : Vars.entrySet()){
            String classDecl = "%class."+cls.getKey()+" = type{";
            String Parent = cls.getValue().getSuper();
            if(Parent != null){
                classDecl += " %class."+Parent+",";
            }
            Map<String,VarInfo> varTable = cls.getValue().getVarMap();
            for(Map.Entry<String,VarInfo> varEntry : varTable.entrySet()){
                String type = getLLVMType(varEntry.getValue().getType());
                classDecl += " "+ type+",";
            }
            if(classDecl.endsWith(",")){
                classDecl = classDecl.substring(0, classDecl.length() - 1);
            }
            classDecl += " }\n";
            this.emit(classDecl);
        }
        this.emit("%IntArray = type { i32, i32* }\n");
        this.emit("%BooleanArray = type { i32, i8* }\n");
        this.emit("declare i8* @calloc(i32, i32)\n");
        this.emit("declare i32 @printf(i8*, ...)\n");
        this.emit("declare void @exit(i32)\n");
        this.emit("@_cint = constant [4 x i8] c\"%d\\0A\\00\"\n");
        this.emit("@_cOOB = constant [15 x i8] c\"Out of bounds\\0A\\00\"\n");
        this.emit("define void @print_int(i32 %i) {\n\t%_str = bitcast [4 x i8]* @_cint to i8*\n\tcall i32 (i8*, ...) @printf(i8* %_str, i32 %i)\n\tret void\n}\n");
        this.emit("define void @throw_oob() {\n\t%_str = bitcast [15 x i8]* @_cOOB to i8*\n\tcall i32 (i8*, ...) @printf(i8* %_str)\n\tcall void @exit(i32 1)\n\tret void\n}\n");
    }
    //Used to keep track of blocks to produce clean and readable llvm code with correct indentation
    public void enter_block(){
        block_count+=1;
    }
    public void exit_block(){
        block_count-=1;
    }
    public void addVariable(String var,String type){
        VariableTypes.put(var, type);
    }
    public String getVariableType(String var){
        return VariableTypes.get(var);
    }
    public String idToTempVar(IRData var){ //Generates a temporary variable and returns it to whoever needs it
        String tempVar = this.new_var();
        String type = getVariableType(var.getData()); //Get the variable type
        this.emit(tempVar+" = load "+ type +", ptr %"+var.getData()); 
        return tempVar;
    }
}
