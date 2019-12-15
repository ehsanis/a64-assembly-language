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
define(x_r, x19)
define(y_r, x20)
define(z_r, x21)
define(result_r, x22)

        .balign 4                                               // insures instruction alignent
        .global main                                            // makes main visible to linker

main:
        stp     x29, x30, [sp, -16]!                            // sotre pair FP and LR and allocate 16 bytes of memory on stack
        mov     x29, sp                                         // update FP to current SP

        // initialize variables
        mov     x_r, 15                                         // x = 15
        mov     y_r, 10                                         // y = 10
        mov     z_r, 5                                          // z = 5
        
        // addition
        add     result_r, x_r, y_r                              // result = x + y
        add     result_r, result_r, z_r                         // result = result + z

        // print the result of the addition
        adrp    x0, print_add                                   // address of format string(print_add)higher 52 bits
        add     x0, x0, :lo12:print_add                         // address of format string(print_add) lower 12 bits
        mov     x1, x_r                                         // 2nd argument = x
        mov     x2, y_r                                         // 3rd arg = y
        mov     x3, z_r                                         // 4th arg = z
        mov     x4, result_r                                    // 5th argument = result_r
        bl      printf                                          // call printf function


        // subtruction 
        sub     result_r, x_r, y_r                              // result = x - y
        sub     result_r, result_r, z_r                         // result = result -z

        // print the result
        adrp    x0, print_sub                                   // same as previous print
        add     x0, x0, :lo12:print_sub                        
        mov     x1, x_r
        mov     x2, y_r
        mov     x3, z_r
        mov     x4, result_r
        bl      printf
        
        // multiplication
        mul     result_r, x_r, y_r                              // result = x * y
        mul     result_r, result_r, z_r                         // result = result * z

        // print the result of multiplication
        adrp    x0, print_mul                                   // same as print_add
        add     x0, x0, :lo12:print_mul
        mov     x1, x_r
        mov     x2, y_r
        mov     x3, z_r
        mov     x4, result_r
        bl      printf
        
        // multiply-add
        madd    result_r, x_r, y_r, z_r                         // result = z + (x * y)
        
        // print result of multiply-addition
        adrp    x0, print_madd                                  // same as above print
        add     x0, x0, :lo12:print_madd
        mov     x1, x_r
        mov     x2, y_r
        mov     x3, z_r
        mov     x4, result_r
        bl      printf
        
        // multiply_sub
        msub    result_r, x_r, y_r, z_r                         // result = (x * y) - z

        // print the result of multiply-subtruction
        adrp    x0, print_msub                                  // same as above
        add     x0, x0, :lo12:print_msub
        mov     x1, x_r
        mov     x2, y_r
        mov     x3, z_r
        mov     x4, result_r
        bl      printf

        // multiply-negate
        mneg    result_r, x_r, y_r                              // result = -(x * y)

        // print the result
        adrp    x0, print_mneg
        add     x0, x0, :lo12:print_mneg
        mov     x1, x_r
        mov     x2, y_r
        mov     x3, result_r
        bl      printf

        // simple division with zero remainder
        udiv     result_r, x_r, z_r                              // result = x/z 
        
        // print the result
        adrp    x0, print_div                                   // same as above prints
        add     x0, x0, :lo12:print_div
        mov     x1, x_r
        mov     x2, z_r
        mov     x3, result_r
        bl      printf


        ldp     x29, x30, [sp], 16                              // deallocate the stack memory
        ret                                                     // return to caller
