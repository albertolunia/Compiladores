
%{
#include <stdio.h>
#include "tokens.h"

int yywrap(void) {
    return 1;
}
%}

VARIAVEL            [A-Za-z][A-Za-z0-9]{0,9}
NUMERO              [0-9]

%%

"\\"[^\"]*\\""            { printf("Comentário: %s\n", yytext); return T_COMMENT; }

"="                         { printf("Operador de atribuição: %s\n", yytext); return T_ASSIGN; }
";"                         { printf("Fim de instrução: %s\n", yytext); return T_SEMICOLON; }



"FLOAT"                     { printf("Palavra reservada: FLOAT\n"); return T_KEYWORD; }
"CHAR"                      { printf("Palavra reservada: CHAR\n"); return T_KEYWORD; }
"LISTA"                     { printf("Palavra reservada: LISTA\n"); return T_KEYWORD; }
"BOOL"                      { printf("Palavra reservada: BOOL\n"); return T_KEYWORD; }

"CONST"                     { printf("Palavra reservada: CONST\n"); return T_KEYWORD; }

"LER"                       { printf("Palavra reservada: LER\n"); return T_KEYWORD; }
"ESCREVER"                  { printf("Palavra reservada: ESCREVER\n"); return T_KEYWORD; }

"SE"                        { printf("Palavra reservada: SE\n"); return T_KEYWORD; }
"ENTAO"                     { printf("Palavra reservada: ENTAO\n"); return T_KEYWORD; }
"SENAO"                     { printf("Palavra reservada: SENAO\n"); return T_KEYWORD; }
"ENQUANTO"                  { printf("Palavra reservada: ENQUANTO\n"); return T_KEYWORD; }
"FACA"                      { printf("Palavra reservada: FACA\n"); return T_KEYWORD; }

{NUMERO}                    { printf("Numero: %s\n", yytext); return T_FLOAT; }

'[@_#\+\-*/.: A-Za-z0-9]'   { printf("Caractere: %s\n", yytext); return T_CHAR; }
'$'                         { printf("Fim da lista: %s\n", yytext); return T_CHAR; }

"+"                         { printf("Operador aritmético: %s\n", yytext); return T_OPARI; }
"-"                         { printf("Operador aritmético: %s\n", yytext); return T_OPARI; }
"*"                         { printf("Operador aritmético: %s\n", yytext); return T_OPARI; }
"/"                         { printf("Operador aritmético: %s\n", yytext); return T_OPARI; }

"^"                         { printf("Operador lógico: %s\n", yytext); return T_OPLOG; }
"|"                         { printf("Operador lógico: %s\n", yytext); return T_OPLOG; }
"~"                         { printf("Operador lógico: %s\n", yytext); return T_OPLOG; }

">"                         { printf("Operador de comparação: %s\n", yytext); return T_OPREL; }
"<"                         { printf("Operador de comparação: %s\n", yytext); return T_OPREL; }
"=="                        { printf("Operador de comparação: %s\n", yytext); return T_OPREL; }
"~="                        { printf("Operador de comparação: %s\n", yytext); return T_OPREL; }

"{"                         { printf("Chaves abertura: %s\n", yytext); return T_CHAVES; }
"}"                         { printf("Chaves fechamento: %s\n", yytext); return T_CHAVES; }

"("                         { printf("Parênteses abertura: %s\n", yytext); return T_PARENTESIS; }
")"                         { printf("Parênteses fechamento: %s\n", yytext); return T_PARENTESIS; }

"\t"                       { printf("Tabulação: '\\t'\n"); return T_TAB; }

" "                         { printf("Espaço: '%s'\n", yytext); return T_SPACE; }
"\n"                        { printf("Quebra de linha: \\n\n"); return T_NEWLINE; }

","                         { printf("Vírgula: %s\n", yytext); return T_COMMA; }

"PROGRAMA"                  { printf("Palavra reservada: PROGRAMA\n"); return T_KEYWORD; }
"PREX"                      { printf("Palavra reservada: PREX\n"); return T_KEYWORD; }

{VARIAVEL}+                 { printf("Variável: %s\n", yytext); return T_VAR; }

\"[^\"]*\"                  { printf("String: %s\n", yytext); return T_STRING; }


%%

int main() {
    while (yylex() != 0){

    } 
    return 0;
}
