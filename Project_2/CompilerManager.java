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
                for (Map.Entry<String, Map<String, FunctionVInfo>> classEntry : vtable.entrySet()) {
                    String className = classEntry.getKey();
                    Map<String, FunctionVInfo> functions = classEntry.getValue();
                    System.out.println("Class: " + className);
                    for (Map.Entry<String, FunctionVInfo> funcEntry : functions.entrySet()) {
                        String functionName = funcEntry.getKey();
                        FunctionVInfo info = funcEntry.getValue();
                        System.out.println("Function: " + functionName);
                        System.out.println("Offset: " + info.getOffset());
                        System.out.println("Return Type: " + info.getRet());
                        System.out.println("Arguments: " + info.getArguments());
                        if(info.isInherited()){
                            System.out.println("Inherited by: "+info.getParent());
                        }
                        System.out.println("-----------------------------");
                    }
                }
                //Step 3: IR generation
                filename = filename.substring(filename.lastIndexOf('/') + 1);
                // Remove the ".java" extension
                if (filename.endsWith(".java")) {
                    filename = filename.substring(0, filename.length() - 5);
                }
                IRHelper irhelp = new IRHelper("IRFiles/"+ filename + ".ll",vtable);
                
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
