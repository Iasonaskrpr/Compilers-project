import java.util.HashMap;
import java.util.Map;
class Info{
    int size;
    String Type;
    Info(int s,String t){
        size = s;
        Type = t;
    }
}
public class ST{ //We use linked hashmaps for implementing 
    private Map<String, Info> table;
    private ST parent;  

    public ST(ST parent) {
        this.table = new HashMap<>();
        this.parent = parent;
    }
    public void insert(String n,int s,String t){
        Info entry = new Info(s,t);
        table.put(n,entry);
    }
    public lookup(String n)


}