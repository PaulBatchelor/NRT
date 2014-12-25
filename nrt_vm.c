#include <stdio.h>
#include <stdlib.h>
#include "nrt_vm.h"
void printVals(NRT_DATA *d)
{
    NRT_NOTE *n = &d->notes[d->index];
    printf("The solfege step is %d\n", n->solf);
    printf("The time is %g\n", n->time);
    printf("The duration is %g\n", n->dur);
}

void changeSolf(NRT_NOTE *n, int solf)
{
    n->solf = solf;
}

void changeDur(NRT_NOTE *n, double dur)
{
    n->dur = dur;
}

void changeTime(NRT_NOTE *n, double time)
{
    n->time = time;
}

void updateCurrentSolf(NRT_DATA *d, int solf)
{
    //rest check added for bugfix
    if(d->isRest == FALSE)
    {
        //NRT_NOTE *n = &d->notes[d->index];
        NRT_NOTE *n = &d->note;
        changeSolf(n, solf);
        d->current_solf = solf;
    }
}
void updateCurrentDur(NRT_DATA *d, double dur)
{
    if(d->isRest == FALSE) {
        //NRT_NOTE *n = &d->notes[d->index];
        NRT_NOTE *n = &d->note;
        changeDur(n, dur);
    }
    d->current_dur = dur;
}
void updateCurrentTime(NRT_DATA *d, double time)
{
    //NRT_NOTE *n = &d->notes[d->index];
    NRT_NOTE *n = &d->note;
    changeTime(n, time);
    d->current_time = time;
}

void incrementTime(NRT_DATA *d)
{
    //printf("the current duration is %g\n", d->current_dur);
    d->current_time += d->current_dur;
}

NRT_NOTE createNewNote(NRT_DATA *d){
    NRT_NOTE n;
    changeSolf(&n, d->current_solf);
    changeTime(&n, d->current_time);
    changeDur(&n, d->current_dur);
    return n;
}

NRT_DATA createData(){
    NRT_DATA d;
    d.current_solf = 0;
    d.current_dur = 1;
    d.current_time = 0;
    //d.index = -1;
    d.index = 0;
    d.isCluster = FALSE;
    d.numNotes = 0;
    d.printNumber = FALSE;
    d.isNewSection = TRUE;
    d.sep = ',';
    return d;
}

void addNote(NRT_DATA *d)
{
//add time from previous dur, so long as index != -1
    if(d->numNotes > 0 && d->isCluster == FALSE && d->isNewSection == FALSE)
    {
        d->current_time += d->current_dur;
    }else if(d->isNewSection == TRUE){
        d->isNewSection = FALSE;
        d->current_time = 0;
        d->current_dur = 1;
    }
    
    if(d->numNotes > 0 && d->isRest == FALSE) {
        printCSV(d);
    }
    //create new note in index 
    if(d->isRest == FALSE)
    {
        d->notes[d->index] = createNewNote(d);
        d->note = createNewNote(d);
        d->numNotes++;
    }

}

void printCSV(NRT_DATA *d)
{

    NRT_NOTE *n = &d->note;
    /* Make sure note isn't a rest first */ 
    if(d->isRest == FALSE)
    {
        if(d->printNumber) {
        fprintf(stdout, "%d%c", d->numNotes,
            d->sep);
        }
        fprintf(stdout, "%g%c%g%c%d\n", 
            n->time, d->sep, n->dur, d-> sep, n->solf);
    }
}

void beginCluster(NRT_DATA *d)
{
    d->current_time += d->current_dur;
    d->isCluster = TRUE;
}

void endCluster(NRT_DATA *d)
{
    d->isCluster = FALSE;
}

void printCsoundScore(NRT_DATA *d)
{
    int i;
    NRT_NOTE *n;
    for(i = 0; i <= d->index; i++){
        n = &d->notes[i];
        printf("i1\t%g\t%g\t%d\n", n->time, n->dur, n->solf);
    }
}

void writeCsoundScore(NRT_DATA *d, char *outfile)
{
    int i;
    FILE *f = fopen(outfile, "w");
    if(!f) {
        printf("Error! Cannot write to score file %s", outfile);
        exit(-1);
    }
    NRT_NOTE *n;
    for(i = 0; i <= d->index; i++){
        n = &d->notes[i];
        fprintf(f,"i1\t%g\t%g\t%d\n", n->time, n->dur, n->solf);
    }
    fclose(f);
}

void addDot(NRT_DATA *d){
    updateCurrentDur(d, d->current_dur + d->current_dur * 0.5);
}

void transposeSolf(NRT_DATA *d, int step)
{
    if(d->isRest == FALSE)
    {
        //NRT_NOTE *n = &d->notes[d->index];
        NRT_NOTE *n = &d->note;
        updateCurrentSolf(d, d->current_solf + step);    
    }
}
void beginSection(NRT_DATA *d)
{
    d->isNewSection = TRUE;
}
void endSection(NRT_DATA *d)
{
}

void printJSON(NRT_DATA *d)
{
    int i;
    printf("{\"notes\":[\n");
    for(i = 0; i <= d->index; i++)
    {
        printf("{\n");
        NRT_NOTE *n = &d->notes[i];
        printf("\"solf\": %i,\n", n->solf);
        printf("\"time\": %g,\n", n->time);
        printf("\"dur\": %g\n", n->dur);
        if(i == d->index) printf("}\n");
        else printf("},\n");
    }
    printf("]}\n");
}
