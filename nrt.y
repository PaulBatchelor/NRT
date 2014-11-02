%{
#include <stdio.h>
#include <stdlib.h>
#include "nrt.tab.h"
#include "nrt_data.h"
#include <ctype.h>
#include <unistd.h>

void parseSolf(NRT_DATA *d, char *n);
void parseRhythm(NRT_DATA *d, int n);
void parseAccidental(NRT_DATA *d, char *n);
void parseOctave(NRT_DATA *d, char *n);
void parseDot(NRT_DATA *d);
int yylex();
int yyparse(void);
void yyerror(const char *s);
FILE *yyin;
NRT_DATA d;

%}

%union {
int ival;
char *sval;
}
%token<sval> SOLF
%token<ival> RHYTHM
%token<sval> DOT
%token<sval> ACC
%token<sval> OCT
%token<sval> LPAREN
%token<sval> RPAREN
%token<sval> LBRAC
%token<sval> RBRAC
%token<sval> ERROR
%%

sections:
sections section |
section |
notes
;

section:
begin_section notes end_section 
;

notes: 
notes inote |
inote
;

inote:
open_par note |
note close_par |
note
;

note:
note_base |
note_with_rhythm 
;


note_base:
solf |
solf accidental octaves |
solf accidental |
solf octaves
;

note_with_rhythm:
note_base rhythm |
note_base rhythm dot
;



//solf: SOLF { printf("we found a SOLF %s\n", $1); } ;
solf: SOLF { parseSolf(&d, $1); } ;
rhythm: RHYTHM { parseRhythm(&d, $1); } ;
accidental: ACC { parseAccidental(&d, $1); } ;
octaves: octaves octave | octave ;
octave: OCT { parseOctave(&d, $1); } ;
dot: DOT { parseDot(&d); } ;
open_par: LPAREN { beginCluster(&d); } ;
close_par: RPAREN { endCluster(&d); } ;
begin_section: LBRAC { beginSection(&d); };
end_section: RBRAC { endSection(&d); };
%%
main(int argc, char **argv){
    char *filename;
    char *scorefile;
    int c;
    int index;
    d = createData();
    int csoundMode = FALSE;
    int jsonMode = FALSE;
    int readFromFile = TRUE;
    char *expr;
    while((c = getopt(argc, argv, "cjs:")) != -1 )
    {
        switch(c)
        {
            case 'c':
            csoundMode = TRUE;
            break;
            case 'j':
            jsonMode = TRUE;
            break;
            case 's':
            readFromFile = FALSE;
            expr = optarg;
            break;
        }
    }
    if(readFromFile == TRUE)
    {
    filename = argv[optind];
    if(csoundMode == TRUE){
    scorefile = argv[optind + 1];
    }
    FILE *input = fopen(filename, "r");
    if(!input)
    {
        printf("Error! Cannot find file.\n");
        return -1;
    }
    
    yyin = input;
    do{
        yyparse();
    }while(!feof(yyin));
    fclose(input);
    }else{ 
    yy_scan_string(expr); 
    yyparse();
    }
    if(csoundMode && readFromFile) writeCsoundScore(&d, scorefile);
    
    if(jsonMode) printJSON(&d);
    return 0;
}
void yyerror(const char *s)
{
	printf("syntax error! \n");
	exit(-1);
}

void parseSolf(NRT_DATA *d, char *n)
{   
    char c = n[0];
    int step = 0;
    d->isRest = FALSE;
    switch(c)
    {
        case 'd': step = 0;
        break;
        case 'r': step = 2;
        break;
        case 'm': step = 4;
        break;
        case 'f': step = 5;
        break;
        case 's': step = 7;
        break;
        case 'l': step = 9;
        break;
        case 't': step = 11;
        break;
        case 'D': step = 12;
        break;
        case 'R': step = 14;
        break;
        case 'M': step = 16;
        break;
        case 'F': step = 17;
        break;
        case 'S': step = 19;
        break;
        case 'L': step = 21;
        break;
        case 'T': step = 23;
        break;
        case 'z': d->isRest = TRUE;
        break;
        case 'Z': d->isRest = TRUE;
        break;
        default:
            printf("There's something wrong... this shouldn't happen..\n");
            exit(-1);
        break;
    }
    addNote(d);
    updateCurrentSolf(d, step);
}
void parseRhythm(NRT_DATA *d, int n)
{
    double rhythm = 0;
    switch(n) 
    {
        case 1: rhythm = 4; break;
        case 2: rhythm = 2; break;
        case 4: rhythm = 1; break;
        case 8: rhythm = 0.5; break;
        case 16: rhythm = 0.25; break;
    }
    if(rhythm != 0) updateCurrentDur(d, rhythm);
}

void parseAccidental(NRT_DATA *d, char *n)
{
    char c = n[0];
    int step = 0;
    switch(c)
    {
        case '+': step = 1;
        break;
        case '-': step = -1;
        break;
        case '=': step = 0;
        break;
    }
    transposeSolf(d, step);
}

void parseOctave(NRT_DATA *d, char *n)
{
    char c = n[0];
    int step = 0;
    switch(c)
    {
        case '\'': step = 12;
        break;
        case ',': step = -12;
        break;
    }
    transposeSolf(d, step);
}

void parseDot(NRT_DATA *d)
{
    addDot(d);
}
