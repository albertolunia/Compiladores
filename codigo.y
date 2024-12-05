%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yylex(void);
void yyerror(const char *s);
extern char *yytext;
%}

%token T_NUMBER T_VAR T_PARENTESISOPEN T_PARENTESISCLOSE
%token T_ASSIGN T_SEMICOLON T_KEYWORD T_COMMENT T_FLOAT T_CHAR T_OPLOG T_OPREL
%token T_CHAVESOPEN T_CHAVESCLOSE T_TAB T_SPACE T_NEWLINE T_COMMA T_STRING
%token T_OPARIMAIS T_OPARIMENOS T_OPARIVEZES T_OPARIDIVISAO

%%

programa:
    T_KEYWORD T_KEYWORD T_CHAVESOPEN declaracoes comandos T_CHAVESCLOSE
    ;

declaracoes:
    declaracao
    | declaracoes declaracao
    ;

declaracao:
    T_KEYWORD T_VAR T_COMMA T_VAR T_SEMICOLON
    | T_KEYWORD T_VAR T_SEMICOLON
    | T_KEYWORD T_VAR T_PARENTESISOPEN T_NUMBER T_PARENTESISCLOSE T_SEMICOLON
    ;

comandos:
    comando
    | comandos comando
    ;

comando:
    T_KEYWORD T_STRING T_SEMICOLON
    | T_KEYWORD T_VAR T_SEMICOLON
    | T_VAR T_ASSIGN expressao T_SEMICOLON
    ;

expressao:
    T_NUMBER { $$ = atoi(yytext); }
    | T_VAR { $$ = 0; /* Placeholder for variable handling */ }
    | expressao T_OPARIMAIS expressao { $$ = $1 + $3; }
    | expressao T_OPARIMENOS expressao { $$ = $1 - $3; }
    | expressao T_OPARIVEZES expressao { $$ = $1 * $3; }
    | expressao T_OPARIDIVISAO expressao { $$ = $1 / $3; }
    | T_PARENTESISOPEN expressao T_PARENTESISCLOSE { $$ = $2; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erro: %s\n", s);
}

int main(void) {
    return yyparse();
}
