#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <unistd.h>
/*
#include "nrt.tab.h"
#include "nrt_vm.h"
#include "lex.nrt.h"
*/

#include "nrt.h"

void parseSolf(NRT_DATA *d, char *n);
void parseRhythm(NRT_DATA *d, int n);
void parseAccidental(NRT_DATA *d, char *n);
void parseOctave(NRT_DATA *d, char *n);
void parseDot(NRT_DATA *d);
int nrtlex();
int nrtparse(void);
void nrterror(const char *s);
FILE *nrtin;
NRT_DATA *nrtGlobalData;
