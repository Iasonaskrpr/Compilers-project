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
	%_0 = getelementptr %IntArray, %IntArray* %i, i32 0, i32 0
	store i32 15, i32* %_0
	store i32 3, i32* %y
	%_1 = load i32, i32* %y
	%_2 = add i32 %_1, 3
	store i32 %_2, i32* %x
	%_3 = load i32, i32* %x
	%_4 = icmp slt i32 %_3, 10
	store i1 %_4, i1* %t
	%_5 = load i32, i32* %y
	%_6 = icmp slt i32 %_5, 4
	store i1 %_6, i1* %z
	%_7 = add i32 0, 4
	%_8 = getelementptr %IntArray, %IntArray* %i, i32 0, i32 0
	%_9 = load i32, i32* %_8
	%_10 = icmp slt i32 %_7, %_9
	br i1 %_10, label %oob0, label %oob1

oob0:
	%_11 = getelementptr %IntArray, %IntArray* %i, i32 0, i32 1
	%_12 = load i32*, i32** %_11
	%_13 = getelementptr i32, i32* %_12, i32 %_7
	store i32 25, i32* %_13
	br label %oob2

oob1:
	call void @throw_oob()
	br label %oob2

oob2:
	%_14 = add i32 0, 3
	%_15 = load i32, i32* %x
	%_16 = getelementptr %IntArray, %IntArray* %i, i32 0, i32 0
	%_17 = load i32, i32* %_16
	%_18 = icmp slt i32 %_14, %_17
	br i1 %_18, label %oob3, label %oob4

oob3:
	%_19 = getelementptr %IntArray, %IntArray* %i, i32 0, i32 1
	%_20 = load i32*, i32** %_19
	%_21 = getelementptr i32, i32* %_20, i32 %_14
	store i32 %_15, i32* %_21
	br label %oob5

oob4:
	call void @throw_oob()
	br label %oob5

oob5:
	%_22 = load i1, i1* %t
	br label %if0
if0:
	%_23 = icmp ne i1 %_22, 0
	br i1 %_23, label %if1, label %if2

if1:
	%_26 = load i1, i1* %z
	%_24 = icmp ne i1 %_26, 0
	br label %if2

if2:
	%_25 = phi i1 [false, %if0], [%_24, %if1]
	%_27 = xor i1 %_25, true
	br i1 %_27, label %if3, label %if4

if3:
	%_28 = add i32 0, 4
	%_29 = getelementptr %IntArray, %IntArray* %i, i32 0, i32 0
	%_30 = load i32, i32* %_29
	%_31 = icmp slt i32 %_28, %_30
	br i1 %_31, label %oob6, label %oob7

oob6:
	%_32 = getelementptr %IntArray, %IntArray* %i, i32 0, i32 1
	%_33 = load i32*, i32** %_32
	%_34 = getelementptr i32, i32* %_33, i32 %_28
	%_35 = load i32, i32* %_34
	br label %oob8

oob7:
	call void @throw_oob()
	br label %oob8

oob8:
	call void @print_int(i32 %_35)
	br label %if5

if4:
	%_36 = add i32 0, 3
	%_37 = getelementptr %IntArray, %IntArray* %i, i32 0, i32 0
	%_38 = load i32, i32* %_37
	%_39 = icmp slt i32 %_36, %_38
	br i1 %_39, label %oob9, label %oob10

oob9:
	%_40 = getelementptr %IntArray, %IntArray* %i, i32 0, i32 1
	%_41 = load i32*, i32** %_40
	%_42 = getelementptr i32, i32* %_41, i32 %_36
	%_43 = load i32, i32* %_42
	br label %oob11

oob10:
	call void @throw_oob()
	br label %oob11

oob11:
	call void @print_int(i32 %_43)
	br label %if5

if5:
	ret i32 0
}
