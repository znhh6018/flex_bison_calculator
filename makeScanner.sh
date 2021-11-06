#!/bin/bash
flex calculator_flex.l
gcc -o scanner lex.yy.c  -lfl