package IRGeneration;
import java.util.*;
public class FunctionVInfo{
    private final int offset; //offset of function
    private final String retType; //The type it returns 
    private final List<String> arguments;// List of arhuments
    private final boolean inherited; //Bool to show if function has been inherited 
    private final String parent_Class; //String to show parent class
    public FunctionVInfo(int offset, String retType,List<String> arguments,boolean inherited, String parent_Class){
        this.offset = offset;
        this.retType = retType;
        this.arguments = arguments;
        this.inherited = inherited;
        this.parent_Class = parent_Class;
    }
    public int getOffset(){
        return this.offset;
    }
    public String getRet(){
        return this.retType;
    }
    public List<String> getArguments(){
        return this.arguments;
    }
    public boolean isInherited(){
        return this.inherited;
    }
    public String getParent(){
        return this.parent_Class;
    }
}