JTB_JAR = Necessary_files/jtb132di.jar
JAVACC_JAR = Necessary_files/javacc5.jar
JTB_INPUT = Necessary_files/minijava.jj
JTB_OUTPUT = Necessary_files/minijava-jtb.jj
all: compile

compile:
	java -jar $(JTB_JAR) -te $(JTB_INPUT)
	java -jar $(JAVACC_JAR) $(JTB_OUTPUT)
	javac -cp . symbolTable/*.java visitor/*.java IRGeneration/*.java *.java
	mkdir -p IRFiles

clean:
	rm -rf IRGeneration/*.class symbolTable/*.class SemanticCheckingVisitors/*.class *.class syntaxtree visitor $(JTB_OUTPUT) *~ JavaCharStream.java MiniJavaParser.java TokenMgrError.java Token.java ParseException.java MiniJavaParserConstants.java MiniJavaParserTokenManager.java