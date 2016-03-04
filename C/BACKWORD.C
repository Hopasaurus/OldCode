/* this program plays with the order of text.
   first it reverses a the line of text,
   then it puts all the words in backwards order,
   then it puts all the words in correct order but letters reversed */


#include<stdio.h>
#include<string.h>

void main()
{

 char    phrasea[100];
 char    phraseb[100];
 char    word[30];
 int     i;
 int     ii=0;
 int     iii;
 int     slen;

 printf("David Hoppe 6.OCT.1998\nType up to one line and press enter.\n");
 gets(phrasea);

 slen=strlen(phrasea);

/* this part reverses the string  */

 for(i=0;i<slen;i++)
 {
   phraseb[i]=phrasea[slen-i-1];
 }

 phraseb[slen]='\0';

 printf("\n%s\n\n",phraseb);

/* this does something */

 for(i=0;i<=slen;i++)
 {
   if(phraseb[i] != ' ' && phraseb[i] != '\0')
   {
     word[ii]=phraseb[i];
     ii++;
   }
   else
   {
     for(iii=0;iii<ii;iii++)
     {
       phrasea[i+iii-ii]=word[ii-iii-1];
     }
     phrasea[i]=phraseb[i];
     ii=0;
   }
 }

 printf("%s\n\n",phrasea);

 ii=0;

 for(i=0;i<=slen;i++)
 {
   if (phraseb[i] != ' ' && phraseb[i] != '\0')
   {
     word[ii]=phraseb[i];
     ii++;
   }
   else
   {
     for(iii=0;iii<ii;iii++)
     {
       phrasea[slen-i+iii]=word[iii];
     }
     if (phraseb[i]==' ')
     { phrasea[slen-i-1]=' '; }
     ii=0;
   }
 }
 printf("%s\n\n",phrasea);

}