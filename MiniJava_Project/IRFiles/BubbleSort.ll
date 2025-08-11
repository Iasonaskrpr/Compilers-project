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
	call void @print_int(i32 10)
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
define i32 @BBS.Start(%class.BBS* %this, i32 %sz) {
	%aux2 = alloca i32
	ret i32 0
}
define %IntArray @BBS.Sort(%class.BBS* %this) {
	%nt = alloca i32
	%i = alloca i32
	%aux02 = alloca i32
	%aux04 = alloca i32
	%aux05 = alloca i32
	%aux06 = alloca i32
	%aux07 = alloca i32
	%j = alloca i32
	%t = alloca i32
		%_0 = getelementptr i32, %class.BBS* %this, i32 0, i32 1
	%_1 = load i32, i32* %_0
	%_2 = sub i32 %_1, 1
	store i32 %_2, i32* %i
	%_4 = sub i32 0, 1
	store i32 %_4, i32* %aux02
	br label %loop0

loop0:
		%_6 = load i32, i32* %aux02
		%_7 = load i32, i32* %i
		%_8 = icmp slt i32 %_6, %_7
		br i1 %_8, label %loop1, label %loop2

loop1:
		store i32 1, i32* %j
		br label %loop3

loop3:
			%_10 = load i32, i32* %j
			%_11 = load i32, i32* %i
			%_12 = add i32 %_11, 1
			%_14 = icmp slt i32 %_10, %_12
			br i1 %_14, label %loop4, label %loop5

loop4:
			%_15 = load i32, i32* %j
			%_16 = sub i32 %_15, 1
			store i32 %_16, i32* %aux07
			%_18 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
			%_19 = load i32, i32* %_18
			%_20 = icmp slt i32 aux07, %_19
			br i1 %_20, label %oob0, label %oob1

oob0:
			%_21 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
			%_22 = load i32*, i32** %_21
			%_23 = getelementptr i32, i32* %_22, i32 aux07
			%_24 = load i32, i32* %_23
			br label %oob2

oob1:
			br label %end

oob2:
			store i32 %_24, i32* %aux04
			%_26 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
			%_27 = load i32, i32* %_26
			%_28 = icmp slt i32 j, %_27
			br i1 %_28, label %oob3, label %oob4

oob3:
			%_29 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
			%_30 = load i32*, i32** %_29
			%_31 = getelementptr i32, i32* %_30, i32 j
			%_32 = load i32, i32* %_31
			br label %oob5

oob4:
			br label %end

oob5:
			store i32 %_32, i32* %aux05
			%_34 = load i32, i32* %aux05
			%_35 = load i32, i32* %aux04
			%_36 = icmp slt i32 %_34, %_35
			br i1 %_36, label %if0, label %if1

if0:
				%_37 = load i32, i32* %j
				%_38 = sub i32 %_37, 1
				store i32 %_38, i32* %aux06
				%_40 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
				%_41 = load i32, i32* %_40
				%_42 = icmp slt i32 aux06, %_41
				br i1 %_42, label %oob6, label %oob7

oob6:
				%_43 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
				%_44 = load i32*, i32** %_43
				%_45 = getelementptr i32, i32* %_44, i32 aux06
				%_46 = load i32, i32* %_45
				br label %oob8

oob7:
				br label %end

oob8:
				store i32 %_46, i32* %t
				%_48 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
				%_49 = load i32, i32* %_48
				%_50 = icmp slt i32 j, %_49
				br i1 %_50, label %oob12, label %oob13

oob12:
				%_51 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
				%_52 = load i32*, i32** %_51
				%_53 = getelementptr i32, i32* %_52, i32 j
				%_54 = load i32, i32* %_53
				br label %oob14

oob13:
				br label %end

oob14:
				%_56 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
				%_57 = load i32, i32* %_56
				%_58 = icmp slt i32 aux06, %_57
				br i1 %_58, label %oob9, label %oob10

oob9:
				%_59 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
				%_60 = load i32*, i32** %_59
				%_61 = getelementptr i32, i32* %_60, i32 aux06
				store i32 %_54, i32* %_61
				br label %oob11

oob10:
				br label %end

oob11:
				%_62 = load i32, i32* %t
				%_63 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
				%_64 = load i32, i32* %_63
				%_65 = icmp slt i32 j, %_64
				br i1 %_65, label %oob15, label %oob16

oob15:
				%_66 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
				%_67 = load i32*, i32** %_66
				%_68 = getelementptr i32, i32* %_67, i32 j
				store i32 %_62, i32* %_68
				br label %oob17

oob16:
				br label %end

oob17:
				br label %if2

if1:
				store i32 0, i32* %nt
				br label %if2

if2:
			%_70 = load i32, i32* %j
			%_71 = add i32 %_70, 1
			store i32 %_71, i32* %j
			br label %loop3

loop5:
		%_73 = load i32, i32* %i
		%_74 = sub i32 %_73, 1
		store i32 %_74, i32* %i
		br label %loop0

loop2:
	ret id number
}
define i32 @BBS.Print(%class.BBS* %this) {
	%j = alloca i32
	store i32 0, i32* %j
	br label %loop6

loop6:
		%_77 = load i32, i32* %j
				%_78 = getelementptr i32, %class.BBS* %this, i32 0, i32 1
		%_79 = load i32, i32* %_78
		%_80 = icmp slt i32 %_77, %_79
		br i1 %_80, label %loop7, label %loop8

loop7:
		%_81 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
		%_82 = load i32, i32* %_81
		%_83 = icmp slt i32 j, %_82
		br i1 %_83, label %oob18, label %oob19

oob18:
		%_84 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
		%_85 = load i32*, i32** %_84
		%_86 = getelementptr i32, i32* %_85, i32 j
		%_87 = load i32, i32* %_86
		br label %oob20

oob19:
		br label %end

oob20:
		call void @print_int(i32 %_87)
		%_89 = load i32, i32* %j
		%_90 = add i32 %_89, 1
		store i32 %_90, i32* %j
		br label %loop6

loop8:
	ret i32 0
}
define i32 @BBS.Init(%class.BBS* %this, i32 %sz) {
		%_92 = getelementptr i32, %class.BBS* %this, i32 0, i32 1
	store i32 sz, i32* %_92
	%_93 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
	store i32 sz, i32* %_93
	%_94 = call i8* @calloc(i32 sz, i32 4)
	%_95 = bitcast i8* %_94 to i32*
	%_96 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
	store i32* %_95, i32** %_96
	%_97 = add i32 0, 0
	%_98 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
	%_99 = load i32, i32* %_98
	%_100 = icmp slt i32 %_97, %_99
	br i1 %_100, label %oob21, label %oob22

oob21:
	%_101 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
	%_102 = load i32*, i32** %_101
	%_103 = getelementptr i32, i32* %_102, i32 %_97
	store i32 20, i32* %_103
	br label %oob23

oob22:
	br label %end

oob23:
	%_104 = add i32 0, 1
	%_105 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
	%_106 = load i32, i32* %_105
	%_107 = icmp slt i32 %_104, %_106
	br i1 %_107, label %oob24, label %oob25

oob24:
	%_108 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
	%_109 = load i32*, i32** %_108
	%_110 = getelementptr i32, i32* %_109, i32 %_104
	store i32 7, i32* %_110
	br label %oob26

oob25:
	br label %end

oob26:
	%_111 = add i32 0, 2
	%_112 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
	%_113 = load i32, i32* %_112
	%_114 = icmp slt i32 %_111, %_113
	br i1 %_114, label %oob27, label %oob28

oob27:
	%_115 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
	%_116 = load i32*, i32** %_115
	%_117 = getelementptr i32, i32* %_116, i32 %_111
	store i32 12, i32* %_117
	br label %oob29

oob28:
	br label %end

oob29:
	%_118 = add i32 0, 3
	%_119 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
	%_120 = load i32, i32* %_119
	%_121 = icmp slt i32 %_118, %_120
	br i1 %_121, label %oob30, label %oob31

oob30:
	%_122 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
	%_123 = load i32*, i32** %_122
	%_124 = getelementptr i32, i32* %_123, i32 %_118
	store i32 18, i32* %_124
	br label %oob32

oob31:
	br label %end

oob32:
	%_125 = add i32 0, 4
	%_126 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
	%_127 = load i32, i32* %_126
	%_128 = icmp slt i32 %_125, %_127
	br i1 %_128, label %oob33, label %oob34

oob33:
	%_129 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
	%_130 = load i32*, i32** %_129
	%_131 = getelementptr i32, i32* %_130, i32 %_125
	store i32 2, i32* %_131
	br label %oob35

oob34:
	br label %end

oob35:
	%_132 = add i32 0, 5
	%_133 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
	%_134 = load i32, i32* %_133
	%_135 = icmp slt i32 %_132, %_134
	br i1 %_135, label %oob36, label %oob37

oob36:
	%_136 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
	%_137 = load i32*, i32** %_136
	%_138 = getelementptr i32, i32* %_137, i32 %_132
	store i32 11, i32* %_138
	br label %oob38

oob37:
	br label %end

oob38:
	%_139 = add i32 0, 6
	%_140 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
	%_141 = load i32, i32* %_140
	%_142 = icmp slt i32 %_139, %_141
	br i1 %_142, label %oob39, label %oob40

oob39:
	%_143 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
	%_144 = load i32*, i32** %_143
	%_145 = getelementptr i32, i32* %_144, i32 %_139
	store i32 6, i32* %_145
	br label %oob41

oob40:
	br label %end

oob41:
	%_146 = add i32 0, 7
	%_147 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
	%_148 = load i32, i32* %_147
	%_149 = icmp slt i32 %_146, %_148
	br i1 %_149, label %oob42, label %oob43

oob42:
	%_150 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
	%_151 = load i32*, i32** %_150
	%_152 = getelementptr i32, i32* %_151, i32 %_146
	store i32 9, i32* %_152
	br label %oob44

oob43:
	br label %end

oob44:
	%_153 = add i32 0, 8
	%_154 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
	%_155 = load i32, i32* %_154
	%_156 = icmp slt i32 %_153, %_155
	br i1 %_156, label %oob45, label %oob46

oob45:
	%_157 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
	%_158 = load i32*, i32** %_157
	%_159 = getelementptr i32, i32* %_158, i32 %_153
	store i32 19, i32* %_159
	br label %oob47

oob46:
	br label %end

oob47:
	%_160 = add i32 0, 9
	%_161 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
	%_162 = load i32, i32* %_161
	%_163 = icmp slt i32 %_160, %_162
	br i1 %_163, label %oob48, label %oob49

oob48:
	%_164 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
	%_165 = load i32*, i32** %_164
	%_166 = getelementptr i32, i32* %_165, i32 %_160
	store i32 5, i32* %_166
	br label %oob50

oob49:
	br label %end

oob50:
	ret i32 0
}
