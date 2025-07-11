package symbolTable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class Scopes {
    private final Map<String, ST> tables; // ClassName → SymbolTable
    private ST currentScope; 
    public Scopes() {
        this.tables = new HashMap<>();
    }

    public boolean enter(String cls, ST parent,boolean flag,boolean isClass) { //flag used to carry scope offset
        if (!tables.containsKey(cls)) {
            ST newScope = new ST(cls,parent,isClass);
            tables.put(cls, newScope);
            if(!flag){
                newScope.updateOffset(parent.getVar(), parent.getMethod());
            }
            currentScope = newScope;
            return true;
        }
        return false;
    }
    public boolean enterScopeByName(String cls){
        this.currentScope = tables.get(cls);
        return this.currentScope!=null;
    }
    public String getClassName(){
        return this.currentScope.getName();
    }
    public void insert(String name, String retType, List<String> paramTypes){
        if (currentScope != null) {
            currentScope.insertMethod(name, retType,paramTypes);
            currentScope.addMethod();
        }
    }
    public void insert(String name,String type) {
        if (currentScope != null) {
            currentScope.insert(name, type);
            if(!name.equals("this")){
                if(type.equals("boolean")){currentScope.addBool();}
                else if(type.equals("int")){currentScope.addInt();}
                else{currentScope.addPointer();}
            }
        }
    }

    public Info lookup(String name) {
        return (currentScope != null) ? currentScope.lookup(name) : null;
    }

    public void exit() {
        if (currentScope != null) {
            currentScope = currentScope.getParent();
        }
    }
    public ST getCurrentScope() {
        return currentScope;
    }

    public ST getClassScope(String cls) {
        return tables.get(cls);
    }

    private Info safeLookup(String name, ST scope) {
        return (scope != null) ? scope.lookup(name) : null;
    }


     // ========= Type Checks =========
    public boolean isInt(String name) {
        return isInt(name, currentScope);
    }

    public boolean isInt(String name, ST scope) {
        Info i = safeLookup(name, scope);
        return i != null && "int".equals(i.getType());
    }

    public boolean isBool(String name) {
        return isBool(name, currentScope);
    }

    public boolean isBool(String name, ST scope) {
        Info i = safeLookup(name, scope);
        return i != null && "boolean".equals(i.getType());
    }

    // ========= Existence =========
    public boolean exists(String name) {
        return exists(name, currentScope);
    }

    public boolean exists(String name, ST scope) {
        return safeLookup(name, scope) != null;
    }

    public boolean existsInScope(String name, ST scopeName) {
        return exists(name, scopeName);
    }

    // ========= Type Retrieval =========
    public String getDeclaredType(String name) {
        return getDeclaredType(name, currentScope);
    }

    public String getDeclaredType(String name, ST scope) {
        Info i = safeLookup(name, scope);
        return (i != null) ? i.getType() : null;
    }
    public boolean methodExists(ST classScope, String methodName, List<String> paramTypes) {
        Info method = (classScope != null) ? classScope.lookup(methodName) : null;

        if (method != null && method.isMethod()) {
        List<String> param = method.getParamTypes();  // expected parameter types
        if (param.size() != paramTypes.size()) return false;

        for (int i = 0; i < param.size(); i++) {
            String expected = param.get(i);
            String actual = paramTypes.get(i);  // type of the actual argument
            if (!isSubtype(expected, actual)) {
                return false;
            }
        }
        return true;  // all parameters match
    }
        return false;
    }
    public boolean methodExistsForOverride(ST classScope, String methodName, List<String> paramTypes) {
        Info method = (classScope != null) ? classScope.lookup(methodName) : null;
        if(method != null && method.isMethod()) {
            return true;
        } 
        return false;
    }
    public String getMethodReturnType(String className, String methodName, List<String> paramTypes) {
        ST classScope = getClassScope(className);
        Info method = (classScope != null) ? classScope.lookup(methodName) : null;

        if (method != null && method.isMethod() && method.getParamTypes().equals(paramTypes)) {
            return method.getRetType();
        }
        return method.getRetType();
    }
    public boolean ClassExists(String Name){
        return this.tables.containsKey(Name);
    }
    public boolean varExistsInCurrentScope(String name) {
        if (currentScope == null) return false;
        return currentScope.varExistsLocally(name);
    }
    public String methodExistsInCurrentScope(String name){
        if (currentScope == null) return null;
        return currentScope.methodExistsLocally(name);
    }
    public boolean isValidOverride(ST classScope, String methodName, String returnType, List<String> paramTypes) {
        ST parentScope =classScope.getParent();
        if(classScope.methodExistsLocally(methodName)!=null){
            return false;
        }
        while (parentScope != null) {
            Info parentMethod = parentScope.lookup(methodName);
            if (parentMethod != null && parentMethod.isMethod()) {
                return parentMethod.getRetType().equals(returnType) &&
                    parentMethod.getParamTypes().equals(paramTypes);
            }
            parentScope = parentScope.getParent();
        }
        return true; // No conflict in parent → allowed
    }
    public void PrintOffset(){
        for (Map.Entry<String,ST> i : this.tables.entrySet()){
            i.getValue().PrintOffsets(i.getKey());
        }
    }
    public boolean isSubtype(String superClass,String subClass){
        if (superClass.equals(subClass)) return true;
        ST sub = tables.get(subClass);
        if(sub!=null){
            sub.getParent();
        }
        while(sub!=null){
            if(sub.getName().equals(superClass)){
                return true;
            }
            sub = sub.getParent();
        }
        return false;
    }
    public Map<String,Map<String,Integer>> getVTables(){
        Map<String, Map<String,Integer>> VTables = new HashMap<>();
        //Iterate over each symbol table and get offset of methods and add to v-table, return it and give it as an argument to the constructor of the file that calls the IR visitor which starts
        //by creating vtables and declaring necessary methods and the calling the visitor
        for(Map.Entry<String,ST> set : this.tables.entrySet()){
            Map<String, Integer> table = new HashMap<>();

        }
    }
}