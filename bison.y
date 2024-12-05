%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yylex(void);
int yyparse(void);
void yyerror(const char *s);
#define YYDEBUG 1
%}

%token T_COMMENT T_ASSIGN T_SEMICOLON T_KEYWORD T_LIST T_CONST T_ENTRADA T_SAIDA T_SE T_ENTAO T_SENAO T_ENQUANTO T_FACA T_PROGRAMA T_PREX T_NUMBER T_FLOAT T_CHAR T_OPARI T_OPLOG T_OPREL
%token T_CHAVESOPEN T_CHAVESCLOSE T_PARENTESISOPEN T_PARENTESISCLOSE T_COMMA T_VAR T_STRING

%start programa

%%

programa: T_PROGRAMA T_PREX T_CHAVESOPEN T_CHAVESCLOSE
    ;

%%

void yyerror(const char *msg) {
    extern char *yytext;
    printf("ERRO: %s (Token não reconhecido: %s)\n", msg, yytext);
}

int main() {
    yyparse();
    return 0;
}
