//
// Created by Тимон on 16.12.2019.
//

#ifndef TISD_07_CAPITAL_H
#define TISD_07_CAPITAL_H

#define NMAX 1000
#define RED 1
#define WHITE 0
#define BLACK 2

int color[NMAX];
int s[NMAX];

void color_blind()
{
    for(int i = 0; i < NMAX; i++)
    {
        color[i] = WHITE;
    }
}

void s_blind()
{
    for(int i = 0; i < NMAX; i++)
    {
        s[i] = WHITE;
    }
}

#endif //TISD_07_CAPITAL_H
