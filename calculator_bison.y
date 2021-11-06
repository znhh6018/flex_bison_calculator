/* simplest version of calculator */
%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
%}

%union{
    char * sval;
    int intType;
}

/* declare tokens */
%token <sval> STRING
%token <intType> NUMBER

%token ADD SUB MUL DIV ABS
%token EOL
%token OP CP
%token SQ

%type <intType> exp factor term

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
 | SUB NUMBER { $$ = -$2; }
 | ABS exp ABS { $$ = $2 >= 0? $2 : - $2; }
 | OP exp CP { $$ = $2; }
 | SQ exp SQ { $$ = $2; }
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
