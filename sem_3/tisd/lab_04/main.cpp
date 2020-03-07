#include <iostream>
#include <stdio.h>
#include <time.h>
#include "cdio.h"


int main()
{
    int mode_work = 0;
    int usr;
    cout << "How do you want to work?" << endl;
    cout << "1. List" << endl;
    cout << "2. Vector" << endl;
    cout << "3. Task" << endl;
    cin >> mode_work;
    if (mode_work == 1) // working with node
    {
        Node* head = NULL;
        char p;
        usr = -1;
        while(usr != 0)
        {
            cout << "1. Push element" << endl;
            cout << "2. Pop element" << endl;
            cout << "3. Stack address info" << endl;
            cout << "4. See stack" << endl;
            cout << "0. Exit" << endl;
            cin >> usr;
            switch (usr)
            {
                case 1:
                    cout << "Input char to push: ";
                    cin >> p;
                    npush_witch_check(&head, p);
                    break;
                case 2:
                    cout << "Poped: " << npop_witch_check(&head) << endl;
                    break;
                case 3:
                    cout << "Adreses: ";
                    masdelout();
                    cout << endl;
                    break;
                case 4:
                    nstackout(&head);
                    break;
            }
            cout << endl;
        }
    }
    else if (mode_work == 2) // working with massive
    {
        char p;
        mstack a;
        usr = -1;
        while(usr != 0) {
            cout << "1. Push element" << endl;
            cout << "2. Pop element" << endl;
            cout << "3. Stack info" << endl;
            cout << "0. Exit" << endl;
            cin >> usr;
            switch (usr) {
                case 1:
                    if (a.n == 4)
                    {
                        cout << "ERROR! STACK OVERFLOW";
                        return 1;
                    }
                    cout << "Input char to push: ";
                    cin >> p;
                    mpush(&a, p);
                    break;
                case 2:
                    cout << "Popped: " << mpop(&a) << endl;
                    break;
                case 3:
                    for (int i = a.n; i >= 0; i--) {
                        cout << a.mas[i];
                    }
                    cout << endl;
                    break;
            }
            cout << endl;
        }
    }
    else if (mode_work == 3) {
        //////////////////////////////////////////////////////////////////////////////////////////

        clock_t time_start, time_end, time_spend;
        mstack a;
        Node *head = NULL;
        char s[MAXSIZE];
        int mode = 0;


        cout << "'A' and 'a' are different letters, be careful" << endl;
        cout << "Please, input line to check: ";
        fgets(s, MAXSIZE, stdin);
        fgets(s, MAXSIZE, stdin);
        cout << "Do you want to see stack info(debug)?:" << endl << "1.Yes" << endl << "0.No" << endl;
        cin >> mode;
        cout << endl;




        // massive method
        time_start = clock();
        int i = 0;

        while (s[i] != '\0') {
            mpush(&a, s[i]);
            i++;
        }
        mpop(&a);
        int size = i - 1;

        i = 0;
        while ((i < size) && (mpop(&a) == s[i])) {
            i++;
        }
        cout << "MASSIVE METHOD RESULT: ";
        if (i == size) {
            cout << "PALINDROME" << endl;
        } else {
            cout << "NOT A PALINDROME" << endl;
        }
        time_end = clock();
        time_spend = time_end - time_start;
        cout << "time spend for massive method:" << double(time_spend) << endl << endl;

        //Node method
        if (mode == 0) {
            time_start = clock();
            i = 0;
            while (s[i] != '\0') {
                npush(&head, s[i]);
                i++;
            }
            npop(&head);
            i = 0;
            while ((i < size) && (npop(&head) == s[i])) {
                i++;
            }
            cout << "STACK METHOD RESULT  : ";
            if (i == size) {
                cout << "PALINDROME" << endl;
            } else {
                cout << "NOT A PALINDROME" << endl;
            }
            time_end = clock();
            time_spend = time_end - time_start;
            cout << "time spend for node method   :" << double(time_spend) << endl;
        } else {
            time_start = clock();
            i = 0;
            while (s[i] != '\0') {
                npush_witch_check(&head, s[i]);
                i++;
            }
            npop(&head);
            i = 0;
            while ((i < size) && (npop_witch_check(&head) == s[i])) {
                i++;
            }
            cout << "STACK METHOD RESULT  : ";
            if (i == size) {
                cout << "PALINDROME" << endl;
            } else {
                cout << "NOT A PALINDROME" << endl;
            }
            time_end = clock();
            time_spend = time_end - time_start;
            cout << "time spend for node method   :" << double(time_spend) << endl;
            masdelout();
        }
    }
    return 0;
}