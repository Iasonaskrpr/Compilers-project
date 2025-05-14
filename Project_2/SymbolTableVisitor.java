import java.util.ArrayList;
import java.util.List;
import java.util.regex.*;
import java.util.*;
import syntaxtree.AndExpression;
import syntaxtree.ArrayLookup;
import syntaxtree.ArrayType;
import syntaxtree.BooleanType;
import syntaxtree.ClassDeclaration;
import syntaxtree.ClassExtendsDeclaration;
import syntaxtree.CompareExpression;
import syntaxtree.Expression;
import syntaxtree.FormalParameter;
import syntaxtree.FormalParameterList;
import syntaxtree.FormalParameterTail;
import syntaxtree.FormalParameterTerm;
import syntaxtree.Identifier;
import syntaxtree.IntegerLiteral;
import syntaxtree.IntegerType;
import syntaxtree.MainClass;
import syntaxtree.MethodDeclaration;
import syntaxtree.Node;
import syntaxtree.PrintStatement;
import syntaxtree.VarDeclaration;
import visitor.GJDepthFirst;


class SymbolTableVisitors extends GJDepthFirst<String, Scopes>{
    /**
     * f0 -> "class"
     * f1 -> Identifier()
     * f2 -> "{"
     * f3 -> "public"
     * f4 -> "static"
     * f5 -> "void"
     * f6 -> "main"
     * f7 -> "("
     * f8 -> "String"
     * f9 -> "["
     * f10 -> "]"
     * f11 -> Identifier()
     * f12 -> ")"
     * f13 -> "{"
     * f14 -> ( VarDeclaration() )*
     * f15 -> ( Statement() )*
     * f16 -> "}"
     * f17 -> "}"
     */
    @Override
public String visit(MainClass n, Scopes Table) throws Exception {
    String classname = n.f1.accept(this, Table); // Class name extraction
    try {
        // Check if class already exists in scope
        if (Table.enter(classname, null,true) == false) {
            throw new Exception("Class " + classname + " already exists in scope.");
        }
        Table.enter("Function_main",Table.getCurrentScope(),false);

        // Insert main method (signature: main(String[] args))
        List<String> params = new ArrayList<>();
        params.add("String[]");
        Table.insert("main","void",params);

        // Insert the parameter "args" of type String[]
        String param = n.f11.accept(this, Table);
        Table.insert(param, -1, "String[]");

        // Visit variable declarations and statements
        n.f14.accept(this, Table);
        n.f15.accept(this, Table);

    } catch (Exception e) {
        // Handle any exceptions or log them
        System.err.println("Error during semantic analysis: " + e.getMessage());
        throw e;  // Rethrow exception to ensure error is propagated
    }
    Table.exitAndDestroy();
    Table.exit();
    // Continue the visit
    super.visit(n, Table);
    return null;
}

    /**
     * f0 -> "class"
     * f1 -> Identifier()
     * f2 -> "{"
     * f3 -> ( VarDeclaration() )*
     * f4 -> ( MethodDeclaration() )*
     * f5 -> "}"
     */
    @Override
    public String visit(ClassDeclaration n, Scopes Table) throws Exception {
        n.f0.accept(this, Table);
        
        String classname = n.f1.accept(this, Table);
        try {
            if (Table.enter(classname, null,true) == false) {
                throw new Exception("Class " + classname + " already exists in scope.");
            }
            n.f3.accept(this,Table);
            n.f4.accept(this,Table);

        } catch (Exception e) {
            System.err.println("Error during semantic analysis: " + e.getMessage());
            throw e;  // Rethrow exception to ensure error is propagated
        }
        Table.exit();

        System.out.println();

        return null;
    }

    /**
     * f0 -> "class"
     * f1 -> Identifier()
     * f2 -> "extends"
     * f3 -> Identifier()
     * f4 -> "{"
     * f5 -> ( VarDeclaration() )*
     * f6 -> ( MethodDeclaration() )*
     * f7 -> "}"
     */
    @Override
    public String visit(ClassExtendsDeclaration n, Scopes Table) throws Exception {
        String classname = n.f1.accept(this, null);
        String subtype = n.f3.accept(this,null);
        ST subScope;
        try {
            if((subScope = Table.getClassScope(subtype)) == null ){
                throw new Exception("Class " + subtype + " doesn't exist.");
            }
            if(Table.enter(classname, subScope,false) == false){
                throw new Exception("Class " + classname + " already exists.");
            }
            n.f5.accept(this,Table);
            n.f6.accept(this,Table);

        } catch (Exception e) {
            System.err.println("Error during semantic analysis: " + e.getMessage());
            throw e;  // Rethrow exception to ensure error is propagated
        }
        return null;
    }

    /**
    * f0 -> Type()
    * f1 -> Identifier()
    * f2 -> ";"
    */
   @Override
   public String visit(VarDeclaration n, Scopes Table) throws Exception {
        String type = n.f0.accept(this, Table);
        String var = n.f1.accept(this, Table);
        try {
            if(Table.varExistsInCurrentScope(var) != false){
                throw new Exception("Variable already exists in current scope");
            }
            Table.insert(var, -1, type);
        } catch (Exception e) {
            System.err.println(e);
            throw e;
        }
        
        return null;
    }

    /**
     * f0 -> "public"
     * f1 -> Type()
     * f2 -> Identifier()
     * f3 -> "("
     * f4 -> ( FormalParameterList() )?
     * f5 -> ")"
     * f6 -> "{"
     * f7 -> ( VarDeclaration() )*
     * f8 -> ( Statement() )*
     * f9 -> "return"
     * f10 -> Expression()
     * f11 -> ";"
     * f12 -> "}"
     */
   @Override
    public String visit(MethodDeclaration n, Scopes Table) throws Exception {
        String argumentList = n.f4.present() ? n.f4.accept(this, null) : null;
        List<String> types = new ArrayList<>();
        try{
            String retType = n.f1.accept(this,Table);
            String Id = n.f2.accept(this,Table);
            Table.enter("Function_"+Id,Table.getCurrentScope(),false);
            if(argumentList != null){
                Pattern pattern = Pattern.compile("([\\w\\[\\]]+)\\s+(\\w+)");
                Matcher matcher = pattern.matcher(argumentList);
                while (matcher.find()) {
                    if(Table.existsInScope(matcher.group(2), Table.getCurrentScope())){throw new Exception("Variable: "+ matcher.group(2)+" already exists");}
                    Table.insert(matcher.group(2), -1, matcher.group(1));
                    types.add(matcher.group(1));
                }
            
            } 
            if(Table.methodExists(Table.getCurrentScope(), Id, types)){
                if(!Table.isValidOverride(Table.getCurrentScope(), Id, retType, types)){
                    Table.exitAndDestroy();
                    throw new Exception("Method: "+ Id+ "already exists");
                }
            }
            Table.insert(Id,retType,types);
            n.f7.accept(this,Table);
            n.f8.accept(this,Table);
            if(!n.f10.accept(this,Table).equals(retType)){
                Table.exitAndDestroy();
                throw new Exception("Invalid return type at method: "+ Id);
            }
            Table.exitAndDestroy();
        }
        catch(Exception e){
            System.err.println("Semantic error: " + e);
            throw e;
        }
        return null;
    }

    /**
     * f0 -> FormalParameter()
     * f1 -> FormalParameterTail()
     */
    @Override
    public String visit(FormalParameterList n, Scopes Table) throws Exception {
        String ret = n.f0.accept(this, null);

        if (n.f1 != null) {
            ret += n.f1.accept(this, null);
        }
        
        return ret;
    }

    /**
     * f0 -> FormalParameter()
     * f1 -> FormalParameterTail()
     */
    @Override
    public String visit(FormalParameterTerm n, Scopes Table) throws Exception {
        return n.f1.accept(this, Table);
    }

    /**
     * f0 -> ","
     * f1 -> FormalParameter()
     */
    @Override
    public String visit(FormalParameterTail n, Scopes Table) throws Exception {
        String ret = "";
        for ( Node node: n.f0.nodes) {
            ret += ", " + node.accept(this, null);
        }

        return ret;
    }

    /**
     * f0 -> Type()
     * f1 -> Identifier()
     */
    @Override
    public String visit(FormalParameter n, Scopes Table) throws Exception{
        String type = n.f0.accept(this, null);
        String name = n.f1.accept(this, null);
        return type + " " + name;
    }

    @Override
    public String visit(ArrayType n, Scopes Table) {
        return "int[]";
    }
    @Override
    public String visit(BooleanType n, Scopes Table) {
        return "boolean";
    }
    @Override
    public String visit(IntegerType n, Scopes Table) {
        return "int";
    }

    @Override
    public String visit(Identifier n, Scopes Table) {
        return n.f0.toString();
    }

    @Override
    public String visit(CompareExpression n, Scopes argu){
        return "boolean";
    }
    @Override
    public String visit(AndExpression n, Scopes argu){
        return "boolean";
    }
    @Override
    public String visit(IntegerLiteral n, Scopes argu){
      return "int";
   }
   @Override
    public String visit(PrintStatement n, Scopes argu) throws Exception{
        String ExpType = n.f2.accept(this,argu);
        try {
             if(!ExpType.equals("int")){
                throw new Exception("Print can only output integers");
            }
        } catch (Exception e) {
            System.err.println(e);
            throw e;
        } 
        return null;
    }
    @Override
    public String visit(Expression n, Scopes argu) throws Exception{
        return n.f0.accept(this,argu);
    }
}