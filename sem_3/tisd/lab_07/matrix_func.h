//
// Created by Тимон on 16.12.2019.
//

#ifndef TISD_07_MATRIX_FUNC_H
#define TISD_07_MATRIX_FUNC_H
#include "capital.h"
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include "matrix_cdio.h"


int dfs(matrix mas, int v)
{
    if (color[v] == BLACK)
    {
        return 0;
    }
    color[v] = BLACK;
    int way;
    for (int i = 0; i < mas.row; i++)
    {
        if (mas.matrix[v][i] != 0)
        {
            way = s[v] + mas.matrix[v][i];
            if (s[i] < way)
            {
                s[i] = way;
            }
        }
    }
    for (int i = 0; i < mas.row; i++)
    {
        if (mas.matrix[v][i] != 0)
        {
            dfs(mas, i);
        }
    }
    return 0;
}

void dfsMaximalWay(struct matrix mas, int *maxwaylen, int *maxwayfrom, int *maxwayto)
{
    dfs(mas, 0);
    *maxwaylen = s[1];
    *maxwayfrom = 0;
    *maxwayto = 1;
    for (int i = 1; i < mas.row; i++)
    {
        if (s[i] > *maxwaylen)
        {
            *maxwaylen = s[i];
            *maxwayto = i;
        }
    }

    for (int j = 1; j < mas.row; j++)
    {
        color_blind();
        s_blind();
        dfs(mas, j);
        for (int i = 1; i < mas.row; i++)
        {
            if (s[i] > *maxwaylen)
            {
                *maxwaylen = s[i];
                *maxwayfrom = j;
                *maxwayto = i;
            }
        }
    }
}

bool cycleFinder(struct matrix mas, int v, bool *flag)
{
    color[v] = RED;
    if (color[v] == BLACK)
    {
        return false;
    }
    for (int i = 0; i < mas.row; i++)
    {
        if (color[i] == WHITE)
        {
            dfs(mas, i);
        }
        if ((color[i] == RED) && (i != v))
        {
            *flag = true;
            return true;
        }
    }
    color[v] = BLACK;

}

void matrix_painter(struct matrix mas)
{
    FILE *f = fopen("output.dot", "w");
    fprintf(f, "digraph test{\n");
    for (int i = 0; i < mas.row; i++)
    {
        for (int j = 0; j < mas.row; j++)
        {
            if (mas.matrix[i][j])
            {
                fprintf(f, "    %d->%d[label = %d];\n", i+1, j+1, mas.matrix[i][j]);
            }
        }
    }
    fprintf(f, "}");
    fclose(f);
    system("dot -Tpng -O output.dot");
    int graph_view;
    //std::cout << "Do you want to s"
    system("gthumb output.dot.png");
}

#endif //TISD_07_MATRIX_FUNC_H
