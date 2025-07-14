package symbolTable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Comparator;
public class ST {
    private final Map<String, Info> table;
    private final ST parent;
    private String name; // Name of the class or scope
    private int varOffset;
    private int methodOffset;
    private boolean classFlag; 
    public ST(ST parent) {
        this.table = new HashMap<>();
        this.parent = parent;
        this.varOffset = 0;
        this.methodOffset = 0;
    }

    public ST(String name, ST parent,boolean cls) {
        this(parent);
        this.name = name;
        this.classFlag = cls;
    }

    public ST() {
        this(null);
    }

    public void insert(String name, String type) {
        table.put(name, new Info(type,this.varOffset));
    }
    public void insertMethod(String name, String retType, List<String> paramTypes) {
        table.put(name, new Info(retType, paramTypes,this.methodOffset));
    }

    public Info lookup(String name) {
        Info info = table.get(name);
        if (info != null) return info;
        if (parent != null) return parent.lookup(name);
        return null;
    }

    public boolean varExistsLocally(String name) {
        return table.containsKey(name) && table.get(name).getRetType() == null;
    }

    public String methodExistsLocally(String name) {
        Info info = table.get(name);
        return (info != null && info.getRetType() != null) ? info.getRetType() : null;
    }
    public ST getParent() {
        return this.parent;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Info getMethodInfo(String name) {
        Info info = table.get(name);
        if (info != null && info.getRetType() != null) return info;
        return null;
    }
    public void PrintOffsets(String cls) {
        if (!this.classFlag) return;
        System.out.println("-----------Class " + cls + "-----------");

        // Sort and print variables
        System.out.println("--Variables---");
        table.entrySet().stream()
            .filter(e -> !e.getValue().isMethod() && !e.getKey().equals("this"))
            .sorted(Comparator.comparingInt(e -> e.getValue().getOffset()))
            .forEach(e ->
                System.out.println(cls + "." + e.getKey() + " : " + e.getValue().getOffset())
            );

        // Sort and print methods
        System.out.println("---Methods---");
        table.entrySet().stream()
            .filter(e -> e.getValue().isMethod())
            .sorted(Comparator.comparingInt(e -> e.getValue().getOffset()))
            .forEach(e ->
                System.out.println(cls + "." + e.getKey() + " : " + e.getValue().getOffset())
            );
    }
    public void addPointer(){
        this.varOffset+=8;
    }
    public void addBool(){
        this.varOffset+=1;
    }
    public void addInt(){
        this.varOffset+=4;
    }
    public void addMethod(){
        this.methodOffset+=8;
    }
    public void updateOffset(int var,int meth){
        this.methodOffset=meth;
        this.varOffset = var;
    }
    public int getVar(){
        return this.varOffset;
    }
    public int getMethod(){
        return this.methodOffset;
    }
    public Map<String, Info> getTable(){
        return this.table;
    }
    public boolean isClass(){
        return this.classFlag;
    }
}