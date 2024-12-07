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

%union {
    char *str;
}

%type <str> T_VAR lista_entradas lista_saidas T_FLOAT sequencia valor chars T_STRING T_NUMBER T_CHAR

%start programa

%%

programa: T_PROGRAMA T_PREX T_CHAVESOPEN declara_constantes declara_variaveis bloco_codigos T_CHAVESCLOSE
    | T_PROGRAMA T_PREX T_CHAVESOPEN declara_variaveis bloco_codigos T_CHAVESCLOSE
    | T_PROGRAMA T_PREX T_CHAVESOPEN declara_constantes bloco_codigos T_CHAVESCLOSE
    | T_PROGRAMA T_PREX T_CHAVESOPEN bloco_codigos T_CHAVESCLOSE
    | T_PROGRAMA T_PREX T_CHAVESOPEN declara_constantes declara_variaveis T_CHAVESCLOSE
    | T_PROGRAMA T_PREX T_CHAVESOPEN declara_variaveis T_CHAVESCLOSE
    | T_PROGRAMA T_PREX T_CHAVESOPEN declara_constantes T_CHAVESCLOSE
    | T_PROGRAMA T_PREX T_CHAVESOPEN T_CHAVESCLOSE
    ;

declara_constantes: constante
    | declara_constantes constante
    ;

constante: T_CONST T_KEYWORD T_VAR valor T_SEMICOLON
    ;

valor: T_FLOAT
    | T_STRING
    | T_NUMBER
    | chars
    ;

chars: T_CHAR
    | chars T_CHAR
    ;

declara_variaveis: variavel
    | declara_variaveis variavel
    ;

variavel: declara_variavel
    | lista
    ;

declara_variavel: T_KEYWORD declara_lista T_SEMICOLON
    ;

declara_lista: T_VAR
    | declara_lista T_COMMA T_VAR
    ;

lista: T_LIST T_KEYWORD lista_listas T_SEMICOLON
     ;

lista_listas: T_VAR T_PARENTESISOPEN T_NUMBER T_PARENTESISCLOSE
               | lista_listas T_COMMA T_VAR T_PARENTESISOPEN T_NUMBER T_PARENTESISCLOSE
               ;

bloco_codigos: codigo
    | bloco_codigos codigo
    ;

codigo: T_VAR T_ASSIGN valor T_SEMICOLON { printf("%s = %s", $1, $3); }
    | entrada
    | saida
    | T_VAR T_ASSIGN T_OPARI sequencia T_SEMICOLON
    ;

sequencia: T_FLOAT { printf(" %s", $1); }
    | sequencia T_FLOAT { printf(" %s", $2); }
    | T_VAR { printf(" %s", $1); }
    | sequencia T_VAR { printf(" %s", $1); }
    | sequencia T_OPARI { printf(" %s", $1); }
    ;

entrada: T_ENTRADA lista_entradas T_SEMICOLON {printf("scanf(\"%%f\", &%s)", $2);}
    ;

lista_entradas: T_VAR { $$ = $1; }
    | lista_entradas T_COMMA T_VAR { $$ = $3; }
    ;

saida: T_SAIDA lista_saidas T_SEMICOLON { printf("printf(\"%%f\", %s)", $2); }
    ;

lista_saidas: T_VAR T_PARENTESISOPEN T_NUMBER T_PARENTESISCLOSE
    | T_VAR T_PARENTESISOPEN T_NUMBER T_COMMA T_NUMBER T_PARENTESISCLOSE
    | T_VAR { $$ = $1; }
    | lista_saidas T_COMMA T_VAR { $$ = $3; }
    ;

%%

void yyerror(const char *msg) {
    extern char *yytext;
    printf("ERRO: %s (Token não reconhecido: %s)\n", msg, yytext);
}

int main() {
    printf("#include <stdio.h>\n#include <stdlib.h>\n#include <string.h>\n\n");
    yyparse();
    return 0;
}
