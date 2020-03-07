//
// Created by Тимон on 22.10.2019.
//

#ifndef LAB_03_CDIO_H
#define LAB_03_CDIO_H
#include <iostream>
#include <time.h>
#include <stdlib.h>
#include <iomanip>
using namespace std;

struct matrix
{
    int **matrix;
    int col;
    int row;
};
struct vector_row
{
    int *mas;
    int size;
};
struct fast_matrix
{
    int* values;
    int* col;
    int* row;
    int values_length;
    int col_length;
};


int vector_create(struct vector_row *v, int size)
{
    v->mas = new int[size];
    v->size = size;
    for(int i = 0; i < size; i++)
    {
        v->mas[i] = 0;
    }
    return 0;
}
int vector_input(struct vector_row *v)
{
    for (int i = 0; i < v->size; i++)
    {
        cin >> v->mas[i];
    }
    return 0;
}
int vector_output(struct vector_row v)
{
    for (int i = 0; i < v.size; i++)
    {
        cout << v.mas[i] << " ";
    }
    cout << endl;
    return 0;
}
void vector_delete(struct vector_row *v)
{
    delete[] v->mas;
}



int matrix_crate(struct matrix *a, int rw, int cl)
{

    //a->matrix = new int*[rw];
    a->matrix = (int**)malloc(rw * sizeof(int*));
    for (int i = 0; i < rw; i++)
    {
        //a->matrix[i] = new int[cl];
        a->matrix[i] = (int*)malloc(cl * sizeof(int));
    }
    a->col = cl;
    a->row = rw;
    return 0;
}
void matrix_delete(struct matrix *a)
{
    for(int i = 0; i < a->row; i++)
    {
        delete[] a->matrix[i];
    }
    delete[] a->matrix;
}
int matrix_input(struct matrix *a)
{
    cout << "input matrix (" << a->row << " x " << a->col << "):" << endl;
    for (int i = 0; i < a->row; i++)
    {
        for(int j = 0; j < a->col; j++)
        {
            cin >> a->matrix[i][j];
        }
    }
    cout << endl;
    return 0;
}
void matrix_output(struct matrix a)
{
    for (int i = 0; i < a.row; i++)
    {
        for(int j = 0; j < a.col; j++)
        {
            cout << setw(5) << left << a.matrix[i][j];
        }
        cout << endl;
    }
}


#endif //LAB_03_CDIO_H
