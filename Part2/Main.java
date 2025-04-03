import java_cup.runtime.*;
import java.io.*;

public class Main {
    public static void main(String[] args) throws Exception {
        PrintStream outFile = new PrintStream(new FileOutputStream("Translated.ir"));
        System.setOut(outFile);
        // Read input from the file
        FileReader fileReader = new FileReader("in.txt"); 
        
        // Create the parser and pass the lexer
        Parser parser = new Parser(new Scanner(fileReader)); 
        parser.parse();
        //parser.debug_parse();  

        fileReader.close(); // Close the file after reading
    }
}