/* simplest version of calculator */
%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
%}

%union{
    char * sval;
    int int_type;
}

/* declare tokens */
%token <sval> STRING
%token <int_type> NUMBER

%token ADD SUB MUL DIV ABS
%token EOL
%token OP CP

%type <int_type> exp factor term

%start calclist

%%
calclist: /* nothing */ 
 | calclist exp EOL { printf("= %d\n", $2); } 
 ;
exp: factor 
 | exp ADD factor { $$ = $1 + $3; }
 | exp SUB factor { $$ = $1 - $3; }
 ;
factor: term 
 | factor MUL term { $$ = $1 * $3; }
 | factor DIV term { $$ = $1 / $3; }
 ;
term: NUMBER 
 | STRING {
          int len = strlen($1)-1;
          $1[len] = '\0';
          $$ = atoi(&$1[1]);
 }
 | ABS term { $$ = $2 >= 0? $2 : - $2; }
 | OP exp CP { $$ = $2; }
;
%%
int
main(int argc, char **argv)
{
 yyparse();
}

int
yyerror(char *s)
{
 fprintf(stderr, "error: %s\n", s);
}
