// Author: sharif ehsani
// Date: Dec 13, 2019
// www.github.com/ehsanis

/*
* This program implements simple loop in ARMv8 assembly language using macros
*/

fmt:    .string "loop number: %d\n"                     // creat format string
        
        // define macros and initialize variables, but assign values to them later
                                        // define variable i and put it in x19
                                        // define variable x and put it in x20

        .balign 4                                       // insure instruction alingment
        .global main                                    // make main visible to the linker

main:
        stp     x29, x30, [sp,-16]!                     // store pair FP and LR and allocate 16 bytes of memory on stack
        mov     x29, sp                                 // update FP with current SP

        // initialize variables
        mov     x19, 0                                  // initialize variable i to zero
        mov     x20, 10                                 // initialize variable x to 10
        b       loop_test                               // branch to loop_test

top:
        // print 
        adrp    x0, fmt                                 // address of the first argument(fmt string) the high order 52 bits
        add     x0, x0, :lo12:fmt                       // address of the first argument(fmt string) the lower 12 bits
        mov     x1, x19                                 // put the second argument = variable i as we print the string + i variable
        bl      printf                                  // call printf function
        // increment i
        add     x19, x19, 1                             // i is initially 0, increment i variable 

loop_test:
        
        // loop test
        cmp     x19, x20                                // compare i variable with x variable
        b.lt    top                                     // if i < x branch to top of the loop and run the loop els exit the loop
        
        // end of program
        ldp     x29, x30, [sp], 16                      // deallocate the stack memory allocated earlier
        ret                                             // return to caller(Operating System)
