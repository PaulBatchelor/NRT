%{
#include "nrt_parse.h"

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



solf: SOLF { parseSolf(nrtGlobalData, $1); } ;
rhythm: RHYTHM { parseRhythm(nrtGlobalData, $1); } ;
accidental: ACC { parseAccidental(nrtGlobalData, $1); } ;
octaves: octaves octave | octave ;
octave: OCT { parseOctave(nrtGlobalData, $1); } ;
dot: DOT { parseDot(nrtGlobalData); } ;
open_par: LPAREN { beginCluster(nrtGlobalData); } ;
close_par: RPAREN { endCluster(nrtGlobalData); } ;
begin_section: LBRAC { beginSection(nrtGlobalData); };
end_section: RBRAC { endSection(nrtGlobalData); };
%%
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
    double rhythm;
    if(n != 0){
        rhythm = 4.0 / n;
        updateCurrentDur(d, rhythm);
    }

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
