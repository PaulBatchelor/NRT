#define TRUE 1
#define FALSE 0

typedef struct {
int solf;
double time;
double dur;
} NRT_NOTE;

typedef struct {
/**=NOTE: Weird things are happening here*/
NRT_NOTE notes[200];
int index;
NRT_NOTE note;
int current_solf;
int isCluster;
int isRest;
int isNewSection;
double current_dur;
double current_time;
int numNotes;
int printNumber;
char sep;
}NRT_DATA;

void printVals(NRT_DATA *d);

void changeSolf(NRT_NOTE *n, int solf);

void changeDur(NRT_NOTE *n, double dur);

void changeTime(NRT_NOTE *n, double time);

void updateCurrentSolf(NRT_DATA *d, int solf);

void updateCurrentDur(NRT_DATA *d, double dur);

void updateCurrentTime(NRT_DATA *d, double time);

NRT_NOTE createNewNote(NRT_DATA *d);

NRT_DATA createData();

void addNote(NRT_DATA *d);

void beginCluster(NRT_DATA *d);

void endCluster(NRT_DATA *d);

void printCsoundScore(NRT_DATA *d);
void writeCsoundScore(NRT_DATA *d, char *outfile);
void printJSON(NRT_DATA *d);
void printCSV(NRT_DATA *d);

void incrementTime(NRT_DATA *d);

void addDot(NRT_DATA *d);

void transposeSolf(NRT_DATA *d, int step);

void endSection(NRT_DATA *d);
void beginSection(NRT_DATA *d);

