#include <iostream>
#include "defines.h"
#include <time.h>
#include "hash.h"
#include "tree.h"
#include "balance_tree.h"

using namespace std;


//9 10 7 9 12 6 14 11 3 4

int main()
{
    srand(time(NULL));
    //################################################
    //################################################
    int readmode = 1;
    cout << "Select readmode" << endl;
    cout << "1. File" << endl;
    cout << "2. Console" << endl;
    cout << "3. Random" << endl;
    cin >> readmode;
    if ((readmode > 3) || (readmode < 1))
    {
        cout << "error!" << endl;
        return EXIT_FAILURE;
    }
    // 1 - file 2 -hands input 3 - random generation
    //################################################
    //################################################
    // for balansed tree
    bal_tree my_tree;
    my_tree.root = NULL;

    // for hash-table
    List *mas_list = new List[ASIZE];
    //List mas_list[ASIZE];
    int h;

    // for basic tree
    tree_Node *head = NULL;

    // global var
    int n;
    int dat;
    int sfor = 15;


    for (int i = 0; i < ASIZE; i++)
    {
        Creation(&(mas_list[i]));
    }

    { // reading
        if (readmode == 2) {
            cout << "Input n" << endl;
            cin >> n;
            for (int i = 0; i < n; i++) {
                cin >> dat;
                h = hash_func(dat);
                Add(&(mas_list[h]), dat); // inserting in hash table
                tree_insert(&head, dat); // inserting in basic tree
                rb_insert(&my_tree, dat); // inserting in balansed_tree
            }
        }
        if (readmode == 1) {
            FILE *f = fopen("input.txt", "r");
            fscanf(f, "%d", &n);
            for (int i = 0; i < n; i++) {
                fscanf(f, "%d", &dat);
                h = hash_func(dat);
                Add(&(mas_list[h]), dat); // inserting in hash table
                tree_insert(&head, dat); // inserting in basic tree
                rb_insert(&my_tree, dat); // inserting in balansed_tree
            }
        }
        if (readmode == 3) {
            cout << "Input n" << endl;
            cin >> n;
            for (int i = 0; i < n; i++) {
                dat = rand() % 101;
                h = hash_func(dat);
                Add(&(mas_list[h]), dat); // inserting in hash table
                tree_insert(&head, dat); // inserting in basic tree
                rb_insert(&my_tree, dat); // inserting in balansed_tree
            }
        }
    }

    // Output what we have read
    cout << "baisc tree:" << endl;
    printWithLvls(head, 1);
    cout << endl << endl << endl;
    cout << "balansed tree:" << endl;
    printrbtree(my_tree.root, 0);
    for (int i = 0; i < ASIZE; i++)
    {
        cout << "[" << i << "]";
        Queue_output(&(mas_list[i]));
    }

    cout << "Input value we are searching for:";
    cin >> sfor;

    // searching
    int htr = hash_list_search(mas_list, sfor);

    int tree_search = get_Node_by_value(head, sfor);


    int bal_tree_search = rb_serch(&my_tree, sfor);

    mas_list = restructed_search(mas_list);
    cout << "Restructed hash table: " << endl;
    for (int i = 0; i < ASIZE; i++)
    {
        cout << "[" << i << "]";
        Queue_output(&(mas_list[i]));
    }



    cout << "Hash table search res: " << htr << endl;
    cout << "Tree search res " << tree_search << endl;
    cout << "Balanced tree res " << bal_tree_search << endl;
    cout << "Restructed Hash table search res: " << hash_list_search(mas_list, sfor) << endl;


    return 0;

}