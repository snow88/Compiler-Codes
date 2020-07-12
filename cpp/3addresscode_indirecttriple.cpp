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
    string triple[50][3];
    int idx = 0;
    for (int i=0; i<n; i++)
    {
        if(exp[i] == "*" || exp[i] == "/")
        {
            triple[idx][0] = exp[i];
            triple[idx][1] = exp[i-1];
            triple[idx][2] = exp[i+1];
            exp.erase(exp.begin()+i);      
            exp.erase(exp.begin()+i);
            exp[i-1] = "(" + to_string(idx+50) + ")";
            i--;
            idx++;
        }
    }

    for (int i=0; i<n; i++)
    {
        if(exp[i] == "+" || exp[i] == "-")
        {
            triple[idx][0] = exp[i];
            triple[idx][1] = exp[i-1];
            triple[idx][2] = exp[i+1];
            exp.erase(exp.begin()+i);       
            exp.erase(exp.begin()+i);
            exp[i-1] = "(" + to_string(idx+50) + ")";
            i--;
            idx++;
        }
    }

    if (exp.size() > 2 && exp[1] == ":=")
    {
        triple[idx][0] = exp[1];
        triple[idx][1] = exp[0];
        triple[idx][2] = exp[2];
        idx++;
    }

    cout<<"\nIndirect Triple tables:"<<endl;

    cout<<"\n\tStmt"<<endl;
    for(int i=0; i<idx; i++)
    {
        cout<<"("<<i<<")\t("<<i+50<<")"<<endl;
    }

    cout<<"\n\top\targ1\targ2"<<endl;
    for (int i=0; i<idx; i++)
    {
        cout<<"("<<i+50<<")\t";
        for (int j=0; j<3; j++)
            cout<<triple[i][j]<<"\t";
        cout<<endl;
    }

    return 0;
}


