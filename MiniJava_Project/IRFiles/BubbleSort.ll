@.BBS_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*,i32)* @BBS.Start to i8*),i8* bitcast (i32 (i8*)* @BBS.Sort to i8*),i8* bitcast (i32 (i8*)* @BBS.Print to i8*),i8* bitcast (i32 (i8*,i32)* @BBS.Init to i8*)]
%class.BBS = type{ %IntArray, i32 }
%IntArray = type { i32, i32* }
%BooleanArray = type { i32, i8* }
declare i8* @calloc(i32, i32)
declare i32 @printf(i8*, ...)
declare void @free(i32)
declare void @exit(i8*)
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
	%_8 = call i32 %_7(i8* %_0, i32 10)
	call void @print_int(i32 %_8)
	%_9 = bitcast %class.BBS* %_3 to i8*
  	call void @free(i8* %_9)
	ret i32 0
}
define i32 @BBS.Start(i8* %this_raw, i32 %sz) {
	%this = bitcast i8* %this_raw to %class.BBS*
	%aux01 = alloca i32
	%_9 = getelementptr [4 x i8*], [4 x i8*]* @.BBS_vtable, i32 0, i32 3
	%_10 = load i8*, i8** %_9
	%_11 = bitcast i8* %_10 to i32(i8*, i32)*
	%_12 = call i32 %_11(i8* %this, i32 %sz)
	store i32 %_12, i32* %aux01
	%_16 = getelementptr [4 x i8*], [4 x i8*]* @.BBS_vtable, i32 0, i32 2
	%_17 = load i8*, i8** %_16
	%_18 = bitcast i8* %_17 to i32(i8*)*
	%_19 = call i32 %_18(i8* %this)
	store i32 %_19, i32* %aux01
	call void @print_int(i32 99999)
	%_22 = getelementptr [4 x i8*], [4 x i8*]* @.BBS_vtable, i32 0, i32 1
	%_23 = load i8*, i8** %_22
	%_24 = bitcast i8* %_23 to i32(i8*)*
	%_25 = call i32 %_24(i8* %this)
	store i32 %_25, i32* %aux01
	%_28 = getelementptr [4 x i8*], [4 x i8*]* @.BBS_vtable, i32 0, i32 2
	%_29 = load i8*, i8** %_28
	%_30 = bitcast i8* %_29 to i32(i8*)*
	%_31 = call i32 %_30(i8* %this)
	store i32 %_31, i32* %aux01
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
	%_34 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 1
	%_35 = load i32, i32* %_34
	%_36 = sub i32 %_35, 1
	store i32 %_36, i32* %i
	%_39 = sub i32 0, 1
	store i32 %_39, i32* %aux02
	br label %loop0

loop0:
		%_42 = load i32, i32* %aux02
		%_43 = load i32, i32* %i
		%_44 = icmp slt i32 %_42, %_43
		br i1 %_44, label %loop1, label %loop2

loop1:
		store i32 1, i32* %j
		br label %loop3

loop3:
			%_47 = load i32, i32* %j
			%_48 = load i32, i32* %i
			%_49 = add i32 %_48, 1
			%_51 = icmp slt i32 %_47, %_49
			br i1 %_51, label %loop4, label %loop5

loop4:
			%_52 = load i32, i32* %j
			%_53 = sub i32 %_52, 1
			store i32 %_53, i32* %aux07
			%_56 = load i32, i32* %aux07
			%_57 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
			%_58 = getelementptr %IntArray, %IntArray* %_57, i32 0, i32 0
			%_59 = load i32, i32* %_58
			%_60 = icmp slt i32 %_56, %_59
			br i1 %_60, label %oob0, label %oob1

oob0:
			%_61 = getelementptr %IntArray, %IntArray* %_57, i32 0, i32 1
			%_62 = load i32*, i32** %_61
			%_63 = getelementptr i32, i32* %_62, i32 %_56
			%_64 = load i32, i32* %_63
			br label %oob2

oob1:
			br label %end

oob2:
			store i32 %_64, i32* %aux04
			%_67 = load i32, i32* %j
			%_68 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
			%_69 = getelementptr %IntArray, %IntArray* %_68, i32 0, i32 0
			%_70 = load i32, i32* %_69
			%_71 = icmp slt i32 %_67, %_70
			br i1 %_71, label %oob3, label %oob4

oob3:
			%_72 = getelementptr %IntArray, %IntArray* %_68, i32 0, i32 1
			%_73 = load i32*, i32** %_72
			%_74 = getelementptr i32, i32* %_73, i32 %_67
			%_75 = load i32, i32* %_74
			br label %oob5

oob4:
			br label %end

oob5:
			store i32 %_75, i32* %aux05
			%_78 = load i32, i32* %aux05
			%_79 = load i32, i32* %aux04
			%_80 = icmp slt i32 %_78, %_79
			br i1 %_80, label %if0, label %if1

if0:
				%_81 = load i32, i32* %j
				%_82 = sub i32 %_81, 1
				store i32 %_82, i32* %aux06
				%_85 = load i32, i32* %aux06
				%_86 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
				%_87 = getelementptr %IntArray, %IntArray* %_86, i32 0, i32 0
				%_88 = load i32, i32* %_87
				%_89 = icmp slt i32 %_85, %_88
				br i1 %_89, label %oob6, label %oob7

oob6:
				%_90 = getelementptr %IntArray, %IntArray* %_86, i32 0, i32 1
				%_91 = load i32*, i32** %_90
				%_92 = getelementptr i32, i32* %_91, i32 %_85
				%_93 = load i32, i32* %_92
				br label %oob8

oob7:
				br label %end

oob8:
				store i32 %_93, i32* %t
				%_96 = load i32, i32* %aux06
				%_97 = load i32, i32* %j
				%_98 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
				%_99 = getelementptr %IntArray, %IntArray* %_98, i32 0, i32 0
				%_100 = load i32, i32* %_99
				%_101 = icmp slt i32 %_97, %_100
				br i1 %_101, label %oob12, label %oob13

oob12:
				%_102 = getelementptr %IntArray, %IntArray* %_98, i32 0, i32 1
				%_103 = load i32*, i32** %_102
				%_104 = getelementptr i32, i32* %_103, i32 %_97
				%_105 = load i32, i32* %_104
				br label %oob14

oob13:
				br label %end

oob14:
				%_106 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
				%_108 = getelementptr %IntArray, %IntArray* %_106, i32 0, i32 0
				%_109 = load i32, i32* %_108
				%_110 = icmp slt i32 %_96, %_109
				br i1 %_110, label %oob9, label %oob10

oob9:
				%_111 = getelementptr %IntArray, %IntArray* %_106, i32 0, i32 1
				%_112 = load i32*, i32** %_111
				%_113 = getelementptr i32, i32* %_112, i32 %_96
				store i32 %_105, i32* %_113
				br label %oob11

oob10:
				br label %end

oob11:
				%_114 = load i32, i32* %j
				%_115 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
				%_116 = load i32, i32* %t
				%_117 = getelementptr %IntArray, %IntArray* %_115, i32 0, i32 0
				%_118 = load i32, i32* %_117
				%_119 = icmp slt i32 %_114, %_118
				br i1 %_119, label %oob15, label %oob16

oob15:
				%_120 = getelementptr %IntArray, %IntArray* %_115, i32 0, i32 1
				%_121 = load i32*, i32** %_120
				%_122 = getelementptr i32, i32* %_121, i32 %_114
				store i32 %_116, i32* %_122
				br label %oob17

oob16:
				br label %end

oob17:
				br label %if2

if1:
				store i32 0, i32* %nt
				br label %if2

if2:
			%_125 = load i32, i32* %j
			%_126 = add i32 %_125, 1
			store i32 %_126, i32* %j
			br label %loop3

loop5:
		%_129 = load i32, i32* %i
		%_130 = sub i32 %_129, 1
		store i32 %_130, i32* %i
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
		%_135 = load i32, i32* %j
		%_136 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 1
		%_137 = load i32, i32* %_136
		%_138 = icmp slt i32 %_135, %_137
		br i1 %_138, label %loop7, label %loop8

loop7:
		%_139 = load i32, i32* %j
		%_140 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
		%_141 = getelementptr %IntArray, %IntArray* %_140, i32 0, i32 0
		%_142 = load i32, i32* %_141
		%_143 = icmp slt i32 %_139, %_142
		br i1 %_143, label %oob18, label %oob19

oob18:
		%_144 = getelementptr %IntArray, %IntArray* %_140, i32 0, i32 1
		%_145 = load i32*, i32** %_144
		%_146 = getelementptr i32, i32* %_145, i32 %_139
		%_147 = load i32, i32* %_146
		br label %oob20

oob19:
		br label %end

oob20:
		call void @print_int(i32 %_147)
		%_149 = load i32, i32* %j
		%_150 = add i32 %_149, 1
		store i32 %_150, i32* %j
		br label %loop6

loop8:
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
define i32 @BBS.Init(i8* %this_raw, i32 %sz) {
	%this = bitcast i8* %this_raw to %class.BBS*
	%_154 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 1
	store i32 %sz, i32* %_154
	%_156 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_157 = getelementptr %IntArray, %IntArray* %_156, i32 0, i32 0
	store i32 %sz, i32* %_157
	%_158 = call i8* @calloc(i32 %sz, i32 4)
	%_159 = bitcast i8* %_158 to i32*
	%_160 = getelementptr %IntArray, %IntArray* %_156, i32 0, i32 1
	store i32* %_159, i32** %_160
	%_161 = add i32 0, 0
	%_162 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_163 = getelementptr %IntArray, %IntArray* %_162, i32 0, i32 0
	%_164 = load i32, i32* %_163
	%_165 = icmp slt i32 %_161, %_164
	br i1 %_165, label %oob21, label %oob22

oob21:
	%_166 = getelementptr %IntArray, %IntArray* %_162, i32 0, i32 1
	%_167 = load i32*, i32** %_166
	%_168 = getelementptr i32, i32* %_167, i32 %_161
	store i32 20, i32* %_168
	br label %oob23

oob22:
	br label %end

oob23:
	%_169 = add i32 0, 1
	%_170 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_171 = getelementptr %IntArray, %IntArray* %_170, i32 0, i32 0
	%_172 = load i32, i32* %_171
	%_173 = icmp slt i32 %_169, %_172
	br i1 %_173, label %oob24, label %oob25

oob24:
	%_174 = getelementptr %IntArray, %IntArray* %_170, i32 0, i32 1
	%_175 = load i32*, i32** %_174
	%_176 = getelementptr i32, i32* %_175, i32 %_169
	store i32 7, i32* %_176
	br label %oob26

oob25:
	br label %end

oob26:
	%_177 = add i32 0, 2
	%_178 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_179 = getelementptr %IntArray, %IntArray* %_178, i32 0, i32 0
	%_180 = load i32, i32* %_179
	%_181 = icmp slt i32 %_177, %_180
	br i1 %_181, label %oob27, label %oob28

oob27:
	%_182 = getelementptr %IntArray, %IntArray* %_178, i32 0, i32 1
	%_183 = load i32*, i32** %_182
	%_184 = getelementptr i32, i32* %_183, i32 %_177
	store i32 12, i32* %_184
	br label %oob29

oob28:
	br label %end

oob29:
	%_185 = add i32 0, 3
	%_186 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_187 = getelementptr %IntArray, %IntArray* %_186, i32 0, i32 0
	%_188 = load i32, i32* %_187
	%_189 = icmp slt i32 %_185, %_188
	br i1 %_189, label %oob30, label %oob31

oob30:
	%_190 = getelementptr %IntArray, %IntArray* %_186, i32 0, i32 1
	%_191 = load i32*, i32** %_190
	%_192 = getelementptr i32, i32* %_191, i32 %_185
	store i32 18, i32* %_192
	br label %oob32

oob31:
	br label %end

oob32:
	%_193 = add i32 0, 4
	%_194 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_195 = getelementptr %IntArray, %IntArray* %_194, i32 0, i32 0
	%_196 = load i32, i32* %_195
	%_197 = icmp slt i32 %_193, %_196
	br i1 %_197, label %oob33, label %oob34

oob33:
	%_198 = getelementptr %IntArray, %IntArray* %_194, i32 0, i32 1
	%_199 = load i32*, i32** %_198
	%_200 = getelementptr i32, i32* %_199, i32 %_193
	store i32 2, i32* %_200
	br label %oob35

oob34:
	br label %end

oob35:
	%_201 = add i32 0, 5
	%_202 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_203 = getelementptr %IntArray, %IntArray* %_202, i32 0, i32 0
	%_204 = load i32, i32* %_203
	%_205 = icmp slt i32 %_201, %_204
	br i1 %_205, label %oob36, label %oob37

oob36:
	%_206 = getelementptr %IntArray, %IntArray* %_202, i32 0, i32 1
	%_207 = load i32*, i32** %_206
	%_208 = getelementptr i32, i32* %_207, i32 %_201
	store i32 11, i32* %_208
	br label %oob38

oob37:
	br label %end

oob38:
	%_209 = add i32 0, 6
	%_210 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_211 = getelementptr %IntArray, %IntArray* %_210, i32 0, i32 0
	%_212 = load i32, i32* %_211
	%_213 = icmp slt i32 %_209, %_212
	br i1 %_213, label %oob39, label %oob40

oob39:
	%_214 = getelementptr %IntArray, %IntArray* %_210, i32 0, i32 1
	%_215 = load i32*, i32** %_214
	%_216 = getelementptr i32, i32* %_215, i32 %_209
	store i32 6, i32* %_216
	br label %oob41

oob40:
	br label %end

oob41:
	%_217 = add i32 0, 7
	%_218 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_219 = getelementptr %IntArray, %IntArray* %_218, i32 0, i32 0
	%_220 = load i32, i32* %_219
	%_221 = icmp slt i32 %_217, %_220
	br i1 %_221, label %oob42, label %oob43

oob42:
	%_222 = getelementptr %IntArray, %IntArray* %_218, i32 0, i32 1
	%_223 = load i32*, i32** %_222
	%_224 = getelementptr i32, i32* %_223, i32 %_217
	store i32 9, i32* %_224
	br label %oob44

oob43:
	br label %end

oob44:
	%_225 = add i32 0, 8
	%_226 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_227 = getelementptr %IntArray, %IntArray* %_226, i32 0, i32 0
	%_228 = load i32, i32* %_227
	%_229 = icmp slt i32 %_225, %_228
	br i1 %_229, label %oob45, label %oob46

oob45:
	%_230 = getelementptr %IntArray, %IntArray* %_226, i32 0, i32 1
	%_231 = load i32*, i32** %_230
	%_232 = getelementptr i32, i32* %_231, i32 %_225
	store i32 19, i32* %_232
	br label %oob47

oob46:
	br label %end

oob47:
	%_233 = add i32 0, 9
	%_234 = getelementptr %class.BBS, %class.BBS* %this, i32 0, i32 0
	%_235 = getelementptr %IntArray, %IntArray* %_234, i32 0, i32 0
	%_236 = load i32, i32* %_235
	%_237 = icmp slt i32 %_233, %_236
	br i1 %_237, label %oob48, label %oob49

oob48:
	%_238 = getelementptr %IntArray, %IntArray* %_234, i32 0, i32 1
	%_239 = load i32*, i32** %_238
	%_240 = getelementptr i32, i32* %_239, i32 %_233
	store i32 5, i32* %_240
	br label %oob50

oob49:
	br label %end

oob50:
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
