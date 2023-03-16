@ swap.s James Heffernan  1 March 2023
@ swap.s Manav Bilakhia  1 March 2023
@ Elementary program to swap the contents of two elements of an array,
@ given the array and the indices of the elements to be swapped.
@ Register use:
@ R1: array
@ R2: index 1
@ R3: value at index 1
@ R4: value at index 2
@ R5: index 2
@ R6: temporary register

.global _start
_start:
    ldr r0, =ar                         @ load the address of the array into r0
    ldr r1, =i1                         @ load the address of index i1 into r1
    ldr r2, [r1]                        @ load the value of i1 into r2
    ldr r3, =i2                         @ load the address of index i2 into r3
    ldr r4, [r3]                        @ load the value of i2 into r4

    ldr r5, [r0, r2, lsl #2]            @ load the value of ar[i1] into r5
    ldr r6, [r0, r4, lsl #2]            @ load the value of ar[i2] into r6

    str r5, [r0, r4, lsl #2]            @ store the value of ar[i1] into ar[i2]
    str r6, [r0, r2, lsl #2]            @ store the value of ar[i2] into ar[i1]

     .data
ar:  .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 @ array of 10 elements
i1:  .word 4                            @ index 1
i2:  .word 8                            @ index 2
