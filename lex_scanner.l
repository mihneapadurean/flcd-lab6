%{
#include <string.h>
#include "y.tab.h"

typedef struct {
    char token[257];
    int symbolTableCode;
}PIF;

typedef struct{
    char token[257];
    int index;
}ST;

ST SymbolTable[100];
int stLength = 0;

PIF ProgramInternalForm[300];
int pifLength = 0;

int errorFound = 0;
int lineNumber = 1;


int addToST(char* token) {
	for(int i = 0; i < stLength; i++) {
		
		if(strcmp(SymbolTable[i].token, token) == 0) {
		  return SymbolTable[i].index;
		}
	}
	strcpy(SymbolTable[stLength].token, token);
	SymbolTable[stLength].index = stLength;
	stLength++;
	
	return stLength - 1;
}

void addToPIF(char* token, int stCode) {
	//printf("%s\n", token);
	strcpy(ProgramInternalForm[pifLength].token, token);
	ProgramInternalForm[pifLength].symbolTableCode = stCode;
	
	pifLength++;
}

void showSymbolTable() {
    printf("~~~~~~~ Symbol table ~~~~~~~\n");
    
    for(int i = 0 ; i < stLength; i++) {
        printf(" %s  %d", SymbolTable[i].token, SymbolTable[i].index);
        printf("\n");
    }
    
    printf("~~~~~~~ End ST ~~~~~~~\n");
    printf("\n");
}

void showProgramInternalForm() {
    printf("~~~~~~~ Program internal form ~~~~~~~\n");
    
    for(int i = 0; i < pifLength; i++) {
    
        printf(" %s  %d ", ProgramInternalForm[i].token, ProgramInternalForm[i].symbolTableCode);
        printf("\n");
    }
    
    printf("~~~~~~~ End PIF ~~~~~~~\n");
    printf("\n");
}
%}

letter  [A-Za-z] 
digit   [0-9]
zero    [0]
nonzero [1-9]
integer     [+-]*{nonzero}+{digit}*|{zero}
identifier  {letter}({letter}|{digit})*
delimitator	[;,:]
acolada     [{}]
operator	[+*/%()<>=]|"-"|"["|"]"|"<="|">="|"<>"
specialChar     \.|\?|\!|[ \t]
character   "'"({letter}|{digit}|{specialChar})"'"
string      ["]({letter}|{digit}|{specialChar})*["]

%%

START   {addToPIF(yytext, -1); return START;}
STOP    {addToPIF(yytext, -1); return STOP;}
IF      {addToPIF(yytext, -1); return IF;}
ELSE    {addToPIF(yytext, -1); return ELSE;}
WHILE   {addToPIF(yytext, -1); return WHILE;} 
READ    {addToPIF(yytext, -1); return READ;}
WRITE   {addToPIF(yytext, -1); return WRITE;}
INT     {addToPIF(yytext, -1); return INT;}
CHAR    {addToPIF(yytext, -1); return CHAR;}
ARRAY   {addToPIF(yytext, -1); return ARRAY;}

":="    {addToPIF(yytext, -1); return ASSIGN;}

"<"	    {addToPIF(yytext, -1); return L;}
">"	    {addToPIF(yytext, -1); return G;}
"="     {addToPIF(yytext, -1); return EQ;} 
"<="	{addToPIF(yytext, -1); return LE;}
">="	{addToPIF(yytext, -1); return GE;}
"<>"	{addToPIF(yytext, -1); return NE;}


{identifier}    {int stCode = addToST(yytext); addToPIF(yytext, stCode); return ID;}
{integer}       {int stCode = addToST(yytext); addToPIF(yytext, stCode); 
				yylval.p_val = yytext;
                return CONST_INT;}
{character}     {int stCode = addToST(yytext); addToPIF(yytext, stCode);
				yylval.p_val = yytext;
	            return CONST_CHAR;}
{string}        {int stCode = addToST(yytext); addToPIF(yytext, stCode);
				yylval.p_val = yytext;
	            return CONST_STRING;}  

{delimitator}	{addToPIF(yytext, -1); return yytext[0];}
{acolada}	{addToPIF(yytext, -1); return yytext[0];}
{operator}	{addToPIF(yytext, -1); return yytext[0];}

[\n]		{ ++lineNumber; }
[ \t]+        { ; /* ignore spaces and tabs */}
.           { errorFound = 1; printf("Illegat token %s at line %d\n", yytext, lineNumber); }
%%

/* yywrap() - wraps the above rule section */
int yywrap() {}

int main(int argc, char** argv) {

	FILE *fp;
	fp = fopen(argv[1], "r");
	
	/* yyin - takes the file pointer which contains the input*/
	yyin = fp;

	/* yylex() - this is the main flex function which runs the Rule Section*/ 
	
	if(!yyparse()) {
		fprintf(stderr,"Program syntacticly correct\n\n\n");
	}

	if (errorFound == 0) {
    	showSymbolTable();
    	showProgramInternalForm();
	}
  
	return 0;
}