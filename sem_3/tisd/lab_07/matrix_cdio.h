//
// Created by Тимон on 16.12.2019.
//

#ifndef TISD_07_MATRIX_CDIO_H
#define TISD_07_MATRIX_CDIO_H
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include "capital.h"
struct matrix
{
    int **matrix;
    int col;
    int row;
};


void matrix_makezero(struct matrix *a)
{
    for (int i = 0; i < a->row; i++)
    {
        for (int j = 0; j < a->col; j++)
        {
            a->matrix[i][j] = 0;
        }
    }
}

int matrix_crate(struct matrix *a, int rw, int cl)
{
    a->matrix = (int**)malloc(rw * sizeof(int*));
    if (a->matrix == NULL)
    {
        return EXIT_FAILURE;
    }
    for (int i = 0; i < rw; i++)
    {
        a->matrix[i] = (int*)malloc(cl * sizeof(int));
    }
    a->col = cl;
    a->row = rw;
    matrix_makezero(a);
    return 0;
}

int matrix_input(struct matrix *a, int n, int m)
{
    a->row = n;
    a->col = m;
    //printf("input matrix\n");
    for (int i = 0; i < a->row; i++)
    {
        for (int j = 0; j < a->col; j++)
        {
            if (scanf("%d", &a->matrix[i][j]) != 1)
            {
                return EXIT_FAILURE;
            }
        }
    }
    printf("\n");
    return EXIT_FAILURE;
}

#endif //TISD_07_MATRIX_CDIO_H
