package IRGeneration;
import java.io.*;
import java.net.URI;
import java.util.*;
import java.util.prefs.BackingStoreException;

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
        ir.emit("define i32 @main(){");
        n.f14.accept(this,ir);
        n.f15.accept(this,ir);
        ir.emit("}");
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
        String type = n.f0.accept(this,ir);
        String var = n.f1.accept(this,ir);
        
        return var;
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

}