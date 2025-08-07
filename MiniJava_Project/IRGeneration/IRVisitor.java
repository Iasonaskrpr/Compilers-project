package IRGeneration;
import syntaxtree.AndExpression;
import syntaxtree.ArrayAllocationExpression;
import syntaxtree.ArrayAssignmentStatement;
import syntaxtree.ArrayLength;
import syntaxtree.ArrayLookup;
import syntaxtree.ArrayType;
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
        ir.exitClass();
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
        ir.exitClass();
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
        ir.exitClass();
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
        String retType = n.f1.accept(this,ir).getData();
        String MethName = n.f2.accept(this,ir).getData();
        ir.emit("define " + retType + " @"+ir.getCurClass()+"."+MethName+"(i8* this");
        n.f4.accept(this,ir);
        ir.emit(") {\n");
        ir.enter_block();
        n.f7.accept(this,ir);
        n.f8.accept(this,ir);
        IRData ret = n.f10.accept(this,ir);
        ir.emit("ret "+ ret.getType() + " "+ ret.getData()+"\n");
        ir.exit_block();
        ir.emit("}\n");
        return null; 
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
        String type = n.f0.accept(this,ir).getData();
        String id = n.f1.accept(this,ir).getData();
        ir.emit(", "+type+" %"+id);
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
        if(tp.isId()){
            type = "%class."+tp.getData();
        }
        IRData id = n.f1.accept(this,ir);
        String var = id.getData();
        if(ir.shouldEmit()){
            ir.addVariable(var, type);
            ir.emit("%"+var+" = alloca "+type+"\n");
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
            index =i.getData();
        }
        IRData valData = n.f5.accept(this,ir);
        String val = valData.getData();
        if(valData.isId()){
            val = ir.idToTempVar(valData);
        }
        String size_ptr = ir.new_var();
        ir.emit(size_ptr+" = getelementptr "+ir.getVariableType(arr.getData())+", "+ir.getVariableType(arr.getData())+"* %"+arr.getData()+", i32 0, i32 0\n");
        String size = ir.new_var();
        ir.emit(size+" = load i32, i32* "+size_ptr+"\n");
        String oob_checker = ir.new_var();
        ir.emit(oob_checker + " = icmp slt i32 "+index+", "+size+"\n");
        ir.emit("br i1 "+oob_checker+", label %"+L1+", label %"+L2+"\n");
        ir.emitlabel(L1);
        String data_ptr_ptr = ir.new_var();
        String data_ptr = ir.new_var();
        String data = ir.new_var();
        if(ir.getVariableType(arr.getData()).equals("%IntArray")){
            ir.emit(data_ptr_ptr + " = getelementptr %IntArray, %IntArray* %"+arr.getData()+", i32 0, i32 1\n");
            ir.emit(data_ptr + " = load i32*, i32** " + data_ptr_ptr + "\n");
            ir.emit(data + " = getelementptr i32, i32* "+data_ptr+", i32 "+ index + "\n");
            ir.emit("store i32 " + val + ", i32* " + data + "\n");
            ir.emit("br label %"+L3+"\n");
        }
        else if(ir.getVariableType(arr.getData()).equals("%BooleanArray")){
            ir.emit(data_ptr_ptr + " = getelementptr %BooleanArray, %BooleanArray* %"+arr.getData()+", i32 0, i32 1\n");
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
        IRData arr = n.f0.accept(this,ir);
        String size_ptr = ir.new_var();
        ir.emit(size_ptr+" = getelementptr "+ir.getVariableType(arr.getData())+", "+ir.getVariableType(arr.getData())+"* %"+arr.getData()+", i32 0, i32 0\n");
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
            index =i.getData();
        }
        String size_ptr = ir.new_var();
        ir.emit(size_ptr+" = getelementptr "+ir.getVariableType(arr.getData())+", "+ir.getVariableType(arr.getData())+"* %"+arr.getData()+", i32 0, i32 0\n");
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
        if(ir.getVariableType(arr.getData()).equals("%IntArray")){
            ir.emit(data_ptr_ptr + " = getelementptr %IntArray, %IntArray* %"+arr.getData()+", i32 0, i32 1\n");
            ir.emit(data_ptr + " = load i32*, i32** " + data_ptr_ptr + "\n");
            ir.emit(data + " = getelementptr i32, i32* "+data_ptr+", i32 "+ index + "\n");
            ir.emit(val + " = load i32, i32* " + data + "\n");
            ir.emit("br label %"+L3+"\n");
        }
        else if(ir.getVariableType(arr.getData()).equals("%BooleanArray")){
            ir.emit(data_ptr_ptr + " = getelementptr %BooleanArray, %BooleanArray* %"+arr.getData()+", i32 0, i32 1\n");
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
        else if(ir.getVariableType(lhs).equals("%BooleanArray") && rightHand.isNum()){
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