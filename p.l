%{

#include <stdio.h>
#include "y.tab.h"
#include <stdlib.h>
extern int yylineno;
%}

/* KEEP TRACK OF LINE NUMBER*/

%option yylineno 

%x COMMENT

%%
int               {return (INT);}

double            {return (DOUBLE);}

if                {return (IF);}

else              {return (ELSE);}

end               {return (ENDD);}

read              {return (READ);}

write             {return (WRITE);}

repeat            {return (REPEAT);}

until            {return (UNTIL);}

START             {return (START);}

END               {return (END);}

then              {return (THEN);}
";"               {return( SEMI ); }
"+"              {return( PLUS ); }
"-"               {return( MINUS ); }
"*"               {return( STAR ); }
"/"              {return( DIVISION ); }
"&"              {return( AND ); }
"|"              {return( OR ); }
"!"               {return( EXCLAMATION ); }
"=="              {return( EQUAL ); }
"<>"              {return( NOTEQUAL ); }
"<"               {return( LESS ); }
"<="              {return( LESSEQUAL ); }
">"               {return( GREATER ); }
">="             {return( GREATEREQUAL ); }
":="             {return( ASSIGNMENT ); }
"("               {return( RBRACKET ); }
")"               {return( LBRACKET); }
"@"          {BEGIN (COMMENT);}
<COMMENT>"@"    {BEGIN(INITIAL);}
<COMMENT>.   ;
[A-Z][a-zA-Z0-9_]*  {return(ID); }
-?[0-9]+            {return(INT_LITERAL);}
[\"][^\"\n]*[\"]     {return (STRING_LITERAL);}

-?[0-9]+\.[0-9]+       {return(DBL_LITERAL);}
[\n]|[ \t]         {;}


%%

