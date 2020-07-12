%{
    #include<iostream>
    using namespace std;
    #include "y.tab.h"
%}

%%

void |
int |
float |
char |
double return TYPE;


include return INCLUDE;
h return H;
using return USING;
namespace return NAMESPACE;
std return STD;

if return IF;
else return ELSE;
switch return SWITCH;
break return BREAK;
continue return CONTINUE;
return return RETURN;

while return WHILE;
for return FOR;
do return DO;

endl return ENDL;

"<<" |
">>" return CASCOP;

"<=" |
">=" |
"!=" |
"==" return RELOP;

"=" return ASSIGN;

"+" | 
"-" | 
"*" | 
"/" |
"%" |
"<" |
">" |
"{" |
"}" |
"(" |
")" |
"[" |
"]" |
"," |
";" |
"#" |
"&" |
"|" |
"." return yytext[0];          

[a-zA-Z][a-zA-Z0-9]* return IDENTIFIER;
[0-9]+ return NUMBER;
\"[a-z0-9A-Z]*\" return LITERAL;

[ \n\t]* |
"//"[a-zA-Z0-9]*\n { ; }

%%

int yywrap()
{
    return 1;
}


