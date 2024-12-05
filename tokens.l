%{
#include <stdio.h>
#include "bison.tab.h"

%}

VARIAVEL            [A-Za-z][A-Za-z0-9]{0,9}
NUMERO              [0-9][0-9]*
FLOAT               0,[0-9]{1,2}|[+-]?[1-9][0-9]*,[0-9]{1,2}
STRING              \"[^\"]*\"
COMENTARIO          "\\"[^\\"]*\\""
CARACTERE           \'([@_#\+\-*/.: A-Za-z0-9$]|\\n)\'


%%

{COMENTARIO}                { printf("Token: %d, Comentário: %s\n", T_COMMENT, yytext); return T_COMMENT; }

"="                         { printf("Token: %d, Operador de atribuição: %s\n", T_ASSIGN, yytext); return T_ASSIGN; }
";"                         { printf("Token: %d, Fim de instrução: %s\n", T_SEMICOLON, yytext); return T_SEMICOLON; }

"FLOAT"                     { printf("Token: %d, Palavra reservada: FLOAT\n", T_KEYWORD); return T_KEYWORD; }
"CHAR"                      { printf("Token: %d, Palavra reservada: CHAR\n", T_KEYWORD); return T_KEYWORD; }
"BOOL"                      { printf("Token: %d, Palavra reservada: BOOL\n", T_KEYWORD); return T_KEYWORD; }

"LISTA"                     { printf("Token: %d, Palavra reservada: LISTA\n", T_LIST); return T_LIST; }

"CONST"                     { printf("Token: %d, Palavra reservada: CONST\n", T_CONST); return T_CONST; }

"LER"                       { printf("Token: %d, Palavra reservada: LER\n", T_ENTRADA); return T_ENTRADA; }
"ESCREVER"                  { printf("Token: %d, Palavra reservada: ESCREVER\n", T_SAIDA); return T_SAIDA; }

"SE"                        { printf("Token: %d, Palavra reservada: SE\n", T_SE); return T_SE; }
"ENTAO"                     { printf("Token: %d, Palavra reservada: ENTAO\n", T_ENTAO); return T_ENTAO; }
"SENAO"                     { printf("Token: %d, Palavra reservada: SENAO\n", T_SENAO); return T_SENAO; }
"ENQUANTO"                  { printf("Token: %d, Palavra reservada: ENQUANTO\n", T_ENQUANTO); return T_ENQUANTO; }
"FACA"                      { printf("Token: %d, Palavra reservada: FACA\n", T_FACA); return T_FACA; }

"PROGRAMA"                  { printf("Token: %d, Palavra reservada: PROGRAMA\n", T_PROGRAMA); return T_PROGRAMA; }

"PREX"                      { printf("Token: %d, Palavra reservada: PREX\n", T_PREX); return T_PREX; }

{NUMERO}                    { printf("Token: %d, Número: %s\n", T_NUMBER, yytext); return T_NUMBER; }

{FLOAT}                     { printf("Token: %d, Número float: %s\n", T_FLOAT, yytext); return T_FLOAT; }

{CARACTERE}                 { printf("Token: %d, Caractere: %s\n", T_CHAR, yytext); return T_CHAR; }

"+"                         { printf("Token: %d, Operador aritmético: %s\n", T_OPARI, yytext); return T_OPARI; }
"-"                         { printf("Token: %d, Operador aritmético: %s\n", T_OPARI, yytext); return T_OPARI; }
"*"                         { printf("Token: %d, Operador aritmético: %s\n", T_OPARI, yytext); return T_OPARI; }
"/"                         { printf("Token: %d, Operador aritmético: %s\n", T_OPARI, yytext); return T_OPARI; }

"^"                         { printf("Token: %d, Operador lógico: %s\n", T_OPLOG, yytext); return T_OPLOG; }
"|"                         { printf("Token: %d, Operador lógico: %s\n", T_OPLOG, yytext); return T_OPLOG; }
"~"                         { printf("Token: %d, Operador lógico: %s\n", T_OPLOG, yytext); return T_OPLOG; }

">"                         { printf("Token: %d, Operador de comparação: %s\n", T_OPREL, yytext); return T_OPREL; }
"<"                         { printf("Token: %d, Operador de comparação: %s\n", T_OPREL, yytext); return T_OPREL; }
"=="                        { printf("Token: %d, Operador de comparação: %s\n", T_OPREL, yytext); return T_OPREL; }
"~="                        { printf("Token: %d, Operador de comparação: %s\n", T_OPREL, yytext); return T_OPREL; }

"{"                         { printf("Token: %d, Chave abertura: %s\n", T_CHAVESOPEN, yytext); return T_CHAVESOPEN; }
"}"                         { printf("Token: %d, Chave fechamento: %s\n", T_CHAVESCLOSE, yytext); return T_CHAVESCLOSE; }

"("                         { printf("Token: %d, Parêntese abertura: %s\n", T_PARENTESISOPEN, yytext); return T_PARENTESISOPEN; }
")"                         { printf("Token: %d, Parêntese fechamento: %s\n", T_PARENTESISCLOSE, yytext); return T_PARENTESISCLOSE; }

","                         { printf("Token: %d, Vírgula: %s\n", T_COMMA, yytext); return T_COMMA; }

{VARIAVEL}                  { printf("Token: %d, Variável: %s\n", T_VAR, yytext); return T_VAR; }

{STRING}                    { printf("Token: %d, String: %s\n", T_STRING, yytext); return T_STRING; }

[ \t\n\r]+                  { /* Ignora espaços, tabulações e quebras de linha */ }

.                           { printf("Caractere não reconhecido: '%s'\n", yytext); return -1; }


%%

int yywrap(void) {
    return 1;
}
