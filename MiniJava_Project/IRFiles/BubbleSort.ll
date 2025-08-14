@.BBS_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*,i32)* @BBS.Start to i8*),i8* bitcast (i32 (i8*)* @BBS.Sort to i8*),i8* bitcast (i32 (i8*)* @BBS.Print to i8*),i8* bitcast (i32 (i8*,i32)* @BBS.Init to i8*)]
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
	%_1 = alloca %class.BBS*
	store %class.BBS* null, %class.BBS** %_1
	%_5 = getelementptr %class.BBS, %class.BBS* null, i32 1
	%_2 = ptrtoint %class.BBS* %_5 to i32
	%_3 = call i8* @calloc(i32 1, i32 %_2)
	%_4 = bitcast i8* %_3 to %class.BBS*
	store %class.BBS* %_4, %class.BBS** %_1
	%_0 = load %class.BBS*, %class.BBS** %_1
	%_6 = getelementptr [4 x i8*], [4 x i8*]* @.BBS_vtable, i32 0, i32 0
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i32(i8*, i32)*
	%_10 = bitcast %class.BBS* %_0 to i8*
	%_9 = call i32 %_8(i8* %_10, i32 10)
	call void @print_int(i32 %_9)
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
define i32 @BBS.Start(i8* %this_raw, i32 %sz) {
	%this = bitcast i8* %this_raw to %class.BBS*
	%aux01 = alloca i32
	%_11 = getelementptr [4 x i8*], [4 x i8*]* @.BBS_vtable, i32 0, i32 3
	%_12 = load i8*, i8** %_11
	%_13 = bitcast i8* %_12 to i32(i8*, i32)*
	%_15 = bitcast %class.BBS* %this to i8*
	%_14 = call i32 %_13(i8* %_15, i32 %sz)
	store i32 %_14, i32* %aux01
	%_18 = getelementptr [4 x i8*], [4 x i8*]* @.BBS_vtable, i32 0, i32 2
	%_19 = load i8*, i8** %_18
	%_20 = bitcast i8* %_19 to i32(i8*)*
	%_22 = bitcast %class.BBS* %this to i8*
	%_21 = call i32 %_20(i8* %_22)
	store i32 %_21, i32* %aux01
	call void @print_int(i32 99999)
	%_25 = getelementptr [4 x i8*], [4 x i8*]* @.BBS_vtable, i32 0, i32 1
	%_26 = load i8*, i8** %_25
	%_27 = bitcast i8* %_26 to i32(i8*)*
	%_29 = bitcast %class.BBS* %this to i8*
	%_28 = call i32 %_27(i8* %_29)
	store i32 %_28, i32* %aux01
	%_32 = getelementptr [4 x i8*], [4 x i8*]* @.BBS_vtable, i32 0, i32 2
	%_33 = load i8*, i8** %_32
	%_34 = bitcast i8* %_33 to i32(i8*)*
	%_36 = bitcast %class.BBS* %this to i8*
	%_35 = call i32 %_34(i8* %_36)
	store i32 %_35, i32* %aux01
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
define i32 @BBS.Sort(i8* %this_raw) {
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
	%_39 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 1
	%_40 = load i32, i32* %_39
	%_41 = sub i32 %_40, 1
	store i32 %_41, i32* %i
	%_44 = sub i32 0, 1
	store i32 %_44, i32* %aux02
	br label %loop0

loop0:
		%_47 = load i32, i32* %aux02
		%_48 = load i32, i32* %i
		%_49 = icmp slt i32 %_47, %_48
		br i1 %_49, label %loop1, label %loop2

loop1:
		store i32 1, i32* %j
		br label %loop3

loop3:
			%_52 = load i32, i32* %j
			%_53 = load i32, i32* %i
			%_54 = add i32 %_53, 1
			%_56 = icmp slt i32 %_52, %_54
			br i1 %_56, label %loop4, label %loop5

loop4:
			%_57 = load i32, i32* %j
			%_58 = sub i32 %_57, 1
			store i32 %_58, i32* %aux07
			%_61 = load i32, i32* %aux07
			%_62 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
			%_63 = getelementptr %IntArray, %IntArray* %_62, i32 0, i32 0
			%_64 = load i32, i32* %_63
			%_65 = icmp slt i32 %_61, %_64
			br i1 %_65, label %oob0, label %oob1

oob0:
			%_66 = getelementptr %IntArray, %IntArray* %_62, i32 0, i32 1
			%_67 = load i32*, i32** %_66
			%_68 = getelementptr i32, i32* %_67, i32 %_61
			%_69 = load i32, i32* %_68
			br label %oob2

oob1:
			br label %end

oob2:
			store i32 %_69, i32* %aux04
			%_72 = load i32, i32* %j
			%_73 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
			%_74 = getelementptr %IntArray, %IntArray* %_73, i32 0, i32 0
			%_75 = load i32, i32* %_74
			%_76 = icmp slt i32 %_72, %_75
			br i1 %_76, label %oob3, label %oob4

oob3:
			%_77 = getelementptr %IntArray, %IntArray* %_73, i32 0, i32 1
			%_78 = load i32*, i32** %_77
			%_79 = getelementptr i32, i32* %_78, i32 %_72
			%_80 = load i32, i32* %_79
			br label %oob5

oob4:
			br label %end

oob5:
			store i32 %_80, i32* %aux05
			%_83 = load i32, i32* %aux05
			%_84 = load i32, i32* %aux04
			%_85 = icmp slt i32 %_83, %_84
			br i1 %_85, label %if0, label %if1

if0:
				%_86 = load i32, i32* %j
				%_87 = sub i32 %_86, 1
				store i32 %_87, i32* %aux06
				%_90 = load i32, i32* %aux06
				%_91 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
				%_92 = getelementptr %IntArray, %IntArray* %_91, i32 0, i32 0
				%_93 = load i32, i32* %_92
				%_94 = icmp slt i32 %_90, %_93
				br i1 %_94, label %oob6, label %oob7

oob6:
				%_95 = getelementptr %IntArray, %IntArray* %_91, i32 0, i32 1
				%_96 = load i32*, i32** %_95
				%_97 = getelementptr i32, i32* %_96, i32 %_90
				%_98 = load i32, i32* %_97
				br label %oob8

oob7:
				br label %end

oob8:
				store i32 %_98, i32* %t
				%_101 = load i32, i32* %aux06
				%_102 = load i32, i32* %j
				%_103 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
				%_104 = getelementptr %IntArray, %IntArray* %_103, i32 0, i32 0
				%_105 = load i32, i32* %_104
				%_106 = icmp slt i32 %_102, %_105
				br i1 %_106, label %oob12, label %oob13

oob12:
				%_107 = getelementptr %IntArray, %IntArray* %_103, i32 0, i32 1
				%_108 = load i32*, i32** %_107
				%_109 = getelementptr i32, i32* %_108, i32 %_102
				%_110 = load i32, i32* %_109
				br label %oob14

oob13:
				br label %end

oob14:
				%_111 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
				%_113 = getelementptr %IntArray, %IntArray* %_111, i32 0, i32 0
				%_114 = load i32, i32* %_113
				%_115 = icmp slt i32 %_101, %_114
				br i1 %_115, label %oob9, label %oob10

oob9:
				%_116 = getelementptr %IntArray, %IntArray* %_111, i32 0, i32 1
				%_117 = load i32*, i32** %_116
				%_118 = getelementptr i32, i32* %_117, i32 %_101
				store i32 %_110, i32* %_118
				br label %oob11

oob10:
				br label %end

oob11:
				%_119 = load i32, i32* %j
				%_120 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
				%_121 = load i32, i32* %t
				%_122 = getelementptr %IntArray, %IntArray* %_120, i32 0, i32 0
				%_123 = load i32, i32* %_122
				%_124 = icmp slt i32 %_119, %_123
				br i1 %_124, label %oob15, label %oob16

oob15:
				%_125 = getelementptr %IntArray, %IntArray* %_120, i32 0, i32 1
				%_126 = load i32*, i32** %_125
				%_127 = getelementptr i32, i32* %_126, i32 %_119
				store i32 %_121, i32* %_127
				br label %oob17

oob16:
				br label %end

oob17:
				br label %if2

if1:
				store i32 0, i32* %nt
				br label %if2

if2:
			%_130 = load i32, i32* %j
			%_131 = add i32 %_130, 1
			store i32 %_131, i32* %j
			br label %loop3

loop5:
		%_134 = load i32, i32* %i
		%_135 = sub i32 %_134, 1
		store i32 %_135, i32* %i
		br label %loop0

loop2:
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
define i32 @BBS.Print(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.BBS*
	%j = alloca i32
	store i32 0, i32* %j
	br label %loop6

loop6:
		%_140 = load i32, i32* %j
		%_141 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 1
		%_142 = load i32, i32* %_141
		%_143 = icmp slt i32 %_140, %_142
		br i1 %_143, label %loop7, label %loop8

loop7:
		%_144 = load i32, i32* %j
		%_145 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
		%_146 = getelementptr %IntArray, %IntArray* %_145, i32 0, i32 0
		%_147 = load i32, i32* %_146
		%_148 = icmp slt i32 %_144, %_147
		br i1 %_148, label %oob18, label %oob19

oob18:
		%_149 = getelementptr %IntArray, %IntArray* %_145, i32 0, i32 1
		%_150 = load i32*, i32** %_149
		%_151 = getelementptr i32, i32* %_150, i32 %_144
		%_152 = load i32, i32* %_151
		br label %oob20

oob19:
		br label %end

oob20:
		call void @print_int(i32 %_152)
		%_154 = load i32, i32* %j
		%_155 = add i32 %_154, 1
		store i32 %_155, i32* %j
		br label %loop6

loop8:
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
define i32 @BBS.Init(i8* %this_raw, i32 %sz) {
	%this = bitcast i8* %this_raw to %class.BBS*
	%_158 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 1
	store i32 %sz, i32* %_158
	%_159 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_160 = getelementptr %IntArray, %IntArray* %_159, i32 0, i32 0
	store i32 %sz, i32* %_160
	%_161 = call i8* @calloc(i32 %sz, i32 4)
	%_162 = bitcast i8* %_161 to i32*
	%_163 = getelementptr %IntArray, %IntArray* %_159, i32 0, i32 1
	store i32* %_162, i32** %_163
	%_164 = add i32 0, 0
	%_165 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_166 = getelementptr %IntArray, %IntArray* %_165, i32 0, i32 0
	%_167 = load i32, i32* %_166
	%_168 = icmp slt i32 %_164, %_167
	br i1 %_168, label %oob21, label %oob22

oob21:
	%_169 = getelementptr %IntArray, %IntArray* %_165, i32 0, i32 1
	%_170 = load i32*, i32** %_169
	%_171 = getelementptr i32, i32* %_170, i32 %_164
	store i32 20, i32* %_171
	br label %oob23

oob22:
	br label %end

oob23:
	%_172 = add i32 0, 1
	%_173 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_174 = getelementptr %IntArray, %IntArray* %_173, i32 0, i32 0
	%_175 = load i32, i32* %_174
	%_176 = icmp slt i32 %_172, %_175
	br i1 %_176, label %oob24, label %oob25

oob24:
	%_177 = getelementptr %IntArray, %IntArray* %_173, i32 0, i32 1
	%_178 = load i32*, i32** %_177
	%_179 = getelementptr i32, i32* %_178, i32 %_172
	store i32 7, i32* %_179
	br label %oob26

oob25:
	br label %end

oob26:
	%_180 = add i32 0, 2
	%_181 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_182 = getelementptr %IntArray, %IntArray* %_181, i32 0, i32 0
	%_183 = load i32, i32* %_182
	%_184 = icmp slt i32 %_180, %_183
	br i1 %_184, label %oob27, label %oob28

oob27:
	%_185 = getelementptr %IntArray, %IntArray* %_181, i32 0, i32 1
	%_186 = load i32*, i32** %_185
	%_187 = getelementptr i32, i32* %_186, i32 %_180
	store i32 12, i32* %_187
	br label %oob29

oob28:
	br label %end

oob29:
	%_188 = add i32 0, 3
	%_189 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_190 = getelementptr %IntArray, %IntArray* %_189, i32 0, i32 0
	%_191 = load i32, i32* %_190
	%_192 = icmp slt i32 %_188, %_191
	br i1 %_192, label %oob30, label %oob31

oob30:
	%_193 = getelementptr %IntArray, %IntArray* %_189, i32 0, i32 1
	%_194 = load i32*, i32** %_193
	%_195 = getelementptr i32, i32* %_194, i32 %_188
	store i32 18, i32* %_195
	br label %oob32

oob31:
	br label %end

oob32:
	%_196 = add i32 0, 4
	%_197 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_198 = getelementptr %IntArray, %IntArray* %_197, i32 0, i32 0
	%_199 = load i32, i32* %_198
	%_200 = icmp slt i32 %_196, %_199
	br i1 %_200, label %oob33, label %oob34

oob33:
	%_201 = getelementptr %IntArray, %IntArray* %_197, i32 0, i32 1
	%_202 = load i32*, i32** %_201
	%_203 = getelementptr i32, i32* %_202, i32 %_196
	store i32 2, i32* %_203
	br label %oob35

oob34:
	br label %end

oob35:
	%_204 = add i32 0, 5
	%_205 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_206 = getelementptr %IntArray, %IntArray* %_205, i32 0, i32 0
	%_207 = load i32, i32* %_206
	%_208 = icmp slt i32 %_204, %_207
	br i1 %_208, label %oob36, label %oob37

oob36:
	%_209 = getelementptr %IntArray, %IntArray* %_205, i32 0, i32 1
	%_210 = load i32*, i32** %_209
	%_211 = getelementptr i32, i32* %_210, i32 %_204
	store i32 11, i32* %_211
	br label %oob38

oob37:
	br label %end

oob38:
	%_212 = add i32 0, 6
	%_213 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_214 = getelementptr %IntArray, %IntArray* %_213, i32 0, i32 0
	%_215 = load i32, i32* %_214
	%_216 = icmp slt i32 %_212, %_215
	br i1 %_216, label %oob39, label %oob40

oob39:
	%_217 = getelementptr %IntArray, %IntArray* %_213, i32 0, i32 1
	%_218 = load i32*, i32** %_217
	%_219 = getelementptr i32, i32* %_218, i32 %_212
	store i32 6, i32* %_219
	br label %oob41

oob40:
	br label %end

oob41:
	%_220 = add i32 0, 7
	%_221 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_222 = getelementptr %IntArray, %IntArray* %_221, i32 0, i32 0
	%_223 = load i32, i32* %_222
	%_224 = icmp slt i32 %_220, %_223
	br i1 %_224, label %oob42, label %oob43

oob42:
	%_225 = getelementptr %IntArray, %IntArray* %_221, i32 0, i32 1
	%_226 = load i32*, i32** %_225
	%_227 = getelementptr i32, i32* %_226, i32 %_220
	store i32 9, i32* %_227
	br label %oob44

oob43:
	br label %end

oob44:
	%_228 = add i32 0, 8
	%_229 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_230 = getelementptr %IntArray, %IntArray* %_229, i32 0, i32 0
	%_231 = load i32, i32* %_230
	%_232 = icmp slt i32 %_228, %_231
	br i1 %_232, label %oob45, label %oob46

oob45:
	%_233 = getelementptr %IntArray, %IntArray* %_229, i32 0, i32 1
	%_234 = load i32*, i32** %_233
	%_235 = getelementptr i32, i32* %_234, i32 %_228
	store i32 19, i32* %_235
	br label %oob47

oob46:
	br label %end

oob47:
	%_236 = add i32 0, 9
	%_237 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_238 = getelementptr %IntArray, %IntArray* %_237, i32 0, i32 0
	%_239 = load i32, i32* %_238
	%_240 = icmp slt i32 %_236, %_239
	br i1 %_240, label %oob48, label %oob49

oob48:
	%_241 = getelementptr %IntArray, %IntArray* %_237, i32 0, i32 1
	%_242 = load i32*, i32** %_241
	%_243 = getelementptr i32, i32* %_242, i32 %_236
	store i32 5, i32* %_243
	br label %oob50

oob49:
	br label %end

oob50:
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
