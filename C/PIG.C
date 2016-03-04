#include<stdio.h>
#include<string.h>

void main()
{
  char norm[100];
  char ormnay[150];
  char firstchar = ' ';
  size_t normsize;
  int i;
  int ii=0;
  int first =0;

  printf("\nDavid Hoppe 04.October.1998\nenter up to one line of stuff to be translated.\n\n");
  gets(norm);
  normsize=strlen(norm);

  for(i=0;i<normsize+1;i++)
    {
     if (first==0)
     { firstchar=norm[i]; first=1; }
     else
     { if (norm[i]==' ' || norm[i]=='\0')
       { ormnay[ii]=firstchar;
         ii++;
         ormnay[ii]='a';
         ii++;
         ormnay[ii]='y';
         ii++;
         ormnay[ii]=' ';
         ii++;
         first=0;
       }
       else { ormnay[ii]=norm[i]; ii++;}
     }
    }
/*    ii--;
    ormnay[ii]=firstchar; ii++;
    ormnay[ii]='a';ii++;
    ormnay[ii]='y';ii++;      */
    ormnay[ii]='\0';
    printf("\n%s\n",ormnay);


}