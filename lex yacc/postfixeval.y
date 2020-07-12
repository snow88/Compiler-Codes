%{
    #include<iostream>
    using namespace std;
    int yylex();
    void yyerror(string);
%}

%union {int i;}
%token <i> NUMBER
%type <i> E

%%

S: E {cout<<"\nAnswer is: "<<$1<<endl;}
;
E: E E '+' {$$ = $1 + $2;}           
|
E E '-'  {$$ = $1 - $2;}
|
E E '*' {$$ = $1 * $2;}
|
E E '/' {$$ = $1 / $2;}
|
NUMBER {$$ = $1;}
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



