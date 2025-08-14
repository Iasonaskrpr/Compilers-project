@.BT_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @BT.Start to i8*)]
@.Tree_vtable = global [20 x i8*] [i8* bitcast (i1 (i8*,i32)* @Tree.Init to i8*),i8* bitcast (i1 (i8*,i8*)* @Tree.SetRight to i8*),i8* bitcast (i1 (i8*,i8*)* @Tree.SetLeft to i8*),i8* bitcast (i8* (i8*)* @Tree.GetRight to i8*),i8* bitcast (i8* (i8*)* @Tree.GetLeft to i8*),i8* bitcast (i32 (i8*)* @Tree.GetKey to i8*),i8* bitcast (i1 (i8*,i32)* @Tree.SetKey to i8*),i8* bitcast (i1 (i8*)* @Tree.GetHas_Right to i8*),i8* bitcast (i1 (i8*)* @Tree.GetHas_Left to i8*),i8* bitcast (i1 (i8*,i1)* @Tree.SetHas_Left to i8*),i8* bitcast (i1 (i8*,i1)* @Tree.SetHas_Right to i8*),i8* bitcast (i1 (i8*,i32,i32)* @Tree.Compare to i8*),i8* bitcast (i1 (i8*,i32)* @Tree.Insert to i8*),i8* bitcast (i1 (i8*,i32)* @Tree.Delete to i8*),i8* bitcast (i1 (i8*,i8*,i8*)* @Tree.Remove to i8*),i8* bitcast (i1 (i8*,i8*,i8*)* @Tree.RemoveRight to i8*),i8* bitcast (i1 (i8*,i8*,i8*)* @Tree.RemoveLeft to i8*),i8* bitcast (i32 (i8*,i32)* @Tree.Search to i8*),i8* bitcast (i1 (i8*)* @Tree.Print to i8*),i8* bitcast (i1 (i8*,i8*)* @Tree.RecPrint to i8*)]
%class.BT = type{ }
%class.Tree = type{ i8*, i1, i8*, i8*, i1, i32 }
%IntArray = type { i32, i32* }
%BooleanArray = type { i32, i8* }
declare i8* @calloc(i32, i32)
declare i32 @printf(i8*, ...)
declare void @exit(i32)
@_cint = constant [4 x i8] c"%d\0A\00"
@_cOOB = constant [15 x i8] c"Out of bounds\0A\00"
define void @print_int(i32 %i) {
	%_str = bitcast [4 x i8]* @_cint to i8*
	call i32 (i8*, ...) @printf(i8* %_str, i32 %i)
	ret void
}
define void @throw_oob() {
	%_str = bitcast [15 x i8]* @_cOOB to i8*
	call i32 (i8*, ...) @printf(i8* %_str)
	call void @exit(i32 1)
	ret void
}
define i32 @main(){
	%_0 = alloca %class.BT*
	store %class.BT* null, %class.BT** %_0
	%_4 = getelementptr %class.BT, %class.BT* null, i32 1
	%_1 = ptrtoint %class.BT* %_4 to i32
	%_2 = call i8* @calloc(i32 1, i32 %_1)
	%_3 = bitcast i8* %_2 to %class.BT*
	store %class.BT* %_3, %class.BT** %_0
	%_5 = getelementptr [1 x i8*], [1 x i8*]* @.BT_vtable, i32 0, i32 0
	%_6 = load i8*, i8** %_5
	%_7 = bitcast i8* %_6 to i32(i8*)*
	%_8 = call i32 %_7(i8* %_0)
	call void @print_int(i32 %_8)
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
define i32 @BT.Start(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.BT*
	%root = alloca %class.Tree*
	store %class.Tree null, %class.Tree %root
	%ntb = alloca i1
	%nti = alloca i32
	%_14 = getelementptr %class.Tree, %class.Tree* null, i32 1
	%_11 = ptrtoint %class.Tree* %_14 to i32
	%_12 = call i8* @calloc(i32 1, i32 %_11)
	%_13 = bitcast i8* %_12 to %class.Tree*
	store %class.Tree* %_13, %class.Tree** %root
