%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yylex(void);
int yyparse(void);
void yyerror(const char *s);
#define YYDEBUG 1
%}

%token <str> T_VAR T_FLOAT T_CHAR T_STRING T_OPARI

%token T_ASSIGN T_SEMICOLON T_KEYWORD T_ENTRADA T_SAIDA T_PROGRAMA T_PREX
%token T_CHAVESOPEN T_CHAVESCLOSE T_PARENTESISOPEN T_PARENTESISCLOSE T_COMMA

%union {
    char *str;
}

%type <str> valor varias_variaveis sequencia

%start programa

%%

programa: T_PROGRAMA T_PREX T_CHAVESOPEN declara_variaveis bloco_codigos T_CHAVESCLOSE
    | T_PROGRAMA T_PREX T_CHAVESOPEN bloco_codigos T_CHAVESCLOSE
    | T_PROGRAMA T_PREX T_CHAVESOPEN declara_variaveis T_CHAVESCLOSE 
    | T_PROGRAMA T_PREX T_CHAVESOPEN T_CHAVESCLOSE
    ;

declara_variaveis: variavel
    | declara_variaveis variavel
    ;

variavel: T_KEYWORD varias_variaveis T_SEMICOLON
    ;

varias_variaveis: T_VAR { printf("%s", $1); }
    | varias_variaveis T_COMMA T_VAR { printf("%s", $3); }
    ;

bloco_codigos: codigo
    | bloco_codigos codigo
    ;

codigo: T_VAR T_ASSIGN valor T_SEMICOLON { printf("%s", $1); }
    | T_VAR T_ASSIGN T_OPARI sequencia T_SEMICOLON
    | entrada
    | saida
    ;

sequencia: T_VAR
    | T_FLOAT
    | sequencia T_FLOAT
    | sequencia T_VAR
    | sequencia T_OPARI
    ;

entrada: T_ENTRADA lista_entradas T_SEMICOLON
    ;

lista_entradas: T_VAR {printf("scanf(\"%%f\", &%s)", $1);}
    | lista_entradas T_COMMA T_VAR
    ;

saida: T_SAIDA lista_saidas T_SEMICOLON
    ;

lista_saidas: T_VAR { printf("printf(\"%%f\", %s)", $1); }
    | lista_saidas T_COMMA T_VAR
    ;

valor: T_FLOAT
    | T_STRING
    ;

%%

void yyerror(const char *msg) {
    extern char *yytext;
    printf("ERRO: %s (Token não reconhecido: %s)\n", msg, yytext);
}

int main() {
    // yydebug = 1;
    printf("#include <stdio.h>\n#include <stdlib.h>\n#include <string.h>\n\n");
    yyparse();
    return 0;
}
