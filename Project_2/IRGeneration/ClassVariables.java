package IRGeneration;
import java.util.*;
public class ClassVariables{
    private final Map<String,VarInfo> Variables;
    private final String Parent;
    public ClassVariables(String Parent){
        Variables = new HashMap<>();
        this.Parent = Parent;
    }
    public String getSuper(){
        return Parent;
    }
    public void addVariable(String name,Integer offset,String type,String Parent){
        if(!Variables.containsKey(name)){
            VarInfo v = new VarInfo(offset,type,Parent);
            Variables.put(name,v);
        }
    }
    public int getVarOffset(String name){
        return Variables.get(name).getOffset();
    }
    public String getVarType(String name){
        return Variables.get(name).getType();
    }
    public String whereToLook(String name){
        return Variables.get(name).getParent();
    }
    public Map<String,VarInfo> getVarMap(){
        return this.Variables;
    }
}