@.BBS_vtable = global [3 x i8*] [i8* bitcast (%IntArray (i8*)* @BBS.Sort to i8*),i8* bitcast (i32 (i8*)* @BBS.Print to i8*),i8* bitcast (i32 (i8*,i32)* @BBS.Init to i8*)]
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
	ret i32 0

end:
	call void @throw_oob()
	ret i32 1
}
%number = alloca %IntArray
%size = alloca i32
define %IntArray @BBS.Sort(i8* this) {
	%nt = alloca i32
	%i = alloca i32
	%aux02 = alloca i32
	%aux04 = alloca i32
	%aux05 = alloca i32
	%aux06 = alloca i32
	%aux07 = alloca i32
	%j = alloca i32
	%t = alloca i32
	%_0 = load i32, i32* %size
	%_1 = sub i32 %_0, 1
	store i32 %_1, i32* %i
	%_2 = sub i32 0, 1
	store i32 %_2, i32* %aux02
	br label %loop0

loop0:
		%_3 = load i32, i32* %aux02
		%_4 = load i32, i32* %i
		%_5 = icmp slt i32 %_3, %_4
		br i1 %_5, label %loop1, label %loop2

loop1:
		store i32 1, i32* %j
		br label %loop3

loop3:
			%_6 = load i32, i32* %j
			%_7 = load i32, i32* %i
			%_8 = add i32 %_7, 1
			%_9 = icmp slt i32 %_6, %_8
			br i1 %_9, label %loop4, label %loop5

loop4:
			%_10 = load i32, i32* %j
			%_11 = sub i32 %_10, 1
			store i32 %_11, i32* %aux07
			%_12 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
			%_13 = load i32, i32* %_12
			%_14 = icmp slt i32 aux07, %_13
			br i1 %_14, label %oob0, label %oob1

oob0:
			%_15 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
			%_16 = load i32*, i32** %_15
			%_17 = getelementptr i32, i32* %_16, i32 aux07
			%_18 = load i32, i32* %_17
			br label %oob2

oob1:
			br label %end

oob2:
			store i32 %_18, i32* %aux04
			%_19 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
			%_20 = load i32, i32* %_19
			%_21 = icmp slt i32 j, %_20
			br i1 %_21, label %oob3, label %oob4

oob3:
			%_22 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
			%_23 = load i32*, i32** %_22
			%_24 = getelementptr i32, i32* %_23, i32 j
			%_25 = load i32, i32* %_24
			br label %oob5

oob4:
			br label %end

oob5:
			store i32 %_25, i32* %aux05
			%_26 = load i32, i32* %aux05
			%_27 = load i32, i32* %aux04
			%_28 = icmp slt i32 %_26, %_27
			br i1 %_28, label %if0, label %if1

if0:
				%_29 = load i32, i32* %j
				%_30 = sub i32 %_29, 1
				store i32 %_30, i32* %aux06
				%_31 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
				%_32 = load i32, i32* %_31
				%_33 = icmp slt i32 aux06, %_32
				br i1 %_33, label %oob6, label %oob7

oob6:
				%_34 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
				%_35 = load i32*, i32** %_34
				%_36 = getelementptr i32, i32* %_35, i32 aux06
				%_37 = load i32, i32* %_36
				br label %oob8

oob7:
				br label %end

oob8:
				store i32 %_37, i32* %t
				%_38 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
				%_39 = load i32, i32* %_38
				%_40 = icmp slt i32 j, %_39
				br i1 %_40, label %oob12, label %oob13

oob12:
				%_41 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
				%_42 = load i32*, i32** %_41
				%_43 = getelementptr i32, i32* %_42, i32 j
				%_44 = load i32, i32* %_43
				br label %oob14

oob13:
				br label %end

oob14:
				%_45 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
				%_46 = load i32, i32* %_45
				%_47 = icmp slt i32 aux06, %_46
				br i1 %_47, label %oob9, label %oob10

oob9:
				%_48 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
				%_49 = load i32*, i32** %_48
				%_50 = getelementptr i32, i32* %_49, i32 aux06
				store i32 %_44, i32* %_50
				br label %oob11

oob10:
				br label %end

oob11:
				%_51 = load i32, i32* %t
				%_52 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
				%_53 = load i32, i32* %_52
				%_54 = icmp slt i32 j, %_53
				br i1 %_54, label %oob15, label %oob16

oob15:
				%_55 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
				%_56 = load i32*, i32** %_55
				%_57 = getelementptr i32, i32* %_56, i32 j
				store i32 %_51, i32* %_57
				br label %oob17

oob16:
				br label %end

oob17:
				br label %if2

if1:
				store i32 0, i32* %nt
				br label %if2

if2:
			%_58 = load i32, i32* %j
			%_59 = add i32 %_58, 1
			store i32 %_59, i32* %j
			br label %loop3

loop5:
		%_60 = load i32, i32* %i
		%_61 = sub i32 %_60, 1
		store i32 %_61, i32* %i
		br label %loop0

loop2:
	ret id number
}
define i32 @BBS.Print(i8* this) {
	%j = alloca i32
	store i32 0, i32* %j
	br label %loop6

loop6:
		%_62 = load i32, i32* %j
		%_63 = load i32, i32* %size
		%_64 = icmp slt i32 %_62, %_63
		br i1 %_64, label %loop7, label %loop8

loop7:
		%_65 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
		%_66 = load i32, i32* %_65
		%_67 = icmp slt i32 j, %_66
		br i1 %_67, label %oob18, label %oob19

oob18:
		%_68 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
		%_69 = load i32*, i32** %_68
		%_70 = getelementptr i32, i32* %_69, i32 j
		%_71 = load i32, i32* %_70
		br label %oob20

oob19:
		br label %end

oob20:
		call void @print_int(i32 %_71)
		%_72 = load i32, i32* %j
		%_73 = add i32 %_72, 1
		store i32 %_73, i32* %j
		br label %loop6

loop8:
	ret num 0
}
define i32 @BBS.Init(i8* this, i32 %.sz) {
	store i32 sz, i32* %size
	%_74 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
	store i32 sz, i32* %_74
	%_75 = call i8* @calloc(i32 sz, i32 4)
	%_76 = bitcast i8* %_75 to i32*
	%_77 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
	store i32* %_76, i32** %_77
	%_78 = add i32 0, 0
	%_79 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
	%_80 = load i32, i32* %_79
	%_81 = icmp slt i32 %_78, %_80
	br i1 %_81, label %oob21, label %oob22

oob21:
	%_82 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
	%_83 = load i32*, i32** %_82
	%_84 = getelementptr i32, i32* %_83, i32 %_78
	store i32 20, i32* %_84
	br label %oob23

oob22:
	br label %end

oob23:
	%_85 = add i32 0, 1
	%_86 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
	%_87 = load i32, i32* %_86
	%_88 = icmp slt i32 %_85, %_87
	br i1 %_88, label %oob24, label %oob25

oob24:
	%_89 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
	%_90 = load i32*, i32** %_89
	%_91 = getelementptr i32, i32* %_90, i32 %_85
	store i32 7, i32* %_91
	br label %oob26

oob25:
	br label %end

oob26:
	%_92 = add i32 0, 2
	%_93 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
	%_94 = load i32, i32* %_93
	%_95 = icmp slt i32 %_92, %_94
	br i1 %_95, label %oob27, label %oob28

oob27:
	%_96 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
	%_97 = load i32*, i32** %_96
	%_98 = getelementptr i32, i32* %_97, i32 %_92
	store i32 12, i32* %_98
	br label %oob29

oob28:
	br label %end

oob29:
	%_99 = add i32 0, 3
	%_100 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
	%_101 = load i32, i32* %_100
	%_102 = icmp slt i32 %_99, %_101
	br i1 %_102, label %oob30, label %oob31

oob30:
	%_103 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
	%_104 = load i32*, i32** %_103
	%_105 = getelementptr i32, i32* %_104, i32 %_99
	store i32 18, i32* %_105
	br label %oob32

oob31:
	br label %end

oob32:
	%_106 = add i32 0, 4
	%_107 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
	%_108 = load i32, i32* %_107
	%_109 = icmp slt i32 %_106, %_108
	br i1 %_109, label %oob33, label %oob34

oob33:
	%_110 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
	%_111 = load i32*, i32** %_110
	%_112 = getelementptr i32, i32* %_111, i32 %_106
	store i32 2, i32* %_112
	br label %oob35

oob34:
	br label %end

oob35:
	%_113 = add i32 0, 5
	%_114 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
	%_115 = load i32, i32* %_114
	%_116 = icmp slt i32 %_113, %_115
	br i1 %_116, label %oob36, label %oob37

oob36:
	%_117 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
	%_118 = load i32*, i32** %_117
	%_119 = getelementptr i32, i32* %_118, i32 %_113
	store i32 11, i32* %_119
	br label %oob38

oob37:
	br label %end

oob38:
	%_120 = add i32 0, 6
	%_121 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
	%_122 = load i32, i32* %_121
	%_123 = icmp slt i32 %_120, %_122
	br i1 %_123, label %oob39, label %oob40

oob39:
	%_124 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
	%_125 = load i32*, i32** %_124
	%_126 = getelementptr i32, i32* %_125, i32 %_120
	store i32 6, i32* %_126
	br label %oob41

oob40:
	br label %end

oob41:
	%_127 = add i32 0, 7
	%_128 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
	%_129 = load i32, i32* %_128
	%_130 = icmp slt i32 %_127, %_129
	br i1 %_130, label %oob42, label %oob43

oob42:
	%_131 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
	%_132 = load i32*, i32** %_131
	%_133 = getelementptr i32, i32* %_132, i32 %_127
	store i32 9, i32* %_133
	br label %oob44

oob43:
	br label %end

oob44:
	%_134 = add i32 0, 8
	%_135 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
	%_136 = load i32, i32* %_135
	%_137 = icmp slt i32 %_134, %_136
	br i1 %_137, label %oob45, label %oob46

oob45:
	%_138 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
	%_139 = load i32*, i32** %_138
	%_140 = getelementptr i32, i32* %_139, i32 %_134
	store i32 19, i32* %_140
	br label %oob47

oob46:
	br label %end

oob47:
	%_141 = add i32 0, 9
	%_142 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 0
	%_143 = load i32, i32* %_142
	%_144 = icmp slt i32 %_141, %_143
	br i1 %_144, label %oob48, label %oob49

oob48:
	%_145 = getelementptr %IntArray, %IntArray* %number, i32 0, i32 1
	%_146 = load i32*, i32** %_145
	%_147 = getelementptr i32, i32* %_146, i32 %_141
	store i32 5, i32* %_147
	br label %oob50

oob49:
	br label %end

oob50:
	ret num 0
}
