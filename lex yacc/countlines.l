%{
    #include<iostream>
    using namespace std;
    int chars=0,words=0,lines=0;
%}

%%
[\n] { lines++;
        words++;
    }
[ ] { words++;
    }
. {chars++;
    }
%%

int main()
{
    yylex();
    cout<<"chars "<<chars<<endl;
    cout<<"words "<<words<<endl;
    cout<<"lines "<<lines<<endl;
    return 0;
}

int yywrap()
{
    return 1;
}
