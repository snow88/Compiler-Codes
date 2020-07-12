%{
    #include<iostream>
    using namespace std;

    int vowels = 0;
    int consonents = 0;
%}

%%

[aeiou] { vowels++;
        }
[bcdfghjklmnpqrstvwxyz] { consonents++;
                        }
[ \t\n] { ;
        } 
%%

int main()
{
    yylex();
    cout<<"No. of vowels: "<<vowels<<endl;
    cout<<"No. of consonents: "<<consonents<<endl;
    return 0;
}

int yywrap()
{
    return 1;
}
