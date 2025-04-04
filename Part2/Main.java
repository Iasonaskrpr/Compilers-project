import java_cup.runtime.*;
import java.io.*;

public class Main {
    public static void main(String[] args) throws Exception {
        PrintStream originalOut = System.out;
        PrintStream outFile = new PrintStream(new FileOutputStream("Translated.ir"));
        System.setOut(outFile);
        // Read input from the file
        FileReader fileReader = new FileReader("in.txt"); 
        
        // Create the parser and pass the lexer
        Parser parser = new Parser(new Scanner(fileReader)); 
        parser.parse();
         
        //outFile = new PrintStream(new FileOutputStream("Translated.java"));
        System.setOut(originalOut);
        FileReader fileReader2 = new FileReader("Translated.ir");
        Parser2 parser2 = new Parser2(new Scanner(fileReader2));
        parser2.parse();
        parser2.debug_parse(); 
        fileReader.close(); // Close the file after reading
    }
}