import java.io.*;
import java.util.Map;
import IRGeneration.*;
import symbolTable.Scopes;
import syntaxtree.Goal;
import SemanticCheckingVisitors.*;
//Calls visitors that perform semantic analysis and generates LLVM IR
public class CompilerManager {
    public static void main(String[] args) {
        if (args.length < 1) {
            System.out.println("Usage: java CompilerManager <MiniJavaSourceFile1> <MiniJavaSourceFile2> ...");
            System.exit(1);
        }

        for (String filename : args) {
            System.out.println("Analyzing: " + filename);

            try (InputStream input = new FileInputStream(filename)) {
                // Parse the input file
                MiniJavaParser parser = new MiniJavaParser(input);
                Goal root = parser.Goal(); // AST root

                // Build a new symbol table for this file
                Scopes scopes = new Scopes();

                // Step 1: Symbol table construction
                SymbolTableVisitor symbolVisitor = new SymbolTableVisitor();
                root.accept(symbolVisitor, scopes);

                // Step 2: Type checking
                TypeCheckingVisitor typeVisitor = new TypeCheckingVisitor();
                root.accept(typeVisitor, scopes);

                System.out.println("Semantic analysis completed successfully for: " + filename);
                Map<String ,Map<String , FunctionVInfo >> vtable = scopes.getVTables();
                IRVisitor irvisitor = new IRVisitor();
                
            } catch (Exception e) {
                System.err.println("Semantic analysis failed for: " + filename);
                System.err.println("Reason: " + e.getMessage());
                e.printStackTrace();
                System.exit(1);
            }
            System.out.println("----------------------------------------");
        }
        System.exit(0);
    }
}
