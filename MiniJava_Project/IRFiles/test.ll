@.Greeter_vtable = global [2 x i8*] [i8* bitcast (i32 (i8*,i8*)* @Greeter.sayHello to i8*),i8* bitcast (i32 (i8*,i32)* @Greeter.update to i8*)]
%class.Greeter = type{ i32, i32, i32, i8* }
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
	%b = alloca %class.Greeter*
	store %class.Greeter* null, %class.Greeter** %b
	%y = alloca %class.Greeter*
	store %class.Greeter* null, %class.Greeter** %y
	%x = alloca i32
	%_3 = getelementptr %class.Greeter, %class.Greeter* null, i32 1
	%_0 = ptrtoint %class.Greeter* %_3 to i32
	%_1 = call i8* @calloc(i32 1, i32 %_0)
	%_2 = bitcast i8* %_1 to %class.Greeter*
	store %class.Greeter* %_2, %class.Greeter** %b
	br i1 true, label %if0, label %if1

if0:
		%_4 = getelementptr [2 x i8*], [2 x i8*]* @.Greeter_vtable, i32 0, i32 0
		%_5 = load i8*, i8** %_4
		%_6 = bitcast i8* %_5 to i32(i8*, i8*)*
		%_8 = load %class.Greeter*, %class.Greeter** %b
		%_9 = bitcast %class.Greeter* %_8 to i8*
		%_10 = load %class.Greeter*, %class.Greeter** %y
		%_7 = call i32 %_6(i8* %_9, i8* %_10)
		store i32 %_7, i32* %x
		br label %if2

if1:
		store i32 4, i32* %x
		br label %if2

if2:
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
define i32 @Greeter.sayHello(i8* %this_raw, i8* %h_raw) {
	%this = bitcast i8* %this_raw to %class.Greeter*
	%.h = bitcast i8* %h_raw to %class.Greeter*
	%h = alloca %class.Greeter*
	store %class.Greeter* %.h, %class.Greeter** %h
	%_12 = getelementptr %class.Greeter, %class.Greeter* %this, i32 0, i32 1
	store i32 8, i32* %_12
	%_18 = getelementptr %class.Greeter, %class.Greeter* null, i32 1
	%_15 = ptrtoint %class.Greeter* %_18 to i32
	%_16 = call i8* @calloc(i32 1, i32 %_15)
	%_17 = bitcast i8* %_16 to %class.Greeter*
	store %class.Greeter* %_17, %class.Greeter** %h
	br i1 true, label %if3, label %if4

if3:
		%_19 = getelementptr [2 x i8*], [2 x i8*]* @.Greeter_vtable, i32 0, i32 1
		%_20 = load i8*, i8** %_19
		%_21 = bitcast i8* %_20 to i32(i8*, i32)*
		%_23 = load %class.Greeter*, %class.Greeter** %h
		%_24 = bitcast %class.Greeter* %_23 to i8*
		%_25 = getelementptr %class.Greeter, %class.Greeter* %this, i32 0, i32 1
		%_26 = load i32, i32* %_25
		%_22 = call i32 %_21(i8* %_24, i32 %_26)
		%_28 = getelementptr %class.Greeter, %class.Greeter* %this, i32 0, i32 0
		store i32 %_22, i32* %_28
		br label %if5

if4:
		%_30 = getelementptr %class.Greeter, %class.Greeter* %this, i32 0, i32 1
		store i32 4, i32* %_30
		br label %if5

if5:
	%_31 = getelementptr %class.Greeter, %class.Greeter* %this, i32 0, i32 1
	%_32 = load i32, i32* %_31
	call void @print_int(i32 %_32)
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
define i32 @Greeter.update(i8* %this_raw, i32 %.j) {
	%this = bitcast i8* %this_raw to %class.Greeter*
	%j = alloca i32
	store i32 %.j, i32* %j
	%_34 = getelementptr %class.Greeter, %class.Greeter* %this, i32 0, i32 1
	store i32 3, i32* %_34
	%_35 = getelementptr %class.Greeter, %class.Greeter* %this, i32 0, i32 1
	%_36 = load i32, i32* %_35
	ret i32 %_36

end:
	call void @throw_oob()
	ret i32 1
}
