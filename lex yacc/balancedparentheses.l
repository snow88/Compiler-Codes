%{
    #include<iostream>
    using namespace std;
    #include "y.tab.h"
%}

%%
"(" { return yytext[0];
    }
")" { return yytext[0];
    }
[ \t\n]* { ;
        }
%%

int yywrap()
{
    return 1;
}
