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
                
                //Step 3: IR generation
                Map<String ,Map<String , FunctionVInfo >> vtable = scopes.getVTables();
                Map<String,ClassVariables> classes = scopes.getClasses();
                
                filename = filename.substring(filename.lastIndexOf('/') + 1);
                // Remove the ".java" extension
                if (filename.endsWith(".java")) {
                    filename = filename.substring(0, filename.length() - 5);
                }
                IRHelper irhelp = new IRHelper("IRFiles/"+ filename + ".ll",vtable,classes,filename);
                IRVisitor irVisitor = new IRVisitor();
                root.accept(irVisitor,irhelp);
                System.out.println("Generated IR code for "+filename+".java");
                
            } catch (Exception e) {
                System.err.println("Semantic analysis failed for: " + filename+".java");
                System.err.println("Reason: " + e.getMessage());
                e.printStackTrace();
                System.exit(1);
            }
            System.out.println("----------------------------------------");
        }
        System.exit(0);
    }
}
