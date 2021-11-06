#!/bin/bash

bison -d calculator_bison.y
flex calculator_flex.l
gcc -o myCalcultor  calculator_bison.tab.c lex.yy.c -lfl
