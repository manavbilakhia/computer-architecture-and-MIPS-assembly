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
    push {r4, r5, r6, r7, r8}
    mov r2, #0              @ int i
    mov r3, #0              @ int j
    sub r4, r1, #1          @ r4 = asize-1
    
    b forcond
for: sub r5, r4, r2         @ r5 = asize-1-i
    mov r3, #0
    b innerforcond
innerfor:
    mov r8, r3, lsl #2      @ r8 = j*4 (to account for byte-addressable)
    ldr r6, [r0, r8]        @ r6 = a[j]
    add r8, r8, #4          @ r8 = j*4+4 (to account for byte addressable)
    ldr r7, [r0, r8]        @ r7 = a[j+1]
    cmp r6, r7
    ble else
    str r6, [r0, r8]        @ a[j+1] = a[j]
    sub r8, r8, #4          @ r8 = j*4
    str r7, [r0, r8]        @ a[j] = a[j+1]
else: add r3, r3, #1        @ j++
innerforcond: cmp r3, r5
    blt innerfor            @ j < size-1-i
    add r2, r2, #1          @ i++
forcond: cmp r2, r4 
    blt for                 @ i < size-1
    pop {r4, r5, r6, r7, r8}
    bx lr

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