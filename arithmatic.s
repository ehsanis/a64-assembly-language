// Author: Sharif Ehsani
// Date: Dec 13, 2019
// www.github.com/ehsanis

/*
*  This program implements simple arithmatic operations in assembly language
*  using macros for ARMv8 Archticture, operting only on integers no float or double used
*  the remainder of a division operation is discarded
*/

// creat foramat strings
print_add:      .string "Addition: x = %d, y = %d, z = %d, x + y + z = %d\n"
print_sub:      .string "Subtruction: x = %d, y = %d, z = %d, x - y -z = %d \n"
print_mul:      .string "Multiplication: x = %d, y = %d, z = %d, x * y * z = %d\n"
print_madd:     .string "Multiply-add: x = %d, y = %d, z = %d, (x * y) + z = %d\n"
print_msub:     .string "Multiply-subtruct: x = %d, y = %d, z = %d, z - (x * y) = %d\n"
print_mneg:     .string "Multiply-negate: x = %d, y = %d, -(x * y) = %d\n"
print_div:      .string "Division: x = %d, z = %d, x / z = %d\n"

// define macros and declare vaiables





        .balign 4                                               // insures instruction alignent
        .global main                                            // makes main visible to linker

main:
        stp     x29, x30, [sp, -16]!                            // sotre pair FP and LR and allocate 16 bytes of memory on stack
        mov     x29, sp                                         // update FP to current SP

        // initialize variables
        mov     x19, 15                                         // x = 15
        mov     x20, 10                                         // y = 10
        mov     x21, 5                                          // z = 5
        
        // addition
        add     x22, x19, x20                              // result = x + y
        add     x22, x22, x21                         // result = result + z

        // print the result of the addition
        adrp    x0, print_add                                   // address of format string(print_add)higher 52 bits
        add     x0, x0, :lo12:print_add                         // address of format string(print_add) lower 12 bits
        mov     x1, x19                                         // 2nd argument = x
        mov     x2, x20                                         // 3rd arg = y
        mov     x3, x21                                         // 4th arg = z
        mov     x4, x22                                    // 5th argument = x22
        bl      printf                                          // call printf function


        // subtruction 
        sub     x22, x19, x20                              // result = x - y
        sub     x22, x22, x21                         // result = result -z

        // print the result
        adrp    x0, print_sub                                   // same as previous print
        add     x0, x0, :lo12:print_sub                        
        mov     x1, x19
        mov     x2, x20
        mov     x3, x21
        mov     x4, x22
        bl      printf
        
        // multiplication
        mul     x22, x19, x20                              // result = x * y
        mul     x22, x22, x21                         // result = result * z

        // print the result of multiplication
        adrp    x0, print_mul                                   // same as print_add
        add     x0, x0, :lo12:print_mul
        mov     x1, x19
        mov     x2, x20
        mov     x3, x21
        mov     x4, x22
        bl      printf
        
        // multiply-add
        madd    x22, x19, x20, x21                         // result = z + (x * y)
        
        // print result of multiply-addition
        adrp    x0, print_madd                                  // same as above print
        add     x0, x0, :lo12:print_madd
        mov     x1, x19
        mov     x2, x20
        mov     x3, x21
        mov     x4, x22
        bl      printf
        
        // multiply_sub
        msub    x22, x19, x20, x21                         // result = (x * y) - z

        // print the result of multiply-subtruction
        adrp    x0, print_msub                                  // same as above
        add     x0, x0, :lo12:print_msub
        mov     x1, x19
        mov     x2, x20
        mov     x3, x21
        mov     x4, x22
        bl      printf

        // multiply-negate
        mneg    x22, x19, x20                              // result = -(x * y)

        // print the result
        adrp    x0, print_mneg
        add     x0, x0, :lo12:print_mneg
        mov     x1, x19
        mov     x2, x20
        mov     x3, x22
        bl      printf

        // simple division with zero remainder
        udiv     x22, x19, x21                              // result = x/z 
        
        // print the result
        adrp    x0, print_div                                   // same as above prints
        add     x0, x0, :lo12:print_div
        mov     x1, x19
        mov     x2, x21
        mov     x3, x22
        bl      printf


        ldp     x29, x30, [sp], 16                              // deallocate the stack memory
        ret                                                     // return to caller
