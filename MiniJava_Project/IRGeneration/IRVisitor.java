package IRGeneration;
import syntaxtree.AndExpression;
import syntaxtree.ArrayType;
import syntaxtree.AssignmentStatement;
import syntaxtree.Block;
import syntaxtree.BooleanArrayType;
import syntaxtree.BooleanType;
import syntaxtree.BracketExpression;
import syntaxtree.Clause;
import syntaxtree.CompareExpression;
import syntaxtree.FalseLiteral;
import syntaxtree.Identifier;
import syntaxtree.IfStatement;
import syntaxtree.IntegerArrayType;
import syntaxtree.IntegerLiteral;
import syntaxtree.IntegerType;
import syntaxtree.MainClass;
import syntaxtree.MinusExpression;
import syntaxtree.NotExpression;
import syntaxtree.PlusExpression;
import syntaxtree.PrimaryExpression;
import syntaxtree.PrintStatement;
import syntaxtree.Statement;
import syntaxtree.TimesExpression;
import syntaxtree.TrueLiteral;
import syntaxtree.Type;
import syntaxtree.VarDeclaration;
import syntaxtree.WhileStatement;
import visitor.GJDepthFirst;

public class IRVisitor extends GJDepthFirst<IRData,IRHelper>{
    /**
     * MainClass ::= "class" Identifier "{" "public" "static" "void" "main" "(" "String" "[" "]" Identifier ")" "{" ( VarDeclaration )* ( Statement )* "}" "}"
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
     * f14 -> ( VarDeclaration )*
     * f15 -> ( Statement )*
     * f16 -> "}"
     * f17 -> "}"
     */ 
    @Override
    public IRData visit(MainClass n, IRHelper ir) throws Exception{
        ir.emit("define i32 @main(){\n");
        ir.enter_block();
        n.f14.accept(this,ir);
        n.f15.accept(this,ir);
        ir.emit("ret i32 0\n");
        ir.exit_block();
        ir.emit("}\n");
        return null;
    }
    /**
     * IfStatement ::= "if" "(" Expression ")" Statement "else" Statement
     * f0 -> "if"
     * f1 -> "("
     * f2 -> Expression()
     * f3 -> ")"
     * f4 -> Statement()
     * f5 -> "else"
     * f6 -> Statement()
     */
    @Override
    public IRData visit(IfStatement n, IRHelper ir)throws Exception{
        IRData expr = n.f2.accept(this,ir);
        String var = expr.getData();
        String _if = ir.new_if_label();
        String _else = ir.new_if_label();
        String end = ir.new_if_label();
        ir.emit("br i1 "+var+", label %"+_if+", label %"+_else+"\n");
        ir.emitlabel(_if);
        n.f4.accept(this,ir);
        ir.emit("br label %"+end+"\n");
        ir.emitlabel(_else);
        n.f6.accept(this,ir);
        ir.emit("br label %"+end+"\n");
        ir.emitlabel(end);
        return null;
    }
    /**
     * WhileStatement ::= "while" "(" Expression ")" Statement
     * f0 -> "while"
     * f1 -> "("
     * f2 -> Expression()
     * f3 -> ")"
     * f4 -> Statement()
     */
    @Override
    public IRData visit(WhileStatement n,IRHelper ir) throws Exception{
        String condition = ir.new_loop_label();
        String body = ir.new_loop_label();
        String end = ir.new_loop_label();
        ir.emit("br label %"+condition+"\n");
        ir.emitlabel(condition);
        IRData expr = n.f2.accept(this,ir);
        String var = expr.getData();
        ir.emit("br i1 "+var+", label %"+body+", label %"+end+"\n");
        ir.emitlabel(body);
        n.f4.accept(this,ir);
        ir.emit("br label %"+condition+"\n");
        ir.emitlabel(end);
        return null;
    }
    /**
     * VarDeclaration ::= Type Identifier ";"
     * f0 -> Type()
     * f1 -> Identifier()
     * f2 -> ";"
     */
    @Override
    public IRData visit(VarDeclaration n,IRHelper ir) throws Exception{
        IRData tp = n.f0.accept(this,ir);
        String type = tp.getData();
        if(tp.isId()){
            type = "%class."+tp.getData();
        }
        IRData id = n.f1.accept(this,ir);
        String var = id.getData();
        ir.addVariable(var, type);
        ir.emit("%"+var+" = alloca "+type+"\n");
        return null;
    }
    /**
     * Statement ::= Block | AssignmentStatement | ArrayAssignmentStatement | IfStatement | WhileStatement | PrintStatement
     * f0 -> Block | AssignmentStatement | ArrayAssignmentStatement | IfStatement | WhileStatement | PrintStatement
     */
    @Override
    public IRData visit(Statement n, IRHelper ir) throws Exception{
        return n.f0.accept(this,ir);
    }

    /**
     * PrintStatement ::= "System.out.println" "(" Expression ")" ";"
     * f0 -> "System.out.println"
     * f1 -> "("
     * f2 -> Expression()
     * f3 -> ")"
     * f4 -> ";"
     */
    @Override
    public IRData visit(PrintStatement n, IRHelper ir) throws Exception{
        IRData data = n.f2.accept(this,ir);
        String var = data.getData();
        if(data.isId()){
            var = ir.idToTempVar(data);
        }
        ir.emit("call void @print_int(i32 "+var+")\n");
        return null;
    }
    /**
     * CompareExpression ::= PrimaryExpression "<" PrimaryExpression
     * f0 -> PrimaryExpression()
     * f1 -> "<"
     * f2 -> PrimaryExpression()
     */
    @Override
    public IRData visit(CompareExpression n,IRHelper ir) throws Exception{
        IRData left = n.f0.accept(this,ir);
        String leftVar = left.getData();
        if(left.isId()){
            leftVar = ir.idToTempVar(left);
        }
        IRData right = n.f2.accept(this,ir);
        String rightVar = right.getData();
        if(right.isId()){
            rightVar = ir.idToTempVar(right);
        }
        String cond = ir.new_var();
        ir.emit(cond+" = icmp slt i32 "+leftVar+", "+rightVar+"\n");
        IRData ret = new IRData(cond,"id");
        return ret;
    }
    /**
     * AndExpression ::= Clause "&&" Clause
     * f0 -> Clause()
     * f1 -> "&&"
     * f2 -> Clause()
     */
    @Override
    public IRData visit(AndExpression n, IRHelper ir) throws Exception {
        IRData left = n.f0.accept(this, ir);
        String leftBool = left.getData();
        if(left.isId()){
            leftBool = ir.idToTempVar(left);
        }
        String leftCheck = ir.new_var();      
        String rightCheck = ir.new_var();     
        String result = ir.new_var();         
        String checkLeftLabel = ir.new_if_label();   
        String evalRightLabel = ir.new_if_label();   
        String mergeLabel = ir.new_if_label();       
        ir.emit("br label %" + checkLeftLabel);
        ir.emitlabel(checkLeftLabel);
        ir.emit(leftCheck + " = icmp ne i1 " + leftBool + ", 0\n");
        ir.emit("br i1 " + leftCheck + ", label %" + evalRightLabel + ", label %" + mergeLabel + "\n");
        ir.emitlabel(evalRightLabel);
        IRData right = n.f2.accept(this, ir);
        String rightBool = right.getData();
        if(right.isId()){
            rightBool = ir.idToTempVar(right);
        }
        ir.emit(rightCheck + " = icmp ne i1 " + rightBool + ", 0\n");
        ir.emit("br label %" + mergeLabel + "\n");
        ir.emitlabel(mergeLabel);
        ir.emit(result + " = phi i1 [false, %" + checkLeftLabel + "], [" + rightCheck + ", %" + evalRightLabel + "]\n");
        IRData ret = new IRData(result,"id");
        return ret;
    }
    /**
     * NotExpression ::= "!" Clause
     * f0 -> "!"
     * f1 -> Clause()
     */
    @Override
    public IRData visit(NotExpression n, IRHelper ir) throws Exception{
        String var = n.f1.accept(this,ir).getData();
        String notVar = ir.new_var();
        ir.emit(notVar+" = xor i1 "+var+", true\n");
        return new IRData(notVar,"id");
    }
    /**
     * Clause ::= NotExpression | PrimaryExpression
     * f0 -> NotExpression()
     */
    @Override
    public IRData visit(Clause n,IRHelper ir) throws Exception{
        return n.f0.accept(this,ir);
    }
    /**
     * BracketExpression ::= "(" Expression ")"
     * f0 -> "("
     * f1 -> Expression()
     * f2 -> ")"
     */
    @Override
    public IRData visit(BracketExpression n, IRHelper ir) throws Exception{
        return n.f1.accept(this,ir);
    }
    /**
     * PlusExpression ::= PrimaryExpression "+" PrimaryExpression
     * f0 -> PrimaryExpression()
     * f1 -> "+"
     * f2 -> PrimaryExpression()
     */
    @Override
    public IRData visit(PlusExpression n, IRHelper ir)throws Exception{
        IRData left = n.f0.accept(this,ir);
        String leftVar = left.getData();
        if(left.isId()){
            leftVar = ir.idToTempVar(left);
        }
        IRData right = n.f2.accept(this,ir);
        String rightVar = right.getData();
        if(right.isId()){
            rightVar = ir.idToTempVar(right);
        }
        String lhs = ir.new_var();
        ir.emit(lhs+" = add i32 "+leftVar+", "+rightVar+"\n");
        return new IRData(lhs,"id");
    }
    /**
     * MinusExpression ::= PrimaryExpression "-" PrimaryExpression
     * f0 -> PrimaryExpression()
     * f1 -> "-"
     * f2 -> PrimaryExpression()
     */
    @Override
    public IRData visit(MinusExpression n, IRHelper ir)throws Exception{
        IRData left = n.f0.accept(this,ir);
        String leftVar = left.getData();
        if(left.isId()){
            leftVar = ir.idToTempVar(left);
        }
        IRData right = n.f2.accept(this,ir);
        String rightVar = right.getData();
        if(right.isId()){
            rightVar = ir.idToTempVar(right);
        }
        String lhs = ir.new_var();
        ir.emit(lhs+" = sub i32 "+leftVar+", "+rightVar+"\n");
        return new IRData(lhs,"id");
    }
    /**
     * TimesExpression ::= PrimaryExpression "*" PrimaryExpression
     * f0 -> PrimaryExpression()
     * f1 -> "*"
     * f2 -> PrimaryExpression()
     */
    @Override
    public IRData visit(TimesExpression n, IRHelper ir)throws Exception{
        IRData left = n.f0.accept(this,ir);
        String leftVar = left.getData();
        if(left.isId()){
            leftVar = ir.idToTempVar(left);
        }
        IRData right = n.f2.accept(this,ir);
        String rightVar = right.getData();
        if(right.isId()){
            rightVar = ir.idToTempVar(right);
        }
        String lhs = ir.new_var();
        ir.emit(lhs+" = mul i32 "+leftVar+", "+rightVar+"\n");
        return new IRData(lhs,"id");
    }
    @Override
    public IRData visit(PrimaryExpression n, IRHelper ir) throws Exception{
        return n.f0.accept(this,ir);
    }
    /**
     * AssignmentStatement ::= Identifier "=" Expression ";"
     * f0 -> Identifier()
     * f1 -> "="
     * f2 -> Expression()
     * f3 -> ";"
     */
    @Override
    public IRData visit(AssignmentStatement n, IRHelper ir) throws Exception{
        String lhs = n.f0.accept(this,ir).getData();
        IRData rightHand = n.f2.accept(this,ir);
        String rhs = rightHand.getData();
        if(ir.getVariableType(lhs).equals("%IntArray") && rightHand.isNum()){
            String ArrPtr = ir.new_var();
            ir.emit(ArrPtr+" = getelementptr %IntArray, %IntArray* %"+lhs+", i32 0, i32 0\n");
            ir.emit("store i32 "+ rhs+", i32* "+ArrPtr+"\n");
            return null;
        }
        else if(ir.getVariableType(lhs).equals("%BooleanArray") && rightHand.isNum()){
            String ArrPtr = ir.new_var();
            ir.emit(ArrPtr+" = getelementptr %BooleanArray, %BooleanArray* %"+lhs+", i32 0, i32 0\n");
            ir.emit("store i32 "+ rhs+", i32* "+ArrPtr+"\n");
            return null;
        }
        ir.emit("store "+ir.getVariableType(lhs)+" "+rhs+", "+ir.getVariableType(lhs)+"* %"+lhs+"\n");
        return null;
    }
    /**
     * Block ::= "{" ( Statement )* "}"
     * f0 -> "{"
     * f1 -> ( Statement )*
     * f2 -> "}"
     */
    @Override
    public IRData visit(Block n, IRHelper ir) throws Exception{
        return n.f1.accept(this,ir);
    }
    /**
     * Type ::= ArrayType | BooleanType | IntegerType | Identifier
     * f0 -> ArrayType() | BooleanType() | IntegerType() | Identifier() 
     */

    @Override
    public IRData visit(Type n, IRHelper ir) throws Exception{
        return n.f0.accept(this,ir);
    }
    @Override
    public IRData visit(ArrayType n,IRHelper ir) throws Exception{
        return n.f0.accept(this,ir);
    }
    @Override
    public IRData visit(IntegerArrayType n, IRHelper ir) {
        return new IRData(ir.getLLVMType("int[]"),"type");
    }
    @Override
    public IRData visit(BooleanArrayType n, IRHelper ir) {
        return new IRData(ir.getLLVMType("boolean[]"),"type");
    }
    @Override
    public IRData visit(IntegerType n,IRHelper ir) {
        return new IRData(ir.getLLVMType("int"),"type");
    }
    @Override
    public IRData visit(BooleanType n, IRHelper ir){
        return new IRData(ir.getLLVMType("boolean"),"type");
    }
    @Override
    public IRData visit(Identifier n, IRHelper ir){
        return new IRData(n.f0.toString(),"id");
    }
    @Override
    public IRData visit(IntegerLiteral n, IRHelper ir){
        return new IRData(n.f0.toString(),"num");
    }
    @Override
    public IRData visit(TrueLiteral n,IRHelper ir){
        return new IRData("1","bool");
    }
    @Override
    public IRData visit(FalseLiteral n,IRHelper ir){
        return new IRData("0","bool");
    }
}