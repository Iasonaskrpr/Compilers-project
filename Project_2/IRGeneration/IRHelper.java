package IRGeneration;
import java.io.*;
import java.util.*;
public class IRHelper{
    private OutputStream f;
    private int labelcount; 
    private int varcount;
    // Initializes variables and opens a new output stream
    public IRHelper(String filename) {
        labelcount = 0;
        varcount = 0;
        if (!filename.endsWith(".ll")) {
            throw new IllegalArgumentException("Filename must end with .ll");
        }
        try {
            f = new FileOutputStream(filename);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Emits command to the .ll file
    public void emit(String command){
        try{
            f.write(command.getBytes());
        }
        catch(IOException e){
            e.printStackTrace();
        }
    }
    // Generates a new label
    public String new_label(){
        String label = "L"+labelcount+":";
        labelcount += 1;
        return label;
    }
    // Generates a new variable
    public String new_var(){
        String var = "%_"+varcount;
        varcount += 1;
        return var;
    }
    // Emits vtable and necessary functions
    public void startGeneration(Map<String ,Map<String , FunctionVInfo>> vtable){
        for(Map.Entry<String, Map<String, FunctionVInfo>> classEntry : vtable.entrySet()){
            String entries = Integer.toString(classEntry.getValue().size());
            String tablename = "@."+classEntry.getKey()+"_vtable = global [" + entries +" x i8*] [";
            Map<String, FunctionVInfo> functions = classEntry.getValue();
            for (Map.Entry<String, FunctionVInfo> methodEntry : functions.entrySet()){
                //Add return types for each function, convert argument to llvm types
            }
            tablename = tablename+ "]\n";
            this.emit(tablename);
        }
        this.emit("declare i8* @calloc(i32, i32)\n");
        this.emit("declare i32 @printf(i8*, ...)\n");
        this.emit("declare void @exit(i32)\n");
        this.emit("@_cint = constant [4 x i8] c\"%d\0a\00\"\n");
        this.emit("@_cOOB = constant [15 x i8] c\"Out of bounds\0a\00\"\n");
        this.emit("define void @print_int(i32 %i) {\n\t%_str = bitcast [4 x i8]* @_cint to i8*\n\tcall i32 (i8*, ...) @printf(i8* %_str, i32 %i)\n\tret void\n}");
        this.emit("define void @throw_oob() {\n%_str = bitcast [15 x i8]* @_cOOB to i8*\n\tcall i32 (i8*, ...) @printf(i8* %_str)\n\tcall void @exit(i32 1)\n\tret void\n}");
    }
}
