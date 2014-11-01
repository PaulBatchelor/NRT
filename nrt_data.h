#define TRUE 1
#define FALSE 0

typedef struct {
int solf;
float time;
float dur;
} NRT_NOTE;

typedef struct {
NRT_NOTE notes[200];
int index;
int current_solf;
int isCluster;
int isRest;
int isNewSection;
float current_dur;
float current_time;
int numNotes;
}NRT_DATA;

void printVals(NRT_DATA *d);

void changeSolf(NRT_NOTE *n, int solf);

void changeDur(NRT_NOTE *n, float dur);

void changeTime(NRT_NOTE *n, float time);

void updateCurrentSolf(NRT_DATA *d, int solf);

void updateCurrentDur(NRT_DATA *d, float dur);

void updateCurrentTime(NRT_DATA *d, float time);

NRT_NOTE createNewNote(NRT_DATA *d);

NRT_DATA createData();

void addNote(NRT_DATA *d);

void beginCluster(NRT_DATA *d);

void endCluster(NRT_DATA *d);

void printCsoundScore(NRT_DATA *d);
void writeCsoundScore(NRT_DATA *d, char *outfile);
void printJSON(NRT_DATA *d);

void incrementTime(NRT_DATA *d);

void addDot(NRT_DATA *d);

void transposeSolf(NRT_DATA *d, int step);

void endSection(NRT_DATA *d);
void beginSection(NRT_DATA *d);
