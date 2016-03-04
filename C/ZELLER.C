/* #include "a:\c\headers\stdio.h" */
#include<stdio.h>


#define MO 0
#define DAY 1
#define YR 2

#define BAD_DIGIT 0
#define INT(x) ((int)(x))

main()
{
        char buff[40];
        char *zeller(char *date);

        printf("\nEnter date: ");
        scanf("%s",buff);
        printf("\n%s\n",zeller(buff));
}



char *zeller(date)
char *date;
{
char c;
int n=0;
int month;
int year;
int century;
int offset;
int mdy[3];

static char *day[] = {
"Sunday",
"Monday",
"Tuesday",
"Wednesday",
"Thursday",
"Friday",
"Saturday"
};

mdy[DAY] = mdy[MO] = mdy[YR] = 0;

while(c = *date++) {
if(c == '-' || c== '/') {
n++;
continue;
}
if(!isdigit(c))
return (BAD_DIGIT);

mdy[n] = 10 * mdy[n] + (c-'0');
}

if(mdy[YR] < 100)
mdy[YR] += 2000;

if(mdy[MO] > 2) {
month=mdy[MO]-2;
year=mdy[YR];
} else {
month=mdy[MO]+10;
year=mdy[YR]-1;
}

century = year / 100;
offset = year % 100;

/*  */
n =INT((13*month-1)/5)+mdy[DAY]+offset
+INT(offset/4)+INT(century/4)-2*century+77;
/*  */
n=n-7*INT(n/7);

return (day[n]);
}