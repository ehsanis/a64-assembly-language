// Author: Sharif Ehsani
// Date: Dec 13, 2019
// www.github.com/ehsanis

// This program implements simple if, else if and else construct in assembly language using
// macros for ARMv8 architercture.

//............NOTE:..
// since the value of a is originally set to 10 which is greater than the value of b = 8
// it only enteres the if block. if you want to check the else block change the value of a or b
// so that a < = b in line/ 46 and line 47



// equivalent C code:
// int a = 10;
// int b = 8;
// if (a > b)
// 
// c = a + b;
// d = c + 5;
//  else
//
// c = a - b;
// d = c - 5;


// creat format string
fmt_if:         .string "this is if block: a = %d, b = %d, c = (a + b) = %d, d = (c + 5) = %d\n"
fmt_else:       .string "this is else block: a = %d, b = %d, c = (a - b) = %d, d = (c - 5) = %d\n"

// define macros and declare variables





        .balign 4                                               // insure insturction allignment
        .global main                                            // make main visible to linker

main:
        stp     x29, x30, [sp, -16]!                            // store pair FP and LR and allocate 16 bytes stack memory
        mov     x29, sp                                         // update FP to current SP

        // initialize variable        
        mov     x19, 10                                         // a = 10
        mov     x20, 8                                          // b = 8
        
        // if block
        cmp     x19, x20                                        // compare a with b
        b.le    else_if                                         // if a < = b go to else if, if a > b continue
        
        add     x21, x19, x20                                   // c = a + b
        add     x22, x21, 5                                     // d = c +  5

        // print values of variables
        adrp    x0, fmt_if                                      // address of fmt_if string higher 52 bits
        add     x0, x0, :lo12:fmt_if                            // address of fmt_if string lower 12 bits
        mov     x1, x19                                         // 2nd argument 
        mov     x2, x20                                         // 3rd arg
        mov     x3, x21                                         // 4th arg
        mov     x4, x22                                         // 5th arg
        bl      printf                                          // call printf function
        b       else
else_if:
        sub     x21, x19, x20                                   // c = a - b
        sub     x22, x21, 5                                     // d = c - 5
        
        // print the values of variabls
        adrp    x0, fmt_else                                    // same as the above print
        add     x0, x0, :lo12:fmt_else
        mov     x1, x19
        mov     x2, x20
        mov     x3, x21
        mov     x4, x22
        bl      printf

else:
        ldp     x29, x30, [sp], 16                              // deallocate the stack memory
        ret                                                     // return to caller (Operating System)
