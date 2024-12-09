%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yylex(void);
int yyparse(void);
void yyerror(const char *s);
#define YYDEBUG 1

FILE *output_file;

%}

%token <str> T_VAR T_FLOAT T_CHAR T_STRING T_OPARI T_ASSIGN T_SEMICOLON T_ENTRADA T_SAIDA

%token T_KEYWORD T_PROGRAMA T_PREX
%token T_CHAVESOPEN T_CHAVESCLOSE T_PARENTESISOPEN T_PARENTESISCLOSE T_COMMA

%union {
    char *str;
}

%type <str> varias_variaveis expressao codigo entrada saida operandos

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

variavel: T_KEYWORD varias_variaveis T_SEMICOLON { fprintf(output_file, ";\n"); }
    ;

varias_variaveis: T_VAR{ fprintf(output_file, "%s", $1); }
    | varias_variaveis T_COMMA T_VAR { fprintf(output_file, ", %s", $3); }
    ;

bloco_codigos: codigo
    | entradaSaida
    | bloco_codigos codigo
    | bloco_codigos entradaSaida
    ;

codigo: T_VAR T_ASSIGN expressao T_SEMICOLON { fprintf(output_file, "\t%s = %s;\n", $1, $3); $$ = strdup($3); }
    ;

entradaSaida: entrada
    | saida
    ;

expressao: operandos {
        $$ = strdup($1);
    }
    | T_OPARI operandos expressao {
        char temp[100];
        sprintf(temp, "%s %s %s", $2, $1, $3);
        $$ = strdup(temp);
    }
    | operandos expressao {
        char temp[100];
        sprintf(temp, "%s %s", $1, $2);
        $$ = strdup(temp);
    }
    ;

operandos: T_VAR { $$ = strdup($1); }
    | T_FLOAT { $$ = strdup($1); }
    ;

entrada: T_ENTRADA lista_entradas T_SEMICOLON
    ;

lista_entradas: T_VAR {fprintf(output_file, "\tscanf(\"%%f\", &%s);\n", $1);}
    | lista_entradas T_VAR {fprintf(output_file, "\tscanf(\"%%f\", &%s);\n", $2);}
    ;

saida: T_SAIDA lista_saidas T_SEMICOLON
    ;

lista_saidas: T_VAR {fprintf(output_file, "\tprintf(\"%%f\\n\", %s);\n", $1); }
    | lista_saidas T_VAR {fprintf(output_file, "\tprintf(\"%%f\\n\", %s);\n", $2); }
    ;

%%

void yyerror(const char *msg) {
    extern char *yytext;
    printf("ERRO: %s (Token não reconhecido: %s)\n", msg, yytext);
}

int main() {
    // yydebug = 1;
    output_file = fopen("output.c", "w");
    if (!output_file) {
        perror("Não foi possível abrir o arquivo de saída");
        return 1;
    }
    fprintf(output_file, "#include <stdio.h>\n\n");
    yyparse();
    fclose(output_file);
    return 0;
}
