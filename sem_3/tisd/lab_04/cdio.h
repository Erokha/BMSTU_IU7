//
// Created by kymblc on 05.11.19.
//

#ifndef LAB_04_TISD_CDIO_H
#define LAB_04_TISD_CDIO_H
#define MAXSIZE 1000000
#include <stdlib.h>
#include <stdio.h>

using namespace std;
struct Node
{
    char data;
    Node* next;
};
struct mstack
{
    char mas[MAXSIZE];
    int n = -1;
};

Node* masdel[MAXSIZE];
int msize = 0;

void mpush(mstack* a, char letter)
{
    a->n++;
    a->mas[a->n] = letter;
}
char mpop(mstack* a)
{
    a->n--;
    return a->mas[a->n + 1];
}
int npush_witch_check(Node** head, char c)
{
    Node* foo = new Node;
    if (foo != NULL)
    {
        foo->data = c;
        foo->next = *head;
        *head = foo;
        for (int i = 0; i < msize; i++)
        {
            if (foo == masdel[i])
            {
                for(int j = i; j < msize - 1; j++)
                {
                    masdel[i] = masdel[i + 1];
                }
                msize--;
            }
        }
        return 0;
    }
    else
    {
        return 1;
    }
}
char npop_witch_check_for_stack_info(Node** head) {
    if (*head == NULL)
    {
        return '\0';
    }
    Node* foo = *head;
    char save = foo->data;
    *head = (*head)->next;
    masdel[msize++] = foo;
    cout << " (" <<  foo << ")";
    delete foo;
    return save;
}


char npop_witch_check(Node** head) {
    if (*head == NULL)
    {
        return '\0';
    }
    Node* foo = *head;
    char save = foo->data;
    *head = (*head)->next;
    masdel[msize++] = foo;
    delete foo;
    return save;
}
int npush(Node** head, char c)
{
    Node* foo = new Node;
    if (foo != NULL)
    {
        foo->data = c;
        foo->next = *head;
        *head = foo;

        return 0;
    }
    else
    {
        return 1;
    }
}
char npop(Node** head) {
    if (*head == NULL)
    {
        return '\0';
    }
    Node* foo = *head;
    char save = foo->data;
    *head = (*head)->next;
    delete foo;
    return save;
}
void nstackout(Node **head)
{
    mstack m;
    int i = 0;
    char c;
    cout << "Stack is: ";
    while (*head != NULL)
    {
        c = npop_witch_check_for_stack_info(head);
        m.mas[i++] = c;
        cout << c;
    }
    for (int j = i - 1; j >= 0; j--)
    {
        npush_witch_check(head, m.mas[j]);
    }
}
void masdelout()
{
    if (msize == 0)
    {
        cout << "massive of adreses is empty" << endl;
    }
    else
    {
        for (int i = 0; i < msize; i++)
        {
            cout << masdel[i] << " ";
        }
    }
}

#endif //LAB_04_TISD_CDIO_H
