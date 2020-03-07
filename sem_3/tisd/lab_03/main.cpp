#include <iostream>
#include <time.h>
#include <stdlib.h>
#include <iomanip>
#include "cdio.h"
#include <time.h>

/*
 * test_one
    1 0 0 0 2 0
    0 0 3 4 0 0
    0 0 0 0 0 0
    0 0 0 8 0 5
    0 0 0 0 0 0
    0 0 0 0 0 0
 * test_two
  2 0 0
  1 0 0
  5 0 0
  0 0 0
 * test_three
    0 0 0 0 0
    0 0 1 3 0
    0 0 0 2 0
    0 0 0 0 1

    0 0 0 0
    0 0 0 0
    1 0 0 0
    3 5 0 0
    0 0 0 0
 */
using namespace std;



void matrix_trans(struct matrix* a, struct matrix* res)
{
    for (int i = 0; i < res->row; i++)
    {
        for (int j = 0; j < res->col; j++)
        {
            res->matrix[i][j] = a->matrix[j][i];
        }
    }
}
void matrix_random_fill(struct matrix* a, int percent)
{
    srand(time(NULL));
    int num_of_fields = (a->row * a->col) * percent / 100;
    int rcol, rrow;

    for (int i = 0; i < a->row; i++)
    {
        for (int j = 0; j < a->col; j++)
        {
            a->matrix[i][j] = 0;
        }

    }
    // cout << "Matrix field with 0" << endl;
    //          ^
    // fill matrix with zeros


    for (int i = 0; i < num_of_fields; i++)
    {
        rcol = rand() % a->col;
        rrow = rand() % a->row;
        while (a->matrix[rrow][rcol])
        {
            rcol = rand() % a->col;
            rrow = rand() % a->row;
        }
        a->matrix[rrow][rcol] = (rand() % 20) + 1;
    }
    //          ^
    // fill random matrix field with random int
}
void vector_coord_input(struct vector_row *v)
{
    int s = 0;
    int foo = 0;
    int data = 0;
    cout << "Columns are enumerated from 0" << endl;
    cout << "Input num of vector non-zero elements(less than" << v->size << "):";
    cin >> s;
    while (s < 0 || s >= v->size)
    {
        cout << "Too much elements" << endl;
        cout << "Input num of vector non-zero elements(less than" << v->size << "):";
        cin >> s;
    }
    for (int i = 0; i < s; i++)
    {
        cout << "Input column and data: ";
        cin >> foo >> data;
        if (foo >= v->size)
        {
            cout << "This field will not be filled, try again" << endl;
            s++;
        }
        else
        {
            v->mas[foo] = data;
        }
    }
}
void slow_to_fast(struct matrix* a, struct fast_matrix* sup)
{
    sup->values_length = 0;
    int nz;
    sup->col = new int[a->col + 1];
    int k = 0;

    for (int i = 0; i < a->col; i++)
    {
        nz = -1;
        for (int j = 0; j < a->row; j++)
        {
            if (a->matrix[j][i] != 0)
            {
                if (nz == -1)
                {
                    nz = sup->values_length;
                }
                sup->values_length++;
            }
        }
        sup->col[i] = nz;
    }
    sup->col[a->col] = sup->values_length;
    for (int i = a->col - 1; i >= 0; i--)
    {
        if (sup->col[i] == -1)
        {
            sup->col[i] = sup->col[i + 1];
        }
    }
    sup->row = new int[sup->values_length];
    sup->values = new int[sup->values_length];

    for (int i = 0; i < a->col; i++)
    {
        for (int j = 0; j < a->row; j++)
        {
            if (a->matrix[j][i] != 0)
            {
                sup->values[k] = a->matrix[j][i];
                sup->row[k] = j;
                k++;
            }
        }
    }

    sup->col_length = a->col + 1;
    // debug print
    /*
    cout << "Debug print: ";

    for (int i = 0; i < sup->values_length; i++)
    {
        cout << setw(5) << left << sup->values[i] << " ";
    }
    cout << endl;
    for (int i = 0; i < sup->values_length; i++)
    {
        cout << setw(5) << left << sup->row[i] << " ";
    }
    cout << endl;
    for (int i = 0; i < sup->col_length; i++)
    {
        cout << setw(5) << left << sup->col[i] << " ";
    }
    cout << endl << endl;
    */

}
void fast_matrix_delete(struct fast_matrix* sup)
{
    delete[] sup->col;
    delete[] sup->row;
    delete[] sup->values;
}

clock_t stupid_matrix_multiply(struct matrix a, struct vector_row v, struct vector_row* res, int out_mode)
{
    clock_t start, stop;
    start = clock();
    int cursum;

    for (int i = 0; i < a.col; i++)
    {
        cursum = 0;
        for (int j = 0; j < a.row; j++)
        {
            cursum += a.matrix[j][i] * v.mas[j];
            //cout << a.matrix[j][i] << " ";
        }
        res->mas[i] = cursum;
    }
    stop = clock();




    if (out_mode == 1)
    {
        cout << "basic output for basic multiply: ";
        for (int i = 0; i < res->size; i++)
        {
            cout << setw(5) << left << res->mas[i];
        }
    }
    else
    {
        struct fast_matrix a;
        int bar = 0;
        int cnt = 0;
        int n = res->size;
        for (int i = 0; i < n; i++)
        {
            if(res->mas[i])
            {
                cnt++;
            }
        }
        a.values_length = cnt;
        a.values = new int[a.values_length];
        a.row = new int[a.values_length];
        a.col = new int[n];
        for (int i = 0; i < n; i++)
        {
            a.col[i] = bar;
            if (res->mas[i])
            {
                a.values[bar] = res->mas[i];
                a.row[bar] = 0;
                bar++;
            }
        }
        cout << "smart output for smart multiply: " << endl;
        cout << "values :";
        for (int i = 0; i < a.values_length; i++)
        {
            cout << setw(5) << left << a.values[i];

        }
        cout << endl;

        cout << "row    :";
        for (int i = 0; i < a.values_length; i++)
        {
            cout << setw(5) << left << a.row[i];

        }
        cout << endl;

        cout << "col    :";
        for (int i = 0; i < n; i++)
        {
            cout << setw(5) << left << a.col[i];

        }
        cout << endl;
    }
    return stop - start;
}
clock_t super_smart_multiply(struct fast_matrix* sup, struct vector_row* v, int output_mode)
{
    //cout << "super fast res is :";
    int bar = 0; // one more counter

    int *mas = new int[sup->col_length - 1];
    int n = sup->col_length - 1;
    int cnt = 0;
    struct fast_matrix a;

    clock_t start, end;
    start = clock();
    for (int i = 0; i < sup->col_length - 1; i++)
    {
        int now = sup->col[i + 1] - sup->col[i];
        int sum = 0;
        for (int j = 0; j < now; j++)
        {
            sum += sup->values[bar] * v->mas[sup->row[bar]];
            bar++;
        }
        mas[i] = sum;
        if(sum)
        {
            cnt++;
        }
        //cout << sum << " ";
    }
    end = clock();


    bar = 0;
    a.values_length = cnt;
    a.values = new int[a.values_length];
    a.row = new int[a.values_length];
    a.col = new int[n];
    //smart res:
    for (int i = 0; i < n; i++)
    {
        a.col[i] = bar;
        if (mas[i])
        {
            a.values[bar] = mas[i];
            a.row[bar] = 0;
            bar++;
        }
    }
    if (output_mode == 1)
    {
        // basic output
        cout << "basic output for smart multiply: ";
        for (int i = 0; i < n; i++)
        {
            cout << setw(5) << left << mas[i];
        }
    }
    else
    {
        //smart output
        cout << "smart output for smart multiply: " << endl;
        cout << "values :";
        for (int i = 0; i < a.values_length; i++)
        {
            cout << setw(5) << left << a.values[i];

        }
        cout << endl;

        cout << "row    :";
        for (int i = 0; i < a.values_length; i++)
        {
            cout << setw(5) << left << a.row[i];

        }
        cout << endl;

        cout << "col    :";
        for (int i = 0; i < n; i++)
        {
            cout << setw(5) << left << a.col[i];

        }
        cout << endl;
    }
    return end - start;
}
void coord_matrix_input(struct matrix *a)
{
    int n;
    int c, r;
    cout << "!Columns and rows are enumerated from 0!\n";
    cout << "Input number of non-zero elements: ";
    cin >> n;
    cout << "(Columns and rown numeretad from 1)" << endl;
    for (int i = 0; i < n; i++)
    {
        cout << "Input column, than row:";
        cin >> c >> r;
        cout << "Input data: ";
        cin >> a->matrix[c][r];
    }
}
int matrix_file_write(struct matrix a)
{
    FILE *f;
    f = fopen("matrix.txt", "w");
    if (f == NULL)
    {
        return EXIT_FAILURE;
    }
    fprintf(f, "%5d%5d\n", a.col, a.row);
    for (int i = 0; i < a.row; i++)
    {
        for (int j = 0; j < a.col; j++)
        {
            fprintf(f, "%5d", a.matrix[i][j]);
        }
        fprintf(f, "\n");
    }
    fclose(f);
    return EXIT_SUCCESS;
}

int main()
{
    struct matrix a;

    struct fast_matrix sup;
    struct vector_row v;
    struct vector_row res;
    struct vector_row to_put_res_here;
    int usr_choice = 0;
    int out_mode = 0; // mode of output

    //int mc = 0;
    //int mr = 0;
    int percent;

    // *Matrix init*
    cout << "Input matrix size(columns(>)):";
    cin >> a.col;
    cout << "Input matrix size(rows (V))  :";
    cin >> a.row;

    if ((a.col <= 0) || (a.row <= 0))
    {
        cout << "Error!";
        return -1;
    }


    matrix_crate(&a, a.row, a.col);
    cout << "Wich way you perfer to get matrix?" << endl;
    cout << "1. Generate random" << endl;
    cout << "2. Full input" << endl;
    cout << "3. Coordinate input(format column, row, data)" << endl;
    cin >> usr_choice;
    while ((usr_choice < 1) || (usr_choice > 3))
    {
        cout << "Error!" << endl;
        cout << "Wich way you perfer to get matrix?" << endl;
        cout << "1. Generate random" << endl;
        cout << "2. Full input" << endl;
        cout << "3. Coordinate input(format column, row, data)" << endl;
    }
    switch (usr_choice) {
        case 1:
            cout << "Wich percent of fill?";
            cin >> percent;
            matrix_random_fill(&a, percent);
            //matrix_file_write(a);
            break;
        case 2:
            matrix_input(&a);
            break;
        case 3:
            coord_matrix_input(&a);
            break;
    }
    cout << "Do you want to see your matrix?" << endl << "1.Yes" << endl << "2.No" << endl;
    cin >> usr_choice;
    if (usr_choice == 1)
    {
        matrix_output(a);
    }
    // *end*




    // *vector init*

    cout << endl;
    vector_create(&v, a.row);
    vector_create(&res, a.col);


    cout << "Wich way do you perfer to get vector?" << endl;
    cout << "1. Full input" << endl;
    cout << "2. Coordinate input(format column, data)" << endl;
    cin >> usr_choice;
    switch (usr_choice) {
        case 1:
            cout << "Please input row to multiply(size:" << a.row << "):";
            vector_input(&v);
            break;
        case 2:
            vector_coord_input(&v);
            break;
    }
    cout << endl << endl;

    cout << "wich method of output do you perfer?" << endl;
    cout << "1. Vector" << endl << "2. 3 arrays" << endl;
    cin >> out_mode;
    // *end*





    // *************************
    // Real programm starts here
    // *************************







    // first method
//    clock_t time_start, time_end;
//    time_start = clock();
//    stupid_matrix_multiply(a, v, &res, out_mode);
//    cout << endl;
//    time_end = clock();
//    clock_t time_spend = time_end - time_start;
    clock_t timer;
    timer = stupid_matrix_multiply(a, v, &res, out_mode);
    cout << endl << "time spend for basic multiply  : " << timer << endl;
    cout << endl;

    // second method
//    clock_t time_end, time_spend;
    slow_to_fast(&a, &sup);
//    clock_t time_start = clock();
    timer = super_smart_multiply(&sup, &v, out_mode);
    cout << endl;
//    time_end = clock();
//    time_spend = time_end - time_start;
    cout << "time spend for 'smart' multiply: " << timer << endl;

    //         |
    // The end V
    matrix_delete(&a);
    vector_delete(&v);
    vector_delete(&res);
    fast_matrix_delete(&sup);
    return 0;
}
