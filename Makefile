HEADER_FILES=nrt.tab.h nrt_vm.h lex.nrt.h
NRT_OBJECTS= lex.nrt.o nrt.tab.o nrt_vm.o

default:
	make all
nrt.tab.c: nrt.y 
	bison -p nrt -d nrt.y

lex.nrt.c: nrt.l nrt.tab.c 
	flex -P nrt --header-file="lex.nrt.h" nrt.l

nrt_vm.o: nrt_vm.c nrt_vm.h
	gcc -c nrt_vm.c

lex.nrt.o: lex.nrt.c nrt.h
	gcc -c lex.nrt.c

nrt.tab.o: nrt.tab.c nrt.h
	gcc -c nrt.tab.c

nrt_objects.o: $(NRT_OBJECTS)
	ld -o nrt_objects.o -r lex.nrt.o nrt.tab.o nrt_vm.o

libnrt.a: $(NRT_OBJECTS)
	ld -o nrt_objects.o -r $(NRT_OBJECTS)

nrt.h: 
	cat $(HEADER_FILES) > nrt.h

nrt: nrt_objects.o nrt_parse.c nrt.h libnrt.a
	gcc  nrt_parse.c -o nrt libnrt.a

clean:
	rm -rf nrt.tab.* lex.nrt.c nrt nrt_vm.o *.o nrt.h

all:
	make nrt

install:
	sudo cp nrt /usr/local/bin
