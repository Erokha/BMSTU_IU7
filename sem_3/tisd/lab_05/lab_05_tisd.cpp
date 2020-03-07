// lab_05_tisd.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include <iostream>
#include <stdlib.h>
#include <time.h>
#include <stdio.h>
#include "queue_v.h"
#include "list.h"

using namespace std;

/* * * * * * * * * * * * * * * * * * * * * * * * * *
     * oa is an apparat, that service the requests *
     *     requests has two types: vip and basic   *
     *   if it's time to service the vip request   *
     *   we have to do it, no matter is it basic   *
     *   request in oa now. If it is, we have to   *
     *            throw it away                    *
     * * * * * * * * * * * * * * * * * * * * * * * */

int main()
{
    int work_mode;
    cout << "Select work mode:" << endl;
    cout << "1. Massive" << endl;
    cout << "2. List" << endl;
    cin >> work_mode;

    int in_mode;


    double maxta = 5;
    double minta = 1;
    double maxts = 4;
    double mints = 0;

    double bmaxta = 3;
    double bminta = 0;
    double bmaxts = 1;
    double bmints = 0;

/*
    double maxta = 5;
    double minta = 0;
    double maxts = 10;
    double mints = 0;

    double bmaxta = 3;
    double bminta = 0;
    double bmaxts = 1;
    double bmints = 0;
*/

    cout << "Do you want to input your own time limits?" << endl;
    cout << "1.Yes" << endl;
    cout << "0.No" << endl;
    cin >> in_mode;
    if (in_mode)
    {
        cout << "Be careful, only 3 numbers after pont! " << endl;
        cout << "For vip queue:" << endl;
        cout << "Input maximum time arrive:" << endl;
        cin >> maxta;
        cout << "Input minimum time arrive:" << endl;
        cin >> minta;

        cout << "Input maximum time service:" << endl;
        cin >> maxts;
        cout << "Input minumum time service:" << endl;
        cin >> mints;


        cout << "For basic queue:" << endl;
        cout << "Input maximum time arrive:" << endl;
        cin >> bmaxta;
        cout << "Input minimum time arrive:" << endl;
        cin >> bminta;

        cout << "Input maximum time service:" << endl;
        cin >> bmaxts;
        cout << "Input minumum time service:" << endl;
        cin >> bmints;
    }
    if (time_check(int(maxta), int(minta), int(maxts), int(mints)) == EXIT_FAILURE)
    {
        cout << "Error!";
        return EXIT_FAILURE;
    }

    if (time_check(int(bmaxta), int(bminta), int(bmaxts), int(bmints)) == EXIT_FAILURE)
    {
        cout << "Error!";
        return EXIT_FAILURE;
    }


    v_init_vip(4000, (int)(maxta * 1000), (int)(minta * 1000), (int)(maxts * 1000), (int)(mints * 1000));
    v_init_basic(30000, (int)(bmaxta * 1000), (int)(bminta * 1000), (int)(bmaxts * 1000), (int)(bmints * 1000));
    avr();
    if (work_mode == 1) {
        clock_t time_start, time_end, time_spend;
        time_start = clock();

        //v_output(100, 1);
        //worker(5000, 1000, 4000, 0);
        worker_another_ver((int)(maxta * 1000), (int)(minta * 1000), (int)(maxts * 1000), (int)(mints * 1000));
        time_end = clock();
        time_spend = time_end - time_start;
        cout << endl << "Time for realization massive method: " << time_spend;
    }
    else
    {
        clock_t time_start, time_end, time_spend;
        time_start = clock();
        worker_with_list((int)(maxta * 1000), (int)(minta * 1000), (int)(maxts * 1000), (int)(mints * 1000));
        time_end = clock();
        time_spend = time_end - time_start;
        cout << endl << "Time for realization list method: " << time_spend;
    }
    return 0;
}


