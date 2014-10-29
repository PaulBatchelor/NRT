default:

nrt.tab.c: nrt.y
	bison -d nrt.y

lex.yy.c: nrt.l nrt.tab.c
	flex nrt.l

nrt: lex.yy.c nrt.tab.c
	gcc lex.yy.c nrt.tab.c -lfl -o nrt

clean:
	rm -rf nrt.tab.* lex.yy.c nrt

all:
	make nrt
