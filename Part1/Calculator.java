
class Calculator{
    private final InputStream in;
    private int lookahead;
    public CalcEval(InputStream in) throws IOException {
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
    private int evalDigit(int c) {
        return c - '0';
    }

    private int isLParen(int c){
        return '(' == c;
    }
    private int isRParen(int c){
        return ')' == c;
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
    
    private int digit(int condition){
        if(isDigit(condition)){
            return evalDigit(condition);
        }
        throw new ParseError();
    }

}