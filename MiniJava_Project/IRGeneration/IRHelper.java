package IRGeneration;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Comparator;
import java.util.stream.Collectors;
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
    private Map<String,String> params; //Map used to allocate parameters
    private String LastMethodCallClass;
    private boolean emit;
    private String CurClass;
    // Initializes variables and opens a new output stream
    public IRHelper(String filename,Map<String ,Map<String , FunctionVInfo>> vtable,Map<String,ClassVariables> Vars) {
        iflabelcount = 0;
        looplabelcount = 0;
        ooblabelcount = 0;
        varcount = 0;
        block_count = 0;
        VariableTypes = new HashMap<>();
        emit = true;
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
                retType = "%BooleanArray";
                break;
            case "int[]":
                retType = "%IntArray";
                break;
            case "void":
                retType = var;
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
        if(command.equals("")){
            return;
        }
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
            if(tablename.endsWith(",")){
                tablename = tablename.substring(0,tablename.length()-1); //Drop last comma
            }
            tablename = tablename+ "]\n";
            this.emit(tablename);
        }
        for(Map.Entry<String,ClassVariables> cls : Vars.entrySet()){
            String classDecl = "%class."+cls.getKey()+" = type{i8**,";
            String Parent = cls.getValue().getSuper();
            if(Parent != null){
                classDecl += " %class."+Parent+",";
            }
            Map<String,VarInfo> varTable = cls.getValue().getVarMap();
            classDecl += " " + varTable.entrySet().stream()
                .sorted(Comparator.comparingInt(e -> e.getValue().getOffset()))
                .map(e -> getLLVMType(e.getValue().getType()))
                .collect(Collectors.joining(", "));
            while(classDecl.endsWith(", ")){
                classDecl = classDecl.substring(0, classDecl.length() - 2);
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
    public String getVariableType(IRData var){ 
        String ret = VariableTypes.get(var.getData());
        if(ret == null){
            VarInfo classVar;
            String cls = CurClass;
            while(Vars.containsKey(cls)){
                classVar = this.getClassVar(var.getData(),cls);
                if(classVar != null){
                    return getLLVMType(classVar.getType());
                }
                cls = Vars.get(cls).getSuper();
            }
        }
        if(ret == null){
            ret = this.params.get(var.getData());
        }
        return ret;
    }
    public String getVariableClass(String var){ 
        String ret = VariableTypes.get(var);
        if(ret == null){
            VarInfo classVar;
            String cls = CurClass;
            while(Vars.containsKey(cls)){
                classVar = this.getClassVar(var,cls);
                if(classVar != null){
                    return classVar.getType();
                }
                cls = Vars.get(cls).getSuper();
            }
        }
        if(ret == null ){
            ret = this.params.get(var);
        }
        if(var.startsWith("%") && ret == null){
            ret = this.LastMethodCallClass;
        }
        if(ret.startsWith("%class")){
            ret = ret.substring(7);
        }
        return ret;
    }
    public void exitClass(){
        VariableTypes.clear();
    }
    public String idToTempVar(IRData var){ //Generates a temporary variable and returns it to whoever needs it
        if(this.VariableTypes.containsKey(var.getData())){
            String tempVar = this.new_var();
            String type = getVariableType(var); //Get the variable type
            if(isClass(type)){
                type = "%class." + type + "*";
            }
            this.emit(tempVar+" = load "+ type +", "+type+"* %"+var.getData()+"\n"); 
            return tempVar;
        }
        VarInfo classVar;
        String cls = CurClass;
        String tmp = "%this";
        String command = "";
        while(Vars.containsKey(cls)){
            classVar = this.getClassVar(var.getData(),cls);
            if(classVar != null){
                String ptr = new_var();
                String retVar = new_var();
                this.emit(command);
                this.emit(ptr+" = getelementptr %class."+cls+", %class."+cls+"* "+tmp+", i32 0, i32 "+ (Vars.get(cls).getVar(var.getData()).getOffset()+1) +"\n");
                this.emit(retVar+ " = load "+getLLVMType(classVar.getType())+", "+getLLVMType(classVar.getType())+"* "+ptr+"\n");
                return retVar;
            }
            String oldtmp = tmp;
            tmp = new_var();
            command = command +  tmp+" = getelementptr %class."+cls+", %class."+cls+"* "+ oldtmp+", i32 0, i32 0\n";
            cls = Vars.get(cls).getSuper();
            
        }
        return var.getData();//Return original variable in case it is not a java variable
        
    }
    public void EnterClass(String cls){
        this.CurClass = cls;
    }
    public String getCurClass(){
        return this.CurClass;
    }
    public void toggleEmit(){
        this.emit = !this.emit;
    }
    public boolean shouldEmit(){
        return this.emit;
    }
    public VarInfo getClassVar(String name){
        ClassVariables c = this.Vars.get(this.CurClass);
        if(c == null) {return null;}
        return c.getVar(name);
    }
    public VarInfo getClassVar(String name,String cls){
        ClassVariables c = this.Vars.get(cls);
        if(c == null) {return null;}
        return c.getVar(name);
       
    }
    public String classVarToTempVar(IRData var){
        VarInfo classVar;
        String cls = CurClass;
        String tmp = "%this";
        String command = "";
        while(Vars.containsKey(cls)){
            classVar = this.getClassVar(var.getData(),cls);
            if(classVar != null){
                String retVar = new_var();
                this.emit(command);
                this.emit(retVar + " = getelementptr %class."+cls+", %class."+cls+"* "+ tmp+", i32 0, i32 "+ (classVar.getOffset()+1) +"\n");
                return retVar;
            }
            String oldtmp = tmp;
            tmp = new_var();
            command = command + tmp+" = getelementptr %class."+cls+", %class."+cls+"* "+ oldtmp+", i32 0, i32 0\n";
            cls = Vars.get(cls).getSuper();
        }
        return null;
    }
    public void new_method(){
        this.params = new HashMap<>();
    }
    public void addParam(String name, String cls){
        this.params.put(name, cls);
    }
    public Map<String, String> getParams(){
        return this.params;
    }
    public String getMethodLoadCommand(String cls, String Method,String vtbl_ptr_ptr){
        FunctionVInfo meth = this.vtable.get(cls).get(Method);
        String methodOffset = Integer.toString(meth.getOffset()/8);
        String vtbl_ptr = new_var();
        String vtbl = new_var();
        if(!vtbl_ptr_ptr.equals("%this") && !vtbl_ptr_ptr.startsWith("%_")){
            String vtbl_p = new_var();
            emit(vtbl_p + " = load %class."+cls+"*, %class."+cls+"** "+vtbl_ptr_ptr+"\n");
            vtbl_ptr_ptr = vtbl_p;
        }
        
        emit(vtbl_ptr + " = getelementptr %class."+cls+", %class."+cls+"* "+vtbl_ptr_ptr+ ", i32 0, i32 0\n");
        emit(vtbl + " = load i8**, i8*** "+vtbl_ptr+"\n");
        String command = "getelementptr i8*, i8** "+vtbl+", i32 "+methodOffset+ "\n";
        return command;
    }
    public String getVtableSize(String cls){
        return Integer.toString(this.vtable.get(cls).size());
    }
    public String getMethodCallCommand(String cls, String Method,String var){
        FunctionVInfo meth = this.vtable.get(cls).get(Method);
        String command = "bitcast i8* " + var + " to "+getLLVMType(meth.getRet())+"(i8*";
        List<String> arguments = meth.getArguments();
        for (String arg : arguments) {
            command = command+", "+getLLVMType(arg);
        }
        command+=")*\n";
        return command;
    }
    public String getMethodRetType(String cls, String Method){
        return getLLVMType(this.vtable.get(cls).get(Method).getRet());
    }
    public String getMethodRawRetType(String cls, String Method){
        return this.vtable.get(cls).get(Method).getRet();
    }
    public List<String> getMethodArgs(String cls, String method){
        return this.vtable.get(cls).get(method).getArguments();
    }
    public boolean isClass(String name){
        return this.vtable.containsKey(name);
    }
    public void lastCallClass(String cls){
        this.LastMethodCallClass = cls;
    }
}
