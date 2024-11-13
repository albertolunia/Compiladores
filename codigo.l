
%{
#include <stdio.h>
#include "tokens.h"  
%}

%%

"if"            { printf("Palavra reservada: if\n"); return T_KEYWORD; }
"else"          { printf("Palavra reservada: if\n"); return T_KEYWORD; }
"var"           { printf("Palavra reservada: var\n"); return T_KEYWORD; }
[a-zA-Z_][a-zA-Z0-9_]*  { printf("Identificador: %s\n", yytext); return T_IDENTIFIER; }
[0-9]+          { printf("Número: %s\n", yytext); return T_NUMBER; }
">"             { printf("Operador de comparação: %s\n", yytext); return T_OPCOMP; }
"<"             { printf("Operador de comparação: %s\n", yytext); return T_OPCOMP; }
">="            { printf("Operador de comparação: %s\n", yytext); return T_OPCOMP; }
"<="            { printf("Operador de comparação: %s\n", yytext); return T_OPCOMP; }
"!="            { printf("Operador de comparação: %s\n", yytext); return T_OPCOMP; }
"=="            { printf("Operador de comparação: %s\n", yytext); return T_OPCOMP; }
[+\-*/]         { printf("Operador: %s\n", yytext); return T_OPERATOR; }
"="             { printf("Operador de atribuição: %s\n", yytext); return T_ASSIGN; }
"("             { printf("Parêntese abertura: %s\n", yytext); return T_PAREN; }
")"             { printf("Parêntese fechamento: %s\n", yytext); return T_PAREN; }
";"             { printf("Ponto e vírgula: %s\n", yytext); return T_SEMICOLON; }
"{"             { printf("Chaves abertura: %s\n", yytext); return T_CHAVES; }
"}"             { printf("Chaves fechamento: %s\n", yytext); return T_CHAVES; }

%%

int main() {
    while (yylex() != 0){

    } 
    return 0;
}
