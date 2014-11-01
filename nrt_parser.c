main(int argc, char **argv){
    char *filename;
    int c;
    int index;
    d = createData();
    while((c = getopt(argc, argv, "c:")) != -1 )
    {
        switch(c)
        {
            case 'c':
            break;
        }
    }

    filename = argv[optind];

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
    printCsoundScore(&d);
    fclose(input);
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
    float rhythm = 0;
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
