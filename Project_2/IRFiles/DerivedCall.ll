@.A_vtable = global [0 x i8*] ]
@.B_vtable = global [0 x i8*] ]
@.F_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*,i8*)* @F.foo to i8*)]
%class.A = type{ i32 }
%class.B = type{ %class.A, i32, i32 }
%class.F = type{ }
declare i8* @calloc(i32, i32)
declare i32 @printf(i8*, ...)
declare void @exit(i32)
@_cint = constant [4 x i8] c"%d a "
@_cOOB = constant [15 x i8] c"Out of bounds a "
%IntArray = type { i32, i32* }
%BooleanArray = type { i32, i8* }
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