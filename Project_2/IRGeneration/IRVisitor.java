package IRGeneration;
import java.io.*;
import java.time.chrono.IsoEra;
import java.util.*;

import syntaxtree.*;
import visitor.GJDepthFirst;

public class IRVisitor extends GJDepthFirst<String,IRHelper>{
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
    public String visit(MainClass n, IRHelper ir) throws Exception{
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
    public String visit(IfStatement n, IRHelper ir)throws Exception{
        String var = n.f2.accept(this,ir);
        String _if = ir.new_if_label();
        String _else = ir.new_if_label();
        ir.emit("br i1 "+var+", label %"+_if+", label %"+_else+"\n");
        ir.emitlabel(_if);
        n.f4.accept(this,ir);
        ir.emitlabel(_else);
        n.f6.accept(this,ir);
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
    public String visit(WhileStatement n,IRHelper ir) throws Exception{
        String condition = ir.new_loop_label();
        String body = ir.new_loop_label();
        String end = ir.new_loop_label();
        ir.emit("br label %"+condition+"\n");
        ir.emitlabel(condition);
        String var = n.f2.accept(this,ir);
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
    public String visit(VarDeclaration n,IRHelper ir) throws Exception{
        //TODO
        String type = n.f0.accept(this,ir);
        String var = n.f1.accept(this,ir);
        
        return var;
    }
    /**
     * Statement ::= Block | AssignmentStatement | ArrayAssignmentStatement | IfStatement | WhileStatement | PrintStatement
     * f0 -> Block | AssignmentStatement | ArrayAssignmentStatement | IfStatement | WhileStatement | PrintStatement
     */
    @Override
    public String visit(Statement n, IRHelper ir) throws Exception{
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
    public String visit(PrintStatement n, IRHelper ir) throws Exception{
        String var = n.f2.accept(this,ir);  
        ir.emit("call void (i32) @print_int(i32 "+var+")\n");
        return null;
    }
    /**
     * CompareExpression ::= PrimaryExpression "<" PrimaryExpression
     * f0 -> PrimaryExpression()
     * f1 -> "<"
     * f2 -> PrimaryExpression()
     */
    @Override
    public String visit(CompareExpression n,IRHelper ir) throws Exception{
        String var1 = n.f0.accept(this,ir);
        String var2 = n.f2.accept(this,ir);
        String cond = ir.new_var();
        ir.emit(cond+" = icmp slt i32 "+var1+", "+var2+"\n");
        return cond;
    }
    /**
     * AndExpression ::= Clause "&&" Clause
     * f0 -> Clause()
     * f1 -> "&&"
     * f2 -> Clause()
     */
    @Override
    public String visit(AndExpression n, IRHelper ir) throws Exception {
        String leftBool = n.f0.accept(this, ir);
        String leftCheck = ir.new_var();      
        String rightCheck = ir.new_var();     
        String result = ir.new_var();         
        String checkLeftLabel = ir.new_if_label();   
        String evalRightLabel = ir.new_if_label();   
        String mergeLabel = ir.new_if_label();       
        ir.emit("br label %" + checkLeftLabel);
        ir.emitlabel(checkLeftLabel);
        ir.emit(leftCheck + " = icmp ne i1 " + leftBool + ", 0\n");
        ir.emit("br i1 " + leftCheck + ", label " + evalRightLabel + ", label " + mergeLabel + "\n");
        ir.emitlabel(evalRightLabel);
        String rightBool = n.f2.accept(this, ir);
        ir.emit(rightCheck + " = icmp ne i1 " + rightBool + ", 0\n");
        ir.emit("br label %" + mergeLabel + "\n");
        ir.emitlabel(mergeLabel);
        ir.emit(result + " = phi i1 [false, %" + checkLeftLabel + "], [" + rightCheck + ", %" + evalRightLabel + "]\n");
        return result;
    }

    /**
     * Type ::= ArrayType | BooleanType | IntegerType | Identifier
     * f0 -> ArrayType() | BooleanType() | IntegerType() | Identifier() 
     */

    @Override
    public String visit(Type n, IRHelper ir) throws Exception{
        return n.f0.accept(this,ir);
    }
    @Override
    public String visit(ArrayType n,IRHelper ir) throws Exception{
        return n.f0.accept(this,ir);
    }
    @Override
    public String visit(IntegerArrayType n, IRHelper ir) {
        return ir.getLLVMType("int[]");
    }
    @Override
    public String visit(BooleanArrayType n, IRHelper ir) {
        return ir.getLLVMType("boolean[]");
    }
    @Override
    public String visit(IntegerType n,IRHelper ir) {
        return ir.getLLVMType("int");
    }
    @Override
    public String visit(BooleanType n, IRHelper ir){
        return ir.getLLVMType("boolean");
    }
    @Override
    public String visit(Identifier n, IRHelper ir){
        return n.f0.toString();
    }
    @Override
    public String visit(IntegerLiteral n, IRHelper ir){
        return n.f0.toString();
    }
    @Override
    public String visit(TrueLiteral n,IRHelper ir){
        return "1";
    }
    @Override
    public String visit(FalseLiteral n,IRHelper ir){
        return "0";
    }
}