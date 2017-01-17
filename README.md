# AssemblySieve
A simple prime finding algorithm written in x64 assembly.

## About
I wrote this bit of code as an exercise after I finished a course on assembly language.
It's not particularly efficient; it has a running time of about O(n^2). 

The assembly file, `prime.asm`, was written with the [Netwide Assembler (NASM)](http://www.nasm.us) syntax.
It also conforms to The System V Application Binary Interface. 

## Usage
`prime.asm` is meant to be assembled with NASM into an object file, and then integrated separately into a C based program. The object file can be assembled with a command something like:
```
  nasm -o prime.o -f elf64 prime.asm
```
where `elf64` should be changed based on the system it's to be used on. 
The resulting object file has the following C function signature / prototype:
```
  void primeSieve(char *c, int size);
```
`gcc` can then be used to link the `prime.o` object file with your code that makes use of it. For a more in depth description on calling the function, have a look at `prime.asm`. For a working example, take a look at `test.c` and the associated makefile.
