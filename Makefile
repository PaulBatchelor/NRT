default:
	make all
nrt.tab.c: nrt.y
	bison -d nrt.y

lex.yy.c: nrt.l nrt.tab.c
	flex nrt.l

nrt_data: nrt_data.c nrt_data.h
	gcc -c nrt_data.c

nrt: lex.yy.c nrt.tab.c nrt_data
	gcc lex.yy.c nrt.tab.c -lfl -o nrt nrt_data.o

clean:
	rm -rf nrt.tab.* lex.yy.c nrt nrt_data.o

out.sco: nrt
	./nrt aCallToAttention.nrt > out.sco
	#./nrt mario.nrt > out.sco

all:
	make nrt

install:
	sudo cp nrt /usr/local/bin
