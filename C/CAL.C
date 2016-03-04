
/* #include "a:\c\headers\stdio.h" */
#include<stdio.h>


#define MO 0
#define DAY 1
#define YR 2

#define BAD_DIGIT 0
#define INT(x) ((int)(x))

static char *mname[] = {
        "Blank",
        "January   ",
        "February  ",
        "March     ",
        "April     ",
        "May       ",
        "June      ",
        "July      ",
        "August    ",
        "September ",
        "October   ",
        "November  ",
        "December  "
};


main()
{
        char buff[40];
        int month, year, numdays, nummonths;
        int StartDay, DaysInMonth, a, b;
        int zeller(int inmonth, int inyear);

        printf("\nEnter month: ");
        scanf("%d",&month);
        printf("\nEnter year:  ");
        scanf("%d",&year);
        printf("\nHow many months: ");
        scanf("%d",&nummonths);

        for (b=0;b<nummonths;b++) {
                printf("\n %s    %d\n", mname[month], year);
                printf("Su Mo Tu We Th Fr Sa\n");
                StartDay = zeller(month, year);

                numdays=31;
                if (month==4||month==6||month==9||month==11) {
                        numdays=30;
                }
                if (month==2) {
                        if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0) {
                                numdays=29;
                        } else {
                                numdays=28;
                        }
                }

                for(a=0;a<StartDay;a++){
                        printf("   ");
                }
                a=1;
                while(a<=numdays) {
                        if(StartDay>6) {
                                StartDay=0;
                                printf("\n");
                        }
                        if(a<10) {
                                printf(" %d ", a);
                        } else {
                                printf("%d ", a);
                        }
                        StartDay++;
                        a++;
                }
                printf("\n");
                month++;
                if (month>12) {
                        month=1;
                        year++;
                }
        }
}

/*char *zeller(date)*/
int zeller(int inmonth, int inyear)
{
        char c;
        int n=0;
        int century;
        int offset, month, year;
        int mdy[3];

        mdy[DAY] = mdy[MO] = mdy[YR] = 0;

        mdy[DAY]=1;
        mdy[MO]=inmonth;
        mdy[YR]=inyear;

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

        n =INT((13*month-1)/5)+mdy[DAY]+offset+INT(offset/4)+INT(century/4)-2*century+77;
        n=n-7*INT(n/7);
        return(n);
}
