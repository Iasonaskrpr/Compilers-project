compile:
	jflex scanner.flex
	java -jar Dependencies/java-cup-11b.jar -interface -parser Parser  irparser.cup
	java -jar Dependencies/java-cup-11b.jar -interface -parser Parser2 Javaparser.cup
	javac -cp Dependencies/java-cup-11b-runtime.jar *.java
execute:
	java -cp Dependencies/java-cup-11b-runtime.jar:. Main 
clean:
	rm -f *.class *~
	rm Parser.java
	rm sym.java 
	rm Scanner.java
	rm Parser2.java
	rm Translated.ir
	rm Translated.java
run:
	@javac Translated.java > /dev/null 2>&1
	@java Translated