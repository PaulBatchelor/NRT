#include "nrt_parse.h"
main(int argc, char **argv){
    char *filename;
    char *scorefile;
    int c;
    int index;
    NRT_DATA d = createData();
    nrtGlobalData = &d;
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
    //if(csoundMode && readFromFile) writeCsoundScore(&nrtGlobalData, scorefile);
    if(csoundMode && readFromFile) writeCsoundScore(&d, scorefile);
    
    //if(jsonMode) printJSON(&nrtGlobalData);
    if(jsonMode) printJSON(&d);
    return 0;
}
