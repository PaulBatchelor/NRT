%{
#include <stdio.h>
#define YY_DECL int yylex()
#include "nrt.tab.h"

%}

%%
[ \n\t]                  ;
"|"	;
[drmfsltDRMFSLTDzZ] {
//yylval.ascii = yytext;
yylval.sval = strdup(yytext);
return SOLF;
}
[0-9]+   yylval.ival = atoi(yytext); return RHYTHM;
[\+\=\-] {
yylval.sval = strdup(yytext); 
return ACC;
}
[\,'] {
yylval.sval = strdup(yytext); 
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
#.*$ ;
.   return ERROR;
%%

//main()
//{
//yylex();
//}
