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
	%_19 = getelementptr [4 x i8*], [4 x i8*]* @.BBS_vtable, i32 0, i32 2
	%_20 = load i8*, i8** %_19
	%_21 = bitcast i8* %_20 to i32(i8*)*
	%_23 = bitcast %class.BBS* %this to i8*
	%_22 = call i32 %_21(i8* %_23)
	store i32 %_22, i32* %aux01
	call void @print_int(i32 99999)
	%_26 = getelementptr [4 x i8*], [4 x i8*]* @.BBS_vtable, i32 0, i32 1
	%_27 = load i8*, i8** %_26
	%_28 = bitcast i8* %_27 to i32(i8*)*
	%_30 = bitcast %class.BBS* %this to i8*
	%_29 = call i32 %_28(i8* %_30)
	store i32 %_29, i32* %aux01
	%_33 = getelementptr [4 x i8*], [4 x i8*]* @.BBS_vtable, i32 0, i32 2
	%_34 = load i8*, i8** %_33
	%_35 = bitcast i8* %_34 to i32(i8*)*
	%_37 = bitcast %class.BBS* %this to i8*
	%_36 = call i32 %_35(i8* %_37)
	store i32 %_36, i32* %aux01
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
	%_40 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 1
	%_41 = load i32, i32* %_40
	%_42 = sub i32 %_41, 1
	store i32 %_42, i32* %i
	%_45 = sub i32 0, 1
	store i32 %_45, i32* %aux02
	br label %loop0

loop0:
		%_48 = load i32, i32* %aux02
		%_49 = load i32, i32* %i
		%_50 = icmp slt i32 %_48, %_49
		br i1 %_50, label %loop1, label %loop2

loop1:
		store i32 1, i32* %j
		br label %loop3

loop3:
			%_53 = load i32, i32* %j
			%_54 = load i32, i32* %i
			%_55 = add i32 %_54, 1
			%_57 = icmp slt i32 %_53, %_55
			br i1 %_57, label %loop4, label %loop5

loop4:
			%_58 = load i32, i32* %j
			%_59 = sub i32 %_58, 1
			store i32 %_59, i32* %aux07
			%_62 = load i32, i32* %aux07
			%_63 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
			%_64 = getelementptr %IntArray, %IntArray* %_63, i32 0, i32 0
			%_65 = load i32, i32* %_64
			%_66 = icmp slt i32 %_62, %_65
			br i1 %_66, label %oob0, label %oob1

oob0:
			%_67 = getelementptr %IntArray, %IntArray* %_63, i32 0, i32 1
			%_68 = load i32*, i32** %_67
			%_69 = getelementptr i32, i32* %_68, i32 %_62
			%_70 = load i32, i32* %_69
			br label %oob2

oob1:
			br label %end

oob2:
			store i32 %_70, i32* %aux04
			%_73 = load i32, i32* %j
			%_74 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
			%_75 = getelementptr %IntArray, %IntArray* %_74, i32 0, i32 0
			%_76 = load i32, i32* %_75
			%_77 = icmp slt i32 %_73, %_76
			br i1 %_77, label %oob3, label %oob4

oob3:
			%_78 = getelementptr %IntArray, %IntArray* %_74, i32 0, i32 1
			%_79 = load i32*, i32** %_78
			%_80 = getelementptr i32, i32* %_79, i32 %_73
			%_81 = load i32, i32* %_80
			br label %oob5

oob4:
			br label %end

oob5:
			store i32 %_81, i32* %aux05
			%_84 = load i32, i32* %aux05
			%_85 = load i32, i32* %aux04
			%_86 = icmp slt i32 %_84, %_85
			br i1 %_86, label %if0, label %if1

if0:
				%_87 = load i32, i32* %j
				%_88 = sub i32 %_87, 1
				store i32 %_88, i32* %aux06
				%_91 = load i32, i32* %aux06
				%_92 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
				%_93 = getelementptr %IntArray, %IntArray* %_92, i32 0, i32 0
				%_94 = load i32, i32* %_93
				%_95 = icmp slt i32 %_91, %_94
				br i1 %_95, label %oob6, label %oob7

oob6:
				%_96 = getelementptr %IntArray, %IntArray* %_92, i32 0, i32 1
				%_97 = load i32*, i32** %_96
				%_98 = getelementptr i32, i32* %_97, i32 %_91
				%_99 = load i32, i32* %_98
				br label %oob8

oob7:
				br label %end

oob8:
				store i32 %_99, i32* %t
				%_102 = load i32, i32* %aux06
				%_103 = load i32, i32* %j
				%_104 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
				%_105 = getelementptr %IntArray, %IntArray* %_104, i32 0, i32 0
				%_106 = load i32, i32* %_105
				%_107 = icmp slt i32 %_103, %_106
				br i1 %_107, label %oob12, label %oob13

oob12:
				%_108 = getelementptr %IntArray, %IntArray* %_104, i32 0, i32 1
				%_109 = load i32*, i32** %_108
				%_110 = getelementptr i32, i32* %_109, i32 %_103
				%_111 = load i32, i32* %_110
				br label %oob14

oob13:
				br label %end

oob14:
				%_112 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
				%_114 = getelementptr %IntArray, %IntArray* %_112, i32 0, i32 0
				%_115 = load i32, i32* %_114
				%_116 = icmp slt i32 %_102, %_115
				br i1 %_116, label %oob9, label %oob10

oob9:
				%_117 = getelementptr %IntArray, %IntArray* %_112, i32 0, i32 1
				%_118 = load i32*, i32** %_117
				%_119 = getelementptr i32, i32* %_118, i32 %_102
				store i32 %_111, i32* %_119
				br label %oob11

oob10:
				br label %end

oob11:
				%_120 = load i32, i32* %j
				%_121 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
				%_122 = load i32, i32* %t
				%_123 = getelementptr %IntArray, %IntArray* %_121, i32 0, i32 0
				%_124 = load i32, i32* %_123
				%_125 = icmp slt i32 %_120, %_124
				br i1 %_125, label %oob15, label %oob16

oob15:
				%_126 = getelementptr %IntArray, %IntArray* %_121, i32 0, i32 1
				%_127 = load i32*, i32** %_126
				%_128 = getelementptr i32, i32* %_127, i32 %_120
				store i32 %_122, i32* %_128
				br label %oob17

oob16:
				br label %end

oob17:
				br label %if2

if1:
				store i32 0, i32* %nt
				br label %if2

if2:
			%_131 = load i32, i32* %j
			%_132 = add i32 %_131, 1
			store i32 %_132, i32* %j
			br label %loop3

loop5:
		%_135 = load i32, i32* %i
		%_136 = sub i32 %_135, 1
		store i32 %_136, i32* %i
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
		%_141 = load i32, i32* %j
		%_142 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 1
		%_143 = load i32, i32* %_142
		%_144 = icmp slt i32 %_141, %_143
		br i1 %_144, label %loop7, label %loop8

loop7:
		%_145 = load i32, i32* %j
		%_146 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
		%_147 = getelementptr %IntArray, %IntArray* %_146, i32 0, i32 0
		%_148 = load i32, i32* %_147
		%_149 = icmp slt i32 %_145, %_148
		br i1 %_149, label %oob18, label %oob19

oob18:
		%_150 = getelementptr %IntArray, %IntArray* %_146, i32 0, i32 1
		%_151 = load i32*, i32** %_150
		%_152 = getelementptr i32, i32* %_151, i32 %_145
		%_153 = load i32, i32* %_152
		br label %oob20

oob19:
		br label %end

oob20:
		call void @print_int(i32 %_153)
		%_155 = load i32, i32* %j
		%_156 = add i32 %_155, 1
		store i32 %_156, i32* %j
		br label %loop6

loop8:
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
define i32 @BBS.Init(i8* %this_raw, i32 %sz) {
	%this = bitcast i8* %this_raw to %class.BBS*
	%_160 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 1
	store i32 %sz, i32* %_160
	%_162 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_163 = getelementptr %IntArray, %IntArray* %_162, i32 0, i32 0
	store i32 %sz, i32* %_163
	%_164 = call i8* @calloc(i32 %sz, i32 4)
	%_165 = bitcast i8* %_164 to i32*
	%_166 = getelementptr %IntArray, %IntArray* %_162, i32 0, i32 1
	store i32* %_165, i32** %_166
	%_167 = add i32 0, 0
	%_168 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_169 = getelementptr %IntArray, %IntArray* %_168, i32 0, i32 0
	%_170 = load i32, i32* %_169
	%_171 = icmp slt i32 %_167, %_170
	br i1 %_171, label %oob21, label %oob22

oob21:
	%_172 = getelementptr %IntArray, %IntArray* %_168, i32 0, i32 1
	%_173 = load i32*, i32** %_172
	%_174 = getelementptr i32, i32* %_173, i32 %_167
	store i32 20, i32* %_174
	br label %oob23

oob22:
	br label %end

oob23:
	%_175 = add i32 0, 1
	%_176 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_177 = getelementptr %IntArray, %IntArray* %_176, i32 0, i32 0
	%_178 = load i32, i32* %_177
	%_179 = icmp slt i32 %_175, %_178
	br i1 %_179, label %oob24, label %oob25

oob24:
	%_180 = getelementptr %IntArray, %IntArray* %_176, i32 0, i32 1
	%_181 = load i32*, i32** %_180
	%_182 = getelementptr i32, i32* %_181, i32 %_175
	store i32 7, i32* %_182
	br label %oob26

oob25:
	br label %end

oob26:
	%_183 = add i32 0, 2
	%_184 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_185 = getelementptr %IntArray, %IntArray* %_184, i32 0, i32 0
	%_186 = load i32, i32* %_185
	%_187 = icmp slt i32 %_183, %_186
	br i1 %_187, label %oob27, label %oob28

oob27:
	%_188 = getelementptr %IntArray, %IntArray* %_184, i32 0, i32 1
	%_189 = load i32*, i32** %_188
	%_190 = getelementptr i32, i32* %_189, i32 %_183
	store i32 12, i32* %_190
	br label %oob29

oob28:
	br label %end

oob29:
	%_191 = add i32 0, 3
	%_192 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_193 = getelementptr %IntArray, %IntArray* %_192, i32 0, i32 0
	%_194 = load i32, i32* %_193
	%_195 = icmp slt i32 %_191, %_194
	br i1 %_195, label %oob30, label %oob31

oob30:
	%_196 = getelementptr %IntArray, %IntArray* %_192, i32 0, i32 1
	%_197 = load i32*, i32** %_196
	%_198 = getelementptr i32, i32* %_197, i32 %_191
	store i32 18, i32* %_198
	br label %oob32

oob31:
	br label %end

oob32:
	%_199 = add i32 0, 4
	%_200 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_201 = getelementptr %IntArray, %IntArray* %_200, i32 0, i32 0
	%_202 = load i32, i32* %_201
	%_203 = icmp slt i32 %_199, %_202
	br i1 %_203, label %oob33, label %oob34

oob33:
	%_204 = getelementptr %IntArray, %IntArray* %_200, i32 0, i32 1
	%_205 = load i32*, i32** %_204
	%_206 = getelementptr i32, i32* %_205, i32 %_199
	store i32 2, i32* %_206
	br label %oob35

oob34:
	br label %end

oob35:
	%_207 = add i32 0, 5
	%_208 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_209 = getelementptr %IntArray, %IntArray* %_208, i32 0, i32 0
	%_210 = load i32, i32* %_209
	%_211 = icmp slt i32 %_207, %_210
	br i1 %_211, label %oob36, label %oob37

oob36:
	%_212 = getelementptr %IntArray, %IntArray* %_208, i32 0, i32 1
	%_213 = load i32*, i32** %_212
	%_214 = getelementptr i32, i32* %_213, i32 %_207
	store i32 11, i32* %_214
	br label %oob38

oob37:
	br label %end

oob38:
	%_215 = add i32 0, 6
	%_216 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_217 = getelementptr %IntArray, %IntArray* %_216, i32 0, i32 0
	%_218 = load i32, i32* %_217
	%_219 = icmp slt i32 %_215, %_218
	br i1 %_219, label %oob39, label %oob40

oob39:
	%_220 = getelementptr %IntArray, %IntArray* %_216, i32 0, i32 1
	%_221 = load i32*, i32** %_220
	%_222 = getelementptr i32, i32* %_221, i32 %_215
	store i32 6, i32* %_222
	br label %oob41

oob40:
	br label %end

oob41:
	%_223 = add i32 0, 7
	%_224 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_225 = getelementptr %IntArray, %IntArray* %_224, i32 0, i32 0
	%_226 = load i32, i32* %_225
	%_227 = icmp slt i32 %_223, %_226
	br i1 %_227, label %oob42, label %oob43

oob42:
	%_228 = getelementptr %IntArray, %IntArray* %_224, i32 0, i32 1
	%_229 = load i32*, i32** %_228
	%_230 = getelementptr i32, i32* %_229, i32 %_223
	store i32 9, i32* %_230
	br label %oob44

oob43:
	br label %end

oob44:
	%_231 = add i32 0, 8
	%_232 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_233 = getelementptr %IntArray, %IntArray* %_232, i32 0, i32 0
	%_234 = load i32, i32* %_233
	%_235 = icmp slt i32 %_231, %_234
	br i1 %_235, label %oob45, label %oob46

oob45:
	%_236 = getelementptr %IntArray, %IntArray* %_232, i32 0, i32 1
	%_237 = load i32*, i32** %_236
	%_238 = getelementptr i32, i32* %_237, i32 %_231
	store i32 19, i32* %_238
	br label %oob47

oob46:
	br label %end

oob47:
	%_239 = add i32 0, 9
	%_240 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_241 = getelementptr %IntArray, %IntArray* %_240, i32 0, i32 0
	%_242 = load i32, i32* %_241
	%_243 = icmp slt i32 %_239, %_242
	br i1 %_243, label %oob48, label %oob49

oob48:
	%_244 = getelementptr %IntArray, %IntArray* %_240, i32 0, i32 1
	%_245 = load i32*, i32** %_244
	%_246 = getelementptr i32, i32* %_245, i32 %_239
	store i32 5, i32* %_246
	br label %oob50

oob49:
	br label %end

oob50:
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
