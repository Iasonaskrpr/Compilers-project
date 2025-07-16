package SemanticCheckingVisitors;
import symbolTable.Scopes;
import symbolTable.Info;
import symbolTable.ST;
import syntaxtree.*;
import visitor.GJDepthFirst;

import java.util.ArrayList;
import java.util.List;


public class TypeCheckingVisitor extends GJDepthFirst<String, Scopes>{
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
        try {
            String cls = n.f1.accept(this,Table);
            if(!Table.enterScopeByName("Function_main")){
                throw new Exception("Unexpected error: Couldn't find "+cls+" class");
            }
            n.f14.accept(this,Table);
            n.f15.accept(this,Table);

        } catch (Exception e) {
            System.err.println(e);
            throw e;
        }
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
        try {
            String classname = n.f1.accept(this, Table);
            if(!Table.enterScopeByName(classname)){
                throw new Exception("Unexpected error: Couldn't find "+classname+" class");
            }
            n.f3.accept(this,Table);
            n.f4.accept(this,Table);

        } catch (Exception e) {
            System.err.println(e);
            throw e;
        }

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
        try {
            String classname = n.f1.accept(this, Table);
            if(!Table.enterScopeByName(classname)){
                throw new Exception("Unexpected error: Couldn't find "+classname+" class");
            }
            n.f5.accept(this,Table);
            n.f6.accept(this,Table);

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
        try {
            String retType = n.f1.accept(this,Table);
            String methodName = n.f2.accept(this, Table);
            if(!Table.enterScopeByName(Table.getClassName()+"_Function_"+methodName)){
                throw new Exception("Unexpected error: Couldn't find "+methodName+" class");
            }
            n.f7.accept(this,Table);
            n.f8.accept(this,Table);
            String _ret = n.f10.accept(this,Table);
            Info var = Table.lookup(_ret);
            if(var != null){
                _ret = var.getType();
            }
            if(!retType.equals(_ret)){
                if(!Table.isSubtype(retType,_ret))
                throw new Exception("Semantic analysis failed: Method "+ methodName +" expected "+retType +" but "+_ret+ " was given");
            }
            Table.exit();
        } catch (Exception e) {
            System.err.println(e);
            throw e;
        }
        
        return null;
    }
    @Override
    public String visit(WhileStatement n,Scopes Table)throws Exception{
        try {
            String type = n.f2.accept(this,Table);
            Info var = Table.lookup(type);
            if(var!=null){
                type = var.getType();
            }
            if(!type.equals("boolean")){
                throw new Exception("Semantic analysis error: while statement expected boolean but "+ type +" was given");
            }
            n.f4.accept(this,Table);
        } catch (Exception e) {
            System.err.println(e);
            throw e;
        }
        return null;
    }
    @Override
    public String visit(IfStatement n,Scopes Table)throws Exception{
        try {
            String type = n.f2.accept(this,Table);
            Info var = Table.lookup(type);
            if(var!=null){
                type = var.getType();
            }
            if(!type.equals("boolean")){
                throw new Exception("Semantic analysis error: if statement expected boolean");
            }
            n.f4.accept(this,Table);
            n.f6.accept(this,Table);
        } catch (Exception e) {
            System.err.println(e);
            throw e;
        }
        return null;
    }
    @Override
    public String visit(PrintStatement n,Scopes Table)throws Exception{
        try {
            String tp = n.f2.accept(this,Table);
            Info var = Table.lookup(tp);
            if(var!=null){
                tp = var.getType();
            }
            if(!tp.equals("int")){
                throw new Exception("Semantic analysis error: print statement expected int but "+tp+" was given");
            }
        } catch (Exception e) {
            System.err.println(e);
            throw e;
        }
        return null;
    }
    @Override
    public String visit(AssignmentStatement n,Scopes Table)throws Exception{
        String id = n.f0.accept(this,Table);
        Info varData = Table.lookup(id);
        try {
            if(varData == null){
                throw new Exception("Semantic analysis error: "+id+" Doesn't exist at "+ Table.getClassName());
            }
            String exp = n.f2.accept(this,Table);
            Info var = Table.lookup(exp);
            if(var!=null){
                exp = var.getType();
            }
            if(!exp.equals(varData.getType())){
                if(!Table.isSubtype(varData.getType(), exp)){
                    throw new Exception("Semantic analysis error: "+id+" is of type "+varData.getType()+ " but type "+exp+" was assigned");
                }
            }
            
         } catch (Exception e) {
            System.err.println(e);
            throw e;
         }
         return varData.getType();
    }
    @Override
    public String visit(ArrayAssignmentStatement n,Scopes Table)throws Exception{
        String id = n.f0.accept(this,Table);
        Info varData = Table.lookup(id);
        Info var;
        try {
            if(varData == null || (!varData.getType().equals("int[]")&&!varData.getType().equals("boolean[]"))){
                throw new Exception("Semantic analysis error: "+id+" is not an array ");
            }
            String type = n.f2.accept(this,Table);
            var = Table.lookup(type);
            if(var!=null){
                type = var.getType();
            } 
            if(!type.equals("int")){
                throw new Exception("Semantic analysis error: Array index is not an integer");
            }
            String alloc = n.f5.accept(this,Table);
            var = Table.lookup(alloc);
            if(var!=null){
                alloc = var.getType();
            }
            if(varData.getType().equals("int[]")&&!alloc.equals("int")){
                throw new Exception("Semantic analysis error: Array is of type int but assignment of "+ alloc +"was given");
            }
            if(varData.getType().equals("boolean[]")&&!alloc.equals("boolean")){
                throw new Exception("Semantic analysis error: Array is of type boolean but assignment of "+ alloc +"was given");
            }

        } catch (Exception e) {
            System.err.println(e);
            throw e;
        }
        return null;
    }
    @Override
    public String visit(IntegerArrayAllocationExpression n,Scopes Table)throws Exception{
        try {
            String alloc = n.f3.accept(this,Table);
            Info sz = Table.lookup(alloc);
            if(sz != null){
                alloc = sz.getType();
            }
            if(!alloc.equals("int")){
                throw new Exception("Semantic analysis error: Array allocation expression expected int but "+alloc+" was given");
            }
        } catch (Exception e) {
            System.err.println(e);
            throw e;
        }
        return "int[]";
    }
    @Override
    public String visit(BooleanArrayAllocationExpression n,Scopes Table)throws Exception{
        try {
            String alloc = n.f3.accept(this,Table);
            Info sz = Table.lookup(alloc);
            if(sz != null){
                alloc = sz.getType();
            }
            if(!alloc.equals("int")){
                throw new Exception("Semantic analysis error: Array allocation expression expected int but "+alloc+" was given");
            }
        } catch (Exception e) {
            System.err.println(e);
            throw e;
        }
        return "boolean[]";
    }
    @Override
    public String visit(ArrayLookup n, Scopes Table)throws Exception{
        String id = n.f0.accept(this,Table);
        Info varData = Table.lookup(id); 
        String type;
        String alloc;
        try {
            if(varData == null){
                throw new Exception("Semantic error analysis: "+id+" doesn't exist ");
            }
            type = varData.getType();
            alloc = n.f2.accept(this,Table);
            Info all = Table.lookup(alloc);
            if(all!=null){
                alloc = all.getType();
            }
            if(type.equals("int[]")){
                if(!alloc.equals("int")){
                    throw new Exception("Semantic error analysis: "+id+" is of type int but "+alloc +" was given");
                }
            }
            else if(type.equals("boolean[]")){
                 if(!alloc.equals("boolean")){
                    throw new Exception("Semantic error analysis: "+id+" is of type boolean but "+alloc +" was given");
                }
            }
            else{
                throw new Exception("Semantic error analysis: "+id+" is not an array ");
            }
            
        } catch (Exception e) {
            System.err.println(e);
            throw e;
        }
        return alloc;
    }
    @Override
    public String visit(ArrayLength n,Scopes Table)throws Exception{
        String id = n.f0.accept(this,Table);
        Info varData = Table.lookup(id);
        try {
            if(varData == null || (!varData.getType().equals("int[]")&&!varData.getType().equals("boolean[]"))){
                throw new Exception("Semantic error analysis: "+id+" is not an array ");
            }
        } catch (Exception e) {
            System.err.println(e);
            throw e;
        }
        return "int";
    }
    @Override
    public String visit(Expression n,Scopes Table) throws Exception{
        return n.f0.accept(this,Table);
    }
    @Override
    public String visit(ArrayType n, Scopes Table) throws Exception{
        return n.f0.accept(this,Table);
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
    public String visit(BooleanArrayType n, Scopes Table){
        return "boolean[]";
    }
    @Override 
    public String visit(IntegerArrayType n , Scopes Table){
        return "int[]";
    }
    @Override
    public String visit(Identifier n, Scopes Table) {
        return n.f0.toString();
    }
    @Override
    public String visit(IntegerLiteral n, Scopes Table) throws Exception {
        return "int";
    }
    @Override
    public String visit(TrueLiteral n ,Scopes Table){
        return "boolean";
    }
    @Override
    public String visit(FalseLiteral n ,Scopes Table){
        return "boolean";
    }
    @Override
    public String visit(ThisExpression n ,Scopes Table){
        return n.f0.toString();
    }
    @Override
    public String visit(AllocationExpression n ,Scopes Table)throws Exception{
        String alloc = n.f1.accept(this,Table);
        try {
            if(!Table.ClassExists(alloc)){
                throw new Exception("Semantic analysis error: Can't allocate if it is not class");
            }
        } catch (Exception e) {
            System.err.println(e);
            throw e;
        }
        return alloc;
    }
    @Override
    public String visit(NotExpression n, Scopes Table) throws Exception{
        String tp = n.f1.accept(this,Table);
        try {
            Info var = Table.lookup(tp);
            if(var!=null){
                tp = var.getType();
            }
            if(!tp.equals("boolean")){
                throw new Exception("Semantic analysis error: not expression expects boolean but type "+ tp + " was given");
            }

        } catch (Exception e) {
            System.err.println(e);
            throw e;
        }
        return "boolean";
    }
    @Override
    public String visit(Clause n,Scopes Table)throws Exception{
        return n.f0.accept(this,Table);
    }
    @Override
    public String visit(BracketExpression n, Scopes Table)throws Exception{
        return n.f1.accept(this,Table);
    }
    @Override
    public String visit(Statement n,Scopes Table)throws Exception{
        return n.f0.accept(this,Table);
    }
    @Override
    public String visit(Type n, Scopes Table)throws Exception{
        return n.f0.accept(this,Table);
    }
    @Override
    public String visit(Block n,Scopes Table)throws Exception{
        return n.f1.accept(this,Table);
    }
    @Override
    public String visit(PrimaryExpression n,Scopes Table)throws Exception{
        return n.f0.accept(this,Table);
    }
    @Override
    public String visit(TimesExpression n,Scopes Table)throws Exception{
        String type1 = n.f0.accept(this,Table);
        String type2 = n.f2.accept(this,Table);
        try {
            Info var1 = Table.lookup(type1);
            Info var2 = Table.lookup(type2);
            if(var1 != null){
                if(var1.getType().equals("int")){
                    type1 = "int";
                }
                else{
                    throw new Exception("Semantic analysis error: Times operator expects integers");
                }
            }
            if(var2 != null){
                if(var2.getType().equals("int")){
                    type2 = "int";
                }
                else{
                    throw new Exception("Semantic analysis error: Times operator expects integers");
                }
            }
            if(!type1.equals("int")||!type2.equals("int")){
                throw new Exception("Semantic analysis error: Times operator expects integers but "+type1+ " * "+ type2+" was given");
            }
        } catch (Exception e) {
            System.err.println(e);
            throw e;
        }
        return "int";
    }
    @Override
    public String visit(PlusExpression n,Scopes Table)throws Exception{
        String type1 = n.f0.accept(this,Table);
        String type2 = n.f2.accept(this,Table);
        try {
            Info var1 = Table.lookup(type1);
            Info var2 = Table.lookup(type2);
            if(var1 != null){
                if(var1.getType().equals("int")){
                    type1 = "int";
                }
                else{
                    throw new Exception("Semantic analysis error: Plus operator expects integers");
                }
            }
            if(var2 != null){
                if(var2.getType().equals("int")){
                    type2 = "int";
                }
                else{
                    throw new Exception("Semantic analysis error: Plus operator expects integers");
                }
            }
            if(!type1.equals("int")||!type2.equals("int")){
                throw new Exception("Semantic analysis error: Plus operator expects integers but "+type1+ " + "+ type2+" was given");
            }
        } catch (Exception e) {
            System.err.println(e);
            throw e;
        }
        return "int";
    }
    @Override
    public String visit(MinusExpression n,Scopes Table)throws Exception{
        String type1 = n.f0.accept(this,Table);
        String type2 = n.f2.accept(this,Table);
        try {
            Info var1 = Table.lookup(type1);
            Info var2 = Table.lookup(type2);
            if(var1 != null){
                if(var1.getType().equals("int")){
                    type1 = "int";
                }
                else{
                    throw new Exception("Semantic analysis error: Minus operator expects integers");
                }
            }
            if(var2 != null){
                if(var2.getType().equals("int")){
                    type2 = "int";
                }
                else{
                    throw new Exception("Semantic analysis error: Minus operator expects integers");
                }
            }
            if(!type1.equals("int")||!type2.equals("int")){
                throw new Exception("Semantic analysis error: Minus operator expects integers but "+type1+ " - "+ type2+" was given");
            }
        } catch (Exception e) {
            System.err.println(e);
            throw e;
        }
        return "int";
    }
    @Override
    public String visit(CompareExpression n,Scopes Table)throws Exception{
        String type1 = n.f0.accept(this,Table);
        String type2 = n.f2.accept(this,Table);
        try {
            Info var1 = Table.lookup(type1);
            Info var2 = Table.lookup(type2);
            if(var1 != null){
                if(var1.getType().equals("int")){
                    type1 = "int";
                }
                else{
                    throw new Exception("Semantic analysis error: Compare operator expects integers");
                }
            }
            if(var2 != null){
                if(var2.getType().equals("int")){
                    type2 = "int";
                }
                else{
                    throw new Exception("Semantic analysis error: Compare operator expects integers");
                }
            }
            if(!type1.equals("int")||!type2.equals("int")){
                throw new Exception("Semantic analysis error: Compare operator expects integers but "+type1+ " < "+ type2+" was given");
            }
        } catch (Exception e) {
            System.err.println(e);
            throw e;
        }
        return "boolean";
    }
    @Override
    public String visit(AndExpression n,Scopes Table)throws Exception{
        String type1 = n.f0.accept(this,Table);
        String type2 = n.f2.accept(this,Table);
        try {
            Info var1 = Table.lookup(type1);
            Info var2 = Table.lookup(type2);
            if(var1 != null){
                if(var1.getType().equals("boolean")){
                    type1 = "boolean";
                }
                else{
                    throw new Exception("Semantic analysis error: Plus operator expects boolean");
                }
            }
            if(var2 != null){
                if(var2.getType().equals("boolean")){
                    type2 = "boolean";
                }
                else{
                    throw new Exception("Semantic analysis error: Plus operator expects boolean");
                }
            }
            if(!type1.equals("boolean")||!type2.equals("boolean")){
                throw new Exception("Semantic analysis error: Plus operator expects boolean but "+type1+ " && "+ type2+" was given");
            }
        } catch (Exception e) {
            System.err.println(e);
            throw e;
        }
        return "boolean";
    }
    @Override
    public String visit(MessageSend n,Scopes Table)throws Exception{
        String id = n.f0.accept(this,Table);
        String retType;
        String classType;
        Info var;
        List<String> types = new ArrayList<>();
        try {
            Info varData = Table.lookup(id);
            if(varData == null){
                ST cls = Table.getClassScope(id);
                if(cls == null){
                    throw new Exception("Semantic analysis error: Item "+id+" doesn't exist");
                }
                classType = id;
            }
            else{
                classType = varData.getType();
            }
            String meth = n.f2.accept(this,Table);
            String argumentList = n.f4.present() ? n.f4.accept(this, Table) : null;
            if(argumentList!=null){
                
                for (String arg : argumentList.split(",")) {
                    var = Table.lookup(arg);
                    if(var!=null){types.add(var.getType());}
                    else{types.add(arg.trim());}
                }

                if (!Table.methodExists(Table.getClassScope(classType), meth, types)) {
                    throw new Exception("Semantic analysis error: method " + meth + " with parameters " + types + " doesn't exist");
                }
                retType = Table.getMethodReturnType(classType, meth, types);
            }
            else{
                if(!Table.methodExists(Table.getClassScope(classType), meth, types)){
                    throw new Exception("Semantic analysis error: method "+meth+" doesn't exist");
                }
                retType = Table.getMethodReturnType(classType, meth, types);
            }
            
        } catch (Exception e) {
            System.err.println(e);
            throw e;
        }
        return retType;
    }
    @Override
    public String visit(ExpressionList n, Scopes Table) throws Exception {
        String exp1 = n.f0.accept(this, Table); // first expression
        String exp2 = n.f1.accept(this, Table); // rest of the expressions with commas

        if (exp1 == null) {
            return "";
        } else if (exp2 == null || exp2.isEmpty()) {
            return exp1;
        }

        return exp1 + exp2;
    }
    @Override
    public String visit(ExpressionTail n, Scopes Table) throws Exception {
        StringBuilder sb = new StringBuilder();
        for (Node node : n.f0.nodes) { // f0 is a NodeListOptional
            String term = node.accept(this, Table);
            if (term != null) {
                sb.append(term);
            }
        }
        return sb.toString();
    }
    @Override
    public String visit(ExpressionTerm n,Scopes Table)throws Exception{
        return ","+n.f1.accept(this,Table);
    }
}