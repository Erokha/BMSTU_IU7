//
// Created by Тимон on 10.12.2019.
//

#ifndef TISD_6_TREE_H
#define TISD_6_TREE_H

struct tree_Node {
    int data;
    struct tree_Node *left;
    struct tree_Node *right;
    struct tree_Node *parent;
};

struct my_tree
{
    tree_Node *root;
    int count;
};

tree_Node* New_Node(int value, tree_Node *parent) {
    tree_Node* tmp = (tree_Node*) malloc(sizeof(tree_Node));
    tmp->left = tmp->right = NULL;
    tmp->data = value;
    tmp->parent = parent;
    return tmp;
}

void tree_insert(tree_Node **head, int value) {
    tree_Node *tmp = NULL;
    tree_Node *ins = NULL;
    if (*head == NULL)
    {
        *head = New_Node(value, NULL);
        return;
    }

    tmp = *head;
    while (tmp)
    {
        // to the right tree
        if (value > tmp->data) {
            if (tmp->right)
            {
                tmp = tmp->right;
                continue;
            }
            else
            {
                tmp->right = New_Node(value, tmp);
                return;
            }
        }
        // to the left tree
        else if (value < tmp->data)
        {
            if (tmp->left)
            {
                tmp = tmp->left;
                continue;
            }
            else
            {
                // here we go
                tmp->left = New_Node(value, tmp);
                return;
            }
        }
        else
        {
            // exiting
            break;
        }
    }
}

int get_Node_by_value(tree_Node *root, int value) {
    int counter = 0;
    while (root)
    {
        if (root->data > value)
        {
            root = root->left;
            counter++;
            continue;
        }
        else if (root->data < value)
        {
            root = root->right;
            counter++;
            continue;
        }
        else
        {
            return counter;
        }
    }
    return -1;
}

void printWithLvls (tree_Node *w, int lvl)
{

    if  (w != NULL)
    {
        printWithLvls (w->right, lvl + 1);
        for (int i = 0; i < lvl; i++)
            cout<< "      ";
        cout << w->data << "\n";
        printWithLvls (w->left, lvl + 1);
    }
}


#endif //TISD_6_TREE_H
