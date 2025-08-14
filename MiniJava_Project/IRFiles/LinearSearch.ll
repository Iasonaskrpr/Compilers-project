@.LS_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*,i32)* @LS.Start to i8*),i8* bitcast (i32 (i8*)* @LS.Print to i8*),i8* bitcast (i32 (i8*,i32)* @LS.Search to i8*),i8* bitcast (i32 (i8*,i32)* @LS.Init to i8*)]
%class.LS = type{ %IntArray, i32 }
%IntArray = type { i32, i32* }
%BooleanArray = type { i32, i8* }
declare i8* @calloc(i64, i64)
declare i32 @printf(i8*, ...)
declare void @free(i8*)
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
	%_0 = alloca %class.LS*
	store %class.LS* null, %class.LS** %_0
	%_4 = getelementptr %class.LS, %class.LS* null, i32 1
	%_1 = ptrtoint %class.LS* %_4 to i32
	%ext = zext i32 %_1 to i64
	%_2 = call i8* @calloc(i64 1, i64 %ext)
	%_3 = bitcast i8* %_2 to %class.LS*
	store %class.LS* %_3, %class.LS** %_0
	%_5 = getelementptr [4 x i8*], [4 x i8*]* @.LS_vtable, i32 0, i32 0
	%_6 = load i8*, i8** %_5
	%_7 = bitcast i8* %_6 to i32(i8*, i32)*
	%_8 = call i32 %_7(i8* %_0, i32 10)
	call void @free(i8* %_2)
	call void @print_int(i32 %_8)
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
define i32 @LS.Start(i8* %this_raw, i32 %sz) {
	%this = bitcast i8* %this_raw to %class.LS*
	%aux01 = alloca i32
	%aux02 = alloca i32
	%_9 = getelementptr [4 x i8*], [4 x i8*]* @.LS_vtable, i32 0, i32 3
	%_10 = load i8*, i8** %_9
	%_11 = bitcast i8* %_10 to i32(i8*, i32)*
	%_12 = call i32 %_11(i8* %this, i32 %sz)
	store i32 %_12, i32* %aux01
	%_16 = getelementptr [4 x i8*], [4 x i8*]* @.LS_vtable, i32 0, i32 1
	%_17 = load i8*, i8** %_16
	%_18 = bitcast i8* %_17 to i32(i8*)*
	%_19 = call i32 %_18(i8* %this)
	store i32 %_19, i32* %aux02
	call void @print_int(i32 9999)
	%_22 = getelementptr [4 x i8*], [4 x i8*]* @.LS_vtable, i32 0, i32 2
	%_23 = load i8*, i8** %_22
	%_24 = bitcast i8* %_23 to i32(i8*, i32)*
	%_25 = call i32 %_24(i8* %this, i32 8)
	call void @print_int(i32 %_25)
	%_28 = getelementptr [4 x i8*], [4 x i8*]* @.LS_vtable, i32 0, i32 2
	%_29 = load i8*, i8** %_28
	%_30 = bitcast i8* %_29 to i32(i8*, i32)*
	%_31 = call i32 %_30(i8* %this, i32 12)
	call void @print_int(i32 %_31)
	%_34 = getelementptr [4 x i8*], [4 x i8*]* @.LS_vtable, i32 0, i32 2
	%_35 = load i8*, i8** %_34
	%_36 = bitcast i8* %_35 to i32(i8*, i32)*
	%_37 = call i32 %_36(i8* %this, i32 17)
	call void @print_int(i32 %_37)
	%_40 = getelementptr [4 x i8*], [4 x i8*]* @.LS_vtable, i32 0, i32 2
	%_41 = load i8*, i8** %_40
	%_42 = bitcast i8* %_41 to i32(i8*, i32)*
	%_43 = call i32 %_42(i8* %this, i32 50)
	call void @print_int(i32 %_43)
	%array_ptr_ptr = getelementptr %class.LS, %class.LS* %this, i32 0, i32 0
	%array_ptr = load %IntArray*, %IntArray** %array_ptr_ptr
	%array_ptr_i8 = bitcast %IntArray* %array_ptr to i8*
	call void @free(i8* %array_ptr_i8)
	ret i32 55

end:
	call void @throw_oob()
	ret i32 1
}
define i32 @LS.Print(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.LS*
	%j = alloca i32
	store i32 1, i32* %j
	br label %loop0

loop0:
		%_48 = load i32, i32* %j
		%_49 = getelementptr %class.LS, %class.LS* %this, i32 0, i32 1
		%_50 = load i32, i32* %_49
		%_51 = icmp slt i32 %_48, %_50
		br i1 %_51, label %loop1, label %loop2

loop1:
		%_52 = load i32, i32* %j
		%_53 = getelementptr %class.LS, %class.LS* %this, i32 0, i32 0
		%_54 = getelementptr %IntArray, %IntArray* %_53, i32 0, i32 0
		%_55 = load i32, i32* %_54
		%_56 = icmp slt i32 %_52, %_55
		br i1 %_56, label %oob0, label %oob1

oob0:
		%_57 = getelementptr %IntArray, %IntArray* %_53, i32 0, i32 1
		%_58 = load i32*, i32** %_57
		%_59 = getelementptr i32, i32* %_58, i32 %_52
		%_60 = load i32, i32* %_59
		br label %oob2

oob1:
		br label %end

oob2:
		call void @print_int(i32 %_60)
		%_62 = load i32, i32* %j
		%_63 = add i32 %_62, 1
		store i32 %_63, i32* %j
		br label %loop0

loop2:
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
define i32 @LS.Search(i8* %this_raw, i32 %num) {
	%this = bitcast i8* %this_raw to %class.LS*
	%j = alloca i32
	%ls01 = alloca i1
	%ifound = alloca i32
	%aux01 = alloca i32
	%aux02 = alloca i32
	%nt = alloca i32
	store i32 1, i32* %j
	store i1 0, i1* %ls01
	store i32 0, i32* %ifound
	br label %loop3

loop3:
		%_72 = load i32, i32* %j
		%_73 = getelementptr %class.LS, %class.LS* %this, i32 0, i32 1
		%_74 = load i32, i32* %_73
		%_75 = icmp slt i32 %_72, %_74
		br i1 %_75, label %loop4, label %loop5

loop4:
		%_76 = load i32, i32* %j
		%_77 = getelementptr %class.LS, %class.LS* %this, i32 0, i32 0
		%_78 = getelementptr %IntArray, %IntArray* %_77, i32 0, i32 0
		%_79 = load i32, i32* %_78
		%_80 = icmp slt i32 %_76, %_79
		br i1 %_80, label %oob3, label %oob4

oob3:
		%_81 = getelementptr %IntArray, %IntArray* %_77, i32 0, i32 1
		%_82 = load i32*, i32** %_81
		%_83 = getelementptr i32, i32* %_82, i32 %_76
		%_84 = load i32, i32* %_83
		br label %oob5

oob4:
		br label %end

oob5:
		store i32 %_84, i32* %aux01
		%_88 = add i32 %num, 1
		store i32 %_88, i32* %aux02
		%_91 = load i32, i32* %aux01
		%_93 = icmp slt i32 %_91, %num
		br i1 %_93, label %if0, label %if1

if0:
			store i32 0, i32* %nt
			br label %if2

if1:
			%_96 = load i32, i32* %aux01
			%_97 = load i32, i32* %aux02
			%_98 = icmp slt i32 %_96, %_97
			%_99 = xor i1 %_98, true
			br i1 %_99, label %if3, label %if4

if3:
				store i32 0, i32* %nt
				br label %if5

if4:
				store i1 1, i1* %ls01
				store i32 1, i32* %ifound
				%_106 = getelementptr %class.LS, %class.LS* %this, i32 0, i32 1
				%_107 = load i32, i32* %_106
				store i32 %_107, i32* %j
				br label %if5

if5:
			br label %if2

if2:
		%_109 = load i32, i32* %j
		%_110 = add i32 %_109, 1
		store i32 %_110, i32* %j
		br label %loop3

loop5:
	%_113 = load i32, i32* %ifound
	ret i32 %_113

end:
	call void @throw_oob()
	ret i32 1
}
define i32 @LS.Init(i8* %this_raw, i32 %sz) {
	%this = bitcast i8* %this_raw to %class.LS*
	%j = alloca i32
	%k = alloca i32
	%aux01 = alloca i32
	%aux02 = alloca i32
	%_115 = getelementptr %class.LS, %class.LS* %this, i32 0, i32 1
	store i32 %sz, i32* %_115
	%_117 = getelementptr %class.LS, %class.LS* %this, i32 0, i32 0
	%_118 = getelementptr %IntArray, %IntArray* %_117, i32 0, i32 0
	store i32 %sz, i32* %_118
	%sz_ext = zext i32 %sz to i64
	%_119 = call i8* @calloc(i64 %sz_ext, i64 4)
	%_120 = bitcast i8* %_119 to i32*
	%_121 = getelementptr %IntArray, %IntArray* %_117, i32 0, i32 1
	store i32* %_120, i32** %_121
	store i32 1, i32* %j
	%_124 = getelementptr %class.LS, %class.LS* %this, i32 0, i32 1
	%_125 = load i32, i32* %_124
	%_126 = add i32 %_125, 1
	store i32 %_126, i32* %k
	br label %loop6

loop6:
		%_129 = load i32, i32* %j
		%_130 = getelementptr %class.LS, %class.LS* %this, i32 0, i32 1
		%_131 = load i32, i32* %_130
		%_132 = icmp slt i32 %_129, %_131
		br i1 %_132, label %loop7, label %loop8

loop7:
		%_133 = load i32, i32* %j
		%_134 = mul i32 2, %_133
		store i32 %_134, i32* %aux01
		%_137 = load i32, i32* %k
		%_138 = sub i32 %_137, 3
		store i32 %_138, i32* %aux02
		%_141 = load i32, i32* %j
		%_142 = load i32, i32* %aux01
		%_143 = load i32, i32* %aux02
		%_144 = add i32 %_142, %_143
		%_145 = getelementptr %class.LS, %class.LS* %this, i32 0, i32 0
		%_147 = getelementptr %IntArray, %IntArray* %_145, i32 0, i32 0
		%_148 = load i32, i32* %_147
		%_149 = icmp slt i32 %_141, %_148
		br i1 %_149, label %oob6, label %oob7

oob6:
		%_150 = getelementptr %IntArray, %IntArray* %_145, i32 0, i32 1
		%_151 = load i32*, i32** %_150
		%_152 = getelementptr i32, i32* %_151, i32 %_141
		store i32 %_144, i32* %_152
		br label %oob8

oob7:
		br label %end

oob8:
		%_153 = load i32, i32* %j
		%_154 = add i32 %_153, 1
		store i32 %_154, i32* %j
		%_157 = load i32, i32* %k
		%_158 = sub i32 %_157, 1
		store i32 %_158, i32* %k
		br label %loop6

loop8:
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
