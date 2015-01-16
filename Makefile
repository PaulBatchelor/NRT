default:
	make all
nrt.tab.c: nrt.y
	bison -p nrt -d nrt.y

lex.nrt.c: nrt.l nrt.tab.c
	flex -P nrt --header-file="lex.nrt.h" nrt.l

nrt_vm.o: nrt_vm.c nrt_vm.h
	gcc -c nrt_vm.c

lex.nrt.o: lex.nrt.c
	gcc -c lex.nrt.c

nrt.tab.o: nrt.tab.c
	gcc -c nrt.tab.c

nrt_objects.o: lex.nrt.o nrt.tab.o nrt_vm.o
	ld -o nrt_objects.o -r lex.nrt.o nrt.tab.o nrt_vm.o

nrt: nrt_objects.o nrt_parse.c
	gcc nrt_objects.o nrt_parse.c -lfl -o nrt 

clean:
	rm -rf nrt.tab.* lex.nrt.c nrt nrt_vm.o *.o

all:
	make nrt

install:
	sudo cp nrt /usr/local/bin
