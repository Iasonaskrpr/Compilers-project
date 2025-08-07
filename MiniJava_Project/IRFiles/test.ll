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
	%_1 = call i8* @calloc(i32 15, i32 4)
	%_2 = bitcast i8* %_1 to i32*
	%_3 = getelementptr %IntArray, %IntArray* %i, i32 0, i32 1
	store i32* %_2, i32** %_3
	store i32 3, i32* %y
	%_4 = load i32, i32* %y
	%_5 = add i32 %_4, 3
	store i32 %_5, i32* %x
	%_6 = load i32, i32* %x
	%_7 = icmp slt i32 %_6, 10
	store i1 %_7, i1* %t
	%_8 = load i32, i32* %y
	%_9 = icmp slt i32 %_8, 4
	store i1 %_9, i1* %z
	%_10 = add i32 0, 4
	%_11 = getelementptr %IntArray, %IntArray* %i, i32 0, i32 0
	%_12 = load i32, i32* %_11
	%_13 = icmp slt i32 %_10, %_12
	br i1 %_13, label %oob0, label %oob1

oob0:
	%_14 = getelementptr %IntArray, %IntArray* %i, i32 0, i32 1
	%_15 = load i32*, i32** %_14
	%_16 = getelementptr i32, i32* %_15, i32 %_10
	store i32 25, i32* %_16
	br label %oob2

oob1:
	br label %end

oob2:
	%_17 = add i32 0, 3
	%_18 = load i32, i32* %x
	%_19 = getelementptr %IntArray, %IntArray* %i, i32 0, i32 0
	%_20 = load i32, i32* %_19
	%_21 = icmp slt i32 %_17, %_20
	br i1 %_21, label %oob3, label %oob4

oob3:
	%_22 = getelementptr %IntArray, %IntArray* %i, i32 0, i32 1
	%_23 = load i32*, i32** %_22
	%_24 = getelementptr i32, i32* %_23, i32 %_17
	store i32 %_18, i32* %_24
	br label %oob5

oob4:
	br label %end

oob5:
	%_25 = load i1, i1* %t
	br label %if0
if0:
	%_26 = icmp ne i1 %_25, 0
	br i1 %_26, label %if1, label %if2

if1:
	%_29 = load i1, i1* %z
	%_27 = icmp ne i1 %_29, 0
	br label %if2

if2:
	%_28 = phi i1 [false, %if0], [%_27, %if1]
	br i1 %_28, label %if3, label %if4

if3:
		%_30 = add i32 0, 8
		%_31 = getelementptr %IntArray, %IntArray* %i, i32 0, i32 0
		%_32 = load i32, i32* %_31
		%_33 = icmp slt i32 %_30, %_32
		br i1 %_33, label %oob6, label %oob7

oob6:
		%_34 = getelementptr %IntArray, %IntArray* %i, i32 0, i32 1
		%_35 = load i32*, i32** %_34
		%_36 = getelementptr i32, i32* %_35, i32 %_30
		%_37 = load i32, i32* %_36
		br label %oob8

oob7:
		br label %end

oob8:
		call void @print_int(i32 %_37)
		br label %if5

if4:
		%_38 = add i32 0, 3
		%_39 = getelementptr %IntArray, %IntArray* %i, i32 0, i32 0
		%_40 = load i32, i32* %_39
		%_41 = icmp slt i32 %_38, %_40
		br i1 %_41, label %oob9, label %oob10

oob9:
		%_42 = getelementptr %IntArray, %IntArray* %i, i32 0, i32 1
		%_43 = load i32*, i32** %_42
		%_44 = getelementptr i32, i32* %_43, i32 %_38
		%_45 = load i32, i32* %_44
		br label %oob11

oob10:
		br label %end

oob11:
		call void @print_int(i32 %_45)
		br label %if5

if5:
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
