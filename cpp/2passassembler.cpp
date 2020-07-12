#include<iostream>
#include<fstream>
#include<string>
#include<unordered_map>
using namespace std;

unordered_map<string,string> machcodes;

void getmachcodes()
{
    machcodes.clear();
    ifstream fin;
    fin.open("machinecodes.txt");
    while (!fin.eof())
    {
        string op, len;
        fin>>op>>len;
        int ln = len[0]-'0';
        for (int i=0; i<ln; i++)
        {
            string nxtop;
            fin>>nxtop;
            op+=nxtop;
        }
        string code;
        fin>>code;
        machcodes[op] = code;
    }
    fin.close();
}

unordered_map<string,int> symboltable;
int address = 2000; 

void assemble()
{
    ifstream fin;
    ofstream fout;
    fin.open("srccode.txt");
    fout.open("objcode.txt", ios::out | ios::trunc);
    string line;
    while(!fin.eof())
    {
        getline(fin,line);
        string op="";
        int flag=0;
        int flaglbl=0;
        int i=0;
        for ( ; i<line.length(); i++)
        {
            if (line[i]==',' || line[i]==' ')
                continue;
            if (line[i]>='0' && line[i]<='9')
            {
                flag=1;
                break;
            }
            if (line[i]==':')
            {
                flaglbl=1;
                break;
            }
            op+=line[i];
        }
        if (flaglbl)
        {
            symboltable[op] = address;
            continue;
        }
        if (machcodes.find(op) == machcodes.end())
        {
            string newop="", lbl="";
            int k=0;
            for ( ; k<op.length(); k++)
            {
                newop+=op[k];
                if (machcodes.find(newop) != machcodes.end())
                    break;
            }
            k++;
            for ( ; k!=op.length(); k++)
                lbl+=op[k];
            fout<<machcodes[newop]<<"\n";
            fout<<symboltable[lbl]/100<<"\n";
            fout<<symboltable[lbl]%100<<"\n";

            address+=3;
            continue;
        }
        fout<<machcodes[op]<<"\n";
        address++;
        if (flag==1)
        {
            string data1 = "";
            string data2 = "";
            int j=0;
            while(i!=line.length() && j<2)
            {
                data1+=line[i];
                i++;
                j++;
            }
            int flag2 = 0;
            while(i!=line.length())
            {
                flag2 = 1;
                data2+=line[i];
                i++;
            }
            fout<<data1<<"\n";
            address++;
            if (flag2)
            {
                fout<<data2<<"\n";
                address++;
            }
        }
    }
    fin.close();
    fout.close();
}

int main()
{
    getmachcodes();
    assemble();
    cout<<"OBJECT FILE generated: objcode.txt"<<endl;
    cout<<"\nSYMBOL TABLE generated:"<<endl;
    cout<<"Label\tAddress"<<endl;
    for (auto val : symboltable)
    {
        cout<<val.first<<"\t"<<val.second<<endl;
    }
    return 0;
}
