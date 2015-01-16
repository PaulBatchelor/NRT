#include "nrt_parse.h"
void printCSV(NRT_DATA *d)
{

    NRT_NOTE *n = &d->note;
    /* Make sure note isn't a rest first */ 
    if(d->isRest == FALSE)
    {
        if(d->printNumber) {
        fprintf(stdout, "%d%c", d->numNotes,
            d->sep);
        } fprintf(stdout, "%g%c%g%c%d\n", 
            n->time, d->sep, n->dur, d-> sep, n->solf);
    }
}
int main(int argc, char **argv){
    char *filename;
    char *scorefile;
    int c;
    int index;
    NRT_DATA d = createData(&printCSV);
    nrtGlobalData = &d;
    int csoundMode = FALSE;
    int jsonMode = FALSE;
    int readFromFile = TRUE;
    char *expr;
    while((c = getopt(argc, argv, "cjs:nF:")) != -1 )
    {
        switch(c)
        {
            case 'c': /* Deprecated */
            csoundMode = TRUE;
            break;
            case 'j': /* Deprecated */
            jsonMode = TRUE;
            break;
            case 's':
            readFromFile = FALSE;
            expr = optarg;
            case 'n':
            d.printNumber = TRUE;
            break;
            case 'F':
            d.sep = optarg[0];
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
            //printf("Error! Cannot find file.\n");
            nrtin = stdin;
            readFromFile = FALSE;
            //return -1;
        }else{
            nrtin = input;
        } 
        do{
            nrtparse();
        }while(!feof(nrtin));

        if(readFromFile) fclose(input);
    }else{ 
    nrt_scan_string(expr); 
    nrtparse();
    }
    printCSV(&d);

    return 0;
}
