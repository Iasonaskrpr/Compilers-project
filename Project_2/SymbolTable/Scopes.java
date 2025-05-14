import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Scopes {
    private final Map<String, ST> tables; // ClassName → SymbolTable
    private ST currentScope;
    private int varOffset;
    private int methodOffset; 
    public Scopes() {
        this.varOffset = 0;
        this.methodOffset = 0;
        this.tables = new HashMap<>();
    }

    public boolean enter(String cls, ST parent,boolean flag) { //flag used to carry scope offset
        if (!tables.containsKey(cls)) {
            ST newScope = new ST(parent);
            tables.put(cls, newScope);
            currentScope = newScope;
            if(flag){
                varOffset = 0;
                methodOffset = 0;
            }
            return true;
        }
        return false;
    }
    public void insert(String name, String retType, List<String> paramTypes){
        if (currentScope != null) {
            currentScope.insertMethod(name, retType,paramTypes,this.methodOffset);
            this.methodOffset+=8;
        }
    }
    public void insert(String name, int size, String type) {
        if (currentScope != null) {
            currentScope.insert(name, size, type,varOffset);
            if(type.equals("boolean")){varOffset+=1;}
            else if(type.equals("int")){varOffset+=4;}
            else{varOffset+=8;}
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
    public void exitAndDestroy() {
        if (currentScope != null) {
            tables.values().remove(currentScope);
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

    // ========= Array Size =========
    public int arraySize(String name) {
        return arraySize(name, currentScope);
    }

    public int arraySize(String name, ST scope) {
        Info i = safeLookup(name, scope);
        return (i != null && "int".equals(i.getType()) && i.getSize() >= 1) ? i.getSize() : -1;
    }

    // ========= Type Checks =========
    public boolean isInt(String name) {
        return isInt(name, currentScope);
    }

    public boolean isInt(String name, ST scope) {
        Info i = safeLookup(name, scope);
        return i != null && "int".equals(i.getType()) && i.getSize() == -1;
    }

    public boolean isBool(String name) {
        return isBool(name, currentScope);
    }

    public boolean isBool(String name, ST scope) {
        Info i = safeLookup(name, scope);
        return i != null && "boolean".equals(i.getType()) && i.getSize() == -1;
    }

    public boolean isUninitializedArray(String name) {
        return isUninitializedArray(name, currentScope);
    }

    public boolean isUninitializedArray(String name, ST scope) {
        Info i = safeLookup(name, scope);
        return i != null && i.getSize() == 0;
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
            return method.getParamTypes().equals(paramTypes);
        }
        return false;
    }

    public String getMethodReturnType(String className, String methodName, List<String> paramTypes) {
        ST classScope = getClassScope(className);
        Info method = (classScope != null) ? classScope.lookup(methodName) : null;

        if (method != null && method.isMethod() && method.getParamTypes().equals(paramTypes)) {
            return method.getRetType();
        }
        return null;
    }
    public boolean InitiazeArray(String name,int size){
        Info arr = this.currentScope.lookup(name);
        if(arr !=null && arr.getSize() != -1){
            arr.changeSize(size);
            return true;
        }
        return false;
    }
    public boolean ClassExists(String Name){
        return this.tables.containsKey(Name);
    }
    public boolean IsArgList(String Name){
        Info i = this.lookup(Name);
        return i.getType().equals("String[]");
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
            System.out.println("-----------Class "+ i.getKey()+"-----------");
            i.getValue().PrintOffsets(i.getKey());
        }
    }
}
