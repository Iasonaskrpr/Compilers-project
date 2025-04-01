import java_cup.runtime.*;

public class TestLexer {
    public static void main(String[] args) throws Exception {
        // Create a new lexer object
        Scanner lexer = new Scanner(System.in);
        
        // Loop to get each token
        Symbol token;
        while ((token = lexer.next_token()).sym != sym.EOF) {
            System.out.println("Token: " + token);
        }
    }
}
