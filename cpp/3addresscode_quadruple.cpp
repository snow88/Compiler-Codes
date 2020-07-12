#include<iostream>
#include<string.h>
#include<vector>
using namespace std;

int main()
{
    int n;
    vector<string> exp;
    string s;
    cout<<"Enter expression length:"<<endl;
    cin>>n;
    cout<<"Enter an expression: "<<endl;
    for (int i=0; i<n; i++)
    {
        cin>>s;
        exp.push_back(s);
    }
    string quadruple[50][4];
    int idx = 0;
    int tempctr = 0;
    for (int i=0; i<n; i++)
    {
        if(exp[i] == "*" || exp[i] == "/")
        {
            quadruple[idx][0] = exp[i];
            quadruple[idx][1] = exp[i-1];
            quadruple[idx][2] = exp[i+1];
            quadruple[idx][3] = "t" + to_string(tempctr);
            tempctr++;
            exp.erase(exp.begin()+i);    
            exp.erase(exp.begin()+i);
            exp[i-1] = quadruple[idx][3];
            i--;
            idx++;
        }
    }

    for (int i=0; i<n; i++)
    {
        if(exp[i] == "+" || exp[i] == "-")
        {
            quadruple[idx][0] = exp[i];
            quadruple[idx][1] = exp[i-1];
            quadruple[idx][2] = exp[i+1];
            quadruple[idx][3] = "t" + to_string(tempctr);
            tempctr++;
            exp.erase(exp.begin()+i);
            exp.erase(exp.begin()+i);
            exp[i-1] = quadruple[idx][3];
            i--;
            idx++;
        }
    }

    if (exp.size() > 2 && exp[1] == ":=")
    {
        quadruple[idx][0] = exp[1];
        quadruple[idx][1] = exp[2];
        quadruple[idx][2] = " ";
        quadruple[idx][3] = exp[0];
        idx++;
    }

    cout<<"\nQuadruple table:"<<endl;
    cout<<"\top\targ1\targ2\tresult"<<endl;
    for (int i=0; i<idx; i++)
    {
        cout<<"("<<i<<")\t";
        for (int j=0; j<4; j++)
            cout<<quadruple[i][j]<<"\t";
        cout<<endl;
    }

    return 0;
}
