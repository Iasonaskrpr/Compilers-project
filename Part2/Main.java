import java_cup.runtime.*;
import java.io.*;

public class Main {
    public static void main(String[] args) throws Exception {
        PrintStream originalOut = System.out;
        PrintStream outFile = new PrintStream(new FileOutputStream("Translated.ir"));
        System.setOut(outFile);
        
        // Create the parser and pass the lexer
        Reader stdinReader = new InputStreamReader(System.in);
        Parser parser = new Parser(new Scanner(stdinReader));
        parser.parse();
         
        outFile = new PrintStream(new FileOutputStream("Translated.java"));
        System.setOut(outFile);
        FileReader fileReader = new FileReader("Translated.ir");
        Parser2 parser2 = new Parser2(new Scanner(fileReader));
        parser2.parse();
        parser2.debug_parse(); 
        fileReader.close(); // Close the file after reading
        stdinReader.close();
    }
}