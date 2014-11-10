default:
	make all
nrt.tab.c: nrt.y
	bison -d nrt.y

lex.yy.c: nrt.l nrt.tab.c
	flex --header-file="lex.yy.h" nrt.l

nrt_data: nrt_data.c nrt_data.h
	gcc -c nrt_data.c

lex.yy.o: lex.yy.c
	gcc -c lex.yy.c

nrt.tab.o: nrt.tab.c
	gcc -c nrt.tab.c

nrt_objects.o: lex.yy.o nrt.tab.o nrt_data.o
	ld -o nrt_objects.o -r lex.yy.o nrt.tab.o nrt_data.o

#nrt: lex.yy.o nrt.tab.o nrt_data.o nrt_parse.c
nrt: nrt_objects.o nrt_parse.c
	#gcc lex.yy.o nrt.tab.o nrt_data.o nrt_parse.c -lfl -o nrt 
	gcc nrt_objects.o nrt_parse.c -lfl -o nrt 

clean:
	rm -rf nrt.tab.* lex.yy.c nrt nrt_data.o *.o

out.sco: nrt
	./nrt aCallToAttention.nrt > out.sco
	#./nrt mario.nrt > out.sco

all:
	make nrt

install:
	sudo cp nrt /usr/local/bin
