@.BT_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @BT.Start to i8*)]
@.Tree_vtable = global [20 x i8*] [i8* bitcast (i1 (i8*,i32)* @Tree.Init to i8*),i8* bitcast (i1 (i8*,i8*)* @Tree.SetRight to i8*),i8* bitcast (i1 (i8*,i8*)* @Tree.SetLeft to i8*),i8* bitcast (i8* (i8*)* @Tree.GetRight to i8*),i8* bitcast (i8* (i8*)* @Tree.GetLeft to i8*),i8* bitcast (i32 (i8*)* @Tree.GetKey to i8*),i8* bitcast (i1 (i8*,i32)* @Tree.SetKey to i8*),i8* bitcast (i1 (i8*)* @Tree.GetHas_Right to i8*),i8* bitcast (i1 (i8*)* @Tree.GetHas_Left to i8*),i8* bitcast (i1 (i8*,i1)* @Tree.SetHas_Left to i8*),i8* bitcast (i1 (i8*,i1)* @Tree.SetHas_Right to i8*),i8* bitcast (i1 (i8*,i32,i32)* @Tree.Compare to i8*),i8* bitcast (i1 (i8*,i32)* @Tree.Insert to i8*),i8* bitcast (i1 (i8*,i32)* @Tree.Delete to i8*),i8* bitcast (i1 (i8*,i8*,i8*)* @Tree.Remove to i8*),i8* bitcast (i1 (i8*,i8*,i8*)* @Tree.RemoveRight to i8*),i8* bitcast (i1 (i8*,i8*,i8*)* @Tree.RemoveLeft to i8*),i8* bitcast (i32 (i8*,i32)* @Tree.Search to i8*),i8* bitcast (i1 (i8*)* @Tree.Print to i8*),i8* bitcast (i1 (i8*,i8*)* @Tree.RecPrint to i8*)]
%class.BT = type{  }
%class.Tree = type{ i8*, i32, i1, i8*, i1, i8* }
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
	%_1 = alloca %class.BT*
	store %class.BT* null, %class.BT** %_1
	%_5 = getelementptr %class.BT, %class.BT* null, i32 1
	%_2 = ptrtoint %class.BT* %_5 to i32
	%_3 = call i8* @calloc(i32 1, i32 %_2)
	%_4 = bitcast i8* %_3 to %class.BT*
	store %class.BT* %_4, %class.BT** %_1
	%_0 = load %class.BT*, %class.BT** %_1
	%_6 = getelementptr [1 x i8*], [1 x i8*]* @.BT_vtable, i32 0, i32 0
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i32(i8*)*
	%_10 = load %class.BT*, %class.BT** %_0
	%_11 = bitcast %class.BT* %_10 to i8*
	%_9 = call i32 %_8(i8* %_11)
	call void @print_int(i32 %_9)
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
define i32 @BT.Start(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.BT*
	%root = alloca %class.Tree*
	store %class.Tree* null, %class.Tree** %root
	%ntb = alloca i1
	%nti = alloca i32
	%_17 = getelementptr %class.Tree, %class.Tree* null, i32 1
	%_14 = ptrtoint %class.Tree* %_17 to i32
	%_15 = call i8* @calloc(i32 1, i32 %_14)
	%_16 = bitcast i8* %_15 to %class.Tree*
	store %class.Tree* %_16, %class.Tree** %root
	%_18 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 0
	%_19 = load i8*, i8** %_18
	%_20 = bitcast i8* %_19 to i1(i8*, i32)*
	%_22 = load %class.Tree*, %class.Tree** %root
	%_23 = bitcast %class.Tree* %_22 to i8*
	%_21 = call i1 %_20(i8* %_23, i32 16)
	store i1 %_21, i1* %ntb
	%_27 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 18
	%_28 = load i8*, i8** %_27
	%_29 = bitcast i8* %_28 to i1(i8*)*
	%_31 = load %class.Tree*, %class.Tree** %root
	%_32 = bitcast %class.Tree* %_31 to i8*
	%_30 = call i1 %_29(i8* %_32)
	store i1 %_30, i1* %ntb
	call void @print_int(i32 100000000)
	%_35 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 12
	%_36 = load i8*, i8** %_35
	%_37 = bitcast i8* %_36 to i1(i8*, i32)*
	%_39 = load %class.Tree*, %class.Tree** %root
	%_40 = bitcast %class.Tree* %_39 to i8*
	%_38 = call i1 %_37(i8* %_40, i32 8)
	store i1 %_38, i1* %ntb
	%_44 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 18
	%_45 = load i8*, i8** %_44
	%_46 = bitcast i8* %_45 to i1(i8*)*
	%_48 = load %class.Tree*, %class.Tree** %root
	%_49 = bitcast %class.Tree* %_48 to i8*
	%_47 = call i1 %_46(i8* %_49)
	store i1 %_47, i1* %ntb
	call void @print_int(i32 200000000)
	%_52 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 12
	%_53 = load i8*, i8** %_52
	%_54 = bitcast i8* %_53 to i1(i8*, i32)*
	%_56 = load %class.Tree*, %class.Tree** %root
	%_57 = bitcast %class.Tree* %_56 to i8*
	%_55 = call i1 %_54(i8* %_57, i32 24)
	store i1 %_55, i1* %ntb
	%_61 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 12
	%_62 = load i8*, i8** %_61
	%_63 = bitcast i8* %_62 to i1(i8*, i32)*
	%_65 = load %class.Tree*, %class.Tree** %root
	%_66 = bitcast %class.Tree* %_65 to i8*
	%_64 = call i1 %_63(i8* %_66, i32 4)
	store i1 %_64, i1* %ntb
	%_70 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 12
	%_71 = load i8*, i8** %_70
	%_72 = bitcast i8* %_71 to i1(i8*, i32)*
	%_74 = load %class.Tree*, %class.Tree** %root
	%_75 = bitcast %class.Tree* %_74 to i8*
	%_73 = call i1 %_72(i8* %_75, i32 12)
	store i1 %_73, i1* %ntb
	%_79 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 12
	%_80 = load i8*, i8** %_79
	%_81 = bitcast i8* %_80 to i1(i8*, i32)*
	%_83 = load %class.Tree*, %class.Tree** %root
	%_84 = bitcast %class.Tree* %_83 to i8*
	%_82 = call i1 %_81(i8* %_84, i32 20)
	store i1 %_82, i1* %ntb
	%_88 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 12
	%_89 = load i8*, i8** %_88
	%_90 = bitcast i8* %_89 to i1(i8*, i32)*
	%_92 = load %class.Tree*, %class.Tree** %root
	%_93 = bitcast %class.Tree* %_92 to i8*
	%_91 = call i1 %_90(i8* %_93, i32 28)
	store i1 %_91, i1* %ntb
	%_97 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 12
	%_98 = load i8*, i8** %_97
	%_99 = bitcast i8* %_98 to i1(i8*, i32)*
	%_101 = load %class.Tree*, %class.Tree** %root
	%_102 = bitcast %class.Tree* %_101 to i8*
	%_100 = call i1 %_99(i8* %_102, i32 14)
	store i1 %_100, i1* %ntb
	%_106 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 18
	%_107 = load i8*, i8** %_106
	%_108 = bitcast i8* %_107 to i1(i8*)*
	%_110 = load %class.Tree*, %class.Tree** %root
	%_111 = bitcast %class.Tree* %_110 to i8*
	%_109 = call i1 %_108(i8* %_111)
	store i1 %_109, i1* %ntb
	call void @print_int(i32 300000000)
	%_114 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 17
	%_115 = load i8*, i8** %_114
	%_116 = bitcast i8* %_115 to i32(i8*, i32)*
	%_118 = load %class.Tree*, %class.Tree** %root
	%_119 = bitcast %class.Tree* %_118 to i8*
	%_117 = call i32 %_116(i8* %_119, i32 24)
	call void @print_int(i32 %_117)
	call void @print_int(i32 400000000)
	%_122 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 17
	%_123 = load i8*, i8** %_122
	%_124 = bitcast i8* %_123 to i32(i8*, i32)*
	%_126 = load %class.Tree*, %class.Tree** %root
	%_127 = bitcast %class.Tree* %_126 to i8*
	%_125 = call i32 %_124(i8* %_127, i32 12)
	call void @print_int(i32 %_125)
	call void @print_int(i32 500000000)
	%_130 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 17
	%_131 = load i8*, i8** %_130
	%_132 = bitcast i8* %_131 to i32(i8*, i32)*
	%_134 = load %class.Tree*, %class.Tree** %root
	%_135 = bitcast %class.Tree* %_134 to i8*
	%_133 = call i32 %_132(i8* %_135, i32 16)
	call void @print_int(i32 %_133)
	call void @print_int(i32 600000000)
	%_138 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 17
	%_139 = load i8*, i8** %_138
	%_140 = bitcast i8* %_139 to i32(i8*, i32)*
	%_142 = load %class.Tree*, %class.Tree** %root
	%_143 = bitcast %class.Tree* %_142 to i8*
	%_141 = call i32 %_140(i8* %_143, i32 50)
	call void @print_int(i32 %_141)
	call void @print_int(i32 700000000)
	%_146 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 17
	%_147 = load i8*, i8** %_146
	%_148 = bitcast i8* %_147 to i32(i8*, i32)*
	%_150 = load %class.Tree*, %class.Tree** %root
	%_151 = bitcast %class.Tree* %_150 to i8*
	%_149 = call i32 %_148(i8* %_151, i32 12)
	call void @print_int(i32 %_149)
	call void @print_int(i32 800000000)
	%_154 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 13
	%_155 = load i8*, i8** %_154
	%_156 = bitcast i8* %_155 to i1(i8*, i32)*
	%_158 = load %class.Tree*, %class.Tree** %root
	%_159 = bitcast %class.Tree* %_158 to i8*
	%_157 = call i1 %_156(i8* %_159, i32 12)
	store i1 %_157, i1* %ntb
	%_163 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 18
	%_164 = load i8*, i8** %_163
	%_165 = bitcast i8* %_164 to i1(i8*)*
	%_167 = load %class.Tree*, %class.Tree** %root
	%_168 = bitcast %class.Tree* %_167 to i8*
	%_166 = call i1 %_165(i8* %_168)
	store i1 %_166, i1* %ntb
	call void @print_int(i32 900000000)
	%_171 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 17
	%_172 = load i8*, i8** %_171
	%_173 = bitcast i8* %_172 to i32(i8*, i32)*
	%_175 = load %class.Tree*, %class.Tree** %root
	%_176 = bitcast %class.Tree* %_175 to i8*
	%_174 = call i32 %_173(i8* %_176, i32 12)
	call void @print_int(i32 %_174)
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
define i1 @Tree.Init(i8* %this_raw, i32 %v_key) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_179 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 1
	store i32 %v_key, i32* %_179
	%_181 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 4
	store i1 false, i1* %_181
	%_183 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 2
	store i1 false, i1* %_183
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.SetRight(i8* %this_raw, i8* %rn_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%rn = bitcast i8* %rn_raw to %class.Tree*
	%_184 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 3
	store i8* %rn, i8** %_184
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.SetLeft(i8* %this_raw, i8* %ln_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%ln = bitcast i8* %ln_raw to %class.Tree*
	%_185 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 5
	store i8* %ln, i8** %_185
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define %class.Tree* @Tree.GetRight(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_186 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 3
	%_187 = load i8*, i8** %_186
	ret %class.Tree* %_187

end:
	call void @throw_oob()
	ret %class.Tree* zeroinitializer
}
define %class.Tree* @Tree.GetLeft(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_188 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 5
	%_189 = load i8*, i8** %_188
	ret %class.Tree* %_189

end:
	call void @throw_oob()
	ret %class.Tree* zeroinitializer
}
define i32 @Tree.GetKey(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_190 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 1
	%_191 = load i32, i32* %_190
	ret i32 %_191

end:
	call void @throw_oob()
	ret i32 1
}
define i1 @Tree.SetKey(i8* %this_raw, i32 %v_key) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_192 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 1
	store i32 %v_key, i32* %_192
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.GetHas_Right(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_193 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 2
	%_194 = load i1, i1* %_193
	ret i1 %_194

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.GetHas_Left(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_195 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 4
	%_196 = load i1, i1* %_195
	ret i1 %_196

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.SetHas_Left(i8* %this_raw, i1 %val) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_197 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 4
	store i1 %val, i1* %_197
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.SetHas_Right(i8* %this_raw, i1 %val) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_198 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 2
	store i1 %val, i1* %_198
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.Compare(i8* %this_raw, i32 %num1, i32 %num2) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%ntb = alloca i1
	%nti = alloca i32
	store i1 false, i1* %ntb
	%_202 = add i32 %num2, 1
	store i32 %_202, i32* %nti
	%_207 = icmp slt i32 %num1, %num2
	br i1 %_207, label %if0, label %if1

if0:
		store i1 false, i1* %ntb
		br label %if2

if1:
		%_211 = load i32, i32* %nti
		%_212 = icmp slt i32 %num1, %_211
		%_213 = xor i1 %_212, true
		br i1 %_213, label %if3, label %if4

if3:
			store i1 false, i1* %ntb
			br label %if5

if4:
			store i1 true, i1* %ntb
			br label %if5

if5:
		br label %if2

if2:
	%_218 = load i1, i1* %ntb
	ret i1 %_218

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.Insert(i8* %this_raw, i32 %v_key) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%new_node = alloca %class.Tree*
	store %class.Tree* null, %class.Tree** %new_node
	%ntb = alloca i1
	%cont = alloca i1
	%key_aux = alloca i32
	%current_node = alloca %class.Tree*
	store %class.Tree* null, %class.Tree** %current_node
	%_224 = getelementptr %class.Tree, %class.Tree* null, i32 1
	%_221 = ptrtoint %class.Tree* %_224 to i32
	%_222 = call i8* @calloc(i32 1, i32 %_221)
	%_223 = bitcast i8* %_222 to %class.Tree*
	store %class.Tree* %_223, %class.Tree** %new_node
	%_225 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 0
	%_226 = load i8*, i8** %_225
	%_227 = bitcast i8* %_226 to i1(i8*, i32)*
	%_229 = load %class.Tree*, %class.Tree** %new_node
	%_230 = bitcast %class.Tree* %_229 to i8*
	%_228 = call i1 %_227(i8* %_230, i32 %v_key)
	store i1 %_228, i1* %ntb
	store %class.Tree* %this, %class.Tree** %current_node
	store i1 true, i1* %cont
	br label %loop0

loop0:
		%_236 = load i1, i1* %cont
		br i1 %_236, label %loop1, label %loop2

loop1:
		%_237 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
		%_238 = load i8*, i8** %_237
		%_239 = bitcast i8* %_238 to i32(i8*)*
		%_241 = load %class.Tree*, %class.Tree** %current_node
		%_242 = bitcast %class.Tree* %_241 to i8*
		%_240 = call i32 %_239(i8* %_242)
		store i32 %_240, i32* %key_aux
		%_246 = load i32, i32* %key_aux
		%_247 = icmp slt i32 %v_key, %_246
		br i1 %_247, label %if6, label %if7

if6:
			%_248 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
			%_249 = load i8*, i8** %_248
			%_250 = bitcast i8* %_249 to i1(i8*)*
			%_252 = load %class.Tree*, %class.Tree** %current_node
			%_253 = bitcast %class.Tree* %_252 to i8*
			%_251 = call i1 %_250(i8* %_253)
			br i1 %_251, label %if9, label %if10

if9:
				%_254 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
				%_255 = load i8*, i8** %_254
				%_256 = bitcast i8* %_255 to i8*(i8*)*
				%_258 = load %class.Tree*, %class.Tree** %current_node
				%_259 = bitcast %class.Tree* %_258 to i8*
				%_257 = call i8* %_256(i8* %_259)
				store %class.Tree* %_257, %class.Tree** %current_node
				br label %if11

if10:
				store i1 false, i1* %cont
				%_264 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 9
				%_265 = load i8*, i8** %_264
				%_266 = bitcast i8* %_265 to i1(i8*, i1)*
				%_268 = load %class.Tree*, %class.Tree** %current_node
				%_269 = bitcast %class.Tree* %_268 to i8*
				%_267 = call i1 %_266(i8* %_269, i1 true)
				store i1 %_267, i1* %ntb
				%_273 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 2
				%_274 = load i8*, i8** %_273
				%_275 = bitcast i8* %_274 to i1(i8*, i8*)*
				%_277 = load %class.Tree*, %class.Tree** %current_node
				%_278 = bitcast %class.Tree* %_277 to i8*
				%_279 = load %class.Tree*, %class.Tree** %new_node
				%_276 = call i1 %_275(i8* %_278, i8* %_279)
				store i1 %_276, i1* %ntb
				br label %if11

if11:
			br label %if8

if7:
			%_282 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
			%_283 = load i8*, i8** %_282
			%_284 = bitcast i8* %_283 to i1(i8*)*
			%_286 = load %class.Tree*, %class.Tree** %current_node
			%_287 = bitcast %class.Tree* %_286 to i8*
			%_285 = call i1 %_284(i8* %_287)
			br i1 %_285, label %if12, label %if13

if12:
				%_288 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 3
				%_289 = load i8*, i8** %_288
				%_290 = bitcast i8* %_289 to i8*(i8*)*
				%_292 = load %class.Tree*, %class.Tree** %current_node
				%_293 = bitcast %class.Tree* %_292 to i8*
				%_291 = call i8* %_290(i8* %_293)
				store %class.Tree* %_291, %class.Tree** %current_node
				br label %if14

if13:
				store i1 false, i1* %cont
				%_298 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 10
				%_299 = load i8*, i8** %_298
				%_300 = bitcast i8* %_299 to i1(i8*, i1)*
				%_302 = load %class.Tree*, %class.Tree** %current_node
				%_303 = bitcast %class.Tree* %_302 to i8*
				%_301 = call i1 %_300(i8* %_303, i1 true)
				store i1 %_301, i1* %ntb
				%_307 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 1
				%_308 = load i8*, i8** %_307
				%_309 = bitcast i8* %_308 to i1(i8*, i8*)*
				%_311 = load %class.Tree*, %class.Tree** %current_node
				%_312 = bitcast %class.Tree* %_311 to i8*
				%_313 = load %class.Tree*, %class.Tree** %new_node
				%_310 = call i1 %_309(i8* %_312, i8* %_313)
				store i1 %_310, i1* %ntb
				br label %if14

if14:
			br label %if8

if8:
		br label %loop0

loop2:
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.Delete(i8* %this_raw, i32 %v_key) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%current_node = alloca %class.Tree*
	store %class.Tree* null, %class.Tree** %current_node
	%parent_node = alloca %class.Tree*
	store %class.Tree* null, %class.Tree** %parent_node
	%cont = alloca i1
	%found = alloca i1
	%is_root = alloca i1
	%key_aux = alloca i32
	%ntb = alloca i1
	store %class.Tree* %this, %class.Tree** %current_node
	store %class.Tree* %this, %class.Tree** %parent_node
	store i1 true, i1* %cont
	store i1 false, i1* %found
	store i1 true, i1* %is_root
	br label %loop3

loop3:
		%_324 = load i1, i1* %cont
		br i1 %_324, label %loop4, label %loop5

loop4:
		%_325 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
		%_326 = load i8*, i8** %_325
		%_327 = bitcast i8* %_326 to i32(i8*)*
		%_329 = load %class.Tree*, %class.Tree** %current_node
		%_330 = bitcast %class.Tree* %_329 to i8*
		%_328 = call i32 %_327(i8* %_330)
		store i32 %_328, i32* %key_aux
		%_334 = load i32, i32* %key_aux
		%_335 = icmp slt i32 %v_key, %_334
		br i1 %_335, label %if15, label %if16

if15:
			%_336 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
			%_337 = load i8*, i8** %_336
			%_338 = bitcast i8* %_337 to i1(i8*)*
			%_340 = load %class.Tree*, %class.Tree** %current_node
			%_341 = bitcast %class.Tree* %_340 to i8*
			%_339 = call i1 %_338(i8* %_341)
			br i1 %_339, label %if18, label %if19

if18:
				%_342 = load %class.Tree*, %class.Tree** %current_node
				store %class.Tree* %_342, %class.Tree** %parent_node
				%_344 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
				%_345 = load i8*, i8** %_344
				%_346 = bitcast i8* %_345 to i8*(i8*)*
				%_348 = load %class.Tree*, %class.Tree** %current_node
				%_349 = bitcast %class.Tree* %_348 to i8*
				%_347 = call i8* %_346(i8* %_349)
				store %class.Tree* %_347, %class.Tree** %current_node
				br label %if20

if19:
				store i1 false, i1* %cont
				br label %if20

if20:
			br label %if17

if16:
			%_354 = load i32, i32* %key_aux
			%_356 = icmp slt i32 %_354, %v_key
			br i1 %_356, label %if21, label %if22

if21:
				%_357 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
				%_358 = load i8*, i8** %_357
				%_359 = bitcast i8* %_358 to i1(i8*)*
				%_361 = load %class.Tree*, %class.Tree** %current_node
				%_362 = bitcast %class.Tree* %_361 to i8*
				%_360 = call i1 %_359(i8* %_362)
				br i1 %_360, label %if24, label %if25

if24:
					%_363 = load %class.Tree*, %class.Tree** %current_node
					store %class.Tree* %_363, %class.Tree** %parent_node
					%_365 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 3
					%_366 = load i8*, i8** %_365
					%_367 = bitcast i8* %_366 to i8*(i8*)*
					%_369 = load %class.Tree*, %class.Tree** %current_node
					%_370 = bitcast %class.Tree* %_369 to i8*
					%_368 = call i8* %_367(i8* %_370)
					store %class.Tree* %_368, %class.Tree** %current_node
					br label %if26

if25:
					store i1 false, i1* %cont
					br label %if26

if26:
				br label %if23

if22:
				%_375 = load i1, i1* %is_root
				br i1 %_375, label %if27, label %if28

if27:
					%_376 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
					%_377 = load i8*, i8** %_376
					%_378 = bitcast i8* %_377 to i1(i8*)*
					%_380 = load %class.Tree*, %class.Tree** %current_node
					%_381 = bitcast %class.Tree* %_380 to i8*
					%_379 = call i1 %_378(i8* %_381)
					%_382 = xor i1 %_379, true
					br label %if30
if30:
					%_384 = icmp ne i1 %_382, 0
					br i1 %_384, label %if31, label %if32

if31:
					%_387 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
					%_388 = load i8*, i8** %_387
					%_389 = bitcast i8* %_388 to i1(i8*)*
					%_391 = load %class.Tree*, %class.Tree** %current_node
					%_392 = bitcast %class.Tree* %_391 to i8*
					%_390 = call i1 %_389(i8* %_392)
					%_393 = xor i1 %_390, true
					%_385 = icmp ne i1 %_393, 0
					br label %if32

if32:
					%_386 = phi i1 [false, %if30], [%_385, %if31]
					br i1 %_386, label %if33, label %if34

if33:
						store i1 true, i1* %ntb
						br label %if35

if34:
						%_397 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 14
						%_398 = load i8*, i8** %_397
						%_399 = bitcast i8* %_398 to i1(i8*, i8*, i8*)*
						%_401 = bitcast %class.Tree* %this to i8*
						%_402 = load %class.Tree*, %class.Tree** %parent_node
						%_403 = load %class.Tree*, %class.Tree** %current_node
						%_400 = call i1 %_399(i8* %_401, i8* %_402, i8* %_403)
						store i1 %_400, i1* %ntb
						br label %if35

if35:
					br label %if29

if28:
					%_406 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 14
					%_407 = load i8*, i8** %_406
					%_408 = bitcast i8* %_407 to i1(i8*, i8*, i8*)*
					%_410 = bitcast %class.Tree* %this to i8*
					%_411 = load %class.Tree*, %class.Tree** %parent_node
					%_412 = load %class.Tree*, %class.Tree** %current_node
					%_409 = call i1 %_408(i8* %_410, i8* %_411, i8* %_412)
					store i1 %_409, i1* %ntb
					br label %if29

if29:
				store i1 true, i1* %found
				store i1 false, i1* %cont
				br label %if23

if23:
			br label %if17

if17:
		store i1 false, i1* %is_root
		br label %loop3

loop5:
	%_421 = load i1, i1* %found
	ret i1 %_421

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.Remove(i8* %this_raw, i8* %p_node_raw, i8* %c_node_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%c_node = bitcast i8* %c_node_raw to %class.Tree*
	%p_node = bitcast i8* %p_node_raw to %class.Tree*
	%ntb = alloca i1
	%auxkey1 = alloca i32
	%auxkey2 = alloca i32
	%_422 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
	%_423 = load i8*, i8** %_422
	%_424 = bitcast i8* %_423 to i1(i8*)*
	%_426 = bitcast %class.Tree* %c_node to i8*
	%_425 = call i1 %_424(i8* %_426)
	br i1 %_425, label %if36, label %if37

if36:
		%_427 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 16
		%_428 = load i8*, i8** %_427
		%_429 = bitcast i8* %_428 to i1(i8*, i8*, i8*)*
		%_431 = bitcast %class.Tree* %this to i8*
		%_430 = call i1 %_429(i8* %_431, i8* %p_node, i8* %c_node)
		store i1 %_430, i1* %ntb
		br label %if38

if37:
		%_434 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
		%_435 = load i8*, i8** %_434
		%_436 = bitcast i8* %_435 to i1(i8*)*
		%_438 = bitcast %class.Tree* %c_node to i8*
		%_437 = call i1 %_436(i8* %_438)
		br i1 %_437, label %if39, label %if40

if39:
			%_439 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 15
			%_440 = load i8*, i8** %_439
			%_441 = bitcast i8* %_440 to i1(i8*, i8*, i8*)*
			%_443 = bitcast %class.Tree* %this to i8*
			%_442 = call i1 %_441(i8* %_443, i8* %p_node, i8* %c_node)
			store i1 %_442, i1* %ntb
			br label %if41

if40:
			%_446 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
			%_447 = load i8*, i8** %_446
			%_448 = bitcast i8* %_447 to i32(i8*)*
			%_450 = bitcast %class.Tree* %c_node to i8*
			%_449 = call i32 %_448(i8* %_450)
			store i32 %_449, i32* %auxkey1
			%_453 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
			%_454 = load i8*, i8** %_453
			%_455 = bitcast i8* %_454 to i8*(i8*)*
			%_457 = bitcast %class.Tree* %p_node to i8*
			%_456 = call i8* %_455(i8* %_457)
			%_458 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
			%_459 = load i8*, i8** %_458
			%_460 = bitcast i8* %_459 to i32(i8*)*
			%_462 = load %class.Tree*, %class.Tree** %_456
			%_463 = bitcast %class.Tree* %_462 to i8*
			%_461 = call i32 %_460(i8* %_463)
			store i32 %_461, i32* %auxkey2
			%_466 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 11
			%_467 = load i8*, i8** %_466
			%_468 = bitcast i8* %_467 to i1(i8*, i32, i32)*
			%_470 = bitcast %class.Tree* %this to i8*
			%_471 = load i32, i32* %auxkey1
			%_472 = load i32, i32* %auxkey2
			%_469 = call i1 %_468(i8* %_470, i32 %_471, i32 %_472)
			br i1 %_469, label %if42, label %if43

if42:
				%_473 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 2
				%_474 = load i8*, i8** %_473
				%_475 = bitcast i8* %_474 to i1(i8*, i8*)*
				%_477 = bitcast %class.Tree* %p_node to i8*
				%_478 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 0
				%_479 = load i8*, i8** %_478
				%_476 = call i1 %_475(i8* %_477, i8* %_479)
				store i1 %_476, i1* %ntb
				%_482 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 9
				%_483 = load i8*, i8** %_482
				%_484 = bitcast i8* %_483 to i1(i8*, i1)*
				%_486 = bitcast %class.Tree* %p_node to i8*
				%_485 = call i1 %_484(i8* %_486, i1 false)
				store i1 %_485, i1* %ntb
				br label %if44

if43:
				%_490 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 1
				%_491 = load i8*, i8** %_490
				%_492 = bitcast i8* %_491 to i1(i8*, i8*)*
				%_494 = bitcast %class.Tree* %p_node to i8*
				%_495 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 0
				%_496 = load i8*, i8** %_495
				%_493 = call i1 %_492(i8* %_494, i8* %_496)
				store i1 %_493, i1* %ntb
				%_499 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 10
				%_500 = load i8*, i8** %_499
				%_501 = bitcast i8* %_500 to i1(i8*, i1)*
				%_503 = bitcast %class.Tree* %p_node to i8*
				%_502 = call i1 %_501(i8* %_503, i1 false)
				store i1 %_502, i1* %ntb
				br label %if44

if44:
			br label %if41

if41:
		br label %if38

if38:
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.RemoveRight(i8* %this_raw, i8* %p_node_raw, i8* %c_node_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%c_node = bitcast i8* %c_node_raw to %class.Tree*
	%p_node = bitcast i8* %p_node_raw to %class.Tree*
	%ntb = alloca i1
	br label %loop6

loop6:
		%_507 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
		%_508 = load i8*, i8** %_507
		%_509 = bitcast i8* %_508 to i1(i8*)*
		%_511 = bitcast %class.Tree* %c_node to i8*
		%_510 = call i1 %_509(i8* %_511)
		br i1 %_510, label %loop7, label %loop8

loop7:
		%_512 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 6
		%_513 = load i8*, i8** %_512
		%_514 = bitcast i8* %_513 to i1(i8*, i32)*
		%_516 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 3
		%_517 = load i8*, i8** %_516
		%_518 = bitcast i8* %_517 to i8*(i8*)*
		%_520 = bitcast %class.Tree* %c_node to i8*
		%_519 = call i8* %_518(i8* %_520)
		%_521 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
		%_522 = load i8*, i8** %_521
		%_523 = bitcast i8* %_522 to i32(i8*)*
		%_525 = load %class.Tree*, %class.Tree** %_519
		%_526 = bitcast %class.Tree* %_525 to i8*
		%_524 = call i32 %_523(i8* %_526)
		%_527 = bitcast %class.Tree* %c_node to i8*
		%_515 = call i1 %_514(i8* %_527, i32 %_524)
		store i1 %_515, i1* %ntb
		store %class.Tree* %c_node, %class.Tree** %p_node
		%_532 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 3
		%_533 = load i8*, i8** %_532
		%_534 = bitcast i8* %_533 to i8*(i8*)*
		%_536 = bitcast %class.Tree* %c_node to i8*
		%_535 = call i8* %_534(i8* %_536)
		store %class.Tree* %_535, %class.Tree** %c_node
		br label %loop6

loop8:
	%_539 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 1
	%_540 = load i8*, i8** %_539
	%_541 = bitcast i8* %_540 to i1(i8*, i8*)*
	%_543 = bitcast %class.Tree* %p_node to i8*
	%_544 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 0
	%_545 = load i8*, i8** %_544
	%_542 = call i1 %_541(i8* %_543, i8* %_545)
	store i1 %_542, i1* %ntb
	%_548 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 10
	%_549 = load i8*, i8** %_548
	%_550 = bitcast i8* %_549 to i1(i8*, i1)*
	%_552 = bitcast %class.Tree* %p_node to i8*
	%_551 = call i1 %_550(i8* %_552, i1 false)
	store i1 %_551, i1* %ntb
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.RemoveLeft(i8* %this_raw, i8* %p_node_raw, i8* %c_node_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%c_node = bitcast i8* %c_node_raw to %class.Tree*
	%p_node = bitcast i8* %p_node_raw to %class.Tree*
	%ntb = alloca i1
	br label %loop9

loop9:
		%_556 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
		%_557 = load i8*, i8** %_556
		%_558 = bitcast i8* %_557 to i1(i8*)*
		%_560 = bitcast %class.Tree* %c_node to i8*
		%_559 = call i1 %_558(i8* %_560)
		br i1 %_559, label %loop10, label %loop11

loop10:
		%_561 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 6
		%_562 = load i8*, i8** %_561
		%_563 = bitcast i8* %_562 to i1(i8*, i32)*
		%_565 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
		%_566 = load i8*, i8** %_565
		%_567 = bitcast i8* %_566 to i8*(i8*)*
		%_569 = bitcast %class.Tree* %c_node to i8*
		%_568 = call i8* %_567(i8* %_569)
		%_570 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
		%_571 = load i8*, i8** %_570
		%_572 = bitcast i8* %_571 to i32(i8*)*
		%_574 = load %class.Tree*, %class.Tree** %_568
		%_575 = bitcast %class.Tree* %_574 to i8*
		%_573 = call i32 %_572(i8* %_575)
		%_576 = bitcast %class.Tree* %c_node to i8*
		%_564 = call i1 %_563(i8* %_576, i32 %_573)
		store i1 %_564, i1* %ntb
		store %class.Tree* %c_node, %class.Tree** %p_node
		%_581 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
		%_582 = load i8*, i8** %_581
		%_583 = bitcast i8* %_582 to i8*(i8*)*
		%_585 = bitcast %class.Tree* %c_node to i8*
		%_584 = call i8* %_583(i8* %_585)
		store %class.Tree* %_584, %class.Tree** %c_node
		br label %loop9

loop11:
	%_588 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 2
	%_589 = load i8*, i8** %_588
	%_590 = bitcast i8* %_589 to i1(i8*, i8*)*
	%_592 = bitcast %class.Tree* %p_node to i8*
	%_593 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 0
	%_594 = load i8*, i8** %_593
	%_591 = call i1 %_590(i8* %_592, i8* %_594)
	store i1 %_591, i1* %ntb
	%_597 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 9
	%_598 = load i8*, i8** %_597
	%_599 = bitcast i8* %_598 to i1(i8*, i1)*
	%_601 = bitcast %class.Tree* %p_node to i8*
	%_600 = call i1 %_599(i8* %_601, i1 false)
	store i1 %_600, i1* %ntb
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i32 @Tree.Search(i8* %this_raw, i32 %v_key) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%cont = alloca i1
	%ifound = alloca i32
	%current_node = alloca %class.Tree*
	store %class.Tree* null, %class.Tree** %current_node
	%key_aux = alloca i32
	store %class.Tree* %this, %class.Tree** %current_node
	store i1 true, i1* %cont
	store i32 0, i32* %ifound
	br label %loop12

loop12:
		%_610 = load i1, i1* %cont
		br i1 %_610, label %loop13, label %loop14

loop13:
		%_611 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
		%_612 = load i8*, i8** %_611
		%_613 = bitcast i8* %_612 to i32(i8*)*
		%_615 = load %class.Tree*, %class.Tree** %current_node
		%_616 = bitcast %class.Tree* %_615 to i8*
		%_614 = call i32 %_613(i8* %_616)
		store i32 %_614, i32* %key_aux
		%_620 = load i32, i32* %key_aux
		%_621 = icmp slt i32 %v_key, %_620
		br i1 %_621, label %if45, label %if46

if45:
			%_622 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
			%_623 = load i8*, i8** %_622
			%_624 = bitcast i8* %_623 to i1(i8*)*
			%_626 = load %class.Tree*, %class.Tree** %current_node
			%_627 = bitcast %class.Tree* %_626 to i8*
			%_625 = call i1 %_624(i8* %_627)
			br i1 %_625, label %if48, label %if49

if48:
				%_628 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
				%_629 = load i8*, i8** %_628
				%_630 = bitcast i8* %_629 to i8*(i8*)*
				%_632 = load %class.Tree*, %class.Tree** %current_node
				%_633 = bitcast %class.Tree* %_632 to i8*
				%_631 = call i8* %_630(i8* %_633)
				store %class.Tree* %_631, %class.Tree** %current_node
				br label %if50

if49:
				store i1 false, i1* %cont
				br label %if50

if50:
			br label %if47

if46:
			%_638 = load i32, i32* %key_aux
			%_640 = icmp slt i32 %_638, %v_key
			br i1 %_640, label %if51, label %if52

if51:
				%_641 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
				%_642 = load i8*, i8** %_641
				%_643 = bitcast i8* %_642 to i1(i8*)*
				%_645 = load %class.Tree*, %class.Tree** %current_node
				%_646 = bitcast %class.Tree* %_645 to i8*
				%_644 = call i1 %_643(i8* %_646)
				br i1 %_644, label %if54, label %if55

if54:
					%_647 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 3
					%_648 = load i8*, i8** %_647
					%_649 = bitcast i8* %_648 to i8*(i8*)*
					%_651 = load %class.Tree*, %class.Tree** %current_node
					%_652 = bitcast %class.Tree* %_651 to i8*
					%_650 = call i8* %_649(i8* %_652)
					store %class.Tree* %_650, %class.Tree** %current_node
					br label %if56

if55:
					store i1 false, i1* %cont
					br label %if56

if56:
				br label %if53

if52:
				store i32 1, i32* %ifound
				store i1 false, i1* %cont
				br label %if53

if53:
			br label %if47

if47:
		br label %loop12

loop14:
	%_661 = load i32, i32* %ifound
	ret i32 %_661

end:
	call void @throw_oob()
	ret i32 1
}
define i1 @Tree.Print(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%current_node = alloca %class.Tree*
	store %class.Tree* null, %class.Tree** %current_node
	%ntb = alloca i1
	store %class.Tree* %this, %class.Tree** %current_node
	%_663 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 19
	%_664 = load i8*, i8** %_663
	%_665 = bitcast i8* %_664 to i1(i8*, i8*)*
	%_667 = bitcast %class.Tree* %this to i8*
	%_668 = load %class.Tree*, %class.Tree** %current_node
	%_666 = call i1 %_665(i8* %_667, i8* %_668)
	store i1 %_666, i1* %ntb
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.RecPrint(i8* %this_raw, i8* %node_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%node = bitcast i8* %node_raw to %class.Tree*
	%ntb = alloca i1
	%_671 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
	%_672 = load i8*, i8** %_671
	%_673 = bitcast i8* %_672 to i1(i8*)*
	%_675 = bitcast %class.Tree* %node to i8*
	%_674 = call i1 %_673(i8* %_675)
	br i1 %_674, label %if57, label %if58

if57:
		%_676 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 19
		%_677 = load i8*, i8** %_676
		%_678 = bitcast i8* %_677 to i1(i8*, i8*)*
		%_680 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
		%_681 = load i8*, i8** %_680
		%_682 = bitcast i8* %_681 to i8*(i8*)*
		%_684 = bitcast %class.Tree* %node to i8*
		%_683 = call i8* %_682(i8* %_684)
		%_685 = bitcast %class.Tree* %this to i8*
		%_679 = call i1 %_678(i8* %_685, i8* %_683)
		store i1 %_679, i1* %ntb
		br label %if59

if58:
		store i1 true, i1* %ntb
		br label %if59

if59:
	%_691 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
	%_692 = load i8*, i8** %_691
	%_693 = bitcast i8* %_692 to i32(i8*)*
	%_695 = bitcast %class.Tree* %node to i8*
	%_694 = call i32 %_693(i8* %_695)
	call void @print_int(i32 %_694)
	%_697 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
	%_698 = load i8*, i8** %_697
	%_699 = bitcast i8* %_698 to i1(i8*)*
	%_701 = bitcast %class.Tree* %node to i8*
	%_700 = call i1 %_699(i8* %_701)
	br i1 %_700, label %if60, label %if61

if60:
		%_702 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 19
		%_703 = load i8*, i8** %_702
		%_704 = bitcast i8* %_703 to i1(i8*, i8*)*
		%_706 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 3
		%_707 = load i8*, i8** %_706
		%_708 = bitcast i8* %_707 to i8*(i8*)*
		%_710 = bitcast %class.Tree* %node to i8*
		%_709 = call i8* %_708(i8* %_710)
		%_711 = bitcast %class.Tree* %this to i8*
		%_705 = call i1 %_704(i8* %_711, i8* %_709)
		store i1 %_705, i1* %ntb
		br label %if62

if61:
		store i1 true, i1* %ntb
		br label %if62

if62:
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
