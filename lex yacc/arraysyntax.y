%{
    #include<iostream>
    using namespace std;
    int yylex();
    void yyerror(string);
%}

%token TYPE IDENTIFIER NUMBER ASSIGN OP

%%
code: dec code
|
stmt code
|

;
dec: TYPE IDENTIFIER list ';'
|
TYPE ar list ';'
;
list: ',' IDENTIFIER list
| 
',' ar list
|

;
ar: IDENTIFIER '[' NUMBER ']' dim
;
dim: '[' NUMBER ']' dim
|

;
stmt: var ASSIGN var OP var ';'
;
var: IDENTIFIER
|
ar
;

%%

int main()
{
    yyparse();
    return 0;
}

void yyerror(string s)
{
    cout<<"error: "<<s<<endl;
}

