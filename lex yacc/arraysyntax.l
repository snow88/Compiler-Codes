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

"=" return ASSIGN;

"+" |
"-" |
"*" |
"/" return OP;

"[" |
"]" |
"," |
";" return yytext[0];

[0-9]+ return NUMBER;

[a-zA-Z][a-zA-Z0-9]* return IDENTIFIER;

[ \n\t]* { ; } 

%%

int yywrap()
{
    return 1;
}
