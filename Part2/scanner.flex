import java_cup.runtime.*;
%%
%class Scanner

%line
%column

%cup

%{
StringBuffer stringBuffer = new StringBuffer();
private Symbol symbol(int type) {
   return new Symbol(type, yyline, yycolumn);
}
private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
}
%}

/* Regular expressions */
LineTerminator = \r|\n|\r\n
WhiteSpace     = {LineTerminator} | [ \t\f]
IDENTIFIER  = [a-zA-Z_][a-zA-Z0-9_]*

%state STRING

%%


<YYINITIAL> {
    "if"        { return new Symbol(sym.IF); }
    "else"      { return new Symbol(sym.ELSE); }
    "prefix"    { return new Symbol(sym.PREFIX); }
    "suffix"    { return new Symbol(sym.SUFFIX); }
    "reverse"   { return new Symbol(sym.REVERSE); }
    "="         { return new Symbol(sym.EQ); }
    "+"         { return new Symbol(sym.CONCAT); }
    "("         { return new Symbol(sym.LPAREN); }
    ")"         { return new Symbol(sym.RPAREN); }
    "{"         { return new Symbol(sym.LBRAC); }
    "}"         { return new Symbol(sym.RBRAC); }
    ","         { return new Symbol(sym.COMMA);}
    {WhiteSpace} { } 
    {IDENTIFIER} { return symbol(sym.IDENTIFIER, yytext()); }
    \"             { stringBuffer.setLength(0); yybegin(STRING); }
}


<STRING> {
    \"                             { 
                                      Symbol s = symbol(sym.STRING_LITERAL, stringBuffer.toString());
                                      yybegin(YYINITIAL);
                                      stringBuffer.setLength(0);
                                      return s;
                                    }
    [^\n\r\"\\]+                   { stringBuffer.append( yytext() ); }
    \\t                            { stringBuffer.append('\t'); }
    \\n                            { stringBuffer.append('\n'); }
    \\r                            { stringBuffer.append('\r'); }
    \\\"                           { stringBuffer.append('\"'); }
    \\                             { stringBuffer.append('\\'); }
}

[^]                    { throw new Error("Illegal character <"+yytext()+">"); }
