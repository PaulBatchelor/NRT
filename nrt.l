%{
#include <stdio.h>
#define YY_DECL int yylex()
#include "nrt.tab.h"

%}

%%
[ \n\t]                  ;
"|"	;
[drmfsltDRMFSLTD]   return SOLF;
[0-9]   return RHYTHM;
[\+\=\-]   return ACC;
[\,']   return OCT;
[\.]   return DOT;
"("   return LBRAC;
")"   return RBRAC;
%%

//main(int argc, char **argv)
//{
//yylex();
//}
