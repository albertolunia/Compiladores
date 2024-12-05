%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yylex(void);
int yyparse(void);
void yyerror(const char *s);
#define YYDEBUG 1
%}

%token T_PROGRAMA T_PREX T_CHAVESOPEN T_CHAVESCLOSE

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
    yydebug = 1;
    yyparse();
    return 0;
}
