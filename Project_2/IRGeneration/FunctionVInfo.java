package IRGeneration;
import java.util.*;
public class FunctionVInfo{
    private final int offset; //offset of function
    private final String retType; //The type it returns 
    private final List<String> arguments;// List of arhuments
    public FunctionVInfo(int offset, String retType,List<String> arguments){
        this.offset = offset;
        this.retType = retType;
        this.arguments = arguments;
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
}