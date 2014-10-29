%{
#include <stdio.h>
#include <stdlib.h>
#include "nrt.tab.h"

int yylex();
int yyparse();
void yyerror(const char *s);
%}


%token SOLF
%token RHYTHM
%token DOT
%token ACC
%token OCT
%token LBRAC
%token RBRAC
%%

cluster:
cluster cluster |
open_bracket cluster close_bracket |
open_bracket notes close_bracket |
notes
;

notes: 
notes note |
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



solf: SOLF { printf("we found a SOLF\n"); } ;
rhythm: RHYTHM { printf("we found a rhythm!\n"); } ;
accidental: ACC { printf("we found an accidental!\n"); } ;
octaves: octaves octave | octave ;
octave: OCT { printf("we found an octave!\n"); } ;
dot: DOT { printf("we found a dot!\n"); } ;
open_bracket: LBRAC { printf("we found a left bracket!\n"); } ;
close_bracket: RBRAC { printf("we found a right bracket!\n"); } ;
%%
main(){
    while(1)
	yyparse();
}
void yyerror(const char *s)
{
	printf("syntax error!");
	exit(-1);
}
