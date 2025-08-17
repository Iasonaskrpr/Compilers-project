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
	%_21 = load %class.Tree*, %class.Tree** %root
	%_22 = bitcast %class.Tree* %_21 to i8*
	%_20 = call i1 %_19(i8* %_22, i32 16)
	store i1 %_20, i1* %ntb
	%_26 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 18
	%_27 = load i8*, i8** %_26
	%_28 = bitcast i8* %_27 to i1(i8*)*
	%_30 = load %class.Tree*, %class.Tree** %root
	%_31 = bitcast %class.Tree* %_30 to i8*
	%_29 = call i1 %_28(i8* %_31)
	store i1 %_29, i1* %ntb
	call void @print_int(i32 100000000)
	%_34 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 12
	%_35 = load i8*, i8** %_34
	%_36 = bitcast i8* %_35 to i1(i8*, i32)*
	%_38 = load %class.Tree*, %class.Tree** %root
	%_39 = bitcast %class.Tree* %_38 to i8*
	%_37 = call i1 %_36(i8* %_39, i32 8)
	store i1 %_37, i1* %ntb
	%_43 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 18
	%_44 = load i8*, i8** %_43
	%_45 = bitcast i8* %_44 to i1(i8*)*
	%_47 = load %class.Tree*, %class.Tree** %root
	%_48 = bitcast %class.Tree* %_47 to i8*
	%_46 = call i1 %_45(i8* %_48)
	store i1 %_46, i1* %ntb
	call void @print_int(i32 200000000)
	%_51 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 12
	%_52 = load i8*, i8** %_51
	%_53 = bitcast i8* %_52 to i1(i8*, i32)*
	%_55 = load %class.Tree*, %class.Tree** %root
	%_56 = bitcast %class.Tree* %_55 to i8*
	%_54 = call i1 %_53(i8* %_56, i32 24)
	store i1 %_54, i1* %ntb
	%_60 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 12
	%_61 = load i8*, i8** %_60
	%_62 = bitcast i8* %_61 to i1(i8*, i32)*
	%_64 = load %class.Tree*, %class.Tree** %root
	%_65 = bitcast %class.Tree* %_64 to i8*
	%_63 = call i1 %_62(i8* %_65, i32 4)
	store i1 %_63, i1* %ntb
	%_69 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 12
	%_70 = load i8*, i8** %_69
	%_71 = bitcast i8* %_70 to i1(i8*, i32)*
	%_73 = load %class.Tree*, %class.Tree** %root
	%_74 = bitcast %class.Tree* %_73 to i8*
	%_72 = call i1 %_71(i8* %_74, i32 12)
	store i1 %_72, i1* %ntb
	%_78 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 12
	%_79 = load i8*, i8** %_78
	%_80 = bitcast i8* %_79 to i1(i8*, i32)*
	%_82 = load %class.Tree*, %class.Tree** %root
	%_83 = bitcast %class.Tree* %_82 to i8*
	%_81 = call i1 %_80(i8* %_83, i32 20)
	store i1 %_81, i1* %ntb
	%_87 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 12
	%_88 = load i8*, i8** %_87
	%_89 = bitcast i8* %_88 to i1(i8*, i32)*
	%_91 = load %class.Tree*, %class.Tree** %root
	%_92 = bitcast %class.Tree* %_91 to i8*
	%_90 = call i1 %_89(i8* %_92, i32 28)
	store i1 %_90, i1* %ntb
	%_96 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 12
	%_97 = load i8*, i8** %_96
	%_98 = bitcast i8* %_97 to i1(i8*, i32)*
	%_100 = load %class.Tree*, %class.Tree** %root
	%_101 = bitcast %class.Tree* %_100 to i8*
	%_99 = call i1 %_98(i8* %_101, i32 14)
	store i1 %_99, i1* %ntb
	%_105 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 18
	%_106 = load i8*, i8** %_105
	%_107 = bitcast i8* %_106 to i1(i8*)*
	%_109 = load %class.Tree*, %class.Tree** %root
	%_110 = bitcast %class.Tree* %_109 to i8*
	%_108 = call i1 %_107(i8* %_110)
	store i1 %_108, i1* %ntb
	call void @print_int(i32 300000000)
	%_113 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 17
	%_114 = load i8*, i8** %_113
	%_115 = bitcast i8* %_114 to i32(i8*, i32)*
	%_117 = load %class.Tree*, %class.Tree** %root
	%_118 = bitcast %class.Tree* %_117 to i8*
	%_116 = call i32 %_115(i8* %_118, i32 24)
	call void @print_int(i32 %_116)
	call void @print_int(i32 400000000)
	%_121 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 17
	%_122 = load i8*, i8** %_121
	%_123 = bitcast i8* %_122 to i32(i8*, i32)*
	%_125 = load %class.Tree*, %class.Tree** %root
	%_126 = bitcast %class.Tree* %_125 to i8*
	%_124 = call i32 %_123(i8* %_126, i32 12)
	call void @print_int(i32 %_124)
	call void @print_int(i32 500000000)
	%_129 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 17
	%_130 = load i8*, i8** %_129
	%_131 = bitcast i8* %_130 to i32(i8*, i32)*
	%_133 = load %class.Tree*, %class.Tree** %root
	%_134 = bitcast %class.Tree* %_133 to i8*
	%_132 = call i32 %_131(i8* %_134, i32 16)
	call void @print_int(i32 %_132)
	call void @print_int(i32 600000000)
	%_137 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 17
	%_138 = load i8*, i8** %_137
	%_139 = bitcast i8* %_138 to i32(i8*, i32)*
	%_141 = load %class.Tree*, %class.Tree** %root
	%_142 = bitcast %class.Tree* %_141 to i8*
	%_140 = call i32 %_139(i8* %_142, i32 50)
	call void @print_int(i32 %_140)
	call void @print_int(i32 700000000)
	%_145 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 17
	%_146 = load i8*, i8** %_145
	%_147 = bitcast i8* %_146 to i32(i8*, i32)*
	%_149 = load %class.Tree*, %class.Tree** %root
	%_150 = bitcast %class.Tree* %_149 to i8*
	%_148 = call i32 %_147(i8* %_150, i32 12)
	call void @print_int(i32 %_148)
	call void @print_int(i32 800000000)
	%_153 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 13
	%_154 = load i8*, i8** %_153
	%_155 = bitcast i8* %_154 to i1(i8*, i32)*
	%_157 = load %class.Tree*, %class.Tree** %root
	%_158 = bitcast %class.Tree* %_157 to i8*
	%_156 = call i1 %_155(i8* %_158, i32 12)
	store i1 %_156, i1* %ntb
	%_162 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 18
	%_163 = load i8*, i8** %_162
	%_164 = bitcast i8* %_163 to i1(i8*)*
	%_166 = load %class.Tree*, %class.Tree** %root
	%_167 = bitcast %class.Tree* %_166 to i8*
	%_165 = call i1 %_164(i8* %_167)
	store i1 %_165, i1* %ntb
	call void @print_int(i32 900000000)
	%_170 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 17
	%_171 = load i8*, i8** %_170
	%_172 = bitcast i8* %_171 to i32(i8*, i32)*
	%_174 = load %class.Tree*, %class.Tree** %root
	%_175 = bitcast %class.Tree* %_174 to i8*
	%_173 = call i32 %_172(i8* %_175, i32 12)
	call void @print_int(i32 %_173)
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
define i1 @Tree.Init(i8* %this_raw, i32 %.v_key) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%_178 = load i32, i32* %v_key
	%_179 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 1
	store i32 %_178, i32* %_179
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
	%.rn = bitcast i8* %rn_raw to %class.Tree*
	%rn = alloca %class.Tree*
	store %class.Tree* %.rn, %class.Tree** %rn
	%_184 = load %class.Tree*, %class.Tree** %rn
	%_185 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 3
	store i8* %_184, i8** %_185
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.SetLeft(i8* %this_raw, i8* %ln_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%.ln = bitcast i8* %ln_raw to %class.Tree*
	%ln = alloca %class.Tree*
	store %class.Tree* %.ln, %class.Tree** %ln
	%_186 = load %class.Tree*, %class.Tree** %ln
	%_187 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 5
	store i8* %_186, i8** %_187
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i8* @Tree.GetRight(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_188 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 3
	%_189 = load i8*, i8** %_188
	ret i8* %_189

end:
	call void @throw_oob()
	ret i8* zeroinitializer
}
define i8* @Tree.GetLeft(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_190 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 5
	%_191 = load i8*, i8** %_190
	ret i8* %_191

end:
	call void @throw_oob()
	ret i8* zeroinitializer
}
define i32 @Tree.GetKey(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_192 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 1
	%_193 = load i32, i32* %_192
	ret i32 %_193

end:
	call void @throw_oob()
	ret i32 1
}
define i1 @Tree.SetKey(i8* %this_raw, i32 %.v_key) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%_194 = load i32, i32* %v_key
	%_195 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 1
	store i32 %_194, i32* %_195
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.GetHas_Right(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_196 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 2
	%_197 = load i1, i1* %_196
	ret i1 %_197

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.GetHas_Left(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_198 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 4
	%_199 = load i1, i1* %_198
	ret i1 %_199

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.SetHas_Left(i8* %this_raw, i1 %.val) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%val = alloca i1
	store i1 %.val, i1* %val
	%_200 = load i1, i1* %val
	%_201 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 4
	store i1 %_200, i1* %_201
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.SetHas_Right(i8* %this_raw, i1 %.val) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%val = alloca i1
	store i1 %.val, i1* %val
	%_202 = load i1, i1* %val
	%_203 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 2
	store i1 %_202, i1* %_203
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.Compare(i8* %this_raw, i32 %.num1, i32 %.num2) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%num1 = alloca i32
	store i32 %.num1, i32* %num1
	%num2 = alloca i32
	store i32 %.num2, i32* %num2
	%ntb = alloca i1
	%nti = alloca i32
	store i1 false, i1* %ntb
	%_206 = load i32, i32* %num2
	%_207 = add i32 %_206, 1
	store i32 %_207, i32* %nti
	%_210 = load i32, i32* %num1
	%_211 = load i32, i32* %num2
	%_212 = icmp slt i32 %_210, %_211
	br i1 %_212, label %if0, label %if1

if0:
		store i1 false, i1* %ntb
		br label %if2

if1:
		%_215 = load i32, i32* %num1
		%_216 = load i32, i32* %nti
		%_217 = icmp slt i32 %_215, %_216
		%_218 = xor i1 %_217, true
		br i1 %_218, label %if3, label %if4

if3:
			store i1 false, i1* %ntb
			br label %if5

if4:
			store i1 true, i1* %ntb
			br label %if5

if5:
		br label %if2

if2:
	%_223 = load i1, i1* %ntb
	ret i1 %_223

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.Insert(i8* %this_raw, i32 %.v_key) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%new_node = alloca %class.Tree*
	store %class.Tree* null, %class.Tree** %new_node
	%ntb = alloca i1
	%cont = alloca i1
	%key_aux = alloca i32
	%current_node = alloca %class.Tree*
	store %class.Tree* null, %class.Tree** %current_node
	%_229 = getelementptr %class.Tree, %class.Tree* null, i32 1
	%_226 = ptrtoint %class.Tree* %_229 to i32
	%_227 = call i8* @calloc(i32 1, i32 %_226)
	%_228 = bitcast i8* %_227 to %class.Tree*
	store %class.Tree* %_228, %class.Tree** %new_node
	%_230 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 0
	%_231 = load i8*, i8** %_230
	%_232 = bitcast i8* %_231 to i1(i8*, i32)*
	%_234 = load %class.Tree*, %class.Tree** %new_node
	%_235 = bitcast %class.Tree* %_234 to i8*
	%_236 = load i32, i32* %v_key
	%_233 = call i1 %_232(i8* %_235, i32 %_236)
	store i1 %_233, i1* %ntb
	store %class.Tree* %this, %class.Tree** %current_node
	store i1 true, i1* %cont
	br label %loop0

loop0:
		%_242 = load i1, i1* %cont
		br i1 %_242, label %loop1, label %loop2

loop1:
		%_243 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
		%_244 = load i8*, i8** %_243
		%_245 = bitcast i8* %_244 to i32(i8*)*
		%_247 = load %class.Tree*, %class.Tree** %current_node
		%_248 = bitcast %class.Tree* %_247 to i8*
		%_246 = call i32 %_245(i8* %_248)
		store i32 %_246, i32* %key_aux
		%_251 = load i32, i32* %v_key
		%_252 = load i32, i32* %key_aux
		%_253 = icmp slt i32 %_251, %_252
		br i1 %_253, label %if6, label %if7

if6:
			%_254 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
			%_255 = load i8*, i8** %_254
			%_256 = bitcast i8* %_255 to i1(i8*)*
			%_258 = load %class.Tree*, %class.Tree** %current_node
			%_259 = bitcast %class.Tree* %_258 to i8*
			%_257 = call i1 %_256(i8* %_259)
			br i1 %_257, label %if9, label %if10

if9:
				%_260 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
				%_261 = load i8*, i8** %_260
				%_262 = bitcast i8* %_261 to i8*(i8*)*
				%_264 = load %class.Tree*, %class.Tree** %current_node
				%_265 = bitcast %class.Tree* %_264 to i8*
				%_263 = call i8* %_262(i8* %_265)
				%_266 = bitcast i8* %_263 to %class.Tree*
				store %class.Tree* %_266, %class.Tree** %current_node
				br label %if11

if10:
				store i1 false, i1* %cont
				%_271 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 9
				%_272 = load i8*, i8** %_271
				%_273 = bitcast i8* %_272 to i1(i8*, i1)*
				%_275 = load %class.Tree*, %class.Tree** %current_node
				%_276 = bitcast %class.Tree* %_275 to i8*
				%_274 = call i1 %_273(i8* %_276, i1 true)
				store i1 %_274, i1* %ntb
				%_280 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 2
				%_281 = load i8*, i8** %_280
				%_282 = bitcast i8* %_281 to i1(i8*, i8*)*
				%_284 = load %class.Tree*, %class.Tree** %current_node
				%_285 = bitcast %class.Tree* %_284 to i8*
				%_286 = load %class.Tree*, %class.Tree** %new_node
				%_283 = call i1 %_282(i8* %_285, i8* %_286)
				store i1 %_283, i1* %ntb
				br label %if11

if11:
			br label %if8

if7:
			%_289 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
			%_290 = load i8*, i8** %_289
			%_291 = bitcast i8* %_290 to i1(i8*)*
			%_293 = load %class.Tree*, %class.Tree** %current_node
			%_294 = bitcast %class.Tree* %_293 to i8*
			%_292 = call i1 %_291(i8* %_294)
			br i1 %_292, label %if12, label %if13

if12:
				%_295 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 3
				%_296 = load i8*, i8** %_295
				%_297 = bitcast i8* %_296 to i8*(i8*)*
				%_299 = load %class.Tree*, %class.Tree** %current_node
				%_300 = bitcast %class.Tree* %_299 to i8*
				%_298 = call i8* %_297(i8* %_300)
				%_301 = bitcast i8* %_298 to %class.Tree*
				store %class.Tree* %_301, %class.Tree** %current_node
				br label %if14

if13:
				store i1 false, i1* %cont
				%_306 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 10
				%_307 = load i8*, i8** %_306
				%_308 = bitcast i8* %_307 to i1(i8*, i1)*
				%_310 = load %class.Tree*, %class.Tree** %current_node
				%_311 = bitcast %class.Tree* %_310 to i8*
				%_309 = call i1 %_308(i8* %_311, i1 true)
				store i1 %_309, i1* %ntb
				%_315 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 1
				%_316 = load i8*, i8** %_315
				%_317 = bitcast i8* %_316 to i1(i8*, i8*)*
				%_319 = load %class.Tree*, %class.Tree** %current_node
				%_320 = bitcast %class.Tree* %_319 to i8*
				%_321 = load %class.Tree*, %class.Tree** %new_node
				%_318 = call i1 %_317(i8* %_320, i8* %_321)
				store i1 %_318, i1* %ntb
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
define i1 @Tree.Delete(i8* %this_raw, i32 %.v_key) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
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
		%_332 = load i1, i1* %cont
		br i1 %_332, label %loop4, label %loop5

loop4:
		%_333 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
		%_334 = load i8*, i8** %_333
		%_335 = bitcast i8* %_334 to i32(i8*)*
		%_337 = load %class.Tree*, %class.Tree** %current_node
		%_338 = bitcast %class.Tree* %_337 to i8*
		%_336 = call i32 %_335(i8* %_338)
		store i32 %_336, i32* %key_aux
		%_341 = load i32, i32* %v_key
		%_342 = load i32, i32* %key_aux
		%_343 = icmp slt i32 %_341, %_342
		br i1 %_343, label %if15, label %if16

if15:
			%_344 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
			%_345 = load i8*, i8** %_344
			%_346 = bitcast i8* %_345 to i1(i8*)*
			%_348 = load %class.Tree*, %class.Tree** %current_node
			%_349 = bitcast %class.Tree* %_348 to i8*
			%_347 = call i1 %_346(i8* %_349)
			br i1 %_347, label %if18, label %if19

if18:
				%_350 = load %class.Tree*, %class.Tree** %current_node
				store %class.Tree* %_350, %class.Tree** %parent_node
				%_352 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
				%_353 = load i8*, i8** %_352
				%_354 = bitcast i8* %_353 to i8*(i8*)*
				%_356 = load %class.Tree*, %class.Tree** %current_node
				%_357 = bitcast %class.Tree* %_356 to i8*
				%_355 = call i8* %_354(i8* %_357)
				%_358 = bitcast i8* %_355 to %class.Tree*
				store %class.Tree* %_358, %class.Tree** %current_node
				br label %if20

if19:
				store i1 false, i1* %cont
				br label %if20

if20:
			br label %if17

if16:
			%_363 = load i32, i32* %key_aux
			%_364 = load i32, i32* %v_key
			%_365 = icmp slt i32 %_363, %_364
			br i1 %_365, label %if21, label %if22

if21:
				%_366 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
				%_367 = load i8*, i8** %_366
				%_368 = bitcast i8* %_367 to i1(i8*)*
				%_370 = load %class.Tree*, %class.Tree** %current_node
				%_371 = bitcast %class.Tree* %_370 to i8*
				%_369 = call i1 %_368(i8* %_371)
				br i1 %_369, label %if24, label %if25

if24:
					%_372 = load %class.Tree*, %class.Tree** %current_node
					store %class.Tree* %_372, %class.Tree** %parent_node
					%_374 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 3
					%_375 = load i8*, i8** %_374
					%_376 = bitcast i8* %_375 to i8*(i8*)*
					%_378 = load %class.Tree*, %class.Tree** %current_node
					%_379 = bitcast %class.Tree* %_378 to i8*
					%_377 = call i8* %_376(i8* %_379)
					%_380 = bitcast i8* %_377 to %class.Tree*
					store %class.Tree* %_380, %class.Tree** %current_node
					br label %if26

if25:
					store i1 false, i1* %cont
					br label %if26

if26:
				br label %if23

if22:
				%_385 = load i1, i1* %is_root
				br i1 %_385, label %if27, label %if28

if27:
					%_386 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
					%_387 = load i8*, i8** %_386
					%_388 = bitcast i8* %_387 to i1(i8*)*
					%_390 = load %class.Tree*, %class.Tree** %current_node
					%_391 = bitcast %class.Tree* %_390 to i8*
					%_389 = call i1 %_388(i8* %_391)
					%_392 = xor i1 %_389, true
					br label %if30
if30:
					%_394 = icmp ne i1 %_392, 0
					br i1 %_394, label %if31, label %if32

if31:
					%_397 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
					%_398 = load i8*, i8** %_397
					%_399 = bitcast i8* %_398 to i1(i8*)*
					%_401 = load %class.Tree*, %class.Tree** %current_node
					%_402 = bitcast %class.Tree* %_401 to i8*
					%_400 = call i1 %_399(i8* %_402)
					%_403 = xor i1 %_400, true
					%_395 = icmp ne i1 %_403, 0
					br label %if32

if32:
					%_396 = phi i1 [false, %if30], [%_395, %if31]
					br i1 %_396, label %if33, label %if34

if33:
						store i1 true, i1* %ntb
						br label %if35

if34:
						%_407 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 14
						%_408 = load i8*, i8** %_407
						%_409 = bitcast i8* %_408 to i1(i8*, i8*, i8*)*
						%_411 = bitcast %class.Tree* %this to i8*
						%_412 = load %class.Tree*, %class.Tree** %parent_node
						%_413 = load %class.Tree*, %class.Tree** %current_node
						%_410 = call i1 %_409(i8* %_411, i8* %_412, i8* %_413)
						store i1 %_410, i1* %ntb
						br label %if35

if35:
					br label %if29

if28:
					%_416 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 14
					%_417 = load i8*, i8** %_416
					%_418 = bitcast i8* %_417 to i1(i8*, i8*, i8*)*
					%_420 = bitcast %class.Tree* %this to i8*
					%_421 = load %class.Tree*, %class.Tree** %parent_node
					%_422 = load %class.Tree*, %class.Tree** %current_node
					%_419 = call i1 %_418(i8* %_420, i8* %_421, i8* %_422)
					store i1 %_419, i1* %ntb
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
	%_431 = load i1, i1* %found
	ret i1 %_431

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.Remove(i8* %this_raw, i8* %p_node_raw, i8* %c_node_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%.c_node = bitcast i8* %c_node_raw to %class.Tree*
	%c_node = alloca %class.Tree*
	store %class.Tree* %.c_node, %class.Tree** %c_node
	%.p_node = bitcast i8* %p_node_raw to %class.Tree*
	%p_node = alloca %class.Tree*
	store %class.Tree* %.p_node, %class.Tree** %p_node
	%ntb = alloca i1
	%auxkey1 = alloca i32
	%auxkey2 = alloca i32
	%_432 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
	%_433 = load i8*, i8** %_432
	%_434 = bitcast i8* %_433 to i1(i8*)*
	%_436 = load %class.Tree*, %class.Tree** %c_node
	%_437 = bitcast %class.Tree* %_436 to i8*
	%_435 = call i1 %_434(i8* %_437)
	br i1 %_435, label %if36, label %if37

if36:
		%_438 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 16
		%_439 = load i8*, i8** %_438
		%_440 = bitcast i8* %_439 to i1(i8*, i8*, i8*)*
		%_442 = bitcast %class.Tree* %this to i8*
		%_443 = load %class.Tree*, %class.Tree** %p_node
		%_444 = load %class.Tree*, %class.Tree** %c_node
		%_441 = call i1 %_440(i8* %_442, i8* %_443, i8* %_444)
		store i1 %_441, i1* %ntb
		br label %if38

if37:
		%_447 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
		%_448 = load i8*, i8** %_447
		%_449 = bitcast i8* %_448 to i1(i8*)*
		%_451 = load %class.Tree*, %class.Tree** %c_node
		%_452 = bitcast %class.Tree* %_451 to i8*
		%_450 = call i1 %_449(i8* %_452)
		br i1 %_450, label %if39, label %if40

if39:
			%_453 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 15
			%_454 = load i8*, i8** %_453
			%_455 = bitcast i8* %_454 to i1(i8*, i8*, i8*)*
			%_457 = bitcast %class.Tree* %this to i8*
			%_458 = load %class.Tree*, %class.Tree** %p_node
			%_459 = load %class.Tree*, %class.Tree** %c_node
			%_456 = call i1 %_455(i8* %_457, i8* %_458, i8* %_459)
			store i1 %_456, i1* %ntb
			br label %if41

if40:
			%_462 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
			%_463 = load i8*, i8** %_462
			%_464 = bitcast i8* %_463 to i32(i8*)*
			%_466 = load %class.Tree*, %class.Tree** %c_node
			%_467 = bitcast %class.Tree* %_466 to i8*
			%_465 = call i32 %_464(i8* %_467)
			store i32 %_465, i32* %auxkey1
			%_470 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
			%_471 = load i8*, i8** %_470
			%_472 = bitcast i8* %_471 to i8*(i8*)*
			%_474 = load %class.Tree*, %class.Tree** %p_node
			%_475 = bitcast %class.Tree* %_474 to i8*
			%_473 = call i8* %_472(i8* %_475)
			%_476 = bitcast i8* %_473 to %class.Tree*
			%_477 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
			%_478 = load i8*, i8** %_477
			%_479 = bitcast i8* %_478 to i32(i8*)*
			%_481 = bitcast %class.Tree* %_476 to i8*
			%_480 = call i32 %_479(i8* %_481)
			store i32 %_480, i32* %auxkey2
			%_484 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 11
			%_485 = load i8*, i8** %_484
			%_486 = bitcast i8* %_485 to i1(i8*, i32, i32)*
			%_488 = bitcast %class.Tree* %this to i8*
			%_489 = load i32, i32* %auxkey1
			%_490 = load i32, i32* %auxkey2
			%_487 = call i1 %_486(i8* %_488, i32 %_489, i32 %_490)
			br i1 %_487, label %if42, label %if43

if42:
				%_491 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 2
				%_492 = load i8*, i8** %_491
				%_493 = bitcast i8* %_492 to i1(i8*, i8*)*
				%_495 = load %class.Tree*, %class.Tree** %p_node
				%_496 = bitcast %class.Tree* %_495 to i8*
				%_497 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 0
				%_498 = load i8*, i8** %_497
				%_494 = call i1 %_493(i8* %_496, i8* %_498)
				store i1 %_494, i1* %ntb
				%_501 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 9
				%_502 = load i8*, i8** %_501
				%_503 = bitcast i8* %_502 to i1(i8*, i1)*
				%_505 = load %class.Tree*, %class.Tree** %p_node
				%_506 = bitcast %class.Tree* %_505 to i8*
				%_504 = call i1 %_503(i8* %_506, i1 false)
				store i1 %_504, i1* %ntb
				br label %if44

if43:
				%_510 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 1
				%_511 = load i8*, i8** %_510
				%_512 = bitcast i8* %_511 to i1(i8*, i8*)*
				%_514 = load %class.Tree*, %class.Tree** %p_node
				%_515 = bitcast %class.Tree* %_514 to i8*
				%_516 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 0
				%_517 = load i8*, i8** %_516
				%_513 = call i1 %_512(i8* %_515, i8* %_517)
				store i1 %_513, i1* %ntb
				%_520 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 10
				%_521 = load i8*, i8** %_520
				%_522 = bitcast i8* %_521 to i1(i8*, i1)*
				%_524 = load %class.Tree*, %class.Tree** %p_node
				%_525 = bitcast %class.Tree* %_524 to i8*
				%_523 = call i1 %_522(i8* %_525, i1 false)
				store i1 %_523, i1* %ntb
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
	%.c_node = bitcast i8* %c_node_raw to %class.Tree*
	%c_node = alloca %class.Tree*
	store %class.Tree* %.c_node, %class.Tree** %c_node
	%.p_node = bitcast i8* %p_node_raw to %class.Tree*
	%p_node = alloca %class.Tree*
	store %class.Tree* %.p_node, %class.Tree** %p_node
	%ntb = alloca i1
	br label %loop6

loop6:
		%_529 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
		%_530 = load i8*, i8** %_529
		%_531 = bitcast i8* %_530 to i1(i8*)*
		%_533 = load %class.Tree*, %class.Tree** %c_node
		%_534 = bitcast %class.Tree* %_533 to i8*
		%_532 = call i1 %_531(i8* %_534)
		br i1 %_532, label %loop7, label %loop8

loop7:
		%_535 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 6
		%_536 = load i8*, i8** %_535
		%_537 = bitcast i8* %_536 to i1(i8*, i32)*
		%_539 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 3
		%_540 = load i8*, i8** %_539
		%_541 = bitcast i8* %_540 to i8*(i8*)*
		%_543 = load %class.Tree*, %class.Tree** %c_node
		%_544 = bitcast %class.Tree* %_543 to i8*
		%_542 = call i8* %_541(i8* %_544)
		%_545 = bitcast i8* %_542 to %class.Tree*
		%_546 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
		%_547 = load i8*, i8** %_546
		%_548 = bitcast i8* %_547 to i32(i8*)*
		%_550 = bitcast %class.Tree* %_545 to i8*
		%_549 = call i32 %_548(i8* %_550)
		%_551 = load %class.Tree*, %class.Tree** %c_node
		%_552 = bitcast %class.Tree* %_551 to i8*
		%_538 = call i1 %_537(i8* %_552, i32 %_549)
		store i1 %_538, i1* %ntb
		%_556 = load %class.Tree*, %class.Tree** %c_node
		store %class.Tree* %_556, %class.Tree** %p_node
		%_558 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 3
		%_559 = load i8*, i8** %_558
		%_560 = bitcast i8* %_559 to i8*(i8*)*
		%_562 = load %class.Tree*, %class.Tree** %c_node
		%_563 = bitcast %class.Tree* %_562 to i8*
		%_561 = call i8* %_560(i8* %_563)
		%_564 = bitcast i8* %_561 to %class.Tree*
		store %class.Tree* %_564, %class.Tree** %c_node
		br label %loop6

loop8:
	%_567 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 1
	%_568 = load i8*, i8** %_567
	%_569 = bitcast i8* %_568 to i1(i8*, i8*)*
	%_571 = load %class.Tree*, %class.Tree** %p_node
	%_572 = bitcast %class.Tree* %_571 to i8*
	%_573 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 0
	%_574 = load i8*, i8** %_573
	%_570 = call i1 %_569(i8* %_572, i8* %_574)
	store i1 %_570, i1* %ntb
	%_577 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 10
	%_578 = load i8*, i8** %_577
	%_579 = bitcast i8* %_578 to i1(i8*, i1)*
	%_581 = load %class.Tree*, %class.Tree** %p_node
	%_582 = bitcast %class.Tree* %_581 to i8*
	%_580 = call i1 %_579(i8* %_582, i1 false)
	store i1 %_580, i1* %ntb
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.RemoveLeft(i8* %this_raw, i8* %p_node_raw, i8* %c_node_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%.c_node = bitcast i8* %c_node_raw to %class.Tree*
	%c_node = alloca %class.Tree*
	store %class.Tree* %.c_node, %class.Tree** %c_node
	%.p_node = bitcast i8* %p_node_raw to %class.Tree*
	%p_node = alloca %class.Tree*
	store %class.Tree* %.p_node, %class.Tree** %p_node
	%ntb = alloca i1
	br label %loop9

loop9:
		%_586 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
		%_587 = load i8*, i8** %_586
		%_588 = bitcast i8* %_587 to i1(i8*)*
		%_590 = load %class.Tree*, %class.Tree** %c_node
		%_591 = bitcast %class.Tree* %_590 to i8*
		%_589 = call i1 %_588(i8* %_591)
		br i1 %_589, label %loop10, label %loop11

loop10:
		%_592 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 6
		%_593 = load i8*, i8** %_592
		%_594 = bitcast i8* %_593 to i1(i8*, i32)*
		%_596 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
		%_597 = load i8*, i8** %_596
		%_598 = bitcast i8* %_597 to i8*(i8*)*
		%_600 = load %class.Tree*, %class.Tree** %c_node
		%_601 = bitcast %class.Tree* %_600 to i8*
		%_599 = call i8* %_598(i8* %_601)
		%_602 = bitcast i8* %_599 to %class.Tree*
		%_603 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
		%_604 = load i8*, i8** %_603
		%_605 = bitcast i8* %_604 to i32(i8*)*
		%_607 = bitcast %class.Tree* %_602 to i8*
		%_606 = call i32 %_605(i8* %_607)
		%_608 = load %class.Tree*, %class.Tree** %c_node
		%_609 = bitcast %class.Tree* %_608 to i8*
		%_595 = call i1 %_594(i8* %_609, i32 %_606)
		store i1 %_595, i1* %ntb
		%_613 = load %class.Tree*, %class.Tree** %c_node
		store %class.Tree* %_613, %class.Tree** %p_node
		%_615 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
		%_616 = load i8*, i8** %_615
		%_617 = bitcast i8* %_616 to i8*(i8*)*
		%_619 = load %class.Tree*, %class.Tree** %c_node
		%_620 = bitcast %class.Tree* %_619 to i8*
		%_618 = call i8* %_617(i8* %_620)
		%_621 = bitcast i8* %_618 to %class.Tree*
		store %class.Tree* %_621, %class.Tree** %c_node
		br label %loop9

loop11:
	%_624 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 2
	%_625 = load i8*, i8** %_624
	%_626 = bitcast i8* %_625 to i1(i8*, i8*)*
	%_628 = load %class.Tree*, %class.Tree** %p_node
	%_629 = bitcast %class.Tree* %_628 to i8*
	%_630 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 0
	%_631 = load i8*, i8** %_630
	%_627 = call i1 %_626(i8* %_629, i8* %_631)
	store i1 %_627, i1* %ntb
	%_634 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 9
	%_635 = load i8*, i8** %_634
	%_636 = bitcast i8* %_635 to i1(i8*, i1)*
	%_638 = load %class.Tree*, %class.Tree** %p_node
	%_639 = bitcast %class.Tree* %_638 to i8*
	%_637 = call i1 %_636(i8* %_639, i1 false)
	store i1 %_637, i1* %ntb
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i32 @Tree.Search(i8* %this_raw, i32 %.v_key) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
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
		%_648 = load i1, i1* %cont
		br i1 %_648, label %loop13, label %loop14

loop13:
		%_649 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
		%_650 = load i8*, i8** %_649
		%_651 = bitcast i8* %_650 to i32(i8*)*
		%_653 = load %class.Tree*, %class.Tree** %current_node
		%_654 = bitcast %class.Tree* %_653 to i8*
		%_652 = call i32 %_651(i8* %_654)
		store i32 %_652, i32* %key_aux
		%_657 = load i32, i32* %v_key
		%_658 = load i32, i32* %key_aux
		%_659 = icmp slt i32 %_657, %_658
		br i1 %_659, label %if45, label %if46

if45:
			%_660 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
			%_661 = load i8*, i8** %_660
			%_662 = bitcast i8* %_661 to i1(i8*)*
			%_664 = load %class.Tree*, %class.Tree** %current_node
			%_665 = bitcast %class.Tree* %_664 to i8*
			%_663 = call i1 %_662(i8* %_665)
			br i1 %_663, label %if48, label %if49

if48:
				%_666 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
				%_667 = load i8*, i8** %_666
				%_668 = bitcast i8* %_667 to i8*(i8*)*
				%_670 = load %class.Tree*, %class.Tree** %current_node
				%_671 = bitcast %class.Tree* %_670 to i8*
				%_669 = call i8* %_668(i8* %_671)
				%_672 = bitcast i8* %_669 to %class.Tree*
				store %class.Tree* %_672, %class.Tree** %current_node
				br label %if50

if49:
				store i1 false, i1* %cont
				br label %if50

if50:
			br label %if47

if46:
			%_677 = load i32, i32* %key_aux
			%_678 = load i32, i32* %v_key
			%_679 = icmp slt i32 %_677, %_678
			br i1 %_679, label %if51, label %if52

if51:
				%_680 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
				%_681 = load i8*, i8** %_680
				%_682 = bitcast i8* %_681 to i1(i8*)*
				%_684 = load %class.Tree*, %class.Tree** %current_node
				%_685 = bitcast %class.Tree* %_684 to i8*
				%_683 = call i1 %_682(i8* %_685)
				br i1 %_683, label %if54, label %if55

if54:
					%_686 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 3
					%_687 = load i8*, i8** %_686
					%_688 = bitcast i8* %_687 to i8*(i8*)*
					%_690 = load %class.Tree*, %class.Tree** %current_node
					%_691 = bitcast %class.Tree* %_690 to i8*
					%_689 = call i8* %_688(i8* %_691)
					%_692 = bitcast i8* %_689 to %class.Tree*
					store %class.Tree* %_692, %class.Tree** %current_node
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
	%_701 = load i32, i32* %ifound
	ret i32 %_701

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
	%_703 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 19
	%_704 = load i8*, i8** %_703
	%_705 = bitcast i8* %_704 to i1(i8*, i8*)*
	%_707 = bitcast %class.Tree* %this to i8*
	%_708 = load %class.Tree*, %class.Tree** %current_node
	%_706 = call i1 %_705(i8* %_707, i8* %_708)
	store i1 %_706, i1* %ntb
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.RecPrint(i8* %this_raw, i8* %node_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%.node = bitcast i8* %node_raw to %class.Tree*
	%node = alloca %class.Tree*
	store %class.Tree* %.node, %class.Tree** %node
	%ntb = alloca i1
	%_711 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
	%_712 = load i8*, i8** %_711
	%_713 = bitcast i8* %_712 to i1(i8*)*
	%_715 = load %class.Tree*, %class.Tree** %node
	%_716 = bitcast %class.Tree* %_715 to i8*
	%_714 = call i1 %_713(i8* %_716)
	br i1 %_714, label %if57, label %if58

if57:
		%_717 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 19
		%_718 = load i8*, i8** %_717
		%_719 = bitcast i8* %_718 to i1(i8*, i8*)*
		%_721 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
		%_722 = load i8*, i8** %_721
		%_723 = bitcast i8* %_722 to i8*(i8*)*
		%_725 = load %class.Tree*, %class.Tree** %node
		%_726 = bitcast %class.Tree* %_725 to i8*
		%_724 = call i8* %_723(i8* %_726)
		%_727 = bitcast i8* %_724 to %class.Tree*
		%_728 = bitcast %class.Tree* %this to i8*
		%_720 = call i1 %_719(i8* %_728, i8* %_727)
		store i1 %_720, i1* %ntb
		br label %if59

if58:
		store i1 true, i1* %ntb
		br label %if59

if59:
	%_734 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
	%_735 = load i8*, i8** %_734
	%_736 = bitcast i8* %_735 to i32(i8*)*
	%_738 = load %class.Tree*, %class.Tree** %node
	%_739 = bitcast %class.Tree* %_738 to i8*
	%_737 = call i32 %_736(i8* %_739)
	call void @print_int(i32 %_737)
	%_741 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
	%_742 = load i8*, i8** %_741
	%_743 = bitcast i8* %_742 to i1(i8*)*
	%_745 = load %class.Tree*, %class.Tree** %node
	%_746 = bitcast %class.Tree* %_745 to i8*
	%_744 = call i1 %_743(i8* %_746)
	br i1 %_744, label %if60, label %if61

if60:
		%_747 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 19
		%_748 = load i8*, i8** %_747
		%_749 = bitcast i8* %_748 to i1(i8*, i8*)*
		%_751 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 3
		%_752 = load i8*, i8** %_751
		%_753 = bitcast i8* %_752 to i8*(i8*)*
		%_755 = load %class.Tree*, %class.Tree** %node
		%_756 = bitcast %class.Tree* %_755 to i8*
		%_754 = call i8* %_753(i8* %_756)
		%_757 = bitcast i8* %_754 to %class.Tree*
		%_758 = bitcast %class.Tree* %this to i8*
		%_750 = call i1 %_749(i8* %_758, i8* %_757)
		store i1 %_750, i1* %ntb
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
