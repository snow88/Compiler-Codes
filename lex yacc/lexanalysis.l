%{
    #include<iostream>
    #include<stdio.h>
    #include<vector>
    #include<string>
    using namespace std;
    vector<pair<int,pair<string,string> > > symboltable;
    int idx = 0;
%}

identifier [a-zA-Z][a-zA-Z0-9]*
number [0-9]+
literal \"[ a-zA-Z0-9]*\"

%%

int |
endl |
include |
h |
using |
namespace |
std |
float |
char |
double |
while |
for |
struct |
typedef |
do |
if |
break |
continue |
void |
switch |
return |
else |
goto {
        cout<<"<"<<yytext<<">"<<endl;
     }

= {
    cout<<"<assignop,"<<yytext<<">"<<endl;
  }

"+" | 
"-" | 
"*" | 
"/" {
    cout<<"<arithmeticop,"<<yytext<<">"<<endl;
  }

"<<" |
">>" {
        cout<<"<cascadeop,"<<yytext<<">"<<endl;
     }

"<=" |
">=" |
"!=" |
"<" |
"==" |
">" {
    cout<<"<relationalop,"<<yytext<<">"<<endl;
  }

"{" |
"}" |
"(" |
")" |
"," |
";" |
"#" |
"." {
      cout<<"<punctuator,"<<yytext<<">"<<endl;
    }

{identifier} {
                int i = -1;
                for (auto v : symboltable)
                {
                    string val = v.second.second;
                    if (val == yytext)
                    {
                        i = v.first;
                        break;
                    }
                }
                if (i != -1)
                {
                    cout<<"<identifier,"<<i<<">"<<endl;
                }
                else
                {
                    idx++;
                    cout<<"<identifier,"<<idx<<">"<<endl;
                    symboltable.push_back(make_pair(idx,make_pair("identifier",yytext)));
                }
             }                                                              

{number} {
                int i = -1;
                for (auto v : symboltable)
                {
                    string val = v.second.second;
                    if (val == yytext)
                    {
                        i = v.first;
                        break;
                    }
                }
                if (i != -1)
                {
                    cout<<"<constant,"<<i<<">"<<endl;
                }
                else
                {
                    idx++;
                    cout<<"<constant,"<<idx<<">"<<endl;
                    symboltable.push_back(make_pair(idx,make_pair("constant",yytext)));
                }
       }

{literal} {
                int i = -1;
                for (auto v : symboltable)
                {
                    string val = v.second.second;
                    if (val == yytext)
                    {
                        i = v.first;
                        break;
                    }
                }
                if (i != -1)
                {
                    cout<<"<literal,"<<i<<">"<<endl;
                }
                else
                {
                    idx++;
                    cout<<"<literal,"<<idx<<">"<<endl;                                    
                    symboltable.push_back(make_pair(idx,make_pair("literal",yytext)));
                }
          }
    
[ \n\t]+ |
"//"[ a-zA-Z0-9]*\n {                                                              
                       ;  //ignore whitespaces and comments
                    }

%%

int main()
{
    FILE *fin;
    fin = fopen("lexinput.txt","r");
    yyin = fin;

    yylex();
    cout<<endl;
    cout<<"SYMBOL TABLE generated:"<<endl;
    for (auto v : symboltable)
    {
        cout<<v.first<<"\t";
        cout<<v.second.first<<"\t";
        cout<<v.second.second<<"\t";
        cout<<endl;
    }
    return 0;
}

int yywrap()
{
    return 1;
}
