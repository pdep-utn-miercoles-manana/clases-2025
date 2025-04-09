#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

bool even(const int number);
int* even_numbers_v1(const int* number, const int count);
int* even_numbers_v2(const int* numbers, const int count);
int* even_numbers_v3(const int* numbers, const int count);
int* filter_numbers(const int * numbers, const int count, bool(*criteria)(int number));
bool grater_than_three(const int number);
void print_array(const char* prefix, int numbers[10]);



void main() {
  const int numbers[10] = {1,2,3,4,5,6,7,8,9,10};

  print_array("Pares version 1", even_numbers_v1(numbers, 10));
  print_array("Pares version 2", even_numbers_v2(numbers, 10));
  print_array("Pares version 3", even_numbers_v3(numbers, 10));

  print_array("Matores a 3", filter_numbers(numbers, 10, grater_than_three));
}




bool even(const int number) {
    return number % 2 == 0;
}

int* even_numbers_v1(const int* number, const int count) {
    int* pares = calloc(count, sizeof(int));
    for (int i = 0, j = 0; i < count; i++) {
        if (number[i] % 2 == 0) {
            pares[j++] = number[i];
        }
    }
    return pares;
}

int* even_numbers_v2(const int* numbers, const int count) {
    int* pares = calloc(count, sizeof(int));
    for (int i = 0, j = 0; i < count; i++) {
        if (even(numbers[i])) {
            pares[j++] = numbers[i];
        }
    }
    return pares;
}

int* even_numbers_v3(const int* numbers, const int count) {
  return filter_numbers(numbers, count, even);
}

int* filter_numbers(const int * numbers, const int count, bool(*criteria)(int number)) {
    int* filtered = calloc(count, sizeof(int));
    for (int i = 0, j = 0; i < count; i++) {
        if (criteria(numbers[i])) {
            filtered[j++] = numbers[i];
        }
    }
    return filtered;
}

bool grater_than_three(const int number) {
    return number > 3;
}

void print_array(const char* prefix, int numbers[10]) {
    if (numbers == NULL) return;
    bool first = true;
    printf("%s: [", prefix);
    for (int i = 0; i < 10; i++) {
        if (numbers[i] == 0) break;
        printf("%s%d", first ? "" : ", ", numbers[i]);
        first = false;
    }
    printf("]\n");
    free(numbers);
}
