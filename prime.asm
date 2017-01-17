
;This C function takes the pointer to a char array and finds all the
;prime values in the array. Every item in the array should be set to
;"true" (0xff). This function will make all the non primes "false" (0x00).
;This assembly file can be built using the NASM assembler with a command
;something like:
;   nasm -o prime.o -f elf64 prime.asm
;but your system may vary.
;C function prototype: void primeSieve(char *c, int size);
;
;Eric Hay
;May 28th 2015

global primeSieve

section .data

section .text

;This C function takes the pointer to a char array and finds all the
;prime values in the array. Every item in the array should be set to
;"true" (0xff). This function will make all the non primes false (0x00).
;C prototype: void primeSieve(char *c, int size);

    primeSieve:

    ;Save all the registers that the amd64 abi says should be saved
    push rbx
    push rsp
    push rbp
    push r12
    push r13
    push r14
    push r15

    ;Acutal code can now begin

    ;Move the pointer to the start of the array to rax
    mov rax, rdi

    ;Lets get the end pointer
    ;Decirement the size of the array by one
    sub rsi, 1
    ;Copy the start pointer into rbx
    mov rbx, rax
    ;Add the size to rbx to create the end pointer
    add rbx, rsi

    ;Set 0 and 1 to not prime
    mov byte [rax], 0x00
    mov byte [rax + 1], 0x00

    ;Set our current prime to 2 (that's where we'll start from)
    ;This actually sets it to 1, but prime_start will set it to 2
    mov rcx, rax
    add rcx, 1

    ;This is the loop to find the next prime
    prime_start:

        ;Move to the next potential prime number
        add rcx, 1

        ;If rcx (pointer to current prime) is = rbx (pointer to end of array),
        ;we should exit, otherwise, we'll continue
        ;Compare rcx and rbx
        cmp rcx, rbx
        ;If they're equal, jump to the end of this loop, otherwise continue
        je prime_end

        ;Check to see if [rcx] (pointer to current prime) is not prime
        ;If it's not, then we go back to the start of this loop
        ;Otherwise we continue to remove all its multiples
        ;Compare the byte pointed to by rcx with "false" (0x00)
        cmp byte [rcx], 0x00
        ;If it's false, go to prime_start, otherwise, continue
        je prime_start

        ;If we've made it this far, we now need to get the value of the prime
        ;This is easily done by rcx - rax. We'll put it in rdx
        mov rdx, rcx
        sub rdx, rax

        ;Copy the address of the current prime into r8
        mov r8, rcx

        ;Now we'll start to remove multiples of the prime in the array
        multiple_start:

            ;Start by jumping to the next multiple
            add r8, rdx

            ;Check to see if it's beyond the end pointer
            cmp r8, rbx
            ;If it's greater than, exit this loop, otherwise, continue
            jg prime_start

            ;Set the multiple to false
            mov byte [r8], 0x00

            ;Unconditionally jump to multiple_start to remove the next multiple
            jmp multiple_start


    prime_end:

    ;Put all the registers back
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbp
    pop rsp
    pop rbx

    ;Return to the calling function
    ret
