import java_cup.runtime.*;
import java.io.*;

public class Main {
    public static void main(String[] args) throws Exception {

        // Read input from the file
        FileReader fileReader = new FileReader("in.txt"); 
        
        // Create the parser and pass the lexer
        Parser parser = new Parser(new Scanner(fileReader)); 

        try {
            // Parse the input and get the result
            Object result = parser.parse().value;
            System.out.println("Parsing result: \n" + result);
        } catch (Exception e) {
            System.err.println("Parsing failed: " + e.getMessage());
            e.printStackTrace();
        }

        fileReader.close(); // Close the file after reading
    }
}