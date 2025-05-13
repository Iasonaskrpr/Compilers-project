import java.util.List;
public class Info {
    private int size; // -1: variable, 0: uninitialized array, >1: array
    private String type;
    private String retType;
    private List<String> paramTypes; // for methods only

    // Constructor for methods
    Info(String retType, List<String> paramTypes) {
        this.size = -1;  // Not applicable for methods
        this.type = "method";
        this.retType = retType;
        this.paramTypes = paramTypes;
    }

    // Constructor for variables
    Info(int size, String type) {
        this(size, type, null);
    }

    // Constructor for arrays (with optional return type)
    Info(int size, String type, String retType) {
        this.size = size;
        this.type = type;
        this.retType = retType;
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
}