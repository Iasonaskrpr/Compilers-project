JTB_JAR = /home/jason/Compilers_1/Project_2/Necessary_files/jtb132di.jar
JAVACC_JAR = /home/jason/Compilers_1/Project_2/Necessary_files/javacc5.jar
JTB_INPUT = /home/jason/Compilers_1/Project_2/Necessary_files/minijava.jj
JTB_OUTPUT = /home/jason/Compilers_1/Project_2/Necessary_files/minijava-jtb.jj

all: compile

compile:
	java -jar $(JTB_JAR) -te $(JTB_INPUT)
	java -jar $(JAVACC_JAR) $(JTB_OUTPUT)
	javac -cp . symbolTable/*.java visitor/*.java *.java

clean:
	rm -rf *.class syntaxtree visitor $(JTB_OUTPUT) *~