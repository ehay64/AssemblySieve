
program: test prime
	gcc prime.o test.o -o program

test:
	gcc -std=c11 -c test.c -o test.o

prime:
	nasm -o prime.o -f elf64 prime.asm

clean:
	rm prime.o test.o program
