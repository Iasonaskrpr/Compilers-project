import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ST {
    private final Map<String, Info> table;
    private final ST parent;
    private String name; // Name of the class or scope
    
    public ST(ST parent) {
        this.table = new HashMap<>();
        this.parent = parent;
    }

    public ST(String name, ST parent) {
        this(parent);
        this.name = name;
    }

    public ST() {
        this(null);
    }

    public void insert(String name, int size, String type,int offset) {
        table.put(name, new Info(size, type,offset));
    }
    public void insertMethod(String name, String retType, List<String> paramTypes,int offset) {
        table.put(name, new Info(retType, paramTypes,offset));
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
    public void PrintOffsets(String cls){
        System.out.println("---Variables---");
        for (Map.Entry<String,Info> i : this.table.entrySet()){
            if(!i.getValue().isMethod()){System.out.println(cls+"."+i.getKey()+" : " + i.getValue().getOffset());} 
        }
        System.out.println("---Methods---");
        for (Map.Entry<String,Info> i : this.table.entrySet()){
            if(i.getValue().isMethod()){System.out.println(cls+"."+i.getKey()+" : " + i.getValue().getOffset());} 
        }
    }
}
