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

%right T_SEMICOLON

%start programa

%%

programa: T_PROGRAMA T_PREX T_CHAVESOPEN lista_constantes lista_variaveis bloco_codigos T_CHAVESCLOSE
    | T_PROGRAMA T_PREX T_CHAVESOPEN lista_variaveis bloco_codigos T_CHAVESCLOSE
    ;

lista_constantes: constante
    | lista_constantes constante
    ;

constante: T_CONST T_KEYWORD T_VAR T_FLOAT T_SEMICOLON
    | T_CONST T_KEYWORD T_VAR T_STRING T_SEMICOLON
    | T_CONST T_KEYWORD T_VAR T_CHAR T_SEMICOLON
    ;

lista_variaveis: variavel
    | lista_variaveis variavel
    ;

variavel: T_KEYWORD T_VAR T_SEMICOLON
    | T_KEYWORD T_VAR T_ASSIGN T_FLOAT T_SEMICOLON
    | T_KEYWORD T_VAR T_ASSIGN T_STRING T_SEMICOLON
    | T_KEYWORD T_VAR T_ASSIGN T_CHAR T_SEMICOLON
    | T_LIST T_KEYWORD T_VAR T_PARENTESISOPEN T_NUMBER T_PARENTESISCLOSE T_SEMICOLON
    | T_KEYWORD T_VAR T_COMMA variavel
    ;

bloco_codigos: codigo
    | bloco_codigos codigo
    ;

codigo: T_VAR T_ASSIGN T_FLOAT T_SEMICOLON
    | T_VAR T_ASSIGN T_STRING T_SEMICOLON
    | T_VAR T_ASSIGN T_CHAR T_SEMICOLON
    | T_ENTRADA T_VAR T_SEMICOLON
    | T_SAIDA T_VAR T_SEMICOLON
    | T_VAR T_ASSIGN T_OPARI T_VAR T_VAR T_SEMICOLON
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
