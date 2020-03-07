// Lab_01.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include <iostream>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#define MASSIZE 31
#define NMAX 50

using namespace std;

typedef char string_t[NMAX];
typedef struct
{
	int mantissa[MASSIZE];
	int mas_size = 0;
	int power = 0;
    int sign = 1;
}big_number;
int correct_check(char *s)
{
    char* isok = "0123456789.+-Ee";
    //#################################################
    int flag_is_okey;
    for(int i = 0; i < strlen(s) - 1; i++)
    {
        flag_is_okey = 0;
        for(int j = 0; j < strlen(isok); j++)
        {
            if(s[i] == isok[j])
            {
                flag_is_okey = 1;
            }
        }
        if(flag_is_okey == 0)
        {
            return EXIT_FAILURE;
        }
    }
    //#################################################

    int signcount = 0;
    int ecount = 0;
    int pointcount = 0;
    int n = strlen(s) - 1;
    int epointer = -1;
    for (int i = 0; i < n; i++)
    {
        if ((s[i] == 'e') || (s[i] == 'E'))
        {
            epointer = i;
            ecount++;
        }
    }
    //################################################


    if (ecount == 0)
    {
        for(int i = 0; i < strlen(s) - 1; i++)
        {
            if (s[i] == '.')
            {
                pointcount++;
            }
            if ((s[i] == '+') || (s[i] == '-'))
            {
                signcount++;
            }

        }
        if (signcount > 1 || pointcount > 1)
        {
            cout << "Error! Wrong format";
            return EXIT_FAILURE;
        }
        return EXIT_SUCCESS;
    }
    if (ecount == 1)
    {
        cout << endl << endl;
        for(int i = 0; i < epointer; i++)
        {
            if (s[i] == '.')
            {
                pointcount++;
            }
            if ((s[i] == '+') || (s[i] == '-'))
            {
                signcount++;
            }
        }
        if (signcount > 1 || pointcount > 1)
        {
            cout << "Error! Wrong format";
            return EXIT_FAILURE;
        }
        int signcount = 0;
        int pointcount = 0;
        int afterecounter = 0;
        cout << endl << endl;
        for(int i = epointer + 1; i < n; i++)
        {
            if (s[i] == '.')
            {
                pointcount++;
            }
            if ((s[i] == '+') || (s[i] == '-'))
            {
                signcount++;
            }
            afterecounter++;
        }
        if (afterecounter > 4)
        {
            cout << "Error! Power overflow";
            return EXIT_FAILURE;
        }
        if (signcount > 1 || pointcount > 0)
        {
            cout << "Error! Wrong format";
            return EXIT_FAILURE;
        }
        return EXIT_SUCCESS;
        //все ок
    }
    else
    {
        cout << "Error! Wrong format";
        return EXIT_FAILURE;
    }
    /*
    for(int i = 0; i < strlen(s) - 1; i++)
    {
        if ((s[i] == 'e') || (s[i] == 'E'))
        {
            ecount++;
        }
        if (s[i] == '.')
        {
            pointcount++;
        }
        if ((s[i] == '+') || (s[i] == '-'))
        {
            signcount++;
        }

    }
    if ((pointcount > 1) || (ecount > 1) || (signcount > 1))
    {
        return EXIT_FAILURE;
    }
    int flag_is_okey;
    for(int i = 0; i < strlen(s) - 1; i++)
    {
        flag_is_okey = 0;
        for(int j = 0; j < strlen(isok); j++)
        {
            if(s[i] == isok[j])
            {
                flag_is_okey = 1;
            }
        }
        if(flag_is_okey == 0)
        {
            return EXIT_FAILURE;
        }
    }
    */
    return EXIT_SUCCESS;

}
void true_output(big_number* num)
{
    if (num->power > 9999)
    {
        cout << "Error, power overflow";
    }
    else
    {
        cout << endl;
        if (num->sign == -1)
        {
            cout << '-';
        }
        cout << "0.";
        for (int i = 0; i < num->mas_size; i++)
        {
            cout << num->mantissa[i];
        }
        cout << "E" << num->power + num->mas_size;
    }
}
void helper(int mode)
{
    switch(mode){
    case 0:
        cout << "Welcome!" << endl << "Gonna divide first number by second number" << endl;
        cout << "Correct input example:" << endl;
        cout << "2" << endl << "2.0" << endl << "2e0" << endl << "2E0" << endl << "2.0E0" << endl << "2.0e0" << endl;
        break;
    case 1:
        cout << "                    ";
        for (int i = 0; i < 30; i++)
        {
            cout << "-";
        }
        cout << "|" << endl;
        cout << "Input first number: ";
        break;
    case 2:
        cout << "                     ";
        for (int i = 0; i < 30; i++)
        {
            cout << "-";
        }
        cout << "|" << endl;
        cout << "Input second number: ";
        break;
    default:
        break;

    }
}
int is_zero(int* mas, int mas_size)
{
	for (int i = 0; i < mas_size; i++)
	{
		if (mas[i] != 0)
		{
			return 0;
		}
	}
	return 1;

}
void res_init(int* res)
{
	for (int i = 0; i < MASSIZE; i++)
	{
		res[i] = 0;
	}
}
void info(big_number* num)
{
	cout << "INFO RESULT:" << endl;
	if (num->mas_size == 0)
	{
		cout << "No mantissa";
	}
	else
	{
		if (num->sign == -1)
		{
			cout << '-';
		}
		for (int i = 0; i < num->mas_size; i++)
		{
			cout << num->mantissa[i];
		}
		cout << 'E' << num->power;
	}
	cout << endl;
}
void test_string_output(string_t s, int st, int en)
{
	cout << "Test string output:" << endl;
	for (int i = st; i < en; i++)
	{
		cout << s[i];
	}
	cout << endl << "Thats all;" << endl;
}
int digit(char c)
{
	return ((int)c - ((int)('0')));
}
int string_to_mantissa(string_t s, int index_start_from, int index_to, big_number* num)
{
	int i;
	int k = 0;
    int n;
    int flag_after_point = 0;
    if (s[index_start_from] == '-')
    {
        num->sign = -1;
        index_start_from++;
    }
    else
    {
        num->sign = 1;
    }

	if (s[index_start_from] == '.')
	{
		index_start_from++;
		flag_after_point = 1;
	}
	while (s[index_start_from] == '0')
	{
		flag_after_point++;
		index_start_from++;
	}
	for (i = index_start_from; ((i <= index_to) && (s[i] != '\n')); i++)
	{
        n = digit(s[i]);
		if ((n < 0) || (n > 9))
		{
			if (s[i] != '.')
			{
				return -1;
			}
			flag_after_point = 1;
		}
		else
		{
			if (flag_after_point)
			{
				flag_after_point++;
			}
			num->mantissa[k] = n;
			k++;
		}
	}
	if (flag_after_point)
	{
		//cout << "Point found. Afterpoint is " << flag_after_point - 1;
		num->power -= flag_after_point - 1;
		//cout << "\n";
	}
	num->mas_size = k;
	return EXIT_SUCCESS;
}
int parcer(string_t s, big_number* num)
{
	int n = strlen(s);
	int i;
	int e_pos;
	int flag = 0; // 0 - E не присутсвует, 1 - присутвует
	int flag_point = 0; // 0 - точки нет, 1 - есть
    /*if (s[0] == '-')
    {
        cout << "ITS MINUS" << endl;
        num->sign = -100;
    }
    */
	for (i = 0; i < n - 1; i++)
	{
		if ((s[i] == 'e') || (s[i] == 'E'))
		{
			flag = 1;
			e_pos = i;
		}
		if (s[i] == '.')
		{
			flag_point = 1;
		}
	}
	if (flag)
	{
		// Е встретилось
		i = 0;
		while (s[i] == '0')
		{
			i++;
		}
		int j = e_pos - 1;
		if (flag_point)
		{
			while (s[j] == '0')
			{
				j--;
			}
		}
		string_to_mantissa(s, i, j, num);
		//Закончили с мантиссой
		i = e_pos + 1;
		int modifier = 1;
		if (s[i] == '-')
		{
			i++;
			modifier = -1;
		}
		else if (s[i] == '+')
		{
			i++;
		}
		int save = i;
		j = 0;
		int sum = 0;
		for (i = n - 2; i >= save; i--)
		{
			sum += digit(s[i]) * pow(10, j);
			j++;
		}
		num->power += sum * modifier;
	}
	else
	{
		//cout << "###############\nE not found\n###############\n\n";
		i = 0;
		while (s[i] == '0')
		{
			i++;
		}
		int j = n - 2;
		if (flag_point)
		{
			while (s[j] == '0')
			{
				j--;
			}
		}
		string_to_mantissa(s, i, j, num);
	}
    //cout << "before info : " << num->sign << endl;
    //info(num);
	return EXIT_SUCCESS;
}
void crest(big_number* num)
{
	int n = num->mas_size - 1;
	while (num->mantissa[n] == 0)
	{
		num->power++;
		n--;
	}
	n++;
	num->mas_size = n;
}
int mantissa_comparison(int* first, int* second, int first_mas_size, int second_mas_size)
{
	if (first_mas_size > second_mas_size)
	{
		//ok
		return EXIT_SUCCESS;
	}
	else if (first_mas_size == second_mas_size)
	{
		int n = first_mas_size;
		int i = 0;
		while ((first[i] >= second[i]) && (i <= n))
		{
			if (first[i] > second[i])
			{
				return EXIT_SUCCESS;
			}
			i++;
		}
		if (i < n)
		{
			//ne ok
			return EXIT_FAILURE;
		}
		else
		{
			//ok
			return EXIT_SUCCESS;
		}
	}
	else
	{
		//cout << "=====" << first_mas_size - second_mas_size << endl;
		return EXIT_FAILURE;
	}
}
int subtraction(int* first, int* second, int n, int m, int* res)
{
	// First > second, могут быть разной длинны
	int new_first[MASSIZE];
	int new_second[MASSIZE];
	int k = 0;
	for (int i = 0; i < n; i++)
	{
		new_first[i] = first[i];
	}
	int j;
	for (j = 0; j < abs(n - m); j++)
	{
		new_second[j] = 0;
	}
	for (int i = j; i < n; i++)
	{
		new_second[i] = second[k];
		k++;
	}
	n -= 1;
	// n - длинна наибольшего числа
	// Гарантированно, что first > second, и что они одинаковой длинны


	for (int i = n; i >= 0; i--)
	{
		if (new_first[i] >= new_second[i])
		{
			res[i] = new_first[i] - new_second[i];
		}
		else
		{
			int j = i;
			while ((new_first[j] < new_second[j]) && (j > 0))
			{
				j--;
			}
			new_first[j]--;
			for (int k = j + 1; k < i; k++)
			{
				new_first[k] += 9;
			}
			new_first[i] += 10;
			res[i] = new_first[i] - new_second[i];
		}

	}

	/*
	cout << endl;
	for (int i = 0; i <= n; i++)
	{
		cout << first[i];
	}
	cout << endl;
	for (int i = 0; i <= n; i++)
	{
		cout << new_second[i];
	}
	cout << endl;
	for (int i = 0; i <= n; i++)
	{
		cout << "-";
	}
	cout << endl;
	for (int i = 0; i <= n; i++)
	{
		cout << res[i];
	}
	cout << endl;
	*/
	return n + 1;

}
void zerobegin_delete(int* mas, int* n)
{
	int i = 0;
	while ((mas[i] == 0) && ((*n) > 1))
	{
		for (int j = 1; j < *n; j++)
		{
			mas[j - 1] = mas[j];
		}
		(*n)--;
	}
	/*
	if ((*n) == 0)
	{
		mas[0] = 0;
		(*n) = 1;
	}
	*/
}
int divide(big_number* first, big_number* second, big_number* result, big_number *to_put_answer)
{
    big_number answer;
    answer = *to_put_answer;
	int solution;
	int from[MASSIZE];
	int n = 1;
	int to_minus_from_power = 0;
	int pointer_to_take;
	from[0] = first->mantissa[0];
	int i = 1;
	while (mantissa_comparison(from, second->mantissa, n, second->mas_size))
	{
		from[i] = first->mantissa[i];
		n++;
		first->power--;
		i++;
	}
	pointer_to_take = i;
	result->mas_size = n;
	for (int i = 0; i < n; i++)
	{
		result->mantissa[i] = from[i];
	}
	pointer_to_take--;
	result->mas_size--;
	n--;

	/*
		^
		| Инициализировалли первое число, из которого потом будем вычитать
	*/

	do {
		result->mantissa[result->mas_size] = first->mantissa[pointer_to_take];
		result->mas_size++;
		pointer_to_take++;
		solution = 0;
		
		zerobegin_delete(result->mantissa, &(result->mas_size));
		while (!mantissa_comparison(result->mantissa, second->mantissa, result->mas_size, second->mas_size))
		{

			n = result->mas_size;
			for (int i = 0; i < n; i++)
			{
				from[i] = result->mantissa[i];
			}
			result->mas_size = subtraction(from, second->mantissa, n, second->mas_size, result->mantissa);
			zerobegin_delete(result->mantissa, &(result->mas_size));
			n = result->mas_size;
			for (int i = 0; i < n; i++)
			{
				from[i] = result->mantissa[i];
			}
			solution++;
		}
		answer.mantissa[answer.mas_size++] = solution;
		
	} while (pointer_to_take < first->mas_size);

	cout << endl << endl;
	/*cout << "res is: ";
	for (int i = 0; i < result->mas_size; i++)
	{
		cout << result->mantissa[i];
	}
	*/
	//#####################################################################################
	//							Деление после точки
	//#####################################################################################
	while (!is_zero(result->mantissa, result->mas_size) && (answer.mas_size <= 30))
	{
		result->mantissa[result->mas_size] = 0;
		result->mas_size++;
		solution = 0;
		zerobegin_delete(result->mantissa, &(result->mas_size));
		while (!mantissa_comparison(result->mantissa, second->mantissa, result->mas_size, second->mas_size))
		{

			n = result->mas_size;
			for (int i = 0; i < n; i++)
			{
				from[i] = result->mantissa[i];
			}
			result->mas_size = subtraction(from, second->mantissa, n, second->mas_size, result->mantissa);
			zerobegin_delete(result->mantissa, &(result->mas_size));
			n = result->mas_size;
			for (int i = 0; i < n; i++)
			{
				from[i] = result->mantissa[i];
			}
			solution++;
		}
		to_minus_from_power++;
		answer.mantissa[answer.mas_size++] = solution;
	}
	//*to_put_answer = answer;
	answer.power -= to_minus_from_power;
    //info(&answer);
    true_output(&answer);
    cout << endl;
	return 0;
}

int main()
{
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени
    //Доделать проверку на 5 знаков в степени

    //############################################
    big_number first;
    big_number second;
	big_number fake;
	big_number answer;

	int test[MASSIZE];
	int from[MASSIZE];
	res_init(test);
    int n;

	string_t one;
	string_t two;
	///#######################################

    helper(0);
    helper(1);
    //#################################################################################
    fgets(one, NMAX, stdin);				 //}   <- Считали строку с первым числом
    if (strlen(one) > 31)
    {
        cout << "Eror! Incorrect length!" << endl;
        return EXIT_FAILURE;
    }

    if (correct_check(one))
    {
        cout << "Error! Wrong format! " << endl;
        return EXIT_FAILURE;
    }

    parcer(one, &first);				     //}
    crest(&first);		                     //}	<- Причесали первое число

    //#################################################################################






    helper(2);
    //#################################################################################
	fgets(two, NMAX, stdin);				 //}
    if (strlen(two) > 31)
    {
        cout << "Eror! Incorrect length!" << endl;
        return EXIT_FAILURE;
    }
    if (correct_check(two))
    {
        cout << "Error! Wrong format!" << endl;
        return EXIT_FAILURE;
    }
    parcer(two, &second);
    crest(&second);							 //}

    //#################################################################################
    if (is_zero(second.mantissa, second.mas_size))
    {
        cout << "Error, division by zero" << endl;
        return EXIT_FAILURE;
    }
    if (is_zero(first.mantissa, second.mas_size))
    {
        cout << "0E0" << endl;
        return EXIT_SUCCESS;
    }
	//#########################################################################################
	from[0] = first.mantissa[0];
	n = 1;


	while (mantissa_comparison(first.mantissa, second.mantissa, first.mas_size, second.mas_size))
	{
		first.mantissa[first.mas_size] = 0;
		first.mas_size++;
		first.power--;
	}
    answer.power = first.power - second.power;
	answer.sign = first.sign * second.sign;
	divide(&first, &second, &fake, &answer);
	/*
	info(&first);
	info(&second);
    */
	return 0;
}
