#define _CRT_SECURE_NO_WARNINGS
#include <string>
#include <locale.h>
#include <iostream>
#include <cstring>
#include "header.h"
#include <ctime>

//test
using namespace std;

int main()
{
	FILE* f;
	f = fopen("db.txt", "w");
	fclose(f);
    setlocale(LC_ALL, "RU");
    flat mas[100];
	int n = 0;
    int user_choice = 0;
    int srtmode = 0;



    do
    {
        user_choice = menu();
        switch (user_choice)
        {
            case 1:
				header_output();
				for (int i = 0; i < n; i++)
				{
                    flat_output(mas[i], i + 1);
				}
				break;


            case 2:
                flat_input(&(mas[n]));
                n++;
                break;


			case 3:
			    cout << endl << "1. Bubble sort" << endl << "2. Insertion sort" << endl;
			    cout << "Whis sort do you perfer?";

			    cin >> srtmode;
			    if (srtmode == 1)
                {
			        mysort_bubble(mas, n);
                } else if (srtmode == 2)
                {
			        mysort_insert(mas, n);
                }
				break;


            case 4:
                cout << "input number of record to delete: ";
                int del;
                cin >> del;
                if ((del > n) || (del < 1))
                {
                    cout << "Incorrect number of record" << endl;
                }
                else
                {
                    delete_from_db(mas, &n, del - 1);
                }
                break;


            case 5:
                double up, down;
                cout << "input upper edge: ";
                cin >> up;
                cout << "input lower edge: ";
                cin >> down;
                if (down > up)
                {
                    swap(up, down);
                }
                search(mas, up, down, n);
                break;


            case 7:
				f = fopen(dbfilename, "w");
				fprintf(f, "%-3d\n", n);
				for (int i = 0; i < n; i++)
				{
					write_building_in_file(f, mas[i]);
				}
				fclose(f);
				break;


			case 0:
				f = fopen(dbfilename, "r");
				fscanf(f, "%3d", &n);
				for (int i = 0; i < n; i++)
				{
					read_building_from_file(f, &mas[i]);
				}
				fclose(f);
				break;


            default:
                cout << endl;
                break;


        }
    } while (1);
    return 0;
}
