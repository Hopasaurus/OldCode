#include<stdio.h>
void main()
{ 
 int count=0,index;

 printf("How many numbers do you want? ");
 scanf("%d",&count);

 for(index=0;index<count;index++)
  { 
   printf("\n Number %d",index+1);
  }
}

