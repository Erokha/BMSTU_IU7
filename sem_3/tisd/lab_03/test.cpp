//
// Created by kymblc on 12/21/19.
//
#include <iostream>
#include <time.h>
#include <stdlib.h>
#include <iomanip>
#include "cdio.h"

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



    if (out_mode == -1)
    {
        int b = 2;
    }
    else if (out_mode == 1)
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
    if (output_mode == -1)
    {
        int b = 2;
    }
    else if (output_mode == 1)
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

void vectorrowrandomfill(struct vector_row *v, int percent)
{
    srand(time(NULL));
    int num_of_fields = (v->size) * percent / 100;
    int pos_to_put;
    for (int i = 0; i > v->size; i++)
    {
        v->mas[i] = 0;
    }
    for (int i = 0; i < num_of_fields; i++)
    {
        pos_to_put = rand() % v->size;
        while (v->mas[pos_to_put])
        {
            pos_to_put = rand() % v->size;
        }
        v->mas[pos_to_put] = (rand() % 20) + 1;
    }
}

int superpetser(int percent_of_fill_matrix, int matrix_sizer)
{
    struct matrix a;

//    struct fast_matrix sup;
    struct fast_matrix sup;
    struct vector_row v;
    struct vector_row res;
    struct vector_row to_put_res_here;
    int usr_choice = 0;
    int out_mode = -1; // mode of output

    //int mc = 0;
    //int mr = 0;
    int percent;

    // *Matrix init*
    a.col = matrix_sizer;
    a.row = matrix_sizer;

    if ((a.col <= 0) || (a.row <= 0))
    {
        cout << "Error!";
        return -1;
    }


    matrix_crate(&a, a.row, a.col);
//    cout << "Wich way you perfer to get matrix?" << endl;
//    cout << "1. Generate random" << endl;
//    cout << "2. Full input" << endl;
//    cout << "3. Coordinate input(format column, row, data)" << endl;
    usr_choice = 1;
    switch (usr_choice) {
        case 1:
            //cout << "Wich percent of fill?";
            percent = percent_of_fill_matrix;
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
    // *end*




    // *vector init*

    cout << endl;
    vector_create(&v, a.row);
    vector_create(&res, a.col);


//    cout << "Wich way do you perfer to get vector?" << endl;
//    cout << "1. Full input" << endl;
//    cout << "2. Coordinate input(format column, data)" << endl;
//    cin >> usr_choice;
//    switch (usr_choice) {
//        case 1:
//            cout << "Please input row to multiply(size:" << a.row << "):";
//            vector_input(&v);
//            break;
//        case 2:
//            vector_coord_input(&v);
//            break;
//    }
//    cout << endl << endl;
    vectorrowrandomfill(&v, 100);
    //vector_output(v);
//    cout << "wich method of output do you perfer?" << endl;
//    cout << "1. Vector" << endl << "2. 3 arrays" << endl;
//    cin >> out_mode;
    out_mode = -1;
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
    cout << "For size " << matrix_sizer << " and percent " << percent_of_fill_matrix << " res is:" << endl;
    clock_t timer;
    clock_t st, end;
    st = clock();
    timer = stupid_matrix_multiply(a, v, &res, -1);
    end = clock();
    cout << endl << "For basic multiply  : " << timer << endl;
    /*cout << end - st;*/

    // second method
//    clock_t time_end, time_spend;
    slow_to_fast(&a, &sup);
//    clock_t time_start = clock();
    st = clock();
    timer = super_smart_multiply(&sup, &v, -1);
    end = clock();
    cout << endl;
//    time_end = clock();
//    time_spend = time_end - time_start;
    cout << "For 'smart' multiply: " << timer << endl;
    cout << end - st << endl;

    //         |
    // The end V
    matrix_delete(&a);
    vector_delete(&v);
    vector_delete(&res);
    fast_matrix_delete(&sup);
    return 0;
}

int main()
{
    struct fast_matrix a;
    int size = 1000;
    cout << "size of smart marix : " << (2 * size * size * 4 * (10)) / 100 + size * 4 << endl;
    cout << "size of smart marix : " << (2 * size * size * 4 * (25)) / 100 + size * 4 << endl;
    cout << "size of smart marix : " << (2 * size * size * 4 * (50)) / 100 + size * 4 << endl;
    cout << "size of smart marix : " << (2 * size * size * 4 * (75)) / 100 + size * 4 << endl;
    cout << "size of smart marix : " << (2 * size * size * 4 * (100)) / 100 + size * 4 << endl;
    cout << "size of basic matrix: " << size * size * 4;
    return 0;
    int sizeoftest = 1000;
//    superpetser(10, sizeoftest);
//    cout << endl << endl;
//    superpetser(25, sizeoftest);
//    cout << endl << endl;
//    superpetser(50, sizeoftest);
//    cout << endl << endl;
//    superpetser(75, sizeoftest);
//    cout << endl << endl;
//    superpetser(100, sizeoftest);
//    cout << endl << endl;



    superpetser(75, sizeoftest);
    cout << endl << endl;

}
