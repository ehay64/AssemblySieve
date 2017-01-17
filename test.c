#include <stdio.h>

void function();
void start();
void primeSieve(char *c, int size);

int main(void)
{
    int arraySize = 5000;
    char array[arraySize];
    
    for (int i = 0; i < arraySize; i++)
    {
        array[i] = 0xff;
    }
    
    primeSieve(array, arraySize);
    
    for (int i = 0; i < arraySize; i++)
    {
        if (array[i] == 0xffffffff)
        {
            printf("%d ", i);
        }
    }
    
    printf("\n");

	return 0;
}

