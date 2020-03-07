//
// Created by Тимон on 10.12.2019.
//

#ifndef TISD_6_BALANCE_TREE_H
#define TISD_6_BALANCE_TREE_H

#include <stdio.h>
#include <stdlib.h>

struct bal_node
{
    int bal;
    int data;
    bal_node *link[2];
};

struct bal_tree
{
    bal_node *root;
    int count;
};

int is_bal (bal_node *node )
{
    if (node != NULL && node->bal == 1)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

struct bal_node *make_node ( int data )
{
    bal_node *rn = new bal_node;

    if ( rn != NULL ) {
        rn->data = data;
        rn->bal = 1; // bal
        rn->link[0] = NULL;
        rn->link[1] = NULL;
    }
    return rn;
}

struct bal_node *rb_single ( struct bal_node *root, int dir )
{
    struct bal_node *save = root->link[!dir];

    root->link[!dir] = save->link[dir];
    save->link[dir] = root;

    root->bal = 1;
    save->bal = 0;

    return save;
}


struct bal_node *rb_double (bal_node *root, int dir)
{
    root->link[!dir] = rb_single ( root->link[!dir], !dir );
    return rb_single ( root, dir );
}

int rb_insert ( struct bal_tree *tree, int data )
{

    if ( tree->root == nullptr ) {
        tree->root = make_node ( data );
        if ( tree->root == NULL )
            return 0;
    }
    else {
        struct bal_node head = {0};
        struct bal_node *g, *t;     // grand parent and parent
        struct bal_node *p, *q;     // parent
        int dir = 0, last;


        t = &head;
        g = p = NULL;
        q = t->link[1] = tree->root;

        for ( ; ; )
        {
            if ( q == NULL ) {
                // node inserting
                p->link[dir] = q = make_node ( data );
                tree->count ++ ;
                if ( q == NULL )
                    return 0;
            }
            else if ( is_bal ( q->link[0] ) && is_bal ( q->link[1] ) )
            {
                // color change
                q->bal = 1;
                q->link[0]->bal = 0;
                q->link[1]->bal = 0;
            }
            // equals of 2 bal nodes
            if ( is_bal ( q ) && is_bal ( p ) )
            {
                int dir2 = t->link[1] == g;

                if ( q == p->link[last] )
                    t->link[dir2] = rb_single ( g, !last );
                else
                    t->link[dir2] = rb_double ( g, !last );
            }

            // if root exists => exit
            if ( q->data == data )
            {
                break;
            }

            last = dir;
            dir = q->data < data;

            if ( g != NULL )
                t = g;
            g = p, p = q;
            q = q->link[dir];
        }

        // update root
        tree->root = head.link[1];
    }
    // root is black
    tree->root->bal = 0;

    return 1;
}

int rb_serch (bal_tree *tree, int data)
{
    int counter = 0;
    bal_node *tmp;
    tmp = tree->root;
    while (tmp) {
        if (tmp->data > data) {
            tmp = tmp->link[0];
            counter++;
            continue;
        } else if (tmp->data < data) {
            tmp = tmp->link[1];
            counter++;
            continue;
        } else {
            return counter;
        }
    }
    return -1;
}

void printrbtree (bal_node *w, int lvl)
{
// *w - указатель на корень дерева
// lvl - уровень вершины
    if  (w != NULL)
    {
        printrbtree (w->link[1], lvl + 1);
        for (int i = 0; i < lvl; i++)
            cout<< "      ";
        cout << w->data << "\n";
        printrbtree (w->link[0], lvl + 1);
    }
}


#endif //TISD_6_BALANCE_TREE_H
