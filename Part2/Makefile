compile:
	jflex scanner.flex
	java -jar ../java-cup-11b.jar -interface -parser Parser  irparser.cup
	java -jar ../java-cup-11b.jar -interface -parser Parser2 Javaparser.cup
	javac -cp ../java-cup-11b-runtime.jar *.java
execute:
	java -cp ../java-cup-11b-runtime.jar:. Main
clean:
	rm -f *.class *~
	rm Parser.java
	rm sym.java 
	rm Scanner.java