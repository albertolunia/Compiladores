%{
#include <stdio.h>
#include "codigo.tab.h"
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
"LISTA"                     { printf("Token: %d, Palavra reservada: LISTA\n", T_KEYWORD); return T_KEYWORD; }
"BOOL"                      { printf("Token: %d, Palavra reservada: BOOL\n", T_KEYWORD); return T_KEYWORD; }

"CONST"                     { printf("Token: %d, Palavra reservada: CONST\n", T_KEYWORD); return T_KEYWORD; }

"LER"                       { printf("Token: %d, Palavra reservada: LER\n", T_KEYWORD); return T_KEYWORD; }
"ESCREVER"                  { printf("Token: %d, Palavra reservada: ESCREVER\n", T_KEYWORD); return T_KEYWORD; }

"SE"                        { printf("Token: %d, Palavra reservada: SE\n", T_KEYWORD); return T_KEYWORD; }
"ENTAO"                     { printf("Token: %d, Palavra reservada: ENTAO\n", T_KEYWORD); return T_KEYWORD; }
"SENAO"                     { printf("Token: %d, Palavra reservada: SENAO\n", T_KEYWORD); return T_KEYWORD; }
"ENQUANTO"                  { printf("Token: %d, Palavra reservada: ENQUANTO\n", T_KEYWORD); return T_KEYWORD; }
"FACA"                      { printf("Token: %d, Palavra reservada: FACA\n", T_KEYWORD); return T_KEYWORD; }

"PROGRAMA"                  { printf("Token: %d, Palavra reservada: PROGRAMA\n", T_KEYWORD); return T_KEYWORD; }
"PREX"                      { printf("Token: %d, Palavra reservada: PREX\n", T_KEYWORD); return T_KEYWORD; }

{NUMERO}                    { printf("Token: %d, Número: %s\n", T_NUMBER, yytext); return T_NUMBER; }

{FLOAT}                     { printf("Token: %d, Número float: %s\n", T_FLOAT, yytext); return T_FLOAT; }

{CARACTERE}                 { printf("Token: %d, Caractere: %s\n", T_CHAR, yytext); return T_CHAR; }

"+"                         { printf("Token: %d, Operador aritmético: %s\n", T_OPARIMAIS, yytext); return T_OPARIMAIS; }
"-"                         { printf("Token: %d, Operador aritmético: %s\n", T_OPARIMENOS, yytext); return T_OPARIMENOS; }
"*"                         { printf("Token: %d, Operador aritmético: %s\n", T_OPARIVEZES, yytext); return T_OPARIVEZES; }
"/"                         { printf("Token: %d, Operador aritmético: %s\n", T_OPARIDIVISAO, yytext); return T_OPARIDIVISAO; }

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

"\t"                        { printf("Token: %d, Tabulação: '\\t'\n", T_TAB); return T_TAB; }

" "                         { printf("Token: %d, Espaço: '%s'\n", T_SPACE, yytext); return T_SPACE; }
"\n"                        { printf("Token: %d, Quebra de linha: \\n\n", T_NEWLINE); return T_NEWLINE; }

","                         { printf("Token: %d, Vírgula: %s\n", T_COMMA, yytext); return T_COMMA; }

{VARIAVEL}                 { printf("Token: %d, Variável: %s\n", T_VAR, yytext); return T_VAR; }

{STRING}                    { printf("Token: %d, String: %s\n", T_STRING, yytext); return T_STRING; }

%%

int yywrap(void) {
    return 1;
}
