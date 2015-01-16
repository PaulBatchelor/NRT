%{
#include <stdio.h>
#define YY_DECL int nrtlex()
#include "nrt.tab.h"

%}
%option noyywrap
%%
[ \n\t]                  ;
"|"	;
[drmfsltDRMFSLTDzZ] {
//nrtlval.ascii = nrttext;
nrtlval.sval = strdup(nrttext);
return SOLF;
}
[0-9]+   nrtlval.ival = atoi(nrttext); return RHYTHM;
[\+\=\-] {
nrtlval.sval = strdup(nrttext); 
return ACC;
}
[\,'] {
nrtlval.sval = strdup(nrttext); 
return OCT;
}
[\.] {
return DOT;
}
"("  {
return LPAREN;
}
")" {  
return RPAREN;
}
"[" {  
return LBRAC;
}
"]" {  
return RBRAC;
}
#.* ;
.   return ERROR;
%%

//main()
//{
//nrtlex();
//}
