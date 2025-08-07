@.BBS_vtable = global [3 x i8*] [i8* bitcast (%IntArray (i8*)* @BBS.Sort to i8*),i8* bitcast (i32 (i8*)* @BBS.Print to i8*),i8* bitcast (i32 (i8*,i32)* @BBS.Init to i8*)]
%class.BBS = type{ %IntArray, i32 }
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
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
define %IntArray @BBS.Sort(i8* this) {
	%nt = alloca i32
	%i = alloca i32
	%aux02 = alloca i32
	%aux04 = alloca i32
	%aux05 = alloca i32
	%aux06 = alloca i32
	%aux07 = alloca i32
	%j = alloca i32
	%t = alloca i32
	%_0 = sub i32 size, 1
	store i32 %_0, i32* %i
	%_1 = sub i32 0, 1
	store i32 %_1, i32* %aux02
	br label %loop0

loop0:
		%_2 = load i32, i32* %aux02
		%_3 = load i32, i32* %i
		%_4 = icmp slt i32 %_2, %_3
		br i1 %_4, label %loop1, label %loop2

loop1:
		store i32 1, i32* %j
		br label %loop3

loop3:
			%_5 = load i32, i32* %j
			%_6 = load i32, i32* %i
			%_7 = add i32 %_6, 1
			%_8 = icmp slt i32 %_5, %_7
			br i1 %_8, label %loop4, label %loop5

loop4:
			%_9 = load i32, i32* %j
			%_10 = sub i32 %_9, 1
			store i32 %_10, i32* %aux07
			%_11 = getelementptr null, null* %number, i32 0, i32 0
			%_12 = load i32, i32* %_11
			%_13 = icmp slt i32 aux07, %_12
			br i1 %_13, label %oob0, label %oob1

oob0:
