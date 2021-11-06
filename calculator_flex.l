%{
    #include "calculator_bison.tab.h"
    YYSTYPE yylval;
%}
%%
"+" {return ADD;}
"-" {return SUB;}
"*" {return MUL;}
"/" {return DIV;}
"|" {return ABS;}
"(" {return OP;}
")" {return CP;}
\'[0-9]+\' {yylval.sval = strdup(yytext); return STRING;} 
"//".* /* ignore comments */
[0-9]+ {yylval.int_type = atoi(yytext); return NUMBER;}
\n {return EOL;}
[ \t] { /* ignore whitespace */ }
. { printf("Mystery character %c\n", *yytext); }
%%