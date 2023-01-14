%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define YYDEBUG 1

#define TYPE_INT 1
#define TYPE_CHAR 2
#define TYPE_STRING 3

int yylex(void);
void yyerror(char *s);

double stack[50];
int top;

void push(double x){ 
        stack[top++] = x; 
}

double pop(){ 
        return stack[--top]; 
}

%}

%union val{
    int i_val;
    char *p_val;
}

%token START
%token STOP
%token IF
%token ELSE
%token WHILE
%token READ
%token WRITE
%token INT
%token CHAR
%token STRING
%token ARRAY

%token ASSIGN 

%token L
%token G
%token EQ
%token LE
%token GE
%token NE

%token <i_val> ID
%token <p_val> CONST_INT
%token <p_val> CONST_CHAR
%token <p_val> CONST_STRING
%token <p_val> CONST_ARRAY

%left '+' 
%left '-'
%left '*' 
%left '/'
%left '%'

%type <i_val> expression term factor constant
%start program

%%

program : START compoundStmt STOP {printf("1\n");}
        ;
compoundStmt : '{' statementList '}' {printf("2\n");}
        | '{' /* empty program */ '}' {printf("3\n");}
        ;
statementList : statement {printf("4\n");}
        | statement statementList {printf("5\n");}
        ;
statement : readStmt ';' {printf("6\n");}
        | writeStmt ';' {printf("7\n");}
        | declarationStmt ';' {printf("8\n");}
        | assignmentStmt ';' {printf("9\n");}
        | ifStmt {printf("10\n");}
        | whileStmt {printf("11\n");}
        ;
readStmt : READ '(' ID ')' {printf("12\n");}
        ;
writeStmt : WRITE '(' ID ')' {printf("13\n");}
        | WRITE '(' constant ')' {printf("14\n");}
        ;
declarationStmt : type  ID {printf("15\n");}
        ;
type : primitiveType {printf("16\n");}
        | arrayType {printf("17\n");}
        ;
primitiveType : INT {printf("18\n");}
        | CHAR {printf("19\n");}
        | STRING {printf("19_2\n");}
        ;
arrayType : ARRAY '[' length ']' {printf("20\n");}
        ;
length : '0' {printf("21\n");}
        | CONST_INT {printf("22\n");}
        ;
assignmentStmt :  ID ASSIGN expression {printf("23\n");}
        ;
expression : expression '+' term {
		if($1==TYPE_CHAR) $$=TYPE_CHAR;
		else $$=TYPE_INT;
		push(pop()+pop());
                printf("24\n");
                }
        | expression '-' term {	
                if($1==TYPE_CHAR) $$=TYPE_CHAR;
		else $$=TYPE_INT;
		push(-pop()+pop());
                printf("25\n");
                }
        | term {$$ = $1; printf("26\n");}
        ;
term : term '*' factor {		
                if($1==TYPE_CHAR) $$=TYPE_CHAR;
		else $$=TYPE_INT;
		push(pop()*pop());
                printf("27\n");
                }
        | term '/' factor {		
                if($1==TYPE_CHAR) $$=TYPE_CHAR;
		else $$=TYPE_INT;
		push(pop()/pop());
                printf("28\n");
                }
        | term '%' factor {		
                if($1==TYPE_CHAR) $$=TYPE_CHAR;
		else $$=TYPE_INT;
		push((int)pop()%(int)pop());
                printf("29\n");
                }
        | factor {$$ = $1;printf("30\n");}
        ;
factor : '(' expression ')'  {$$ = $2;printf("31\n");}
        | ID {printf("32\n");}
        | constant {printf("33\n");}
        ;
constant : CONST_INT { $$ = TYPE_INT; push(atof($1)); printf("34\n");}
        | CONST_CHAR { $$ = TYPE_CHAR; push((double)$1[0]); printf("35\n");}
        | CONST_STRING { $$ = TYPE_CHAR; push((double)$1[0]); printf("36\n"); }
        ;
ifStmt : IF '(' condition ')' compoundStmt {printf("37\n");}
        | IF '(' condition ')' compoundStmt ELSE compoundStmt {printf("38\n");}
        ;
whileStmt : WHILE '(' condition ')' compoundStmt {printf("39\n");}
        ;
condition : expression relationalOperator expression {printf("40\n");}
        ;
relationalOperator : EQ {printf("41\n");}
        | L {printf("42\n");}
        | G {printf("43\n");}
        | NE {printf("44\n");}
        | LE {printf("45\n");}
        | GE {printf("46\n");}
        ;

%%

void yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
}