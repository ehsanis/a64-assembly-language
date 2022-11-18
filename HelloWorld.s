/*
* Author: Sharif Ehsani
* Date: Dec 14, 2019
* www.gitbuh.com/ehsanis
* https://sharifehsani.github.io/
*
* This program runs on ARMv8 archeticture. assembly language 
* it prints 2 lines of statements with the first one having a decimal value
*/

//creats the format string
print_1:      .string "Hello World %d\n"
print_2:      .string "This is my first print statement in assembly language\n"

        .balign 4                                               // aligns instruction by multiple of 4
        .global main                                            // make main visible to linker

main:
        // store paire of registers (x29 = FP = frame pointer that that holds the adddress of 
        // currently executing instruction and x30 = LR = link register)
        // [sp, -16] allocates 16 bytes in stack memory, does so by preincrementing the SP reg by -16
        // SP = stack pointer = points to the location in RAM where we write to

        stp     x29, x30, [sp,-16]!                             // store paire (Fllocates stack memory
        mov     x29, sp                                         // updates FP to current SP
        
        // adrp and add lines below are both the address of format string which is also the first
        // argument in x0
        adrp    x0, print_1                                     // address of the string(fmt) high order 52 bits
        add     x0, x0, :lo12:print_1                           // address of the string(fmt) low 12 order bits
        mov     x1, 2019                                        // put an immidiate value 2019 as a second argument 
        bl      printf                                          // call printf
        adrp    x0, print_2                                     // address of the second string the higher 52 bits
        add     x0, x0, :lo12:print_2                           // address of the second string the lower 12 bits
        bl      printf                                          // call the printf function

        // loads the pair of registers (FP and LR from RAM
        // [sp], 16 deallocates the memory we allocated at the begining 
        ldp     x29, x30, [sp],16                               // deallocate the allocated memory
        ret                                                     // return to the caller

