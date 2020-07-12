%{
    #include<iostream>
    using namespace std;
    #include "y.tab.h"
%}

%%

int |
float |
char |
double return TYPE;

"*" return VALAT;
"+" |
"-" |
"/" return ARITH;

"&" return LOC;

"=" return ASSIGN;

";" |
"," return yytext[0];

[a-zA-Z][a-zA-Z0-9]* return IDENTIFIER;

[ \n\t]* { ; }

%%

int yywrap()
{
    return 1;
}
