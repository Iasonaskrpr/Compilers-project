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
	%i = alloca %IntArray
	%z = alloca i1
	%t = alloca i1
	store i32 3, i32* %y
	%_0 = load i32, i32* %y
	%_1 = add i32 %_0, 3
	store i32 %_1, i32* %x
	%_2 = load i32, i32* %x
	%_3 = icmp slt i32 %_2, 10
	store i1 %_3, i1* %t
	%_4 = load i32, i32* %y
	%_5 = icmp slt i32 %_4, 4
	store i1 %_5, i1* %z
	%_6 = load i1, i1* %t
	br label %if0
if0:
	%_7 = icmp ne i1 %_6, 0
	br i1 %_7, label %if1, label %if2

if1:
	%_10 = load i1, i1* %z
	%_8 = icmp ne i1 %_10, 0
	br label %if2

if2:
	%_9 = phi i1 [false, %if0], [%_8, %if1]
	%_11 = xor i1 %_9, true
	br i1 %_11, label %if3, label %if4

if3:
	%_12 = load i32, i32* %y
	call void @print_int(i32 %_12)
	br label %if5

if4:
	%_13 = load i32, i32* %x
	call void @print_int(i32 %_13)
	br label %if5

if5:
	ret i32 0
}
