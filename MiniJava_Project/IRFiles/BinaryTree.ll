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
define i1 @Tree.Init(i8* %this_raw, i32 %v_key) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_178 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 1
	store i32 %v_key, i32* %_178
	%_180 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 4
	store i1 false, i1* %_180
	%_182 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 2
	store i1 false, i1* %_182
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.SetRight(i8* %this_raw, i8* %rn_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%rn = bitcast i8* %rn_raw to %class.Tree*
	%_183 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 3
	store i8* %rn, i8** %_183
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.SetLeft(i8* %this_raw, i8* %ln_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%ln = bitcast i8* %ln_raw to %class.Tree*
	%_184 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 5
	store i8* %ln, i8** %_184
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i8* @Tree.GetRight(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_185 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 3
	%_186 = load i8*, i8** %_185
	ret i8* %_186

end:
	call void @throw_oob()
	ret i8* zeroinitializer
}
define i8* @Tree.GetLeft(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_187 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 5
	%_188 = load i8*, i8** %_187
	ret i8* %_188

end:
	call void @throw_oob()
	ret i8* zeroinitializer
}
define i32 @Tree.GetKey(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_189 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 1
	%_190 = load i32, i32* %_189
	ret i32 %_190

end:
	call void @throw_oob()
	ret i32 1
}
define i1 @Tree.SetKey(i8* %this_raw, i32 %v_key) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_191 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 1
	store i32 %v_key, i32* %_191
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.GetHas_Right(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_192 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 2
	%_193 = load i1, i1* %_192
	ret i1 %_193

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.GetHas_Left(i8* %this_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_194 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 4
	%_195 = load i1, i1* %_194
	ret i1 %_195

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.SetHas_Left(i8* %this_raw, i1 %val) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_196 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 4
	store i1 %val, i1* %_196
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.SetHas_Right(i8* %this_raw, i1 %val) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%_197 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 2
	store i1 %val, i1* %_197
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
	%_201 = add i32 %num2, 1
	store i32 %_201, i32* %nti
	%_206 = icmp slt i32 %num1, %num2
	br i1 %_206, label %if0, label %if1

if0:
		store i1 false, i1* %ntb
		br label %if2

if1:
		%_210 = load i32, i32* %nti
		%_211 = icmp slt i32 %num1, %_210
		%_212 = xor i1 %_211, true
		br i1 %_212, label %if3, label %if4

if3:
			store i1 false, i1* %ntb
			br label %if5

if4:
			store i1 true, i1* %ntb
			br label %if5

if5:
		br label %if2

if2:
	%_217 = load i1, i1* %ntb
	ret i1 %_217

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
	%_223 = getelementptr %class.Tree, %class.Tree* null, i32 1
	%_220 = ptrtoint %class.Tree* %_223 to i32
	%_221 = call i8* @calloc(i32 1, i32 %_220)
	%_222 = bitcast i8* %_221 to %class.Tree*
	store %class.Tree* %_222, %class.Tree** %new_node
	%_224 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 0
	%_225 = load i8*, i8** %_224
	%_226 = bitcast i8* %_225 to i1(i8*, i32)*
	%_228 = load %class.Tree*, %class.Tree** %new_node
	%_229 = bitcast %class.Tree* %_228 to i8*
	%_227 = call i1 %_226(i8* %_229, i32 %v_key)
	store i1 %_227, i1* %ntb
	store %class.Tree* %this, %class.Tree** %current_node
	store i1 true, i1* %cont
	br label %loop0

loop0:
		%_235 = load i1, i1* %cont
		br i1 %_235, label %loop1, label %loop2

loop1:
		%_236 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
		%_237 = load i8*, i8** %_236
		%_238 = bitcast i8* %_237 to i32(i8*)*
		%_240 = load %class.Tree*, %class.Tree** %current_node
		%_241 = bitcast %class.Tree* %_240 to i8*
		%_239 = call i32 %_238(i8* %_241)
		store i32 %_239, i32* %key_aux
		%_245 = load i32, i32* %key_aux
		%_246 = icmp slt i32 %v_key, %_245
		br i1 %_246, label %if6, label %if7

if6:
			%_247 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
			%_248 = load i8*, i8** %_247
			%_249 = bitcast i8* %_248 to i1(i8*)*
			%_251 = load %class.Tree*, %class.Tree** %current_node
			%_252 = bitcast %class.Tree* %_251 to i8*
			%_250 = call i1 %_249(i8* %_252)
			br i1 %_250, label %if9, label %if10

if9:
				%_253 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
				%_254 = load i8*, i8** %_253
				%_255 = bitcast i8* %_254 to i8*(i8*)*
				%_257 = load %class.Tree*, %class.Tree** %current_node
				%_258 = bitcast %class.Tree* %_257 to i8*
				%_256 = call i8* %_255(i8* %_258)
				%_259 = bitcast i8* %_256 to %class.Tree*
				store %class.Tree* %_259, %class.Tree** %current_node
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
				%_280 = bitcast %class.Tree* %_279 to i8*
				%_276 = call i1 %_275(i8* %_278, i8* %_280)
				store i1 %_276, i1* %ntb
				br label %if11

if11:
			br label %if8

if7:
			%_283 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
			%_284 = load i8*, i8** %_283
			%_285 = bitcast i8* %_284 to i1(i8*)*
			%_287 = load %class.Tree*, %class.Tree** %current_node
			%_288 = bitcast %class.Tree* %_287 to i8*
			%_286 = call i1 %_285(i8* %_288)
			br i1 %_286, label %if12, label %if13

if12:
				%_289 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 3
				%_290 = load i8*, i8** %_289
				%_291 = bitcast i8* %_290 to i8*(i8*)*
				%_293 = load %class.Tree*, %class.Tree** %current_node
				%_294 = bitcast %class.Tree* %_293 to i8*
				%_292 = call i8* %_291(i8* %_294)
				%_295 = bitcast i8* %_292 to %class.Tree*
				store %class.Tree* %_295, %class.Tree** %current_node
				br label %if14

if13:
				store i1 false, i1* %cont
				%_300 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 10
				%_301 = load i8*, i8** %_300
				%_302 = bitcast i8* %_301 to i1(i8*, i1)*
				%_304 = load %class.Tree*, %class.Tree** %current_node
				%_305 = bitcast %class.Tree* %_304 to i8*
				%_303 = call i1 %_302(i8* %_305, i1 true)
				store i1 %_303, i1* %ntb
				%_309 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 1
				%_310 = load i8*, i8** %_309
				%_311 = bitcast i8* %_310 to i1(i8*, i8*)*
				%_313 = load %class.Tree*, %class.Tree** %current_node
				%_314 = bitcast %class.Tree* %_313 to i8*
				%_315 = load %class.Tree*, %class.Tree** %new_node
				%_316 = bitcast %class.Tree* %_315 to i8*
				%_312 = call i1 %_311(i8* %_314, i8* %_316)
				store i1 %_312, i1* %ntb
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
		%_327 = load i1, i1* %cont
		br i1 %_327, label %loop4, label %loop5

loop4:
		%_328 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
		%_329 = load i8*, i8** %_328
		%_330 = bitcast i8* %_329 to i32(i8*)*
		%_332 = load %class.Tree*, %class.Tree** %current_node
		%_333 = bitcast %class.Tree* %_332 to i8*
		%_331 = call i32 %_330(i8* %_333)
		store i32 %_331, i32* %key_aux
		%_337 = load i32, i32* %key_aux
		%_338 = icmp slt i32 %v_key, %_337
		br i1 %_338, label %if15, label %if16

if15:
			%_339 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
			%_340 = load i8*, i8** %_339
			%_341 = bitcast i8* %_340 to i1(i8*)*
			%_343 = load %class.Tree*, %class.Tree** %current_node
			%_344 = bitcast %class.Tree* %_343 to i8*
			%_342 = call i1 %_341(i8* %_344)
			br i1 %_342, label %if18, label %if19

if18:
				%_345 = load %class.Tree*, %class.Tree** %current_node
				store %class.Tree* %_345, %class.Tree** %parent_node
				%_347 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
				%_348 = load i8*, i8** %_347
				%_349 = bitcast i8* %_348 to i8*(i8*)*
				%_351 = load %class.Tree*, %class.Tree** %current_node
				%_352 = bitcast %class.Tree* %_351 to i8*
				%_350 = call i8* %_349(i8* %_352)
				%_353 = bitcast i8* %_350 to %class.Tree*
				store %class.Tree* %_353, %class.Tree** %current_node
				br label %if20

if19:
				store i1 false, i1* %cont
				br label %if20

if20:
			br label %if17

if16:
			%_358 = load i32, i32* %key_aux
			%_360 = icmp slt i32 %_358, %v_key
			br i1 %_360, label %if21, label %if22

if21:
				%_361 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
				%_362 = load i8*, i8** %_361
				%_363 = bitcast i8* %_362 to i1(i8*)*
				%_365 = load %class.Tree*, %class.Tree** %current_node
				%_366 = bitcast %class.Tree* %_365 to i8*
				%_364 = call i1 %_363(i8* %_366)
				br i1 %_364, label %if24, label %if25

if24:
					%_367 = load %class.Tree*, %class.Tree** %current_node
					store %class.Tree* %_367, %class.Tree** %parent_node
					%_369 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 3
					%_370 = load i8*, i8** %_369
					%_371 = bitcast i8* %_370 to i8*(i8*)*
					%_373 = load %class.Tree*, %class.Tree** %current_node
					%_374 = bitcast %class.Tree* %_373 to i8*
					%_372 = call i8* %_371(i8* %_374)
					%_375 = bitcast i8* %_372 to %class.Tree*
					store %class.Tree* %_375, %class.Tree** %current_node
					br label %if26

if25:
					store i1 false, i1* %cont
					br label %if26

if26:
				br label %if23

if22:
				%_380 = load i1, i1* %is_root
				br i1 %_380, label %if27, label %if28

if27:
					%_381 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
					%_382 = load i8*, i8** %_381
					%_383 = bitcast i8* %_382 to i1(i8*)*
					%_385 = load %class.Tree*, %class.Tree** %current_node
					%_386 = bitcast %class.Tree* %_385 to i8*
					%_384 = call i1 %_383(i8* %_386)
					%_387 = xor i1 %_384, true
					br label %if30
if30:
					%_389 = icmp ne i1 %_387, 0
					br i1 %_389, label %if31, label %if32

if31:
					%_392 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
					%_393 = load i8*, i8** %_392
					%_394 = bitcast i8* %_393 to i1(i8*)*
					%_396 = load %class.Tree*, %class.Tree** %current_node
					%_397 = bitcast %class.Tree* %_396 to i8*
					%_395 = call i1 %_394(i8* %_397)
					%_398 = xor i1 %_395, true
					%_390 = icmp ne i1 %_398, 0
					br label %if32

if32:
					%_391 = phi i1 [false, %if30], [%_390, %if31]
					br i1 %_391, label %if33, label %if34

if33:
						store i1 true, i1* %ntb
						br label %if35

if34:
						%_402 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 14
						%_403 = load i8*, i8** %_402
						%_404 = bitcast i8* %_403 to i1(i8*, i8*, i8*)*
						%_406 = bitcast %class.Tree* %this to i8*
						%_407 = load %class.Tree*, %class.Tree** %parent_node
						%_408 = bitcast %class.Tree* %_407 to i8*
						%_409 = load %class.Tree*, %class.Tree** %current_node
						%_410 = bitcast %class.Tree* %_409 to i8*
						%_405 = call i1 %_404(i8* %_406, i8* %_408, i8* %_410)
						store i1 %_405, i1* %ntb
						br label %if35

if35:
					br label %if29

if28:
					%_413 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 14
					%_414 = load i8*, i8** %_413
					%_415 = bitcast i8* %_414 to i1(i8*, i8*, i8*)*
					%_417 = bitcast %class.Tree* %this to i8*
					%_418 = load %class.Tree*, %class.Tree** %parent_node
					%_419 = bitcast %class.Tree* %_418 to i8*
					%_420 = load %class.Tree*, %class.Tree** %current_node
					%_421 = bitcast %class.Tree* %_420 to i8*
					%_416 = call i1 %_415(i8* %_417, i8* %_419, i8* %_421)
					store i1 %_416, i1* %ntb
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
	%_430 = load i1, i1* %found
	ret i1 %_430

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
	%_431 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
	%_432 = load i8*, i8** %_431
	%_433 = bitcast i8* %_432 to i1(i8*)*
	%_435 = bitcast %class.Tree* %c_node to i8*
	%_434 = call i1 %_433(i8* %_435)
	br i1 %_434, label %if36, label %if37

if36:
		%_436 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 16
		%_437 = load i8*, i8** %_436
		%_438 = bitcast i8* %_437 to i1(i8*, i8*, i8*)*
		%_440 = bitcast %class.Tree* %this to i8*
		%_441 = bitcast %class.Tree* %p_node to i8*
		%_442 = bitcast %class.Tree* %c_node to i8*
		%_439 = call i1 %_438(i8* %_440, i8* %_441, i8* %_442)
		store i1 %_439, i1* %ntb
		br label %if38

if37:
		%_445 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
		%_446 = load i8*, i8** %_445
		%_447 = bitcast i8* %_446 to i1(i8*)*
		%_449 = bitcast %class.Tree* %c_node to i8*
		%_448 = call i1 %_447(i8* %_449)
		br i1 %_448, label %if39, label %if40

if39:
			%_450 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 15
			%_451 = load i8*, i8** %_450
			%_452 = bitcast i8* %_451 to i1(i8*, i8*, i8*)*
			%_454 = bitcast %class.Tree* %this to i8*
			%_455 = bitcast %class.Tree* %p_node to i8*
			%_456 = bitcast %class.Tree* %c_node to i8*
			%_453 = call i1 %_452(i8* %_454, i8* %_455, i8* %_456)
			store i1 %_453, i1* %ntb
			br label %if41

if40:
			%_459 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
			%_460 = load i8*, i8** %_459
			%_461 = bitcast i8* %_460 to i32(i8*)*
			%_463 = bitcast %class.Tree* %c_node to i8*
			%_462 = call i32 %_461(i8* %_463)
			store i32 %_462, i32* %auxkey1
			%_466 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
			%_467 = load i8*, i8** %_466
			%_468 = bitcast i8* %_467 to i8*(i8*)*
			%_470 = bitcast %class.Tree* %p_node to i8*
			%_469 = call i8* %_468(i8* %_470)
			%_471 = bitcast i8* %_469 to %class.Tree*
			%_472 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
			%_473 = load i8*, i8** %_472
			%_474 = bitcast i8* %_473 to i32(i8*)*
			%_475 = call i32 %_474(i8* %_471)
			store i32 %_475, i32* %auxkey2
			%_478 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 11
			%_479 = load i8*, i8** %_478
			%_480 = bitcast i8* %_479 to i1(i8*, i32, i32)*
			%_482 = bitcast %class.Tree* %this to i8*
			%_483 = load i32, i32* %auxkey1
			%_484 = load i32, i32* %auxkey2
			%_481 = call i1 %_480(i8* %_482, i32 %_483, i32 %_484)
			br i1 %_481, label %if42, label %if43

if42:
				%_485 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 2
				%_486 = load i8*, i8** %_485
				%_487 = bitcast i8* %_486 to i1(i8*, i8*)*
				%_489 = bitcast %class.Tree* %p_node to i8*
				%_490 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 0
				%_491 = load i8*, i8** %_490
				%_492 = bitcast %class.Tree* %_491 to i8*
				%_488 = call i1 %_487(i8* %_489, i8* %_492)
				store i1 %_488, i1* %ntb
				%_495 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 9
				%_496 = load i8*, i8** %_495
				%_497 = bitcast i8* %_496 to i1(i8*, i1)*
				%_499 = bitcast %class.Tree* %p_node to i8*
				%_498 = call i1 %_497(i8* %_499, i1 false)
				store i1 %_498, i1* %ntb
				br label %if44

if43:
				%_503 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 1
				%_504 = load i8*, i8** %_503
				%_505 = bitcast i8* %_504 to i1(i8*, i8*)*
				%_507 = bitcast %class.Tree* %p_node to i8*
				%_508 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 0
				%_509 = load i8*, i8** %_508
				%_510 = bitcast %class.Tree* %_509 to i8*
				%_506 = call i1 %_505(i8* %_507, i8* %_510)
				store i1 %_506, i1* %ntb
				%_513 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 10
				%_514 = load i8*, i8** %_513
				%_515 = bitcast i8* %_514 to i1(i8*, i1)*
				%_517 = bitcast %class.Tree* %p_node to i8*
				%_516 = call i1 %_515(i8* %_517, i1 false)
				store i1 %_516, i1* %ntb
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
		%_521 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
		%_522 = load i8*, i8** %_521
		%_523 = bitcast i8* %_522 to i1(i8*)*
		%_525 = bitcast %class.Tree* %c_node to i8*
		%_524 = call i1 %_523(i8* %_525)
		br i1 %_524, label %loop7, label %loop8

loop7:
		%_526 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 6
		%_527 = load i8*, i8** %_526
		%_528 = bitcast i8* %_527 to i1(i8*, i32)*
		%_530 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 3
		%_531 = load i8*, i8** %_530
		%_532 = bitcast i8* %_531 to i8*(i8*)*
		%_534 = bitcast %class.Tree* %c_node to i8*
		%_533 = call i8* %_532(i8* %_534)
		%_535 = bitcast i8* %_533 to %class.Tree*
		%_536 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
		%_537 = load i8*, i8** %_536
		%_538 = bitcast i8* %_537 to i32(i8*)*
		%_539 = call i32 %_538(i8* %_535)
		%_540 = bitcast %class.Tree* %c_node to i8*
		%_529 = call i1 %_528(i8* %_540, i32 %_539)
		store i1 %_529, i1* %ntb
		store %class.Tree* %c_node, %class.Tree** %p_node
		%_545 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 3
		%_546 = load i8*, i8** %_545
		%_547 = bitcast i8* %_546 to i8*(i8*)*
		%_549 = bitcast %class.Tree* %c_node to i8*
		%_548 = call i8* %_547(i8* %_549)
		%_550 = bitcast i8* %_548 to %class.Tree*
		store %class.Tree* %_550, %class.Tree** %c_node
		br label %loop6

loop8:
	%_553 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 1
	%_554 = load i8*, i8** %_553
	%_555 = bitcast i8* %_554 to i1(i8*, i8*)*
	%_557 = bitcast %class.Tree* %p_node to i8*
	%_558 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 0
	%_559 = load i8*, i8** %_558
	%_560 = bitcast %class.Tree* %_559 to i8*
	%_556 = call i1 %_555(i8* %_557, i8* %_560)
	store i1 %_556, i1* %ntb
	%_563 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 10
	%_564 = load i8*, i8** %_563
	%_565 = bitcast i8* %_564 to i1(i8*, i1)*
	%_567 = bitcast %class.Tree* %p_node to i8*
	%_566 = call i1 %_565(i8* %_567, i1 false)
	store i1 %_566, i1* %ntb
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
		%_571 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
		%_572 = load i8*, i8** %_571
		%_573 = bitcast i8* %_572 to i1(i8*)*
		%_575 = bitcast %class.Tree* %c_node to i8*
		%_574 = call i1 %_573(i8* %_575)
		br i1 %_574, label %loop10, label %loop11

loop10:
		%_576 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 6
		%_577 = load i8*, i8** %_576
		%_578 = bitcast i8* %_577 to i1(i8*, i32)*
		%_580 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
		%_581 = load i8*, i8** %_580
		%_582 = bitcast i8* %_581 to i8*(i8*)*
		%_584 = bitcast %class.Tree* %c_node to i8*
		%_583 = call i8* %_582(i8* %_584)
		%_585 = bitcast i8* %_583 to %class.Tree*
		%_586 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
		%_587 = load i8*, i8** %_586
		%_588 = bitcast i8* %_587 to i32(i8*)*
		%_589 = call i32 %_588(i8* %_585)
		%_590 = bitcast %class.Tree* %c_node to i8*
		%_579 = call i1 %_578(i8* %_590, i32 %_589)
		store i1 %_579, i1* %ntb
		store %class.Tree* %c_node, %class.Tree** %p_node
		%_595 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
		%_596 = load i8*, i8** %_595
		%_597 = bitcast i8* %_596 to i8*(i8*)*
		%_599 = bitcast %class.Tree* %c_node to i8*
		%_598 = call i8* %_597(i8* %_599)
		%_600 = bitcast i8* %_598 to %class.Tree*
		store %class.Tree* %_600, %class.Tree** %c_node
		br label %loop9

loop11:
	%_603 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 2
	%_604 = load i8*, i8** %_603
	%_605 = bitcast i8* %_604 to i1(i8*, i8*)*
	%_607 = bitcast %class.Tree* %p_node to i8*
	%_608 = getelementptr %class.Tree, %class.Tree* %this, i32 0, i32 0
	%_609 = load i8*, i8** %_608
	%_610 = bitcast %class.Tree* %_609 to i8*
	%_606 = call i1 %_605(i8* %_607, i8* %_610)
	store i1 %_606, i1* %ntb
	%_613 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 9
	%_614 = load i8*, i8** %_613
	%_615 = bitcast i8* %_614 to i1(i8*, i1)*
	%_617 = bitcast %class.Tree* %p_node to i8*
	%_616 = call i1 %_615(i8* %_617, i1 false)
	store i1 %_616, i1* %ntb
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
		%_626 = load i1, i1* %cont
		br i1 %_626, label %loop13, label %loop14

loop13:
		%_627 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
		%_628 = load i8*, i8** %_627
		%_629 = bitcast i8* %_628 to i32(i8*)*
		%_631 = load %class.Tree*, %class.Tree** %current_node
		%_632 = bitcast %class.Tree* %_631 to i8*
		%_630 = call i32 %_629(i8* %_632)
		store i32 %_630, i32* %key_aux
		%_636 = load i32, i32* %key_aux
		%_637 = icmp slt i32 %v_key, %_636
		br i1 %_637, label %if45, label %if46

if45:
			%_638 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
			%_639 = load i8*, i8** %_638
			%_640 = bitcast i8* %_639 to i1(i8*)*
			%_642 = load %class.Tree*, %class.Tree** %current_node
			%_643 = bitcast %class.Tree* %_642 to i8*
			%_641 = call i1 %_640(i8* %_643)
			br i1 %_641, label %if48, label %if49

if48:
				%_644 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
				%_645 = load i8*, i8** %_644
				%_646 = bitcast i8* %_645 to i8*(i8*)*
				%_648 = load %class.Tree*, %class.Tree** %current_node
				%_649 = bitcast %class.Tree* %_648 to i8*
				%_647 = call i8* %_646(i8* %_649)
				%_650 = bitcast i8* %_647 to %class.Tree*
				store %class.Tree* %_650, %class.Tree** %current_node
				br label %if50

if49:
				store i1 false, i1* %cont
				br label %if50

if50:
			br label %if47

if46:
			%_655 = load i32, i32* %key_aux
			%_657 = icmp slt i32 %_655, %v_key
			br i1 %_657, label %if51, label %if52

if51:
				%_658 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
				%_659 = load i8*, i8** %_658
				%_660 = bitcast i8* %_659 to i1(i8*)*
				%_662 = load %class.Tree*, %class.Tree** %current_node
				%_663 = bitcast %class.Tree* %_662 to i8*
				%_661 = call i1 %_660(i8* %_663)
				br i1 %_661, label %if54, label %if55

if54:
					%_664 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 3
					%_665 = load i8*, i8** %_664
					%_666 = bitcast i8* %_665 to i8*(i8*)*
					%_668 = load %class.Tree*, %class.Tree** %current_node
					%_669 = bitcast %class.Tree* %_668 to i8*
					%_667 = call i8* %_666(i8* %_669)
					%_670 = bitcast i8* %_667 to %class.Tree*
					store %class.Tree* %_670, %class.Tree** %current_node
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
	%_679 = load i32, i32* %ifound
	ret i32 %_679

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
	%_681 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 19
	%_682 = load i8*, i8** %_681
	%_683 = bitcast i8* %_682 to i1(i8*, i8*)*
	%_685 = bitcast %class.Tree* %this to i8*
	%_686 = load %class.Tree*, %class.Tree** %current_node
	%_687 = bitcast %class.Tree* %_686 to i8*
	%_684 = call i1 %_683(i8* %_685, i8* %_687)
	store i1 %_684, i1* %ntb
	ret i1 true

end:
	call void @throw_oob()
	ret i1 false
}
define i1 @Tree.RecPrint(i8* %this_raw, i8* %node_raw) {
	%this = bitcast i8* %this_raw to %class.Tree*
	%node = bitcast i8* %node_raw to %class.Tree*
	%ntb = alloca i1
	%_690 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 8
	%_691 = load i8*, i8** %_690
	%_692 = bitcast i8* %_691 to i1(i8*)*
	%_694 = bitcast %class.Tree* %node to i8*
	%_693 = call i1 %_692(i8* %_694)
	br i1 %_693, label %if57, label %if58

if57:
		%_695 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 19
		%_696 = load i8*, i8** %_695
		%_697 = bitcast i8* %_696 to i1(i8*, i8*)*
		%_699 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 4
		%_700 = load i8*, i8** %_699
		%_701 = bitcast i8* %_700 to i8*(i8*)*
		%_703 = bitcast %class.Tree* %node to i8*
		%_702 = call i8* %_701(i8* %_703)
		%_704 = bitcast i8* %_702 to %class.Tree*
		%_705 = bitcast %class.Tree* %this to i8*
		%_707 = bitcast %class.Tree* %_704 to i8*
		%_698 = call i1 %_697(i8* %_705, i8* %_707)
		store i1 %_698, i1* %ntb
		br label %if59

if58:
		store i1 true, i1* %ntb
		br label %if59

if59:
	%_712 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 5
	%_713 = load i8*, i8** %_712
	%_714 = bitcast i8* %_713 to i32(i8*)*
	%_716 = bitcast %class.Tree* %node to i8*
	%_715 = call i32 %_714(i8* %_716)
	call void @print_int(i32 %_715)
	%_718 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 7
	%_719 = load i8*, i8** %_718
	%_720 = bitcast i8* %_719 to i1(i8*)*
	%_722 = bitcast %class.Tree* %node to i8*
	%_721 = call i1 %_720(i8* %_722)
	br i1 %_721, label %if60, label %if61

if60:
		%_723 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 19
		%_724 = load i8*, i8** %_723
		%_725 = bitcast i8* %_724 to i1(i8*, i8*)*
		%_727 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 3
		%_728 = load i8*, i8** %_727
		%_729 = bitcast i8* %_728 to i8*(i8*)*
		%_731 = bitcast %class.Tree* %node to i8*
		%_730 = call i8* %_729(i8* %_731)
		%_732 = bitcast i8* %_730 to %class.Tree*
		%_733 = bitcast %class.Tree* %this to i8*
		%_735 = bitcast %class.Tree* %_732 to i8*
		%_726 = call i1 %_725(i8* %_733, i8* %_735)
		store i1 %_726, i1* %ntb
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
