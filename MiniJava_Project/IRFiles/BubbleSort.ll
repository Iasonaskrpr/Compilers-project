@.BBS_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*,i32)* @BBS.Start to i8*),i8* bitcast (%IntArray (i8*)* @BBS.Sort to i8*),i8* bitcast (i32 (i8*)* @BBS.Print to i8*),i8* bitcast (i32 (i8*,i32)* @BBS.Init to i8*)]
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
	%_0 = alloca %class.BBS*
	store %class.BBS* null, %class.BBS** %_0
	%_4 = getelementptr %class.BBS, %class.BBS* null, i32 1
	%_1 = ptrtoint %class.BBS* %_4 to i32
	%_2 = call i8* @calloc(i32 1, i32 %_1)
	%_3 = bitcast i8* %_2 to %class.BBS*
	store %class.BBS* %_3, %class.BBS** %_0
	%_5 = getelementptr [4 x i8*], [4 x i8*]* @.BBS_vtable, i32 0, i32 0
	%_6 = load i8*, i8** %_5
	%_7 = bitcast i8* %_6 to i32(i8*, i32)*
	%_8 = call i32 %_7(i8* %_0	, i32 10	)
	call void @print_int(i32 %_8)
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
define i32 @BBS.Start(i8* %this_raw, i32 %sz) {
	%this = bitcast i8* %this_raw to %class.BBS*
	%aux2 = alloca i32
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
define %IntArray @BBS.Sort(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.BBS*
	%nt = alloca i32
	%i = alloca i32
	%aux02 = alloca i32
	%aux04 = alloca i32
	%aux05 = alloca i32
	%aux06 = alloca i32
	%aux07 = alloca i32
	%j = alloca i32
	%t = alloca i32
	%_9 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 1
	%_10 = load i32, i32* %_9
	%_11 = sub i32 %_10, 1
	store i32 %_11, i32* %i
	%_13 = sub i32 0, 1
	store i32 %_13, i32* %aux02
	br label %loop0

loop0:
		%_15 = load i32, i32* %aux02
		%_16 = load i32, i32* %i
		%_17 = icmp slt i32 %_15, %_16
		br i1 %_17, label %loop1, label %loop2

loop1:
		store i32 1, i32* %j
		br label %loop3

loop3:
			%_19 = load i32, i32* %j
			%_20 = load i32, i32* %i
			%_21 = add i32 %_20, 1
			%_23 = icmp slt i32 %_19, %_21
			br i1 %_23, label %loop4, label %loop5

loop4:
			%_24 = load i32, i32* %j
			%_25 = sub i32 %_24, 1
			store i32 %_25, i32* %aux07
			%_27 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
			%_28 = getelementptr %IntArray, %IntArray* %_27, i32 0, i32 0
			%_29 = load i32, i32* %_28
			%_30 = icmp slt i32 aux07, %_29
			br i1 %_30, label %oob0, label %oob1

oob0:
			%_31 = getelementptr %IntArray, %IntArray* %_27, i32 0, i32 1
			%_32 = load i32*, i32** %_31
			%_33 = getelementptr i32, i32* %_32, i32 aux07
			%_34 = load i32, i32* %_33
			br label %oob2

oob1:
			br label %end

oob2:
			store i32 %_34, i32* %aux04
			%_36 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
			%_37 = getelementptr %IntArray, %IntArray* %_36, i32 0, i32 0
			%_38 = load i32, i32* %_37
			%_39 = icmp slt i32 j, %_38
			br i1 %_39, label %oob3, label %oob4

oob3:
			%_40 = getelementptr %IntArray, %IntArray* %_36, i32 0, i32 1
			%_41 = load i32*, i32** %_40
			%_42 = getelementptr i32, i32* %_41, i32 j
			%_43 = load i32, i32* %_42
			br label %oob5

oob4:
			br label %end

oob5:
			store i32 %_43, i32* %aux05
			%_45 = load i32, i32* %aux05
			%_46 = load i32, i32* %aux04
			%_47 = icmp slt i32 %_45, %_46
			br i1 %_47, label %if0, label %if1

if0:
				%_48 = load i32, i32* %j
				%_49 = sub i32 %_48, 1
				store i32 %_49, i32* %aux06
				%_51 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
				%_52 = getelementptr %IntArray, %IntArray* %_51, i32 0, i32 0
				%_53 = load i32, i32* %_52
				%_54 = icmp slt i32 aux06, %_53
				br i1 %_54, label %oob6, label %oob7

oob6:
				%_55 = getelementptr %IntArray, %IntArray* %_51, i32 0, i32 1
				%_56 = load i32*, i32** %_55
				%_57 = getelementptr i32, i32* %_56, i32 aux06
				%_58 = load i32, i32* %_57
				br label %oob8

oob7:
				br label %end

oob8:
				store i32 %_58, i32* %t
				%_60 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
				%_61 = getelementptr %IntArray, %IntArray* %_60, i32 0, i32 0
				%_62 = load i32, i32* %_61
				%_63 = icmp slt i32 j, %_62
				br i1 %_63, label %oob12, label %oob13

oob12:
				%_64 = getelementptr %IntArray, %IntArray* %_60, i32 0, i32 1
				%_65 = load i32*, i32** %_64
				%_66 = getelementptr i32, i32* %_65, i32 j
				%_67 = load i32, i32* %_66
				br label %oob14

oob13:
				br label %end

oob14:
				%_68 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
				%_70 = getelementptr %IntArray, %IntArray* %_68, i32 0, i32 0
				%_71 = load i32, i32* %_70
				%_72 = icmp slt i32 aux06, %_71
				br i1 %_72, label %oob9, label %oob10

oob9:
				%_73 = getelementptr %IntArray, %IntArray* %_68, i32 0, i32 1
				%_74 = load i32*, i32** %_73
				%_75 = getelementptr i32, i32* %_74, i32 aux06
				store i32 %_67, i32* %_75
				br label %oob11

oob10:
				br label %end

oob11:
				%_76 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
				%_77 = load i32, i32* %t
				%_78 = getelementptr %IntArray, %IntArray* %_76, i32 0, i32 0
				%_79 = load i32, i32* %_78
				%_80 = icmp slt i32 j, %_79
				br i1 %_80, label %oob15, label %oob16

oob15:
				%_81 = getelementptr %IntArray, %IntArray* %_76, i32 0, i32 1
				%_82 = load i32*, i32** %_81
				%_83 = getelementptr i32, i32* %_82, i32 j
				store i32 %_77, i32* %_83
				br label %oob17

oob16:
				br label %end

oob17:
				br label %if2

if1:
				store i32 0, i32* %nt
				br label %if2

if2:
			%_85 = load i32, i32* %j
			%_86 = add i32 %_85, 1
			store i32 %_86, i32* %j
			br label %loop3

loop5:
		%_88 = load i32, i32* %i
		%_89 = sub i32 %_88, 1
		store i32 %_89, i32* %i
		br label %loop0

loop2:
	%_91 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_92 = load %IntArray, %IntArray* %_91
	ret %IntArray %_92

end:
	call void @throw_oob()
	ret %IntArray null
}
define i32 @BBS.Print(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.BBS*
	%j = alloca i32
	store i32 0, i32* %j
	br label %loop6

loop6:
		%_94 = load i32, i32* %j
		%_95 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 1
		%_96 = load i32, i32* %_95
		%_97 = icmp slt i32 %_94, %_96
		br i1 %_97, label %loop7, label %loop8

loop7:
		%_98 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
		%_99 = getelementptr %IntArray, %IntArray* %_98, i32 0, i32 0
		%_100 = load i32, i32* %_99
		%_101 = icmp slt i32 j, %_100
		br i1 %_101, label %oob18, label %oob19

oob18:
		%_102 = getelementptr %IntArray, %IntArray* %_98, i32 0, i32 1
		%_103 = load i32*, i32** %_102
		%_104 = getelementptr i32, i32* %_103, i32 j
		%_105 = load i32, i32* %_104
		br label %oob20

oob19:
		br label %end

oob20:
		call void @print_int(i32 %_105)
		%_107 = load i32, i32* %j
		%_108 = add i32 %_107, 1
		store i32 %_108, i32* %j
		br label %loop6

loop8:
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
define i32 @BBS.Init(i8* %this_raw, i32 %sz) {
	%this = bitcast i8* %this_raw to %class.BBS*
	%_110 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 1
	store i32 sz, i32* %_110
	%_111 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_112 = getelementptr %IntArray, %IntArray* %_111, i32 0, i32 0
	store i32 sz, i32* %_112
	%_113 = call i8* @calloc(i32 sz, i32 4)
	%_114 = bitcast i8* %_113 to i32*
	%_115 = getelementptr %IntArray, %IntArray* %_111, i32 0, i32 1
	store i32* %_114, i32** %_115
	%_116 = add i32 0, 0
	%_117 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_118 = getelementptr %IntArray, %IntArray* %_117, i32 0, i32 0
	%_119 = load i32, i32* %_118
	%_120 = icmp slt i32 %_116, %_119
	br i1 %_120, label %oob21, label %oob22

oob21:
	%_121 = getelementptr %IntArray, %IntArray* %_117, i32 0, i32 1
	%_122 = load i32*, i32** %_121
	%_123 = getelementptr i32, i32* %_122, i32 %_116
	store i32 20, i32* %_123
	br label %oob23

oob22:
	br label %end

oob23:
	%_124 = add i32 0, 1
	%_125 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_126 = getelementptr %IntArray, %IntArray* %_125, i32 0, i32 0
	%_127 = load i32, i32* %_126
	%_128 = icmp slt i32 %_124, %_127
	br i1 %_128, label %oob24, label %oob25

oob24:
	%_129 = getelementptr %IntArray, %IntArray* %_125, i32 0, i32 1
	%_130 = load i32*, i32** %_129
	%_131 = getelementptr i32, i32* %_130, i32 %_124
	store i32 7, i32* %_131
	br label %oob26

oob25:
	br label %end

oob26:
	%_132 = add i32 0, 2
	%_133 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_134 = getelementptr %IntArray, %IntArray* %_133, i32 0, i32 0
	%_135 = load i32, i32* %_134
	%_136 = icmp slt i32 %_132, %_135
	br i1 %_136, label %oob27, label %oob28

oob27:
	%_137 = getelementptr %IntArray, %IntArray* %_133, i32 0, i32 1
	%_138 = load i32*, i32** %_137
	%_139 = getelementptr i32, i32* %_138, i32 %_132
	store i32 12, i32* %_139
	br label %oob29

oob28:
	br label %end

oob29:
	%_140 = add i32 0, 3
	%_141 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_142 = getelementptr %IntArray, %IntArray* %_141, i32 0, i32 0
	%_143 = load i32, i32* %_142
	%_144 = icmp slt i32 %_140, %_143
	br i1 %_144, label %oob30, label %oob31

oob30:
	%_145 = getelementptr %IntArray, %IntArray* %_141, i32 0, i32 1
	%_146 = load i32*, i32** %_145
	%_147 = getelementptr i32, i32* %_146, i32 %_140
	store i32 18, i32* %_147
	br label %oob32

oob31:
	br label %end

oob32:
	%_148 = add i32 0, 4
	%_149 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_150 = getelementptr %IntArray, %IntArray* %_149, i32 0, i32 0
	%_151 = load i32, i32* %_150
	%_152 = icmp slt i32 %_148, %_151
	br i1 %_152, label %oob33, label %oob34

oob33:
	%_153 = getelementptr %IntArray, %IntArray* %_149, i32 0, i32 1
	%_154 = load i32*, i32** %_153
	%_155 = getelementptr i32, i32* %_154, i32 %_148
	store i32 2, i32* %_155
	br label %oob35

oob34:
	br label %end

oob35:
	%_156 = add i32 0, 5
	%_157 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_158 = getelementptr %IntArray, %IntArray* %_157, i32 0, i32 0
	%_159 = load i32, i32* %_158
	%_160 = icmp slt i32 %_156, %_159
	br i1 %_160, label %oob36, label %oob37

oob36:
	%_161 = getelementptr %IntArray, %IntArray* %_157, i32 0, i32 1
	%_162 = load i32*, i32** %_161
	%_163 = getelementptr i32, i32* %_162, i32 %_156
	store i32 11, i32* %_163
	br label %oob38

oob37:
	br label %end

oob38:
	%_164 = add i32 0, 6
	%_165 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_166 = getelementptr %IntArray, %IntArray* %_165, i32 0, i32 0
	%_167 = load i32, i32* %_166
	%_168 = icmp slt i32 %_164, %_167
	br i1 %_168, label %oob39, label %oob40

oob39:
	%_169 = getelementptr %IntArray, %IntArray* %_165, i32 0, i32 1
	%_170 = load i32*, i32** %_169
	%_171 = getelementptr i32, i32* %_170, i32 %_164
	store i32 6, i32* %_171
	br label %oob41

oob40:
	br label %end

oob41:
	%_172 = add i32 0, 7
	%_173 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_174 = getelementptr %IntArray, %IntArray* %_173, i32 0, i32 0
	%_175 = load i32, i32* %_174
	%_176 = icmp slt i32 %_172, %_175
	br i1 %_176, label %oob42, label %oob43

oob42:
	%_177 = getelementptr %IntArray, %IntArray* %_173, i32 0, i32 1
	%_178 = load i32*, i32** %_177
	%_179 = getelementptr i32, i32* %_178, i32 %_172
	store i32 9, i32* %_179
	br label %oob44

oob43:
	br label %end

oob44:
	%_180 = add i32 0, 8
	%_181 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_182 = getelementptr %IntArray, %IntArray* %_181, i32 0, i32 0
	%_183 = load i32, i32* %_182
	%_184 = icmp slt i32 %_180, %_183
	br i1 %_184, label %oob45, label %oob46

oob45:
	%_185 = getelementptr %IntArray, %IntArray* %_181, i32 0, i32 1
	%_186 = load i32*, i32** %_185
	%_187 = getelementptr i32, i32* %_186, i32 %_180
	store i32 19, i32* %_187
	br label %oob47

oob46:
	br label %end

oob47:
	%_188 = add i32 0, 9
	%_189 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_190 = getelementptr %IntArray, %IntArray* %_189, i32 0, i32 0
	%_191 = load i32, i32* %_190
	%_192 = icmp slt i32 %_188, %_191
	br i1 %_192, label %oob48, label %oob49

oob48:
	%_193 = getelementptr %IntArray, %IntArray* %_189, i32 0, i32 1
	%_194 = load i32*, i32** %_193
	%_195 = getelementptr i32, i32* %_194, i32 %_188
	store i32 5, i32* %_195
	br label %oob50

oob49:
	br label %end

oob50:
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
