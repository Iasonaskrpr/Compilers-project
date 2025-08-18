package IRGeneration;
import java.util.*;

import javax.sql.RowSetInternal;

import syntaxtree.AndExpression;
import syntaxtree.ArrayAllocationExpression;
import syntaxtree.ArrayAssignmentStatement;
import syntaxtree.ArrayLength;
import syntaxtree.ArrayLookup;
import syntaxtree.ArrayType;
import syntaxtree.AllocationExpression;
import syntaxtree.AssignmentStatement;
import syntaxtree.Block;
import syntaxtree.BooleanArrayAllocationExpression;
import syntaxtree.BooleanArrayType;
import syntaxtree.BooleanType;
import syntaxtree.BracketExpression;
import syntaxtree.ClassDeclaration;
import syntaxtree.ClassExtendsDeclaration;
import syntaxtree.Clause;
import syntaxtree.CompareExpression;
import syntaxtree.ExpressionList;
import syntaxtree.ExpressionTail;
import syntaxtree.ExpressionTerm;
import syntaxtree.FalseLiteral;
import syntaxtree.FormalParameter;
import syntaxtree.FormalParameterList;
import syntaxtree.FormalParameterTail;
import syntaxtree.FormalParameterTerm;
import syntaxtree.Identifier;
import syntaxtree.IfStatement;
import syntaxtree.IntegerArrayAllocationExpression;
import syntaxtree.IntegerArrayType;
import syntaxtree.IntegerLiteral;
import syntaxtree.IntegerType;
import syntaxtree.MainClass;
import syntaxtree.MessageSend;
import syntaxtree.MethodDeclaration;
import syntaxtree.MinusExpression;
import syntaxtree.NotExpression;
import syntaxtree.PlusExpression;
import syntaxtree.PrimaryExpression;
import syntaxtree.PrintStatement;
import syntaxtree.Statement;
import syntaxtree.TimesExpression;
import syntaxtree.TrueLiteral;
import syntaxtree.Type;
import syntaxtree.TypeDeclaration;
import syntaxtree.VarDeclaration;
import syntaxtree.WhileStatement;
import syntaxtree.ThisExpression;
import syntaxtree.Node;
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
        ir.emitlabel("end");
        ir.emit("call void @throw_oob()\n");
        ir.emit("ret i32 1\n");
        ir.exit_block();
        ir.emit("}\n");
        return null;
    }
    /**
     * TypeDeclaration ::= ClassDeclaration | ClassExtendsDeclaration
     * f0 -> ClassDeclaration()
     */
    @Override
    public IRData visit(TypeDeclaration n, IRHelper ir) throws Exception{
        return n.f0.accept(this,ir);
    }
    /**
     * ClassDeclaration ::= "class" Identifier "{" ( VarDeclaration )* ( MethodDeclaration )* "}"
     * f0 -> "class"
     * f1 -> Identifier()
     * f2 -> "{"
     * f3 -> ( VarDeclaration )*
     * f4 -> ( MethodDeclaration )*
     * f5 -> "}"
     */
    @Override
    public IRData visit(ClassDeclaration n, IRHelper ir) throws Exception{
        IRData Class = n.f1.accept(this, ir);
        ir.EnterClass(Class.getData());
        ir.toggleEmit();
        n.f3.accept(this,ir);
        ir.toggleEmit();
        n.f4.accept(this,ir);
        return null;
    }
    /**
     * ClassExtendsDeclaration ::= "class" Identifier "extends" Identifier "{" ( VarDeclaration )* ( MethodDeclaration )* "}"
     * f0 -> "class"
     * f1 -> Identifier()
     * f2 -> "extends"
     * f3 -> Identifier()
     * f4 -> "{"
     * f5 -> ( VarDeclaration )*
     * f6 -> ( MethodDeclaration )*
     * f7 -> "}"
     */
    @Override
    public IRData visit(ClassExtendsDeclaration n, IRHelper ir) throws Exception{
        IRData Class = n.f1.accept(this, ir);
        ir.EnterClass(Class.getData());
        ir.toggleEmit();
        n.f5.accept(this,ir);
        ir.toggleEmit();
        n.f6.accept(this,ir);
        return null;
    }
    /**
     * MethodDeclaration ::= "public" Type Identifier "(" ( FormalParameterList )? ")" "{" ( VarDeclaration )* ( Statement )* "return" Expression ";" "}"
     * f0 -> "public"
     * f1 -> Type()
     * f2 -> Identifier()
     * f3 -> "("
     * f4 -> ( FormalParameterList )?
     * f5 -> ")"
     * f6 -> "{"
     * f7 -> ( VarDeclaration )*
     * f8 -> ( Statement )*
     * f9 -> "return"
     * f10 -> Expression()
     * f11 -> ";"
     * f12 -> "}"
     */
    @Override
    public IRData visit(MethodDeclaration n, IRHelper ir) throws Exception{
        Map<String, String> params;
        String retType = n.f1.accept(this,ir).getData();
        String MethName = n.f2.accept(this,ir).getData();
        ir.new_method();
        if(ir.isClass(retType)){
            retType = "i8*";
        }
        ir.emit("define " + retType + " @"+ir.getCurClass()+"."+MethName+"(i8* %this_raw");
        n.f4.accept(this,ir);
        ir.emit(") {\n");
        ir.enter_block();
        ir.emit("%this = bitcast i8* %this_raw to %class."+ir.getCurClass()+"*\n");
        params = ir.getParams();
        for (Map.Entry<String, String> p : params.entrySet()) {
            if(ir.isClass(p.getValue())){
                ir.emit("%."+p.getKey()+" = bitcast i8* %"+p.getKey()+"_raw to %class."+p.getValue()+"*\n");
                ir.emit("%"+p.getKey()+" = alloca %class."+p.getValue()+"*\n");
                ir.emit("store %class."+p.getValue()+"* %."+p.getKey()+", %class."+p.getValue()+"** %"+p.getKey()+"\n");
            }
            else{
                ir.emit("%"+p.getKey()+" = alloca "+p.getValue()+"\n");
                ir.emit("store "+p.getValue()+" %."+p.getKey()+", "+p.getValue()+"* %"+p.getKey()+"\n");
            }
            
            
        }
        n.f7.accept(this,ir);
        n.f8.accept(this,ir);
        IRData ret = n.f10.accept(this,ir);
        if(ret.isNum()){ir.emit("ret i32 "+ ret.getData()+"\n");}
        else if(ret.isBool()){ ir.emit("ret i1 "+ ret.getData()+"\n");}
        else{//In case it is an id we have to load it first
            if(ret.getData().startsWith("%")){
                ir.emit("ret "+ retType + " "+ ret.getData()+"\n");
            }
            else{
                String retVar = ir.idToTempVar(ret);
                ir.emit("ret "+retType+" "+retVar+"\n");
            }
        }
        ir.emitlabel("end");
        ir.emit("call void @throw_oob()\n");
        if(retType.equals("i32")){ir.emit("ret i32 1\n");}
        else if(retType.equals("i1")){ ir.emit("ret i1 false\n");}
        else{ir.emit("ret "+ retType + " zeroinitializer\n");}
        ir.exit_block();
        ir.emit("}\n");
        return null; 
    }
    /**
     * AllocationExpression ::= "new" Identifier "(" ")"
     * f0 -> "new"
     * f1 -> Identifier()
     * f2 -> "("
     * f3 -> ")"
     */
    @Override
    public IRData visit(AllocationExpression n, IRHelper ir) throws Exception{
        return new IRData (n.f1.accept(this,ir).getData(),"new");
    }
    /**
     * FormalParameterList ::= FormalParameter FormalParameterTail
     * f0 -> FormalParameter()
     * f1 -> FormalParameterTail()
     */
    @Override
    public IRData visit(FormalParameterList n, IRHelper ir) throws Exception{
        n.f0.accept(this,ir);
        n.f1.accept(this,ir);
        return null;
    }
    /**
     * FormalParameter ::= Type Identifier
     * f0 -> Type()
     * f1 -> Identifier()
     */
    @Override 
    public IRData visit(FormalParameter n, IRHelper ir) throws Exception {
        //Class parameters require casting
        IRData typeData = n.f0.accept(this,ir);
        String type = typeData.getData();
        String id = n.f1.accept(this,ir).getData();
        ir.addParam(id, type);
        ir.addVariable(id, type);
        if(typeData.isId()){
            type = "i8*";
            ir.emit(", "+type+" %"+id+"_raw");
        }
        else{
            ir.emit(", "+type+" %."+id);
            }
        return null;
    }
    /**
     * FormalParameterTail ::= ( FormalParameterTerm )*
     * f0 -> ( FormalParameterTerm )*
     */
    @Override
    public IRData visit(FormalParameterTail n, IRHelper ir) throws Exception{
        n.f0.accept(this,ir);
        return null;
    }
    /**
     * FormalParameterTerm ::= "," FormalParameter
     * f0 -> ","
     * f1 -> FormalParameter()
     */
    @Override
    public IRData visit(FormalParameterTerm n, IRHelper ir) throws Exception{
        n.f1.accept(this,ir);
        return null;
    }
    /**
     * MessageSend ::= PrimaryExpression "." Identifier "(" ( ExpressionList )? ")"
     * f0 -> PrimaryExpression()
     * f1 -> "."
     * f2 -> Identifier()
     * f3 -> "("
     * f4 -> ( ExpressionList )?
     * f5 -> ")"
     */
    @Override
    public IRData visit(MessageSend n, IRHelper ir) throws Exception{
        String thisVar = n.f0.accept(this,ir).getData();
        String methodName = n.f2.accept(this,ir).getData();
        //Load method from vtable to var and call it like that
        String cls;
        if(thisVar.equals("this")){
            thisVar = "%this";
            cls = ir.getCurClass();
        }
        else if(ir.isClass(thisVar)){ //If it is a constructor we need to construct the class first
            cls = thisVar;
            String tempVar;
            thisVar = ir.new_var();
            tempVar = ir.new_var();
            ir.emit(tempVar+" = alloca %class."+cls+"*\n"); 
            ir.emit("store %class."+cls+ "* null, %class."+cls+"** "+tempVar+"\n"); 
            String size = ir.new_var();
            String mem = ir.new_var();
            String cls_ptr = ir.new_var();
            String cls_ptr_ptr = ir.new_var();
            ir.emit(cls_ptr_ptr + " = getelementptr %class."+cls+", %class."+cls+"* null, i32 1\n");
            ir.emit(size+" = ptrtoint %class."+cls+"* "+cls_ptr_ptr+ " to i32\n");
            ir.emit(mem + " = call i8* @calloc(i32 1, i32 "+size+")\n");
            ir.emit(cls_ptr + " = bitcast i8* " + mem + " to %class."+cls+"*\n");
            String vtbl = ir.new_var();
            String vtblcast = ir.new_var();
            String vptrfield = ir.new_var();
            String vtblName = "@." + cls + "_vtable"; 
            ir.emit(vtbl + " = getelementptr ["+ir.getVtableSize(cls)+" x i8*], ["+ir.getVtableSize(cls)+" x i8*]* "+vtblName+", i32 0, i32 0\n");
            ir.emit(vtblcast + " = bitcast i8** " + vtbl + " to i8**\n");
            ir.emit(vptrfield + " = getelementptr %class." + cls + ", %class." + cls + "* " + cls_ptr + ", i32 0, i32 0\n");
            ir.emit("store i8** " + vtblcast + ", i8*** " + vptrfield + "\n");
            ir.emit("store %class."+cls+"* "+cls_ptr+", %class."+cls+"** "+tempVar+"\n");
            ir.emit(thisVar+" = load %class."+cls+"*, %class."+cls+"** "+tempVar+"\n");
        }
        else{ 
            cls = ir.getVariableClass(thisVar);
            if(!thisVar.startsWith("%")){
                thisVar = "%"+thisVar;
            }
        }
        String method_ptr = ir.new_var();
        String method_raw = ir.new_var();
        String method = ir.new_var();
        String ret = ir.new_var();
        String Loadcmd = ir.getMethodLoadCommand(cls, methodName,thisVar);
        ir.emit(method_ptr+ " = " + Loadcmd);
        ir.emit(method_raw + " = load i8*, i8** "+method_ptr+"\n");
        ir.emit(method + " = "+ ir.getMethodCallCommand(cls, methodName, method_raw));
        String Arguments;
        if(n.f4.present()){
            Arguments = n.f4.accept(this,ir).getData();
        }
        else{
            Arguments = "";
        }
        String this_raw = thisVar;
        if(!this_raw.equals("%this") && !this_raw.startsWith("%_")){
            String this_loaded = ir.idToTempVar(new IRData(this_raw.substring(1),"id"));
            if(this_loaded == null){
                this_loaded= ir.new_var();
                ir.emit(this_loaded + " = load %class."+cls+"*, %class."+cls+"** "+this_raw+"\n");
            }
            
            this_raw = this_loaded;
        }
        thisVar = ir.new_var();
        ir.emit(thisVar + " = bitcast %class."+cls+"* "+this_raw+ " to i8*\n");
        String callCommand;
        String returnType = ir.getMethodRetType(cls,methodName);
        ir.lastCallClass(ir.getMethodRawRetType(cls, methodName));
        callCommand = ret+" = call "+ returnType +" "+method+"(i8* "+thisVar;
        if(!Arguments.equals("")){
            String[] ids = Arguments.split("--");
            List<String> types = ir.getMethodArgs(cls, methodName);
            int i = 0;
            for(String id : ids){
                String tp;
                System.out.println(types.get(i));
                if(ir.isClass(id)){
                    String varcls = id;
                    String tempVar;
                    id = ir.new_var();
                    String uncastid = ir.new_var();
                    tempVar = ir.new_var();
                    ir.emit(tempVar+" = alloca %class."+varcls+"*\n"); 
                    ir.emit("store %class."+varcls+ "* null, %class."+varcls+"** "+tempVar+"\n"); 
                    String size = ir.new_var();
                    String mem = ir.new_var();
                    String cls_ptr = ir.new_var();
                    String cls_ptr_ptr = ir.new_var();
                    ir.emit(cls_ptr_ptr + " = getelementptr %class."+varcls+", %class."+varcls+"* null, i32 1\n");
                    ir.emit(size+" = ptrtoint %class."+varcls+"* "+cls_ptr_ptr+ " to i32\n");
                    ir.emit(mem + " = call i8* @calloc(i32 1, i32 "+size+")\n");
                    ir.emit(cls_ptr + " = bitcast i8* " + mem + " to %class."+varcls+"*\n");
                    String vtbl = ir.new_var();
                    String vtblcast = ir.new_var();
                    String vptrfield = ir.new_var();
                    String vtblName = "@." + varcls + "_vtable"; 
                    ir.emit(vtbl + " = getelementptr ["+ir.getVtableSize(varcls)+" x i8*], ["+ir.getVtableSize(varcls)+" x i8*]* "+vtblName+", i32 0, i32 0\n");
                    ir.emit(vtblcast + " = bitcast i8** " + vtbl + " to i8**\n");
                    ir.emit(vptrfield + " = getelementptr %class." + varcls + ", %class." + varcls + "* " + cls_ptr + ", i32 0, i32 0\n");
                    ir.emit("store i8** " + vtblcast + ", i8*** " + vptrfield + "\n");
                    ir.emit("store %class."+varcls+"* "+cls_ptr+", %class."+varcls+"** "+tempVar+"\n");
                    ir.emit(uncastid+" = load %class."+varcls+"*, %class."+varcls+"** "+tempVar+"\n");
                    ir.emit(id + " = bitcast %class."+varcls+"* "+ uncastid+" to i8* ");
                    tp = "i8*";
                }
                else{
                    tp = ir.getLLVMType(types.get(i));
                    id = ir.idToTempVar(new IRData(id,"id"));
                }
                if(id.equals("this")){
                    String new_id = ir.new_var();
                    ir.emit(new_id + " = bitcast %class."+cls+"* %this to i8*\n");
                    id = new_id;
                }
                callCommand += ", "+tp+" "+id;
                i++;
            }
        }
        callCommand+=")\n";
        ir.emit(callCommand);
        if(returnType.equals("i8*")){
            String ret_raw = ret;
            ret = ir.new_var();
            ir.emit(ret + " = bitcast i8* "+ret_raw+" to %class."+ir.getMethodRawRetType(cls,methodName)+"*\n");
        }
        return new IRData(ret,"id");
    }
    /**
     * ExpressionList ::= Expression ExpressionTail
     * f0 -> Expression()
     * f1 -> ExpressionTail()
     */
    @Override
    public IRData visit(ExpressionList n, IRHelper ir) throws Exception{
        String arg = n.f0.accept(this,ir).getData();
        IRData Rest_Data = n.f1.accept(this,ir);
        if(Rest_Data != null){
            arg += Rest_Data.getData();
        }
        return new IRData(arg,"Args");
    }
    /**
     * ExpressionTail ::= ( ExpressionTerm )*
     * f0 -> ( ExpressionTerm )*
     */
    @Override
    public IRData visit(ExpressionTail n, IRHelper ir) throws Exception{
        String Arguments = "";
        for(Node node : n.f0.nodes){
            IRData term = node.accept(this,ir);
            Arguments += "--"+term.getData();
        }  
        return new IRData(Arguments,"Args");
    }
    /**
     * ExpressionTerm ::= "," Expression
     * f0 -> ","
     * f1 -> Expression()
     */
    @Override
    public IRData visit(ExpressionTerm n, IRHelper ir) throws Exception{
        return n.f1.accept(this,ir);
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
        if(!var.startsWith("%") && !var.equals("true") && !var.equals("false")){
            var = ir.idToTempVar(expr);
        }
        String _if = ir.new_if_label();
        String _else = ir.new_if_label();
        String end = ir.new_if_label();
        ir.emit("br i1 "+var+", label %"+_if+", label %"+_else+"\n");
        ir.enter_block();
        ir.emitlabel(_if);
        n.f4.accept(this,ir);
        ir.emit("br label %"+end+"\n");
        ir.emitlabel(_else);
        n.f6.accept(this,ir);
        ir.emit("br label %"+end+"\n");
        ir.emitlabel(end);
        ir.exit_block();
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
        ir.enter_block();
        ir.emitlabel(condition);
        IRData expr = n.f2.accept(this,ir);
        String var = expr.getData();
        if(!var.startsWith("%") && !var.equals("true") && !var.equals(false)){
            var = ir.idToTempVar(expr);
        }
        ir.emit("br i1 "+var+", label %"+body+", label %"+end+"\n");
        ir.emitlabel(body);
        n.f4.accept(this,ir);
        ir.emit("br label %"+condition+"\n");
        ir.emitlabel(end);
        ir.exit_block();
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
        IRData id = n.f1.accept(this,ir);
        String var = id.getData();
        if(ir.shouldEmit()){
            ir.addVariable(var, type);
            if(tp.isId()){
                type = "%class."+tp.getData();
                ir.emit("%"+var+" = alloca "+type+"*\n");
                ir.emit("store "+type+ "* null, "+type+"** %"+var+"\n");
            }
            else{
                ir.emit("%"+var+" = alloca "+type+"\n");
            }
        }
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
     * ArrayAllocationExpression ::= BooleanArrayAllocationExpression | IntegerArrayAllocationExpression
     * f0 -> BooleanArrayAllocationExpression()
     */
    @Override
    public IRData visit(ArrayAllocationExpression n,IRHelper ir) throws Exception{
        return n.f0.accept(this,ir);
    }
    @Override
    public IRData visit(IntegerArrayAllocationExpression n,IRHelper ir) throws Exception{
        return new IRData(n.f3.accept(this,ir).getData(),"num");
    }
    @Override
    public IRData visit(BooleanArrayAllocationExpression n,IRHelper ir) throws Exception{
        return new IRData(n.f3.accept(this,ir).getData(),"num");
    }
    /**
     * ArrayAssignmentStatement ::= Identifier "[" Expression "]" "=" Expression ";"
     * f0 -> Identifier()
     * f1 -> "["
     * f2 -> Expression()
     * f3 -> "]"
     * f4 -> "="
     * f5 -> Expression()
     * f6 -> ";"
     */
    @Override
    public IRData visit(ArrayAssignmentStatement n,IRHelper ir) throws Exception{
        IRData arr = n.f0.accept(this,ir);
        IRData i = n.f2.accept(this,ir);
        String L1 = ir.new_oob_label();
        String L2 = ir.new_oob_label();
        String L3 = ir.new_oob_label();
        String index;
        if(i.isNum()){
            index = ir.new_var();
            ir.emit(index+" = add i32 0, "+i.getData()+"\n");
        } 
        else{
            if(!i.getData().startsWith("%")){
                index =ir.idToTempVar(i);
                }
            else{
                index = i.getData();
            }
            
        }
        IRData valData = n.f5.accept(this,ir);
        String val = valData.getData();
        String var = arr.getData();
        String cls = ir.classVarToTempVar(arr);
        if(cls != null){
            var = cls;
            var = var.substring(1);
        }
        if(valData.isId()){
            val = ir.idToTempVar(valData);
        }
        String size_ptr = ir.new_var();
        ir.emit(size_ptr+" = getelementptr "+ir.getVariableType(arr)+", "+ir.getVariableType(arr)+"* %"+var+", i32 0, i32 0\n");
        String size = ir.new_var();
        ir.emit(size+" = load i32, i32* "+size_ptr+"\n");
        String oob_checker = ir.new_var();
        ir.emit(oob_checker + " = icmp slt i32 "+index+", "+size+"\n");
        ir.emit("br i1 "+oob_checker+", label %"+L1+", label %"+L2+"\n");
        ir.emitlabel(L1);
        String data_ptr_ptr = ir.new_var();
        String data_ptr = ir.new_var();
        String data = ir.new_var();
        if(ir.getVariableType(arr).equals("%IntArray")){
            ir.emit(data_ptr_ptr + " = getelementptr %IntArray, %IntArray* %"+var+", i32 0, i32 1\n");
            ir.emit(data_ptr + " = load i32*, i32** " + data_ptr_ptr + "\n");
            ir.emit(data + " = getelementptr i32, i32* "+data_ptr+", i32 "+ index + "\n");
            ir.emit("store i32 " + val + ", i32* " + data + "\n");
            ir.emit("br label %"+L3+"\n");
        }
        else if(ir.getVariableType(arr).equals("%BooleanArray")){
            ir.emit(data_ptr_ptr + " = getelementptr %BooleanArray, %BooleanArray* %"+var+", i32 0, i32 1\n");
            ir.emit(data_ptr + " = load i8*, i8** " + data_ptr_ptr + "\n");
            ir.emit(data + " = getelementptr i8, i8* "+data_ptr+", i32 "+ index + "\n");
            String valExt = ir.new_var();
            ir.emit(valExt + " = zext i1 "+val+" to i8\n");
            ir.emit("store i8 " + valExt + ", i8* " + data + "\n");
            ir.emit("br label %"+L3+"\n");
        }
        ir.emitlabel(L2);
        ir.emit("br label %end\n");
        ir.emitlabel(L3);
        return null;
    }
    /**
     * ArrayLength ::= Identifier() "." "length"
     * f0 -> Identifier()
     * f1 -> "."
     * f2 -> "length"
     */
    @Override
    public IRData visit(ArrayLength n, IRHelper ir) throws Exception{
        //Edit
        IRData arr = n.f0.accept(this,ir);
        String size_ptr = ir.new_var();
        String var = arr.getData();
        String cls = ir.classVarToTempVar(arr);
        if(cls != null){
            var = cls;
            var = var.substring(1);
        }
        ir.emit(size_ptr+" = getelementptr "+ir.getVariableType(arr)+", "+ir.getVariableType(arr)+"* %"+var+", i32 0, i32 0\n");
        String size = ir.new_var();
        ir.emit(size+" = load i32, i32* "+size_ptr+"\n");
        return new IRData(size,"id");
    }
    /**
     * ArrayLookup ::= Identifier() "[" Expression() "]"
     * f0 -> Identifier()
     * f1 -> "["
     * f2 -> Expression()
     * f3 -> "]"
     */
    @Override
    public IRData visit(ArrayLookup n, IRHelper ir) throws Exception{
        IRData arr = n.f0.accept(this,ir);
        IRData i = n.f2.accept(this,ir);
        String L1 = ir.new_oob_label();
        String L2 = ir.new_oob_label();
        String L3 = ir.new_oob_label();
        String index;
        if(i.isNum()){
            index = ir.new_var();
            ir.emit(index+" = add i32 0, "+i.getData()+"\n");
        } 
        else{
            if(!i.getData().startsWith("%")){
                index =ir.idToTempVar(i);
                }
            else{
                index = i.getData();
            }
        }
        String var = arr.getData();
        String cls = ir.classVarToTempVar(arr);
        if(cls != null){
            var = cls;
            var = var.substring(1);
        }
        String size_ptr = ir.new_var();
        ir.emit(size_ptr+" = getelementptr "+ir.getVariableType(arr)+", "+ir.getVariableType(arr)+"* %"+var+", i32 0, i32 0\n");
        String size = ir.new_var();
        ir.emit(size+" = load i32, i32* "+size_ptr+"\n");
        String oob_checker = ir.new_var();
        ir.emit(oob_checker + " = icmp slt i32 "+index+", "+size+"\n");
        ir.emit("br i1 "+oob_checker+", label %"+L1+", label %"+L2+"\n");
        ir.emitlabel(L1);
        String data_ptr_ptr = ir.new_var();
        String data_ptr = ir.new_var();
        String data = ir.new_var();
        String val = ir.new_var();
        if(ir.getVariableType(arr).equals("%IntArray")){
            ir.emit(data_ptr_ptr + " = getelementptr %IntArray, %IntArray* %"+var+", i32 0, i32 1\n");
            ir.emit(data_ptr + " = load i32*, i32** " + data_ptr_ptr + "\n");
            ir.emit(data + " = getelementptr i32, i32* "+data_ptr+", i32 "+ index + "\n");
            ir.emit(val + " = load i32, i32* " + data + "\n");
            ir.emit("br label %"+L3+"\n");
        }
        else if(ir.getVariableType(arr).equals("%BooleanArray")){
            ir.emit(data_ptr_ptr + " = getelementptr %BooleanArray, %BooleanArray* %"+var+", i32 0, i32 1\n");
            ir.emit(data_ptr + " = load i8*, i8** " + data_ptr_ptr + "\n");
            ir.emit(data + " = getelementptr i8, i8* "+data_ptr+", i32 "+ index + "\n");
            String valLong = ir.new_var();
            ir.emit(valLong + " = load i8, i8* " + data + "\n");
            ir.emit(val + " = icmp ne i8 "+ valLong + ", 0\n"); //Convert to i1 from i8
            ir.emit("br label %"+L3+"\n");
        }
        ir.emitlabel(L2);
        ir.emit("br label %end\n");
        ir.emitlabel(L3);
        IRData ret = new IRData(val,"id");
        return ret;
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
        String var = ir.idToTempVar(n.f1.accept(this,ir));
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
        IRData left = n.f0.accept(this,ir);
        String lhs = left.getData();
        IRData rightHand = n.f2.accept(this,ir);
        String rhs = rightHand.getData();
        if(rhs.equals("this")){
            rhs = "%" + rhs;
        }
        else{
            rhs = ir.idToTempVar(rightHand);
        }
        if(ir.getVariableType(left).equals("%IntArray") && rightHand.isNum()){
            String l = ir.classVarToTempVar(left);
            if(l != null){
                lhs = l;
                lhs = lhs.substring(1);
            }
            String SzPtr = ir.new_var();
            ir.emit(SzPtr+" = getelementptr %IntArray, %IntArray* %"+lhs+", i32 0, i32 0\n");
            ir.emit("store i32 "+ rhs+", i32* "+SzPtr+"\n");
            String ArrPtrRaw = ir.new_var();
            String ArrPtr = ir.new_var();
            String ArrFieldptr = ir.new_var();
            ir.emit(ArrPtrRaw + " = call i8* @calloc(i32 "+rhs+", i32 4)\n");
            ir.emit(ArrPtr + " = bitcast i8* " + ArrPtrRaw + " to i32*\n");
            ir.emit(ArrFieldptr +" = getelementptr %IntArray, %IntArray* %"+lhs+", i32 0, i32 1\n");
            ir.emit("store i32* " +ArrPtr+ ", i32** "+ArrFieldptr+"\n");
            return null;
        }
        else if(ir.getVariableType(left).equals("%BooleanArray") && rightHand.isNum()){
            String l = ir.classVarToTempVar(left);
            if(l != null){
                lhs = l;
                lhs = lhs.substring(1);
            }
            String SzPtr = ir.new_var();
            ir.emit(SzPtr+" = getelementptr %BooleanArray, %BooleanArray* %"+lhs+", i32 0, i32 0\n");
            ir.emit("store i32 "+ rhs+", i32* "+SzPtr+"\n");
            String ArrPtrRaw = ir.new_var();
            String ArrPtr = ir.new_var();
            String ArrFieldptr = ir.new_var();
            ir.emit(ArrPtrRaw + " = call i8* @calloc(i32 "+rhs+", i32 1)\n");
            ir.emit(ArrFieldptr +" = getelementptr %BooleanArray, %BooleanArray* %"+lhs+", i32 0, i32 1\n");
            ir.emit("store i8* " +ArrPtr+ ", i8** "+ArrFieldptr+"\n");
            return null;
        }
        String l = ir.classVarToTempVar(left);
        if(rightHand.getType().equals("new")){
            String size = ir.new_var();
            String mem = ir.new_var();
            String cls_ptr = ir.new_var();
            String cls_ptr_ptr = ir.new_var();
            String cls = "%class."+rightHand.getData();
            ir.emit(cls_ptr_ptr + " = getelementptr "+cls+", "+cls+"* null, i32 1\n");
            ir.emit(size+" = ptrtoint "+cls+"* "+cls_ptr_ptr+ " to i32\n");
            ir.emit(mem + " = call i8* @calloc(i32 1, i32 "+size+")\n");
            ir.emit(cls_ptr + " = bitcast i8* " + mem + " to "+cls+"*\n");
            String vtbl = ir.new_var();
            String vtblcast = ir.new_var();
            String vptrfield = ir.new_var();
            String vtblName = "@." + rightHand.getData() + "_vtable"; 
            ir.emit(vtbl + " = getelementptr ["+ir.getVtableSize(rightHand.getData())+" x i8*], ["+ir.getVtableSize(rightHand.getData())+" x i8*]* "+vtblName+", i32 0, i32 0\n");
            ir.emit(vptrfield + " = getelementptr " + cls + ", " + cls + "* " + cls_ptr + ", i32 0, i32 0\n");
            ir.emit("store i8** " + vtbl + ", i8*** " + vptrfield + "\n");
            if(l == null){
                ir.emit("store "+cls+"* "+cls_ptr+", "+cls+"** %"+lhs+"\n");
            }
            else{
                ir.emit("store "+cls+"* "+cls_ptr+", "+cls+"** "+l+"\n");
            }
        }
        else if(l == null){
            String tp = ir.getVariableType(left);
            if(ir.isClass(tp)){
                tp = "%class."+ tp+"*";
            }
            ir.emit("store "+tp+" "+rhs+", "+tp+"* %"+lhs+"\n");
        }
        else{
            String tp = ir.getVariableType(left);
            if(ir.isClass(tp)){
                tp = "%class."+ tp+"*";
            }
            ir.emit("store " + tp +" "+rhs+", "+tp+"* "+ l +"\n");
            }
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
        return new IRData("true","bool");
    }
    @Override
    public IRData visit(FalseLiteral n,IRHelper ir){
        return new IRData("false","bool");
    }
    @Override
    public IRData visit(ThisExpression n, IRHelper ir){
        return new IRData("this","id");
    }
}