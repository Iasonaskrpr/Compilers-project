import java.io.InputStream;
import java.io.IOException;
import java.lang.Math;
class Calculator{
    private final InputStream in;
    private int lookahead;
    public Calculator(InputStream in) throws IOException {
        this.in = in;
        lookahead = in.read();
    }
    private void skipWhitespace() throws IOException {
        while (lookahead == ' ' || lookahead == '\t' || lookahead == '\r') {
            lookahead = in.read();
        }
    }
    private void consume(int symbol) throws IOException, ParseError {
        if (lookahead == symbol)
            lookahead = in.read();
        else
            throw new ParseError();
    }
    private boolean isDigit(int c) {
        return '0' <= c && c <= '9';
    }
    private boolean isOp(int c){
        return '-'== c || '+' == c ; 
    }
    private boolean isExp(int c){
        return '*' == c;
    }
    private int evalDigit(int c) {
        return c - '0';
    }

    private boolean isLParen(int c){
        return '(' == c;
    }
    private boolean isRParen(int c){
        return ')' == c;
    }
    private boolean isEOF(int c){
        return c == -1 || c == 10;
    }
    public int eval() throws IOException, ParseError {
        skipWhitespace();
        int value = expr();

        if (lookahead != -1 && lookahead != '\n')
            throw new ParseError();

        return value;
    }
    private int expr() throws IOException, ParseError{
        if(isDigit(lookahead)||isLParen(lookahead)){
            int cond = power(lookahead);
            cond  = exprTail(cond);
            return cond;
        }
        throw new ParseError();
    }
    private int exprTail(int condition) throws IOException, ParseError{
        if(isOp(lookahead)){
            int op = lookahead;
            consume(lookahead);
            skipWhitespace();
            if(op == '+'){
                condition += power(lookahead);
            }
            else{
                condition -= power(lookahead);
            }
            return exprTail(condition);
        }
        else if(isEOF(lookahead)||isRParen(lookahead)){
            return condition;
        }
        throw new ParseError();
    }
    private int power(int condition) throws IOException, ParseError{
        skipWhitespace();
        if(isDigit(condition)||isLParen(condition)){
            condition = number(condition);
            skipWhitespace();
            return powerTail(condition);
        }
        throw new ParseError();
    }
    private int powerTail(int condition) throws IOException, ParseError{
        if(isExp(lookahead)){  
            consume(lookahead);
            skipWhitespace();
            int num2 = number(lookahead);
            skipWhitespace();
            num2 = powerTail(num2);
            return (int)Math.pow(condition,num2);
        }
        else if(isOp(lookahead)||isRParen(lookahead)||isEOF(lookahead)){
            return condition;
        }
        throw new ParseError();
    }
    private int number(int condition) throws IOException, ParseError{
        
        if(isDigit(condition)){
            condition = digit(condition);
            return numberTail(condition);
        }
        else if (isLParen(condition)) {
            consume(condition);
            skipWhitespace();
            int value = expr();
            consume(')'); 
            skipWhitespace();
            return value;
        }
        throw new ParseError();
    }
    private int numberTail(int condition) throws IOException, ParseError{
        consume(lookahead);
        if(isDigit(lookahead)){
            condition *= 10;
            condition += digit(lookahead);
            return numberTail(condition);
        }
        skipWhitespace();
        if(isOp(lookahead)||isRParen(lookahead)||isEOF(lookahead)){
            return condition;
        }
        else if(isExp(lookahead)){
            consume(lookahead);
            if (isExp(lookahead)){
                return condition;
            }
            else{
                throw new ParseError();
            }
        }
        throw new ParseError();
    }
    private int digit(int condition) throws IOException, ParseError{
        if(isDigit(condition)){
            return evalDigit(condition);
        }
        throw new ParseError();
    }

}