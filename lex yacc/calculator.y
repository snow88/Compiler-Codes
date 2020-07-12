%{
    #include<iostream>
    using namespace std;
    int yylex();
    void yyerror(string);
%}

%union {int i;}                                         
%token <i> NUMBER //PLUS MINUS MULTIPLY DIVIDE EXPONENT
%type <i> E T F
//%left '+' '-'
//%left '*' '/'
//%right '^'                                   

%%

S: E {cout<<"\nAnswer is: "<<$1<<endl;}
;
E: E '+' T {$$ = $1 + $3;}
|
E '-' T {$$ = $1 - $3;}
|
T {$$ = $1;}
;
T: T '*' F {$$ = $1 * $3;}
|
T '/' F {$$ = $1 / $3;}
|
F {$$ = $1;}
;
F: '(' E ')' {$$ = $2;}
|
'-' F {$$ = -$2;}
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
