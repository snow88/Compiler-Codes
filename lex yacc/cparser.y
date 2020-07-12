%{
    #include<iostream>
    using namespace std;
    int yylex();
    void yyerror(string);

%}

%token IDENTIFIER NUMBER LITERAL ASSIGN RELOP CASCOP ENDL DO FOR WHILE RETURN CONTINUE BREAK SWITCH ELSE IF STD NAMESPACE USING H INCLUDE TYPE

%%

prog: header func { cout<<"The program is syntactically correct."<<endl; exit(0); }
;

header: '#' INCLUDE '<' IDENTIFIER '.' H '>' header
|
USING NAMESPACE STD ';'
|
 
;

func: TYPE IDENTIFIER '(' ')' '{' code '}'
;
code: declare code
|
stmt code
|
io code
|

;

declare: TYPE var init list
;
list: ';'
|
',' var init list
;
init: ASSIGN NUMBER
|
ASSIGN var
|

;

stmt: compstmt
|
forstmt
|
whilestmt
|
ifstmt
;
compstmt: var ASSIGN  term compstmt
|
arithop term compstmt
|
';'
;
forstmt: FOR '(' TYPE IDENTIFIER ASSIGN TERM ';' cond ';' compstmt ')' '{' code '}'
;
whilestmt: WHILE '(' cond ')' '{' code '}'
;
cond: term RELOP term nlist         
;
nlist: '&' '&' cond
|
'|' '|' cond
|

;
term: var
|
NUMBER
;
ifstmt: IF '(' cond ')' '{' code '}'
|
IF cond '{' code '}' ELSE '{' code '}'
;

io: IDENTIFIER CASCOP LITERAL clist
|
IDENTIFIER CASCOP var clist
;
clist: ';'
|
CASCOP LITERAL clist
|
CASCOP var clist
;

var: IDENTIFIER
|
ar
|
ptr
;
ar: IDENTIFIER '[' idx ']' dim
;
idx: NUMBER
|
IDENTIFIER
;
dim: '[' idx ']' dim
|

;
ptr: '*' IDENTIFIER
|
'&' IDENTIFIER
;

arithop: '+'
|
'-'
|
'*'
|
'/'
|
'%'
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
