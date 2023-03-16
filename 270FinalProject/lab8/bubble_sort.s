@ BubbkeSort.s James Heffernan 2nd March 2023
@ BubbkeSort.s Manav Bilakhia 2nd March 2023
.text
.global _start

@ Subroutine for bubble sort
@ Sorts an array in place using the bubble sort algorithm
@
@ Arguments: 
@  r0: pointer to start of array (*a)
@  r1: the size of the array
bubblesort:
    @ TODO: implement

_start:
    ldr r0, =array      @ load address of array
    ldr r1, =endarr     @ load address of end of array
    sub r1, r1, r0      @ get the number of bytes between start and end of array
    mov r1, r1, asr #2  @ get the number of words between start and end of array
    bl bubblesort       @ sort the array
_end:
    b _end

.data
    array:          .word -123, 548, 923, 431, 560, -348
    endarr: