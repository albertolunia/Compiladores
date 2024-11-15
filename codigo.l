%{
#include <stdio.h>

int yywrap(void) {
    return 1;
}
%}

VARIAVEL            [A-Za-z][A-Za-z0-9]{0,9}
NUMERO              [0-9]
STRING              \"[^\"]*\"

%%

"\\"[^\\"]*\\""             { printf("Comentário: %s\n", yytext); }

"="                         { printf("Operador de atribuição: %s\n", yytext); }
";"                         { printf("Fim de instrução: %s\n", yytext); }

"FLOAT"                     { printf("Palavra reservada: FLOAT\n"); }
"CHAR"                      { printf("Palavra reservada: CHAR\n"); }
"LISTA"                     { printf("Palavra reservada: LISTA\n"); }
"BOOL"                      { printf("Palavra reservada: BOOL\n"); }

"CONST"                     { printf("Palavra reservada: CONST\n"); }

"LER"                       { printf("Palavra reservada: LER\n"); }
"ESCREVER"                  { printf("Palavra reservada: ESCREVER\n"); }

"SE"                        { printf("Palavra reservada: SE\n"); }
"ENTAO"                     { printf("Palavra reservada: ENTAO\n"); }
"SENAO"                     { printf("Palavra reservada: SENAO\n"); }
"ENQUANTO"                  { printf("Palavra reservada: ENQUANTO\n"); }
"FACA"                      { printf("Palavra reservada: FACA\n"); }

"PROGRAMA"                  { printf("Palavra reservada: PROGRAMA\n"); }
"PREX"                      { printf("Palavra reservada: PREX\n"); }

{NUMERO}                    { printf("Numero: %s\n", yytext); }

'[@_#\+\-*/.: A-Za-z0-9]'   { printf("Caractere: %s\n", yytext); }
'$'                         { printf("Fim da lista: %s\n", yytext); }

"+"                         { printf("Operador aritmético: %s\n", yytext); }
"-"                         { printf("Operador aritmético: %s\n", yytext); }
"*"                         { printf("Operador aritmético: %s\n", yytext); }
"/"                         { printf("Operador aritmético: %s\n", yytext); }

"^"                         { printf("Operador lógico: %s\n", yytext); }
"|"                         { printf("Operador lógico: %s\n", yytext); }
"~"                         { printf("Operador lógico: %s\n", yytext); }

">"                         { printf("Operador de comparação: %s\n", yytext); }
"<"                         { printf("Operador de comparação: %s\n", yytext); }
"=="                        { printf("Operador de comparação: %s\n", yytext); }
"~="                        { printf("Operador de comparação: %s\n", yytext); }

"{"                         { printf("Chaves abertura: %s\n", yytext); }
"}"                         { printf("Chaves fechamento: %s\n", yytext); }

"("                         { printf("Parênteses abertura: %s\n", yytext); }
")"                         { printf("Parênteses fechamento: %s\n", yytext); }

"\t"                       { printf("Tabulação: '\\t'\n"); }

" "                         { printf("Espaço: '%s'\n", yytext); }
"\n"                        { printf("Quebra de linha: \\n\n"); }

","                         { printf("Vírgula: %s\n", yytext); }

{VARIAVEL}+                 { printf("Variável: %s\n", yytext); }

{STRING}                    { printf("String: %s\n", yytext); }

%%

int main() {
    while (yylex() != 0){

    } 
    return 0;
}
