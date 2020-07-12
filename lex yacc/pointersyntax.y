%{
    #include<iostream>
    using namespace std;
    int yylex();
    void yyerror(string);
%}

%token TYPE LOC VALAT IDENTIFIER ASSIGN ARITH

%%
code: dec code
|
stmt code
|

;
dec: TYPE IDENTIFIER eq list ';'
|
TYPE VALAT IDENTIFIER eq list ';'
;
list: ',' IDENTIFIER eq list
|
',' VALAT IDENTIFIER eq list
|

;
eq: ASSIGN IDENTIFIER
|
ASSIGN LOC IDENTIFIER
|

;
stmt: IDENTIFIER ASSIGN IDENTIFIER ARITH IDENTIFIER ';'
|
IDENTIFIER ASSIGN IDENTIFIER VALAT IDENTIFIER ';'
|
VALAT IDENTIFIER ASSIGN IDENTIFIER ARITH IDENTIFIER ';'
|
VALAT IDENTIFIER ASSIGN IDENTIFIER VALAT IDENTIFIER ';'
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
