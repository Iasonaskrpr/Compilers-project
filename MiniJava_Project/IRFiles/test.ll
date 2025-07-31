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
	%x = alloca i32
	%y = alloca i32
	store i32 3, ptr %y
	%_0 = load i32, ptr %y
	%_1 = add i32 %_0, 3
	store i32 %_1, ptr %x
	%_2 = load i32, ptr %x
	%_3 = icmp slt i32 %_2, 10
	br i1 %_3, label %if0, label %if1

if0:
	%_4 = load i32, ptr %y
	call void @print_int(i32 %_4)
	br label %if2
if1:
	%_5 = load i32, ptr %x
	call void @print_int(i32 %_5)
	br label %if2
if2:
	ret i32 0
}
