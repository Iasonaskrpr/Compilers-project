import java.io.InputStream;
import java.io.IOException;
class Calculator{
    private final InputStream in;
    private int lookahead;
    public Calculator(InputStream in) throws IOException {
        this.in = in;
        lookahead = in.read();
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
    private boolean evalDigit(int c) {
        return c - '0';
    }

    private boolean isLParen(int c){
        return '(' == c;
    }
    private boolean isRParen(int c){
        return ')' == c;
    }
    private boolean isEOF(int c){
        return c == -1;
    }
    public int eval() throws IOException, ParseError {
        int value = expr();

        if (lookahead != -1 && lookahead != '\n')
            throw new ParseError();

        return value;
    }
    private int expr() throws IOException, ParseError{
        consume(lookahead);
        if(isDigit(lookahead)||isLParen(lookahead)){
            int cond = power(lookahead);
            cond  = expTail(cond);
            return cond;
        }
        throw new ParseError();
    }
    private int power(int condition){
        if(isDigit(condition)||isLParen(condition)){
            condition = number(condition);
            return powerTail(condition);
        }
        throw new ParseError();
    }
    private int number(int condition){
        if(isDigit(condition)){
            condition = digit(condition);
            return numberTail(condition);
        }
        else if(isLParen(condition)){
            return expr();
        }

        throw new ParseError();
    }
    private int numberTail(int condition){
        consume(lookahead);
        if(isDigit(lookahead)){
            condition *= 10;
            condition += digit(lookahead);
            return numberTail(condition);
        }
        else if(isOp(lookahead)||isRParen(lookahead)||isEOF(lookahead)){
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
    private int digit(int condition){
        if(isDigit(condition)){
            return evalDigit(condition);
        }
        throw new ParseError();
    }

}