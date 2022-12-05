#include <iostream>
#include <stack>
#include <fstream>
#include <string>
#include <assert.h>
using namespace std;

void populate(stack<char> (&stacks)[9]);

int main()
{
    stack<char> stacks[9];
    stack<char> tmp_stack;
    populate(stacks);

    ifstream file("input.txt");
    string line;

    int crates, from, to = 0;

    while (getline(file, line))
    {

        sscanf_s(line.c_str(), "move %d from %d to %d", &crates, &from, &to);

        for (int i = 0; i < crates; i++)
        {
            tmp_stack.push(stacks[from - 1].top());
            stacks[from - 1].pop();
        }
        for (int i = 0; i < crates; i++)
        {
            stacks[to - 1].push(tmp_stack.top());
            tmp_stack.pop();
        }
    }

    for (auto stack : stacks)
    {
        cout << stack.top();
    }

    cout << "\n";
}

void populate(stack<char> (&stacks)[9])
{
    stacks[0].push('Z');
    stacks[0].push('T');
    stacks[0].push('F');
    stacks[0].push('R');
    stacks[0].push('W');
    stacks[0].push('J');
    stacks[0].push('G');

    stacks[1].push('G');
    stacks[1].push('W');
    stacks[1].push('M');

    stacks[2].push('J');
    stacks[2].push('N');
    stacks[2].push('H');
    stacks[2].push('G');

    stacks[3].push('J');
    stacks[3].push('R');
    stacks[3].push('C');
    stacks[3].push('N');
    stacks[3].push('W');

    stacks[4].push('W');
    stacks[4].push('F');
    stacks[4].push('S');
    stacks[4].push('B');
    stacks[4].push('G');
    stacks[4].push('Q');
    stacks[4].push('V');
    stacks[4].push('M');

    stacks[5].push('S');
    stacks[5].push('R');
    stacks[5].push('T');
    stacks[5].push('D');
    stacks[5].push('V');
    stacks[5].push('W');
    stacks[5].push('C');

    stacks[6].push('H');
    stacks[6].push('B');
    stacks[6].push('N');
    stacks[6].push('C');
    stacks[6].push('D');
    stacks[6].push('Z');
    stacks[6].push('G');
    stacks[6].push('V');

    stacks[7].push('S');
    stacks[7].push('J');
    stacks[7].push('N');
    stacks[7].push('M');
    stacks[7].push('G');
    stacks[7].push('C');

    stacks[8].push('G');
    stacks[8].push('P');
    stacks[8].push('N');
    stacks[8].push('W');
    stacks[8].push('C');
    stacks[8].push('J');
    stacks[8].push('D');
    stacks[8].push('L');
}