#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <unistd.h>

#include "nrt.tab.h"
#include "nrt_vm.h"
#include "lex.yy.h"

void parseSolf(NRT_DATA *d, char *n);
void parseRhythm(NRT_DATA *d, int n);
void parseAccidental(NRT_DATA *d, char *n);
void parseOctave(NRT_DATA *d, char *n);
void parseDot(NRT_DATA *d);
int yylex();
int yyparse(void);
void yyerror(const char *s);
FILE *yyin;
NRT_DATA *nrtGlobalData;
