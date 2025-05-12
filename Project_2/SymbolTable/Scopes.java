import java.util.HashMap;
import java.util.Map;
class Info {
    private int size;
    private String type;
    private String RetType;
    Info(int size, String type,String RetType) {
        this.size = size;
        this.type = type;
        this.RetType = RetType;
    }
    Info(int size, String type) {
        this.size = size;
        this.type = type;
        this.RetType = null;
    }
    public String GetType() {
        return this.type;
    }

    public int GetSize() {
        return this.size;
    }
    public String GetRetType(){
        return this.RetType;
    }
}
class ST{ 
    private Map<String, Info> table;
    private ST parent;  //If say a class extends we use this to look up 

    public ST(ST parent) {
        this.table = new HashMap<>();
        this.parent = parent;
    }
    public ST() {
        this.table = new HashMap<>();
        this.parent = null;
    }
    public void insert(String name, int size, String type) {
        table.put(name, new Info(size, type));
    }
    public void insert(String name, int size, String type,String RetType) {
        table.put(name, new Info(size, type,RetType));
    }
    public Info lookup(String name) {
        Info info = table.get(name);
        if (info != null) return info;
        if (parent != null) return parent.lookup(name);
        return null;
    }
    public ST getParent() {
        return this.parent;
    }
}
public class Scopes{
    private Map<String, ST> Tables; //Class name->symbol table
    private ST CurrentScope;
    public Scopes() {
        this.Tables = new HashMap<>();
    }
    public void enter(String cls, ST parent){
        if (!Tables.containsKey(cls)) {
            ST newScope = new ST(parent);           
            this.Tables.put(cls, newScope);         
            this.CurrentScope = newScope;           
        }
    }
    public void insert(String name, int size, String type){
        this.CurrentScope.insert(name, size, type);
    }
    public Info lookup(String name) {
        if (CurrentScope != null) {
            return CurrentScope.lookup(name);
        }
        return null;
    }
    public void exit() {
        if (this.CurrentScope != null) {
            this.CurrentScope = this.CurrentScope.getParent();
        }
    }
    public ST getCurrentScope() {
        return this.CurrentScope;
    }
    public ST getClassScope(String cls) {
        return Tables.get(cls);
    }
}