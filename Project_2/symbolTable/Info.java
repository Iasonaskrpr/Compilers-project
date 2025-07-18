package symbolTable;
import java.util.List;
public class Info {
    private int offset;
    private String type;
    private String retType;
    private List<String> paramTypes; // for methods only

    // Constructor for methods
    Info(String retType, List<String> paramTypes,int offset) {
        this.type = "method";
        this.retType = retType;
        this.paramTypes = paramTypes;
        this.offset = offset;
    }
    // Constructor for variables
    Info(String type, int offset) {
        this.type = type;
        this.offset = offset;
        this.retType = null;
        this.paramTypes = null;
    }

    public boolean isMethod() {
        return this.type.equals("method");
    }

    public List<String> getParamTypes() {
        return this.paramTypes;
    }

    public String getType() {
        return this.type;
    }

    public String getRetType() {
        return this.retType;
    }
    public int getOffset(){
        return this.offset;
    }
}