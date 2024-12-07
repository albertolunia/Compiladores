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

"="                         { printf(" = "); return T_ASSIGN; }
";"                         { printf(";\n\t"); return T_SEMICOLON; }

"FLOAT"                     { printf("float "); return T_KEYWORD; }
"CHAR"                      { printf("char "); return T_KEYWORD; }
"BOOL"                      { printf("bool "); return T_KEYWORD; }

"LISTA"                     { return T_LIST; }

"CONST"                     { printf("#define"); return T_CONST; }

"LER"                       { return T_ENTRADA; }
"ESCREVER"                  { return T_SAIDA; }

"SE"                        { printf("Token: %d, Palavra reservada: SE\n", T_SE); return T_SE; }
"ENTAO"                     { printf("Token: %d, Palavra reservada: ENTAO\n", T_ENTAO); return T_ENTAO; }
"SENAO"                     { printf("Token: %d, Palavra reservada: SENAO\n", T_SENAO); return T_SENAO; }
"ENQUANTO"                  { printf("Token: %d, Palavra reservada: ENQUANTO\n", T_ENQUANTO); return T_ENQUANTO; }
"FACA"                      { printf("Token: %d, Palavra reservada: FACA\n", T_FACA); return T_FACA; }

"PROGRAMA"                  { printf("int "); return T_PROGRAMA; }

"PREX"                      { printf("main() "); return T_PREX; }

{NUMERO}                    { printf("%s", yytext); return T_NUMBER; }

{FLOAT}                     { printf("%s", yytext); return T_FLOAT; }

{CARACTERE}                 { printf("%s", yytext); return T_CHAR; }

"+"                         { printf("+"); return T_OPARI; }
"-"                         { printf("-"); return T_OPARI; }
"*"                         { printf("*"); return T_OPARI; }
"/"                         { printf("/"); return T_OPARI; }

"^"                         { printf("Token: %d, Operador lógico: %s\n", T_OPLOG, yytext); return T_OPLOG; }
"|"                         { printf("Token: %d, Operador lógico: %s\n", T_OPLOG, yytext); return T_OPLOG; }
"~"                         { printf("Token: %d, Operador lógico: %s\n", T_OPLOG, yytext); return T_OPLOG; }

">"                         { printf("Token: %d, Operador de comparação: %s\n", T_OPREL, yytext); return T_OPREL; }
"<"                         { printf("Token: %d, Operador de comparação: %s\n", T_OPREL, yytext); return T_OPREL; }
"=="                        { printf("Token: %d, Operador de comparação: %s\n", T_OPREL, yytext); return T_OPREL; }
"~="                        { printf("Token: %d, Operador de comparação: %s\n", T_OPREL, yytext); return T_OPREL; }

"{"                         { printf("{\n\t"); return T_CHAVESOPEN; }
"}"                         { printf("\n\treturn 0;\n}\n"); return T_CHAVESCLOSE; }

"("                         { printf("("); return T_PARENTESISOPEN; }
")"                         { printf(")"); return T_PARENTESISCLOSE; }

","                         { printf(", "); return T_COMMA; }

{VARIAVEL}                  { yylval.str = strdup(yytext);
                              printf("%s", yytext); 
                              return T_VAR; 
                            }

{STRING}                    { printf("%s", yytext); return T_STRING; }

[ \t\n\r]+                  { /* Ignora espaços, tabulações e quebras de linha */ }

.                           { printf("Caractere não reconhecido: '%s'\n", yytext); return -1; }


%%

int yywrap(void) {
    return 1;
}
