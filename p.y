%{
#include <stdio.h>
#include <stdlib.h>
extern int yylineno;
extern FILE* yyin;

extern int yyerror (char* msg);
extern int yyparse();
extern char *yytext;
extern int yylex();
%}
%token  IF ELSE THEN START END READ WRITE REPEAT UNTIL 
%token INT DOUBLE ENDD 
%token INT_LITERAL DBL_LITERAL STRING_LITERAL ID 

%token PLUS MINUS STAR DIVISION AND OR EXCLAMATION EQUAL NOTEQUAL LESS LESSEQUAL GREATER GREATEREQUAL ASSIGNMENT
%token  RBRACKET LBRACKET SEMI 

%right ASSIGNMENT 

%right EXCLAMATION 

%left EQUAL NOTEQUAL

%left LESS LESSEQUAL GREATER GREATEREQUAL

%left PLUS MINUS

%left STAR DIVISION

%% 



Program: START stmt_sequence END;





stmt_sequence: statement SEMI stmt_sequence
               | statement SEMI ;

               

statement :   dec_stmt 

              | if_stmt 

              |repeat_stmt

              | assign_stmt

              | read_stmt 

              | write_stmt;



dec_stmt:      type ID;



type:          INT 

              | DOUBLE;





              

if_stmt: IF exp THEN stmt_sequence I ;

I: ENDD | ELSE stmt_sequence ENDD;



repeat_stmt: REPEAT stmt_sequence UNTIL exp ;



assign_stmt:     ID ASSIGNMENT exp;



read_stmt: READ ID;





write_stmt : WRITE RBRACKET exp LBRACKET
            | WRITE RBRACKET STRING_LITERAL LBRACKET;








           

exp : simple_exp comparison_op simple_exp
            | simple_exp  ;



comparison_op : EQUAL

              |NOTEQUAL

              |LESS

              |LESSEQUAL

              | GREATEREQUAL

              |GREATER;





                      

simple_exp: simple_exp PLUS aop
            | simple_exp MINUS aop
            | aop;










aop: aop STAR factor
    |aop DIVISION factor
    |factor;



factor: RBRACKET exp LBRACKET

        | INT_LITERAL 

        | DBL_LITERAL 

        | ID;



%%

int main(int argc, char *argv[])

{



yyin = fopen(argv[1], "r" ) ; 

if(!yyparse())

        printf("\nParsing complete\n");
         

    else

        printf("\nParsing failed\n");

    

    fclose(yyin);

return 0;

}



extern int yyerror (char* msg)

{

printf("\nSyntax error: line %d %s at %s ",yylineno,msg,yytext);

return 0;

}



