#include<stdio.h>
#include<string.h>

void main()
{

char name[80];
size_t strsize;
size_t indexvar;

printf("\n Type up to one line then press enter \n\n");
gets(name);
printf("\n");

for(indexvar = strlen(name);indexvar > 0;indexvar--)
{
 printf("%c", name[indexvar-1]);
}
printf("\n");
}