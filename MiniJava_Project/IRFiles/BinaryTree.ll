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
	%_10 = bitcast %class.BT* %_0 to i8*
	%_9 = call i32 %_8(i8* %_10)
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
	%_16 = getelementptr %class.Tree, %class.Tree* null, i32 1
	%_13 = ptrtoint %class.Tree* %_16 to i32
	%_14 = call i8* @calloc(i32 1, i32 %_13)
	%_15 = bitcast i8* %_14 to %class.Tree*
	store %class.Tree* %_15, %class.Tree** %root
	%_17 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 0
	%_18 = load i8*, i8** %_17
	%_19 = bitcast i8* %_18 to i1(i8*, i32)*
	%_21 = bitcast %class.Tree* %root to i8*
	%_20 = call i1 %_19(i8* %_21, i32 16)
	store i1 %_20, i1* %ntb
	%_25 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 18
	%_26 = load i8*, i8** %_25
	%_27 = bitcast i8* %_26 to i1(i8*)*
	%_29 = bitcast %class.Tree* %root to i8*
	%_28 = call i1 %_27(i8* %_29)
	store i1 %_28, i1* %ntb
	call void @print_int(i32 100000000)
	%_32 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 12
	%_33 = load i8*, i8** %_32
	%_34 = bitcast i8* %_33 to i1(i8*, i32)*
	%_36 = bitcast %class.Tree* %root to i8*
	%_35 = call i1 %_34(i8* %_36, i32 8)
	store i1 %_35, i1* %ntb
	%_40 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 18
	%_41 = load i8*, i8** %_40
	%_42 = bitcast i8* %_41 to i1(i8*)*
	%_44 = bitcast %class.Tree* %root to i8*
	%_43 = call i1 %_42(i8* %_44)
	store i1 %_43, i1* %ntb
	%_47 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 12
	%_48 = load i8*, i8** %_47
	%_49 = bitcast i8* %_48 to i1(i8*, i32)*
	%_51 = bitcast %class.Tree* %root to i8*
	%_50 = call i1 %_49(i8* %_51, i32 24)
	store i1 %_50, i1* %ntb
	%_55 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 12
	%_56 = load i8*, i8** %_55
	%_57 = bitcast i8* %_56 to i1(i8*, i32)*
	%_59 = bitcast %class.Tree* %root to i8*
	%_58 = call i1 %_57(i8* %_59, i32 4)
	store i1 %_58, i1* %ntb
	%_63 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 12
	%_64 = load i8*, i8** %_63
	%_65 = bitcast i8* %_64 to i1(i8*, i32)*
	%_67 = bitcast %class.Tree* %root to i8*
	%_66 = call i1 %_65(i8* %_67, i32 12)
	store i1 %_66, i1* %ntb
	%_71 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 12
	%_72 = load i8*, i8** %_71
	%_73 = bitcast i8* %_72 to i1(i8*, i32)*
	%_75 = bitcast %class.Tree* %root to i8*
	%_74 = call i1 %_73(i8* %_75, i32 20)
	store i1 %_74, i1* %ntb
	%_79 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 12
	%_80 = load i8*, i8** %_79
	%_81 = bitcast i8* %_80 to i1(i8*, i32)*
	%_83 = bitcast %class.Tree* %root to i8*
	%_82 = call i1 %_81(i8* %_83, i32 28)
	store i1 %_82, i1* %ntb
	%_87 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 12
	%_88 = load i8*, i8** %_87
	%_89 = bitcast i8* %_88 to i1(i8*, i32)*
	%_91 = bitcast %class.Tree* %root to i8*
	%_90 = call i1 %_89(i8* %_91, i32 14)
	store i1 %_90, i1* %ntb
	%_95 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 18
	%_96 = load i8*, i8** %_95
	%_97 = bitcast i8* %_96 to i1(i8*)*
	%_99 = bitcast %class.Tree* %root to i8*
	%_98 = call i1 %_97(i8* %_99)
	store i1 %_98, i1* %ntb
	%_102 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 17
	%_103 = load i8*, i8** %_102
	%_104 = bitcast i8* %_103 to i32(i8*, i32)*
	%_106 = bitcast %class.Tree* %root to i8*
	%_105 = call i32 %_104(i8* %_106, i32 24)
	call void @print_int(i32 %_105)
	%_109 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 17
	%_110 = load i8*, i8** %_109
	%_111 = bitcast i8* %_110 to i32(i8*, i32)*
	%_113 = bitcast %class.Tree* %root to i8*
	%_112 = call i32 %_111(i8* %_113, i32 12)
	call void @print_int(i32 %_112)
	%_116 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 17
	%_117 = load i8*, i8** %_116
	%_118 = bitcast i8* %_117 to i32(i8*, i32)*
	%_120 = bitcast %class.Tree* %root to i8*
	%_119 = call i32 %_118(i8* %_120, i32 16)
	call void @print_int(i32 %_119)
	%_123 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 17
	%_124 = load i8*, i8** %_123
	%_125 = bitcast i8* %_124 to i32(i8*, i32)*
	%_127 = bitcast %class.Tree* %root to i8*
	%_126 = call i32 %_125(i8* %_127, i32 50)
	call void @print_int(i32 %_126)
	%_130 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 17
	%_131 = load i8*, i8** %_130
	%_132 = bitcast i8* %_131 to i32(i8*, i32)*
	%_134 = bitcast %class.Tree* %root to i8*
	%_133 = call i32 %_132(i8* %_134, i32 12)
	call void @print_int(i32 %_133)
	%_137 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 13
	%_138 = load i8*, i8** %_137
	%_139 = bitcast i8* %_138 to i1(i8*, i32)*
	%_141 = bitcast %class.Tree* %root to i8*
	%_140 = call i1 %_139(i8* %_141, i32 12)
	store i1 %_140, i1* %ntb
	%_145 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 18
	%_146 = load i8*, i8** %_145
	%_147 = bitcast i8* %_146 to i1(i8*)*
	%_149 = bitcast %class.Tree* %root to i8*
	%_148 = call i1 %_147(i8* %_149)
	store i1 %_148, i1* %ntb
	%_152 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 17
	%_153 = load i8*, i8** %_152
	%_154 = bitcast i8* %_153 to i32(i8*, i32)*
	%_156 = bitcast %class.Tree* %root to i8*
	%_155 = call i32 %_154(i8* %_156, i32 12)
	call void @print_int(i32 %_155)
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
define i1 @Tree.Init(i8* %this_raw, i32 %v_key) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_159 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 1
	store i32 %v_key, i32* %_159
	%_161 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 4
	store i1 false, i1* %_161
	%_163 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 2
	store i1 false, i1* %_163
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.SetRight(i8* %this_raw, i8* %rn_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%rn = bitcast i8* %rn_raw to %class.Tree*
	%_164 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 3
	store i8* %rn, i8** %_164
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.SetLeft(i8* %this_raw, i8* %ln_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%ln = bitcast i8* %ln_raw to %class.Tree*
	%_165 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 5
	store i8* %ln, i8** %_165
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define %class.Tree* @Tree.GetRight(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_166 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 3
	%_167 = load i8*, i8** %_166
	ret %class.Tree* %_167

end:
	call void @throw_oob()
	ret %class.Tree* zeroinitializer
}
define %class.Tree* @Tree.GetLeft(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_168 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 5
	%_169 = load i8*, i8** %_168
	ret %class.Tree* %_169

end:
	call void @throw_oob()
	ret %class.Tree* zeroinitializer
}
define i32 @Tree.GetKey(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_170 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 1
	%_171 = load i32, i32* %_170
	ret i32 %_171

end:
	call void @throw_oob()
	ret i32 1
}
define i1 @Tree.SetKey(i8* %this_raw, i32 %v_key) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_172 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 1
	store i32 %v_key, i32* %_172
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.GetHas_Right(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_173 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 2
	%_174 = load i1, i1* %_173
	ret i1 %_174

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.GetHas_Left(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_175 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 4
	%_176 = load i1, i1* %_175
	ret i1 %_176

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.SetHas_Left(i8* %this_raw, i1 %val) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_177 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 4
	store i1 %val, i1* %_177
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.SetHas_Right(i8* %this_raw, i1 %val) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_178 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 2
	store i1 %val, i1* %_178
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
	%_182 = add i32 %num2, 1
	store i32 %_182, i32* %nti
	%_187 = icmp slt i32 %num1, %num2
	br i1 %_187, label %if0, label %if1

if0:
		store i1 false, i1* %ntb
		br label %if2

if1:
		%_191 = load i32, i32* %nti
		%_192 = icmp slt i32 %num1, %_191
		%_193 = xor i1 %_192, true
		br i1 %_193, label %if3, label %if4

if3:
			store i1 false, i1* %ntb
			br label %if5

if4:
			store i1 true, i1* %ntb
			br label %if5

if5:
		br label %if2

if2:
	%_198 = load i1, i1* %ntb
	ret i1 %_198

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
	%_204 = getelementptr %class.Tree, %class.Tree* null, i32 1
	%_201 = ptrtoint %class.Tree* %_204 to i32
	%_202 = call i8* @calloc(i32 1, i32 %_201)
	%_203 = bitcast i8* %_202 to %class.Tree*
	store %class.Tree* %_203, %class.Tree** %new_node
	%_205 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 0
	%_206 = load i8*, i8** %_205
	%_207 = bitcast i8* %_206 to i1(i8*, i32)*
	%_209 = bitcast %class.Tree* %new_node to i8*
	%_208 = call i1 %_207(i8* %_209, i32 %v_key)
	store i1 %_208, i1* %ntb
	store %class.Tree* %this, %class.Tree** %current_node
	store i1 true, i1* %cont
	br label %loop0

loop0:
		%_215 = load i1, i1* %cont
		br i1 %_215, label %loop1, label %loop2

loop1:
		%_216 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
		%_217 = load i8*, i8** %_216
		%_218 = bitcast i8* %_217 to i32(i8*)*
		%_220 = bitcast %class.Tree* %current_node to i8*
		%_219 = call i32 %_218(i8* %_220)
		store i32 %_219, i32* %key_aux
		%_224 = load i32, i32* %key_aux
		%_225 = icmp slt i32 %v_key, %_224
		br i1 %_225, label %if6, label %if7

if6:
			%_226 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
			%_227 = load i8*, i8** %_226
			%_228 = bitcast i8* %_227 to i1(i8*)*
			%_230 = bitcast %class.Tree* %current_node to i8*
			%_229 = call i1 %_228(i8* %_230)
			br i1 %_229, label %if9, label %if10

if9:
				%_231 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
				%_232 = load i8*, i8** %_231
				%_233 = bitcast i8* %_232 to i8*(i8*)*
				%_235 = bitcast %class.Tree* %current_node to i8*
				%_234 = call i8* %_233(i8* %_235)
				store %class.Tree* %_234, %class.Tree** %current_node
				br label %if11

if10:
				store i1 false, i1* %cont
				%_240 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 9
				%_241 = load i8*, i8** %_240
				%_242 = bitcast i8* %_241 to i1(i8*, i1)*
				%_244 = bitcast %class.Tree* %current_node to i8*
				%_243 = call i1 %_242(i8* %_244, i1 true)
				store i1 %_243, i1* %ntb
				%_248 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 2
				%_249 = load i8*, i8** %_248
				%_250 = bitcast i8* %_249 to i1(i8*, i8*)*
				%_252 = bitcast %class.Tree* %current_node to i8*
				%_253 = load %class.Tree*, %class.Tree** %new_node
				%_251 = call i1 %_250(i8* %_252, i8* %_253)
				store i1 %_251, i1* %ntb
				br label %if11

if11:
			br label %if8

if7:
			%_256 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
			%_257 = load i8*, i8** %_256
			%_258 = bitcast i8* %_257 to i1(i8*)*
			%_260 = bitcast %class.Tree* %current_node to i8*
			%_259 = call i1 %_258(i8* %_260)
			br i1 %_259, label %if12, label %if13

if12:
				%_261 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 3
				%_262 = load i8*, i8** %_261
				%_263 = bitcast i8* %_262 to i8*(i8*)*
				%_265 = bitcast %class.Tree* %current_node to i8*
				%_264 = call i8* %_263(i8* %_265)
				store %class.Tree* %_264, %class.Tree** %current_node
				br label %if14

if13:
				store i1 false, i1* %cont
				%_270 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 10
				%_271 = load i8*, i8** %_270
				%_272 = bitcast i8* %_271 to i1(i8*, i1)*
				%_274 = bitcast %class.Tree* %current_node to i8*
				%_273 = call i1 %_272(i8* %_274, i1 true)
				store i1 %_273, i1* %ntb
				%_278 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 1
				%_279 = load i8*, i8** %_278
				%_280 = bitcast i8* %_279 to i1(i8*, i8*)*
				%_282 = bitcast %class.Tree* %current_node to i8*
				%_283 = load %class.Tree*, %class.Tree** %new_node
				%_281 = call i1 %_280(i8* %_282, i8* %_283)
				store i1 %_281, i1* %ntb
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
		%_294 = load i1, i1* %cont
		br i1 %_294, label %loop4, label %loop5

loop4:
		%_295 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
		%_296 = load i8*, i8** %_295
		%_297 = bitcast i8* %_296 to i32(i8*)*
		%_299 = bitcast %class.Tree* %current_node to i8*
		%_298 = call i32 %_297(i8* %_299)
		store i32 %_298, i32* %key_aux
		%_303 = load i32, i32* %key_aux
		%_304 = icmp slt i32 %v_key, %_303
		br i1 %_304, label %if15, label %if16

if15:
			%_305 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
			%_306 = load i8*, i8** %_305
			%_307 = bitcast i8* %_306 to i1(i8*)*
			%_309 = bitcast %class.Tree* %current_node to i8*
			%_308 = call i1 %_307(i8* %_309)
			br i1 %_308, label %if18, label %if19

if18:
				%_310 = load %class.Tree*, %class.Tree** %current_node
				store %class.Tree* %_310, %class.Tree** %parent_node
				%_312 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
				%_313 = load i8*, i8** %_312
				%_314 = bitcast i8* %_313 to i8*(i8*)*
				%_316 = bitcast %class.Tree* %current_node to i8*
				%_315 = call i8* %_314(i8* %_316)
				store %class.Tree* %_315, %class.Tree** %current_node
				br label %if20

if19:
				store i1 false, i1* %cont
				br label %if20

if20:
			br label %if17

if16:
			%_321 = load i32, i32* %key_aux
			%_323 = icmp slt i32 %_321, %v_key
			br i1 %_323, label %if21, label %if22

if21:
				%_324 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
				%_325 = load i8*, i8** %_324
				%_326 = bitcast i8* %_325 to i1(i8*)*
				%_328 = bitcast %class.Tree* %current_node to i8*
				%_327 = call i1 %_326(i8* %_328)
				br i1 %_327, label %if24, label %if25

if24:
					%_329 = load %class.Tree*, %class.Tree** %current_node
					store %class.Tree* %_329, %class.Tree** %parent_node
					%_331 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 3
					%_332 = load i8*, i8** %_331
					%_333 = bitcast i8* %_332 to i8*(i8*)*
					%_335 = bitcast %class.Tree* %current_node to i8*
					%_334 = call i8* %_333(i8* %_335)
					store %class.Tree* %_334, %class.Tree** %current_node
					br label %if26

if25:
					store i1 false, i1* %cont
					br label %if26

if26:
				br label %if23

if22:
				%_340 = load i1, i1* %is_root
				br i1 %_340, label %if27, label %if28

if27:
					%_341 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
					%_342 = load i8*, i8** %_341
					%_343 = bitcast i8* %_342 to i1(i8*)*
					%_345 = bitcast %class.Tree* %current_node to i8*
					%_344 = call i1 %_343(i8* %_345)
					%_346 = xor i1 %_344, true
					br label %if30
if30:
					%_348 = icmp ne i1 %_346, 0
					br i1 %_348, label %if31, label %if32

if31:
					%_351 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
					%_352 = load i8*, i8** %_351
					%_353 = bitcast i8* %_352 to i1(i8*)*
					%_355 = bitcast %class.Tree* %current_node to i8*
					%_354 = call i1 %_353(i8* %_355)
					%_356 = xor i1 %_354, true
					%_349 = icmp ne i1 %_356, 0
					br label %if32

if32:
					%_350 = phi i1 [false, %if30], [%_349, %if31]
					br i1 %_350, label %if33, label %if34

if33:
						store i1 true, i1* %ntb
						br label %if35

if34:
						%_360 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 14
						%_361 = load i8*, i8** %_360
						%_362 = bitcast i8* %_361 to i1(i8*, i8*, i8*)*
						%_364 = bitcast %class.Tree* %this to i8*
						%_365 = load %class.Tree*, %class.Tree** %parent_node
						%_366 = load %class.Tree*, %class.Tree** %current_node
						%_363 = call i1 %_362(i8* %_364, i8* %_365, i8* %_366)
						store i1 %_363, i1* %ntb
						br label %if35

if35:
					br label %if29

if28:
					%_369 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 14
					%_370 = load i8*, i8** %_369
					%_371 = bitcast i8* %_370 to i1(i8*, i8*, i8*)*
					%_373 = bitcast %class.Tree* %this to i8*
					%_374 = load %class.Tree*, %class.Tree** %parent_node
					%_375 = load %class.Tree*, %class.Tree** %current_node
					%_372 = call i1 %_371(i8* %_373, i8* %_374, i8* %_375)
					store i1 %_372, i1* %ntb
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
	%_384 = load i1, i1* %found
	ret i1 %_384

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
	%_385 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
	%_386 = load i8*, i8** %_385
	%_387 = bitcast i8* %_386 to i1(i8*)*
	%_389 = bitcast %class.Tree* %c_node to i8*
	%_388 = call i1 %_387(i8* %_389)
	br i1 %_388, label %if36, label %if37

if36:
		%_390 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 16
		%_391 = load i8*, i8** %_390
		%_392 = bitcast i8* %_391 to i1(i8*, i8*, i8*)*
		%_394 = bitcast %class.Tree* %this to i8*
		%_393 = call i1 %_392(i8* %_394, i8* %p_node, i8* %c_node)
		store i1 %_393, i1* %ntb
		br label %if38

if37:
		%_397 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
		%_398 = load i8*, i8** %_397
		%_399 = bitcast i8* %_398 to i1(i8*)*
		%_401 = bitcast %class.Tree* %c_node to i8*
		%_400 = call i1 %_399(i8* %_401)
		br i1 %_400, label %if39, label %if40

if39:
			%_402 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 15
			%_403 = load i8*, i8** %_402
			%_404 = bitcast i8* %_403 to i1(i8*, i8*, i8*)*
			%_406 = bitcast %class.Tree* %this to i8*
			%_405 = call i1 %_404(i8* %_406, i8* %p_node, i8* %c_node)
			store i1 %_405, i1* %ntb
			br label %if41

if40:
			%_409 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
			%_410 = load i8*, i8** %_409
			%_411 = bitcast i8* %_410 to i32(i8*)*
			%_413 = bitcast %class.Tree* %c_node to i8*
			%_412 = call i32 %_411(i8* %_413)
			store i32 %_412, i32* %auxkey1
			%_416 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
			%_417 = load i8*, i8** %_416
			%_418 = bitcast i8* %_417 to i8*(i8*)*
			%_420 = bitcast %class.Tree* %p_node to i8*
			%_419 = call i8* %_418(i8* %_420)
			%_421 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
			%_422 = load i8*, i8** %_421
			%_423 = bitcast i8* %_422 to i32(i8*)*
			%_425 = bitcast %class.Tree* %_419 to i8*
			%_424 = call i32 %_423(i8* %_425)
			store i32 %_424, i32* %auxkey2
			%_428 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 11
			%_429 = load i8*, i8** %_428
			%_430 = bitcast i8* %_429 to i1(i8*, i32, i32)*
			%_432 = bitcast %class.Tree* %this to i8*
			%_433 = load i32, i32* %auxkey1
			%_434 = load i32, i32* %auxkey2
			%_431 = call i1 %_430(i8* %_432, i32 %_433, i32 %_434)
			br i1 %_431, label %if42, label %if43

if42:
				%_435 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 2
				%_436 = load i8*, i8** %_435
				%_437 = bitcast i8* %_436 to i1(i8*, i8*)*
				%_439 = bitcast %class.Tree* %p_node to i8*
				%_440 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 0
				%_441 = load i8*, i8** %_440
				%_438 = call i1 %_437(i8* %_439, i8* %_441)
				store i1 %_438, i1* %ntb
				%_444 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 9
				%_445 = load i8*, i8** %_444
				%_446 = bitcast i8* %_445 to i1(i8*, i1)*
				%_448 = bitcast %class.Tree* %p_node to i8*
				%_447 = call i1 %_446(i8* %_448, i1 false)
				store i1 %_447, i1* %ntb
				br label %if44

if43:
				%_452 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 1
				%_453 = load i8*, i8** %_452
				%_454 = bitcast i8* %_453 to i1(i8*, i8*)*
				%_456 = bitcast %class.Tree* %p_node to i8*
				%_457 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 0
				%_458 = load i8*, i8** %_457
				%_455 = call i1 %_454(i8* %_456, i8* %_458)
				store i1 %_455, i1* %ntb
				%_461 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 10
				%_462 = load i8*, i8** %_461
				%_463 = bitcast i8* %_462 to i1(i8*, i1)*
				%_465 = bitcast %class.Tree* %p_node to i8*
				%_464 = call i1 %_463(i8* %_465, i1 false)
				store i1 %_464, i1* %ntb
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
		%_469 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
		%_470 = load i8*, i8** %_469
		%_471 = bitcast i8* %_470 to i1(i8*)*
		%_473 = bitcast %class.Tree* %c_node to i8*
		%_472 = call i1 %_471(i8* %_473)
		br i1 %_472, label %loop7, label %loop8

loop7:
		%_474 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 6
		%_475 = load i8*, i8** %_474
		%_476 = bitcast i8* %_475 to i1(i8*, i32)*
		%_478 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 3
		%_479 = load i8*, i8** %_478
		%_480 = bitcast i8* %_479 to i8*(i8*)*
		%_482 = bitcast %class.Tree* %c_node to i8*
		%_481 = call i8* %_480(i8* %_482)
		%_483 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
		%_484 = load i8*, i8** %_483
		%_485 = bitcast i8* %_484 to i32(i8*)*
		%_487 = bitcast %class.Tree* %_481 to i8*
		%_486 = call i32 %_485(i8* %_487)
		%_488 = bitcast %class.Tree* %c_node to i8*
		%_477 = call i1 %_476(i8* %_488, i32 %_486)
		store i1 %_477, i1* %ntb
		store %class.Tree* %c_node, %class.Tree** %p_node
		%_493 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 3
		%_494 = load i8*, i8** %_493
		%_495 = bitcast i8* %_494 to i8*(i8*)*
		%_497 = bitcast %class.Tree* %c_node to i8*
		%_496 = call i8* %_495(i8* %_497)
		store %class.Tree* %_496, %class.Tree** %c_node
		br label %loop6

loop8:
	%_500 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 1
	%_501 = load i8*, i8** %_500
	%_502 = bitcast i8* %_501 to i1(i8*, i8*)*
	%_504 = bitcast %class.Tree* %p_node to i8*
	%_505 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 0
	%_506 = load i8*, i8** %_505
	%_503 = call i1 %_502(i8* %_504, i8* %_506)
	store i1 %_503, i1* %ntb
	%_509 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 10
	%_510 = load i8*, i8** %_509
	%_511 = bitcast i8* %_510 to i1(i8*, i1)*
	%_513 = bitcast %class.Tree* %p_node to i8*
	%_512 = call i1 %_511(i8* %_513, i1 false)
	store i1 %_512, i1* %ntb
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
		%_517 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
		%_518 = load i8*, i8** %_517
		%_519 = bitcast i8* %_518 to i1(i8*)*
		%_521 = bitcast %class.Tree* %c_node to i8*
		%_520 = call i1 %_519(i8* %_521)
		br i1 %_520, label %loop10, label %loop11

loop10:
		%_522 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 6
		%_523 = load i8*, i8** %_522
		%_524 = bitcast i8* %_523 to i1(i8*, i32)*
		%_526 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
		%_527 = load i8*, i8** %_526
		%_528 = bitcast i8* %_527 to i8*(i8*)*
		%_530 = bitcast %class.Tree* %c_node to i8*
		%_529 = call i8* %_528(i8* %_530)
		%_531 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
		%_532 = load i8*, i8** %_531
		%_533 = bitcast i8* %_532 to i32(i8*)*
		%_535 = bitcast %class.Tree* %_529 to i8*
		%_534 = call i32 %_533(i8* %_535)
		%_536 = bitcast %class.Tree* %c_node to i8*
		%_525 = call i1 %_524(i8* %_536, i32 %_534)
		store i1 %_525, i1* %ntb
		store %class.Tree* %c_node, %class.Tree** %p_node
		%_541 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
		%_542 = load i8*, i8** %_541
		%_543 = bitcast i8* %_542 to i8*(i8*)*
		%_545 = bitcast %class.Tree* %c_node to i8*
		%_544 = call i8* %_543(i8* %_545)
		store %class.Tree* %_544, %class.Tree** %c_node
		br label %loop9

loop11:
	%_548 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 2
	%_549 = load i8*, i8** %_548
	%_550 = bitcast i8* %_549 to i1(i8*, i8*)*
	%_552 = bitcast %class.Tree* %p_node to i8*
	%_553 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 0
	%_554 = load i8*, i8** %_553
	%_551 = call i1 %_550(i8* %_552, i8* %_554)
	store i1 %_551, i1* %ntb
	%_557 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 9
	%_558 = load i8*, i8** %_557
	%_559 = bitcast i8* %_558 to i1(i8*, i1)*
	%_561 = bitcast %class.Tree* %p_node to i8*
	%_560 = call i1 %_559(i8* %_561, i1 false)
	store i1 %_560, i1* %ntb
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
		%_570 = load i1, i1* %cont
		br i1 %_570, label %loop13, label %loop14

loop13:
		%_571 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
		%_572 = load i8*, i8** %_571
		%_573 = bitcast i8* %_572 to i32(i8*)*
		%_575 = bitcast %class.Tree* %current_node to i8*
		%_574 = call i32 %_573(i8* %_575)
		store i32 %_574, i32* %key_aux
		%_579 = load i32, i32* %key_aux
		%_580 = icmp slt i32 %v_key, %_579
		br i1 %_580, label %if45, label %if46

if45:
			%_581 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
			%_582 = load i8*, i8** %_581
			%_583 = bitcast i8* %_582 to i1(i8*)*
			%_585 = bitcast %class.Tree* %current_node to i8*
			%_584 = call i1 %_583(i8* %_585)
			br i1 %_584, label %if48, label %if49

if48:
				%_586 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
				%_587 = load i8*, i8** %_586
				%_588 = bitcast i8* %_587 to i8*(i8*)*
				%_590 = bitcast %class.Tree* %current_node to i8*
				%_589 = call i8* %_588(i8* %_590)
				store %class.Tree* %_589, %class.Tree** %current_node
				br label %if50

if49:
				store i1 false, i1* %cont
				br label %if50

if50:
			br label %if47

if46:
			%_595 = load i32, i32* %key_aux
			%_597 = icmp slt i32 %_595, %v_key
			br i1 %_597, label %if51, label %if52

if51:
				%_598 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
				%_599 = load i8*, i8** %_598
				%_600 = bitcast i8* %_599 to i1(i8*)*
				%_602 = bitcast %class.Tree* %current_node to i8*
				%_601 = call i1 %_600(i8* %_602)
				br i1 %_601, label %if54, label %if55

if54:
					%_603 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 3
					%_604 = load i8*, i8** %_603
					%_605 = bitcast i8* %_604 to i8*(i8*)*
					%_607 = bitcast %class.Tree* %current_node to i8*
					%_606 = call i8* %_605(i8* %_607)
					store %class.Tree* %_606, %class.Tree** %current_node
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
	%_616 = load i32, i32* %ifound
	ret i32 %_616

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
	%_618 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 19
	%_619 = load i8*, i8** %_618
	%_620 = bitcast i8* %_619 to i1(i8*, i8*)*
	%_622 = bitcast %class.Tree* %this to i8*
	%_623 = load %class.Tree*, %class.Tree** %current_node
	%_621 = call i1 %_620(i8* %_622, i8* %_623)
	store i1 %_621, i1* %ntb
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.RecPrint(i8* %this_raw, i8* %node_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%node = bitcast i8* %node_raw to %class.Tree*
	%ntb = alloca i1
	%_626 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
	%_627 = load i8*, i8** %_626
	%_628 = bitcast i8* %_627 to i1(i8*)*
	%_630 = bitcast %class.Tree* %node to i8*
	%_629 = call i1 %_628(i8* %_630)
	br i1 %_629, label %if57, label %if58

if57:
		%_631 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 19
		%_632 = load i8*, i8** %_631
		%_633 = bitcast i8* %_632 to i1(i8*, i8*)*
		%_635 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
		%_636 = load i8*, i8** %_635
		%_637 = bitcast i8* %_636 to i8*(i8*)*
		%_639 = bitcast %class.Tree* %node to i8*
		%_638 = call i8* %_637(i8* %_639)
		%_640 = bitcast %class.Tree* %this to i8*
		%_634 = call i1 %_633(i8* %_640, i8* %_638)
		store i1 %_634, i1* %ntb
		br label %if59

if58:
		store i1 true, i1* %ntb
		br label %if59

if59:
	%_646 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
	%_647 = load i8*, i8** %_646
	%_648 = bitcast i8* %_647 to i32(i8*)*
	%_650 = bitcast %class.Tree* %node to i8*
	%_649 = call i32 %_648(i8* %_650)
	call void @print_int(i32 %_649)
	%_652 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
	%_653 = load i8*, i8** %_652
	%_654 = bitcast i8* %_653 to i1(i8*)*
	%_656 = bitcast %class.Tree* %node to i8*
	%_655 = call i1 %_654(i8* %_656)
	br i1 %_655, label %if60, label %if61

if60:
		%_657 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 19
		%_658 = load i8*, i8** %_657
		%_659 = bitcast i8* %_658 to i1(i8*, i8*)*
		%_661 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 3
		%_662 = load i8*, i8** %_661
		%_663 = bitcast i8* %_662 to i8*(i8*)*
		%_665 = bitcast %class.Tree* %node to i8*
		%_664 = call i8* %_663(i8* %_665)
		%_666 = bitcast %class.Tree* %this to i8*
		%_660 = call i1 %_659(i8* %_666, i8* %_664)
		store i1 %_660, i1* %ntb
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
