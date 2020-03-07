#ifndef LAB_05_TISD_LIST_H
#define LAB_05_TISD_LIST_H
#include <stdlib.h>
#include <stdio.h>
#include "queue_v.h"
#include <iostream>

using namespace std;

struct Node
{
    int timer_arrived;
    int time_service;
    Node *next;
};

struct Queue
{
    int size;
    Node *first;
    Node *last;
};

Node* masdel[20000];
int msize = 0;

void Creation(Queue *Q)
{
    Q->first=new Node;
    Q->first->next= NULL;
    Q->last=Q->first;
    Q->size=0;
}

void Add(Queue *Q, int time_arv, int time_srv)
{
    Q->last->next=new Node;
    Q->last=Q->last->next;
    Q->last->time_service = time_srv;
    Q->last->timer_arrived = time_arv;
    Q->last->next=NULL; //обнуление указателя на следующий элемент
    Q->size++;
    for(int i = 0; i < msize; i++)
    {
        if (Q->last == masdel[i]) {
            for (int j = i; j < msize - 1; j++) {
                masdel[j] = masdel[j + 1];
            }
            msize--;
        }
        break;
    }
}
void Delete(Queue *Q)
{
    //cout << "Gonna delete " << Q->first->next << endl;
    Node *tmp;
    tmp = Q->first->next;
    //Q->first = Q->first->next; //смещение указателя
    //cout << "Free at address " << Q->first << endl;
    masdel[msize++] = Q->first;
    free(Q->first);
    Q->first = tmp;
    Q->size--;
}
void Output(Queue *Q)
{
    Node *i;
    i = Q->first;
    for (int j = 0; j < Q->size; j++)
    {
        cout << i->next->timer_arrived << endl;
        i = i->next;
    }

}

void worker_with_list_adr(int t_arrived_max, int t_arrived_min, int t_service_max, int t_service_min)
{

    v_init_vip(1500, t_arrived_max, t_arrived_min, t_service_max, t_service_min);
    v_init_basic(20000, t_arrived_max, t_arrived_min, t_service_max, t_service_min);

    Queue vip_q;
    Queue basic_q;

    Creation(&vip_q);
    Creation(&basic_q);


    int timer = 0;
    const int MAGIC = 1000;
    int vip_passed = 0;
    bool is_basic_in_oa = false;
    int throwed = 0;
    int time_second_servicing = 0;
    int success = 0;

    while (vip_passed < MAGIC)
    {
        //#################################################################################

        // checking is is time to send vip in oa
        for (int j = vip.head; vip.time_arrived[j] <= timer; j++)
        {
            Add(&vip_q, vip.time_arrived[vip.head], vip.time_service[vip.head]);
            cout << "Added element on address " << &(vip_q.last->next) << endl;
            vip.head++;
            //cout << "Added vip at time " << (double)timer / 1000 << endl;
        }
        // checking is is time to send basic in oa
        for (int j = basic.head; basic.time_arrived[j] <= timer; j++)
        {
            Add(&basic_q, basic.time_arrived[basic.head], basic.time_service[basic.head]);
            basic.head++;
            //cout << "Added basic at time " << (double)timer / 1000 << endl;
            // Output(&basic_q);
        }

        //#################################################################################

        if (vip_q.size) // if smt in vip queue
        {

            if (!(vip_passed % 100) && vip_passed != 0)
            {
                cout << "served                     : " << vip_passed << endl;
                cout << "current vip queue length   : " << vip_q.size << endl;
                cout << "current basic queue length : " << basic_q.size << endl;
                //cout << "debug :" << local_basic.tail << " " << local_basic.head << endl;
                cout << "time is                    : " << (double)timer / 1000 << endl << endl << endl;

            }


            if (is_basic_in_oa)
            {
                is_basic_in_oa = false;
                // pushing basic element from oa to the end of the basic queue
                Add(&basic_q, basic_q.first->next->timer_arrived, basic_q.first->next->time_service);
                Delete(&basic_q);
                cout << "basic throwed" << endl;
                throwed++;

                time_second_servicing = 0;
            }
            timer += vip_q.first->next->time_service;
            vip_passed++;
            Delete(&vip_q);
        }
        else // if vip queue is empty
        {
            if (!is_basic_in_oa)
            {
                if (basic_q.size)
                {
                    is_basic_in_oa = true;
                }
            }

            if (is_basic_in_oa)
            {
                time_second_servicing++;
                if (time_second_servicing == basic_q.first->next->time_service)
                {
                    Delete(&basic_q);
                    cout << "Basic served" << endl;
                    is_basic_in_oa = false;
                    //cout << "basic passed at time " << (double)timer / 1000 << endl;
                    time_second_servicing = 0;
                    success++;
                }
            }

        }
        timer++;
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
    cout << "requests in       : " << MAGIC + basic.head << endl;
    cout << "requests out      : " << MAGIC + success << endl;
    cout << "error koeffecient : " << fabs((double)(result_error - timer)) / result_error * 100 << "%" << endl;

}


void worker_with_list(int t_arrived_max, int t_arrived_min, int t_service_max, int t_service_min)
{

    //v_init_vip(1500, t_arrived_max, t_arrived_min, t_service_max, t_service_min);
    //v_init_basic(20000, (int)(3 * 1000), (int)(0 * 1000), (int)(1 * 1000), (int)(0 * 1000));
    int frm;
    cout << "Do you want to see mem.fragmentation?" << endl << "1.Yes" << endl << "0.No" << endl;
    cin >> frm;


    Queue vip_q;
    Queue basic_q;

    Creation(&vip_q);
    Creation(&basic_q);


    int timer = 0;
    const int MAGIC = 1000;
    int vip_passed = 0;
    bool is_basic_in_oa = false;
    int throwed = 0;
    int time_second_servicing = 0;
    int success = 0;

    while (vip_passed <= MAGIC)
    {
        //#################################################################################

        // checking is is time to send vip in oa
        for (int j = vip.head; vip.time_arrived[j] <= timer; j++)
        {
            Add(&vip_q, vip.time_arrived[vip.head], vip.time_service[vip.head]);
            vip.head++;
        }
        // checking is is time to send basic in oa
        for (int j = basic.head; basic.time_arrived[j] <= timer; j++)
        {
            Add(&basic_q, basic.time_arrived[basic.head], basic.time_service[basic.head]);
            basic.head++;
           // Output(&basic_q);
        }

        //#################################################################################

        if (vip_q.size) // if smt in vip queue
        {

            if (!(vip_passed % 100) && vip_passed != 0)
            {
                cout << "served                     : " << vip_passed << endl;
                cout << "current vip queue length   : " << vip_q.size << endl;
                cout << "current basic queue length : " << basic_q.size << endl;
                cout << "time is                    : " << (double)timer / 1000 << endl << endl << endl;

            }


            if (is_basic_in_oa)
            {
                is_basic_in_oa = false;
                // pushing basic element from oa to the end of the basic queue
                Add(&basic_q, basic_q.first->next->timer_arrived, basic_q.first->next->time_service);
                Delete(&basic_q);
                throwed++;

                time_second_servicing = 0;
            }
            timer += vip_q.first->next->time_service;
            vip_passed++;
            Delete(&vip_q);
        }
        else // if vip queue is empty
        {
            if (!is_basic_in_oa)
            {
                if (basic_q.size)
                {
                    is_basic_in_oa = true;
                }
            }

            if (is_basic_in_oa)
            {
                time_second_servicing++;
                if (time_second_servicing >= basic_q.first->next->time_service)
                {
                    Delete(&basic_q);
                    is_basic_in_oa = false;
                    time_second_servicing = 0;
                    success++;
                }
            }

        }
        timer++;
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
//    cout << "requests in       : " << vip.tail + basic.tail << endl;
    cout << "vip requests in    : " << vip.head << endl;
    cout << "baisc requests in  : " << basic.head << endl;
    cout << "requests out      : " << MAGIC + success << endl;
    cout << "error koeffecient : " << fabs((double)(result_error - timer)) / result_error * 100 << "%" << endl;

    if (frm == 1) {
        cout << "Addresses where we could see memory fragmentation: " << endl;
        for (int i = 0; i < msize; i++) {
            cout << masdel[i] << " ";
        }
    }

}

#endif //LAB_05_TISD_LIST_H