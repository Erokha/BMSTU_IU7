//
// Created by Тимон on 10.12.2019.
//

#ifndef TISD_6_HASH_H
#define TISD_6_HASH_H

#include <stdlib.h>
#include <iostream>

using namespace std;

struct Node
{
    int data;
    Node *next;
};

struct List
{
    int size;
    Node *first;
    Node *last;
};

void Creation(List *Q)
{
    Q->first=new Node;
    Q->first->next= NULL;
    Q->last=Q->first;
    Q->size=0;
}

void Add(List *Q, int data)
{
    Q->last->next=new Node;
    Q->last=Q->last->next;
    Q->last->data = data;
    Q->last->next=NULL;
    Q->size++;
}

int hash_func(int x)
{
    return x % ASIZE;
}

void Queue_output(List *Q)
{
    if (Q->size == 0)
    {
        cout << " NULL" << endl;
    }
    else
    {
        Node *out = Q->first;
        for (int i = 0; i < Q->size; i++)
        {
            cout << " -> ";
            cout << out->next->data;
            out = out->next;
        }
        cout << endl;
    }
}
int hash_list_search(List *mas, int data)
{
    int search_counter = 1;
    int h = hash_func(data);
    Node *nd = mas[h].first;
    while (nd->next != NULL)
    {
        if (nd->next->data == data)
        {
            return search_counter;
        }
        nd = nd->next;
        search_counter++;
    }
    return -1;
}

List* restructed_search(List *src)
{
    List *newList = new List[ASIZE * 3];
    int ASIZESAVER = ASIZE;
    ASIZE *= 3;
    Node *tmp;
    int h;
    int dat;

    for (int i = 0; i < ASIZE; i++)
    {
        Creation(&(newList[i]));
    }
    for (int i = 0; i < ASIZESAVER; i++)
    {
        tmp = src[i].first;
        for(int j = 0; j < src[i].size; j++)
        {
            dat = tmp->next->data;
            h = hash_func(dat);
            Add(&(newList[h]), dat);
            tmp = tmp->next;
        }
    }

//    for (int i = 0; i < ASIZE; i++)
//    {
//        cout << "[" << i << "]";
//        Queue_output(&(newList[i]));
//    }


    List *ptr = newList;
    return ptr;
}

#endif //TISD_6_HASH_H
