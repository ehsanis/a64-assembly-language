// Author: Sharif Ehsani
// Date: Dec 13, 2019
/*
* This program implements simple while loop in assembly language for ARMv8 architecture
*/

/*
* equivelent C code
* int i = 10
* while (i < 20) 
*{
*       x = x + i;
*       printf(x);
*       i = i + 1;
*       printf(i);
*}
*/

fmt_x:  .string "This is the value of x  = %d\n"        // create format string to print value of x
fmt_i:  .string "This is the value of i = %d\n"         // creat format string to print value of i

// define macros and initialize variables 
                                        // declare variable x and put it in x19
                                        // declare variable i and put it in x20

        .balign 4                                       // insure instruction allignment
        .global main                                    // make maine visible to linker

main:

        stp     x29, x30, [sp, -16]!                    // store pair of FP and LR and allocate 16 byte memory on stack
        mov     x29, sp                                 // update FP with SP

        mov     x19, 0                                  // initialize variable x to zero
        mov     x20, 10                                 // initialize variable i to 10
        b       loop_test                               // branch to loop_test

top:    
        add     x19, x19, x20                           // x19 = x19 + x20

        adrp    x0, fmt_x                               // address of fmt_x string into first arugment (x0) higher 52 bits
        add     x0, x0, :lo12:fmt_x                     // address of fmt_x string lower 12 bits
        mov     x1, x19                                 // 2nd argument = x19
        bl      printf                                  // call printf function

        adrp    x0, fmt_i                               // address of x20 string
        add     x0, x0, :lo12:fmt_i                     // lower 12 bits
        mov     x1, x20                                 // 2nd arg = x20
        bl      printf                                  // call printf function
        
        add     x20, x20, 1                             // i++, increment i

loop_test:
        cmp     x20, 20                                 // compare value of x20 with 20 if i < 20 enter the loop
        b.lt    top                                     // branch to top of the loop and implement the loop if the condition meets else exit
                                                        // the program

        ldp     x29, x30, [sp], 16                      // deallocate the stack memory that was allocated earlier
        ret                                             // return to caller(operating system)
