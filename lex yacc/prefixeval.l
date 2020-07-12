%{
    #include<iostream>
    using namespace std;
    #include "y.tab.h"
%}

%%

[0-9]+ { 
        yylval.i = stoi(yytext);
        return NUMBER;
       }
[+\-*/] return yytext[0];
[ \n\t]* ;                                 

%%

int yywrap()
{
    return 1;
}


