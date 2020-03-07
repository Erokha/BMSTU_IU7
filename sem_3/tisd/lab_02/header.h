#include <string>
#include <locale.h>
#include <iostream>
#include <cstring>
#include <time.h>
#define EPS 1e-6

#define dbfilename "output.txt"
using namespace std;
// адрес 20
// площадь 7
// число комнат 13
// цена метра 15
// тип жилья 9
// отделка 9
// год постройки 14
// владельцы 7
// жильцы 7
// животные 8


typedef struct secondary_p
{
	int year_of_build;
	int number_of_owners;
	int number_of_livers;
	bool animals;
} secondary_p;
typedef struct primary_p
{
	bool is_finish;
} primary_p;
typedef struct flat
{
    int mode;						// type of flat primary or secondary
	char address[20];
    int area;
    int number_of_rooms;
    double cost_per_meter;
    union
    {
		primary_p primary;
		secondary_p secondary;
    };
} flat;
char all_to_small_register(char ch)
{
    const char* big =   "QWERTYUIOPASDFGHJKLZXCVBNM";
    const char* small = "qwertyuiopasdfghjklzxcvbnm";
    for (int i = 0; i < int(strlen(big)); i++)
    {
        if (ch == big[i])
        {
            return small[i];
        }
    }
    return ch;
}
int write_building_in_file(FILE* file, flat fl)
{
	int rc;
	rc = fprintf(file, "%-2d%-20s%-7d%-13d%-15.2lf", fl.mode, fl.address, fl.area, fl.number_of_rooms, fl.cost_per_meter);
	if (fl.mode == 1)
	{
		rc += fprintf(file, "%-9d\n", fl.primary.is_finish);
	}
	else
	{
		rc += fprintf(file, "%-14d%-7d%-7d%-8d\n", fl.secondary.year_of_build, fl.secondary.number_of_owners, fl.secondary.number_of_livers, fl.secondary.animals);
	}
	return rc;
}
int read_building_from_file(FILE* file, flat *fl)
{
    int error = 0;
	int fin = 0;
    char address[20];
    error += fscanf(file, "%2d", &fl->mode);
    error += fscanf(file, "%20s", address);
    error += fscanf(file, "%7d", &fl->area);
    error += fscanf(file, "%13d", &fl->number_of_rooms);
    error += fscanf(file, "%15lf", &fl->cost_per_meter);
	if (fl->mode == 1)
	{
		error += fscanf(file, "%9d", &fin);
		fl->primary.is_finish = bool(fin);
	}
	else
	{
		error += fscanf(file, "%14d%7d%7d%8d", &fl->secondary.year_of_build, &fl->secondary.number_of_owners, &fl->secondary.number_of_livers, &fin);
		fl->secondary.animals = bool(fin);
	}
    strcpy(fl->address, address);
    //cout << "address is: " << address << endl;
    return error;
}
void delete_from_db(flat *mas, int *n, int pointer_to_delete)
{
    for (int i = pointer_to_delete; i < *n; i++)
    {
        mas[i] = mas[i + 1];
    }
    (*n)--;

}
int menu()
{
    int user_choice = 0;
    for (int i = 0; i <= 80; i++)
    {
        cout << "-";
    }
    cout << endl;
	cout << "1. Print DB" << endl;
    cout << "2. Add record to DB" << endl;
	cout << "3. Sort" << endl;
    cout << "4. Delete element from DB" << endl;
    cout << "5. Search as task" << endl;
    cout << "7. Save DB to file" << endl;
	cout << "0. Load DB from file" << endl;
    for (int i = 0; i <= 80; i++)
    {
        cout << "-";
    }
    cout << endl << ">> ";
	cin >> user_choice;
    cout << endl << endl;
    return user_choice;
}
void srt_output()
{
    cout << "+--------------------+-------+-------------+---------------+---------+---------+--------------+-------+--------+--------+---+" << endl;
    cout << "|                                             Sorted by cost per meter                                                      |" << endl;
}
void header_output()
{
    cout << "+--------------------+-------+-------------+---------------+---------+---------+--------------+-------+--------+--------+---+" << endl;
    cout << "|Address             |Area   |Num of rooms |cost per meter |type     |finish   |year of build |Owners |Tenatns |Animals |pos|" << endl;
    cout << "|                    |       |             |               |         |         |              |       |        |        |   |" << endl;
    cout << "+--------------------+-------+-------------+---------------+---------+---------+--------------+-------+--------+--------+---+" << endl;
}
void flat_output(flat fl, int id)
{
    printf("|");
    printf("%-20s|", fl.address);
    printf("%-7d|", fl.area);
    printf("%-13d|", fl.number_of_rooms);
    printf("%-15.2lf|", fl.cost_per_meter);
    if (fl.mode == 1)
    {
        printf("primary  |");
        if (fl.primary.is_finish)
        {
            printf("%-9s|", "yes");
        }
        else
        {
            printf("%-9s|", "no");
        }
        printf("%-14s|", "");
        printf("%-7s|", "");
        printf("%-8s|", "");
        printf("%-8s|", "");
    }
    else {
        printf("secondary|");
        printf("%-9s|", " ");
        printf("%-14d|", fl.secondary.year_of_build);
        printf("%-7d|", fl.secondary.number_of_owners);
        printf("%-8d|", fl.secondary.number_of_livers);
        if (fl.secondary.animals)
        {
            printf("%-8s|", "yes");
        }
        else
        {
            printf("%-8s|", "no");
        }
    }
    printf("%3d|\n", id);
    cout << "+--------------------+-------+-------------+---------------+---------+---------+--------------+-------+--------+--------+---+" << endl;
}
void flat_input(flat* a)
{
    int type;
    int cur;
    cout << "Input type of flat(1 - primary, 2 - secondary): ";
    cin >> type;
    a->mode = type;
    while (!((type == 1) || (type == 2)))
    {
        cout << "Something went wrong!\nInput type of flat(1 - primary, 2 - secondary: ";
        cin >> type;
    }
    cout << "Input address(less than 20 symbols, use '_' insted of ' '): ";
    cin >> a->address;
    cout << "Input area: ";
    cin >> a->area;
    cout << "Input number of rooms: ";
    cin >> a->number_of_rooms;
    cout << "Input cost per square meter: ";
    cin >> a->cost_per_meter;
    if (type == 1)
    {
    //##########################################################
    //This is primary
        cout << "Is there a finish in the apartament(1-yes, 0 - no)?: ";
        cin >> cur;
        while (!((cur == 1) || (cur == 0)))
        {
			cout << "Error! Wrong format" << endl;
			cout << "Is there a finish in the apartament(1-yes, 0 - no)?: ";
            cin >> cur;
        }
        if (cur == 1)
        {
            a->primary.is_finish = true;
        } else
        {
			a->primary.is_finish = false;
        }
    }
    else
    {
	//##########################################################
	//This is secondary
        cout << "Input year of build: ";
        cin >> a->secondary.year_of_build;
        cout << "Input number of owners: ";
        cin >> a->secondary.number_of_owners;
        cout << "Input number of Tenatns: ";
        cin >> a->secondary.number_of_livers;
        cout << "Were there an animals in the apartament(1-yes, 0 - no)?: ";
        cin >> cur;
        while (!((cur == 1) || (cur == 0)))
        {
			cout << "Error! Wrong format" << endl;
			cout << "Were there an animals in the apartament(1-yes, 0 - no)?: ";
            cin >> cur;
        }
        if (cur == 1)
        {
            a->secondary.animals = true;
        } else
        {
            a->secondary.animals = false;
        }
    }
}
void mysort_bubble(flat* mas, int n)
{
    //***********************
    // Without key
    //***********************
	flat buf;
	flat new_mas[100];
	clock_t time_start, time_end;
	time_start = clock();
	for (int i = 0; i < n; i++)
	{
		new_mas[i] = mas[i];
	}
	for (int i = 0; i < n; i++)
	{
		for (int j = n - 1; j > i; j--)
		{
			if (new_mas[j - 1].cost_per_meter > new_mas[j].cost_per_meter)
			{
				buf = new_mas[j - 1];
				new_mas[j - 1] = new_mas[j];
				new_mas[j] = buf;
			}
		}
	}
	srt_output();
	header_output();
	for (int i = 0; i < n; i++)
	{
        flat_output(new_mas[i], i + 1);
	}
	time_end = clock();
	clock_t time_spend = time_end - time_start;
	cout << "time spend in: " << double(time_spend) << endl;

    //***********************
	// With keys
    //***********************

	int key[100];
	for (int i = 0; i < n; i++) 
	{
		key[i] = i;
	}
	time_start = clock();
	for (int i = 0; i < n; i++)
	{
		for (int j = n - 1; j > i; j--)
		{
			if (new_mas[j - 1].cost_per_meter > new_mas[j].cost_per_meter)
			{
				int a = key[j - 1];
				key[j - 1] = key[j];
				key[j] = a;
			}
		}
	}
	srt_output();
	header_output();
	for (int i = 0; i < n; i++)
	{
        flat_output(new_mas[key[i]], i + 1);
	}
    time_end = clock();
	time_spend = time_end - time_start;
	cout << "time spend: " << double(time_spend) << endl;

}
void mysort_insert(flat* mas, int n)
{
    //***********************
    // Without key
    //***********************
    flat buf;
    int buf_index;
    flat new_mas[100];
    clock_t time_start, time_end;
    time_start = clock();

    for (int i = 0; i < n; i++)
    {
        new_mas[i] = mas[i];
    }

    for (int i = 0; i < n; i++)
    {
        buf = new_mas[i];
        buf_index = i;
        for (int j = i; j < n; j++)
        {
            if (new_mas[j].cost_per_meter < buf.cost_per_meter)
            {
                buf = new_mas[j];
                buf_index = j;
            }
        }
        new_mas[buf_index] = new_mas[i];
        new_mas[i] = buf;
    }
    srt_output();
    header_output();
    for (int i = 0; i < n; i++)
    {
        flat_output(new_mas[i], i + 1);
    }
    time_end = clock();
    clock_t time_spend = time_end - time_start;
    cout << "time spend in: " << double(time_spend) << endl;
    //***********************
    // With keys
    //***********************

    int key[100];
    for (int i = 0; i < n; i++)
    {
        key[i] = i;
    }
    time_start = clock();
    for (int i = 0; i < n; i++)
    {
        buf = new_mas[i];
        buf_index = i;
        for (int j = i; j < n; j++)
        {
            if (new_mas[j].cost_per_meter < buf.cost_per_meter)
            {
                buf = new_mas[j];
                buf_index = j;
            }
        }
        new_mas[buf_index] = new_mas[i];
        new_mas[i] = buf;
    }
    srt_output();
    header_output();
    for (int i = 0; i < n; i++)
    {
        flat_output(new_mas[key[i]], i + 1);
    }
    time_end = clock();
    time_spend = time_end - time_start;
    cout << "time spend: " << double(time_spend) << endl;
}
void search(flat* mas, double up, double down, int n)
{
    int p = 1;
    header_output();
    for(int i = 0; i < n; i++)
    {
        if ((mas[i].mode == 2) && (mas[i].number_of_rooms == 2) && (mas[i].secondary.animals == false))
        {
            if ((mas[i].cost_per_meter > down) && (mas[i].cost_per_meter < up))
            {
                flat_output(mas[i], p);
                p++;
            }
        }
    }
}
