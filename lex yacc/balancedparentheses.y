%{
    #include<iostream>
    using namespace std;
    int yylex();
    void yyerror(string);
%}

%%
S: S S
|
'(' S ')'
|

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
