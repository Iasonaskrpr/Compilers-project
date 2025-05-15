import java.io.FileInputStream;
import java.io.InputStream;

import symbolTable.Scopes;
import syntaxtree.Goal; // Root of MiniJava AST

public class TestSemanticAnalyzer {
    public static void main(String[] args) {
        if (args.length < 1) {
            System.out.println("Usage: java TestSemanticAnalyzer <MiniJavaSourceFile>");
            return;
        }

        String filename = args[0];

        try (InputStream input = new FileInputStream(filename)) {
            // Parse the input file
            MiniJavaParser parser = new MiniJavaParser(input);
            Goal root = parser.Goal(); // Start symbol for MiniJava

            // Set up Scopes and visitor
            Scopes scopes = new Scopes();
            SymbolTableVisitor visitor = new SymbolTableVisitor();

            // Visit the AST
            root.accept(visitor, scopes);

            // If no exceptions, success
            System.out.println("Semantic analysis completed successfully.");
            scopes.PrintOffset(); // Optional offset display

        } catch (Exception e) {
            System.err.println("Semantic analysis failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
