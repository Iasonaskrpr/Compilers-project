import java.util.List;
public class Info {
    private int size; // -1: variable, 0: uninitialized variable or array, >1: array
    private int offset;
    private String type;
    private String retType;
    private List<String> paramTypes; // for methods only

    // Constructor for methods
    Info(String retType, List<String> paramTypes,int offset) {
        this.size = -1;  // Not applicable for methods
        this.type = "method";
        this.retType = retType;
        this.paramTypes = paramTypes;
        this.offset = offset;
    }
    // Constructor for arrays
    Info(int size, String type, int offset) {
        this.size = size;
        this.type = type;
        this.offset = offset;
        this.retType = null;
        this.paramTypes = null;
    }

    public boolean isMethod() {
        return "method".equals(this.type);
    }

    public List<String> getParamTypes() {
        return this.paramTypes;
    }

    public String getType() {
        return this.type;
    }

    public int getSize() {
        return this.size;
    }

    public String getRetType() {
        return this.retType;
    }

    public void changeSize(int size) {
        this.size = size;
    }
    public int getOffset(){
        return this.offset;
    }
}