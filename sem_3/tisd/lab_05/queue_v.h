#ifndef LAB_05_QUEUE_V_H
#define LAB_05_QUEUE_V_H

#include <stdlib.h>
#include <stdio.h>
#include <random>
#include <time.h>
#include <iostream>
#include <math.h>

using namespace std;

typedef struct list_queue
{
    int time_arrived[40000];
    int time_service[40000];
    int head;
    int tail;
} lq;

lq vip;
lq basic;

int time_check(int t_arrived_max, int t_arrived_min, int t_service_max, int t_service_min)
{
    if (t_arrived_max < 0)
    {
        return EXIT_FAILURE;
    }
    if (t_arrived_min < 0)
    {
        return EXIT_FAILURE;
    }
    if (t_service_max < 0)
    {
        return EXIT_FAILURE;
    }
    if (t_service_min < 0)
    {
        return EXIT_FAILURE;
    }
    if (t_arrived_max < t_arrived_min)
    {
        return EXIT_FAILURE;
    }
    if (t_service_max < t_service_min)
    {
        return EXIT_FAILURE;
    }
    return EXIT_SUCCESS;
}

void v_init_vip(int size, int t_arrived_max, int t_arrived_min, int t_service_max, int t_service_min)
{
    srand(time(NULL));
    //unsigned long long sum = 0;
    for (int i = 0; i < size; i++)
    {
        vip.time_arrived[i] = rand() % (t_arrived_max - t_arrived_min) + t_arrived_min;
        vip.time_service[i] = rand() % (t_service_max - t_service_min) + t_service_min;
        //sum += vip.time_arrived[i];
    }
    for (int i = 1; i < size; i++)
    {
        vip.time_arrived[i] += vip.time_arrived[i - 1];
    }
    vip.head = 0;
    vip.tail = size;
    //cout << sum / size;
}
void v_init_basic(int size, int t_arrived_max, int t_arrived_min, int t_service_max, int t_service_min)
{
    srand(time(NULL));
    for (int i = 0; i < size; i++)
    {
        basic.time_arrived[i] = rand() % (t_arrived_max - t_arrived_min) + t_arrived_min;
        basic.time_service[i] = rand() % (t_service_max - t_service_min) + t_service_min;
    }
    for (int i = 1; i < size; i++)
    {
        basic.time_arrived[i] += basic.time_arrived[i - 1];
    }
    basic.head = 0;
    basic.tail = size;
}
void v_output(int size, int mode) // mode: 1 - only vip, 2 - only basic, 3 - all
{
    if (mode == 1)
    {
        for (int i = 0; i < size; i++)
        {
            cout << "vip[" <<  i << "]: ";
            cout << "time arrived: " << vip.time_arrived[i] << " ";
            cout << "time service: " << vip.time_service[i] << endl;
        }
    }
    else if (mode == 2)
    {
        for (int i = 0; i < size; i++)
        {
            cout << "basic[" << i << "]: ";
            cout << "time arrived: " << vip.time_arrived[i];
            cout << "time service: " << vip.time_service[i] << endl;
        }
    }
    else
    {
        for (int i = 0; i < size; i++)
        {
            cout << "vip[" << i << "]: ";
            cout << "time arrived: " << vip.time_arrived[i];
            cout << "time service: " << vip.time_service[i] << endl;
        }
        cout << endl << endl;
        for (int i = 0; i < size; i++)
        {
            cout << "basic[" << i << "]: ";
            cout << "time arrived: " << vip.time_arrived[i];
            cout << "time service: " << vip.time_service[i] << endl;
        }
    }
}
void avr() //just for debug
{
    unsigned long long sum = 0;
    for (int i = 0; i < 1000; i++)
    {
        sum += vip.time_service[i];
    }
    cout << sum / 1000 << endl;
}

void worker_another_ver(int t_arrived_max, int t_arrived_min, int t_service_max, int t_service_min)
{
    int timer = 0;
    const int MAGIC = 1000;
    lq local_vip;
    lq local_basic;
    local_vip.head = 0;
    local_vip.tail = 0;
    local_basic.head = 0;

    bool is_basic_in_oa = false;
    int time_second_servicing = 0;
    int throwed = 0;
    int success = 0;

    while (local_vip.head <= MAGIC + 1)
    {


        //#################################################################################

        // checking is is time to send vip in local queue
        for (int j = vip.head; vip.time_arrived[j] <= timer; j++)
        {
            local_vip.time_arrived[local_vip.tail] = vip.time_arrived[vip.head];
            local_vip.time_service[local_vip.tail] = vip.time_service[vip.head];
            vip.head++;
            local_vip.tail++;
        }
        // checking is is time to send basic in local queue
        for (int j = basic.head; basic.time_arrived[j] <= timer; j++)
        {
            local_basic.time_arrived[local_basic.tail] = basic.time_arrived[basic.head];
            local_basic.time_service[local_basic.tail] = basic.time_service[basic.head];
            basic.head++;
            local_basic.tail++;
        }

        //#################################################################################
        if (local_vip.head != local_vip.tail) // if vip queue is not empty
        {
            if (!(local_vip.head % 100) && local_vip.head != 0)
            {
                cout << "served                     : " << local_vip.head << endl;
                cout << "current vip queue length   : " << local_vip.tail - local_vip.head << endl;
                cout << "current basic queue length : " << local_basic.tail - local_basic.head << endl;
                cout << "time is                    : " << (double)timer / 1000 << endl << endl << endl;
            }



            if (is_basic_in_oa)
            {
                is_basic_in_oa = false;

                // pushing basic element from oa to the end of the basic queue
                local_basic.time_arrived[local_basic.tail] = local_basic.time_arrived[local_basic.head];
                local_basic.time_service[local_basic.tail] = local_basic.time_service[local_basic.head];
                local_basic.tail++;
                local_basic.head++;
                throwed++;

                time_second_servicing = 0;
            }
            timer += local_vip.time_service[local_vip.head];
            local_vip.head++;
        }
        else // if vip queue is empty
        {
            if (!is_basic_in_oa)
            {
                if (local_basic.head != local_basic.tail)
                {
                    is_basic_in_oa = true;
                }
            }

            if (is_basic_in_oa)
            {
                time_second_servicing++;
                if (time_second_servicing >= local_basic.time_service[local_basic.head])
                {
                    local_basic.head++;
                    is_basic_in_oa = false;
                    time_second_servicing = 0;
                    success++;
                }
            }
        }
        timer++;
    }

    int result_error;
    if ((t_arrived_max + t_arrived_min) >= (t_service_max + t_service_min))
    {
        result_error = MAGIC * (t_arrived_max + t_arrived_min) / 2;
    }
    else
    {
        result_error = MAGIC * (t_service_max + t_service_min) / 2;
    }
    /*
    cout << "time spend        : " << (double)timer / 1000 << endl;

    cout << "successfulu passed: " << succes << endl;
     */
    cout << "time spend        : " << (double)timer / 1000 << endl;
    cout << "\'throwed\'         : " << throwed << endl;
    cout << "vip requests in    : " << vip.head << endl;
    cout << "baisc requests in  : " << basic.head << endl;
    cout << "requests out      : " << local_vip.head + success << endl;
    cout << "error koeffecient : " << fabs((double)(result_error - timer)) / result_error * 100 << "%" << endl;

}

void worker(int t_arrived_max, int t_arrived_min, int t_service_max, int t_service_min)
{
    /* * * * * * * * * * * * * * * * * * * * * * * *
     * oa is an apparat, that service the requests *
     *     requests has two types: vip and basic   *
     *   if it's time to service the vip request   *
     *   we have to do it, no matter is it basic   *
     *   request in oa now. If it is, we have to   *
     *            throw it away                    *
     * * * * * * * * * * * * * * * * * * * * * * * */
    int timer = 0;
    const int MAGIC = 1000;
    vip.head = 0;
    basic.head = 0;
    bool is_second_in_oa = false;
    bool is_vip_in_oa = false;
    int throwed = 0;
    int second = 0;
    int succes = 0;
    //timer = 1400;




    while (vip.head <= MAGIC)
    {

        // checking 'is is time to send vip in oa
        if (vip.time_arrived[vip.head] <= timer)
        {
            is_vip_in_oa = true;
            if (!(vip.head % 100) && vip.head != 0)
            {
                cout << "served : " << vip.head << endl;
                cout << "time is: " << (double)timer / 1000 << endl << endl << endl;
            }
            if (is_second_in_oa)
            {
                // need to throw it out from array;
                // cout << "Throwing basic [" << basic.head << "]" << endl;
                // cout << "At time " << timer << endl;
                basic.head++;
                is_second_in_oa = false;
                throwed++;
            }
            timer += vip.time_service[vip.head];
            vip.head++;
        }
        // not time yet
        else
        {   
            if (!is_second_in_oa) // need push second to oa if possible
            {
                if (basic.time_arrived[basic.head] <= timer)
                {
                    is_second_in_oa = true; // pushing if possible
                }
            }
            if (is_second_in_oa) // if second in oa, then servicing
            {
                basic.time_service[basic.head]--;
                second++;
                if (basic.time_service[basic.head] <= 0)
                {
                    basic.head++;
                    is_second_in_oa = false;
                    succes++;
                }
            }
            timer++;
        }
    }

    int result_error;
    if ((t_arrived_max + t_arrived_min)/2 >= (t_service_max + t_service_min)/2)
    {
        result_error = MAGIC * (t_arrived_max + t_arrived_min) / 2;
    }
    else
    {
        result_error = MAGIC * (t_service_max + t_service_min) / 2;
    }

    cout << "time spend        : " << (double)timer / 1000 << endl;
    cout << "\'throwed\'         : " << throwed << endl;
    cout << "requests out      : " << MAGIC + succes << endl;
    cout << "error koeffecient : " << fabs((double)(result_error - timer)) / result_error * 100 << "%" << endl;
    //cout << "successfulu passed: " << succes << endl;
}

#endif //LAB_05_QUEUE_V_H