@ isort.s James Heffernan 2nd March 2023
@ isort.s Manav Bilakhia 2nd March 2023
.text
.global _start

@ Subroutine for insertion sort
@  r0: pointer to start of array (*a)
@  r1: the size of the array
@  r2: pointer to the current element (*p)
@  r3: pointer to the previous element (*q)
@  r4: temporary variable
@  r5: temporary variable

isortptr:
    push {r1, r4, r5}
    mov r4, r1, lsl #2  @ r4 = asize
    add r4, r4, r0      @ r4 = a+asize
    mov r1, r0          @ r1 = int *p = a;
    mov r2, #0          @ r2 = int *q
    mov r3, #0          @ r3 = int tmp
    add r1, r1, #4      @ ++p
    b forcond
    
for: mov r2, r1         @ q = p
    ldr r3, [r1]        @ tmp = *p

while: cmp r2, r0
    ble wend            @ while (q > a) &&
    ldr r5, [r2, #-4]   @ r5 = *(q-1)
    cmp r5, r3          
    ble wend            @ *((q-1) > tmp)
                        @ {
    str r5, [r2]        @ *q = *(q-1)
    add r2, r2, #-4     @ q--
    b while             @ }

wend: str r3, [r2]      @ *q = tmp
    add r1, r1, #4      @ p++

forcond: cmp r1, r4
    blt for             @ for (p < a+asize)

    pop {r1, r4, r5}
    bx lr

_start:
    ldr r0, =array      @ load address of array
    ldr r1, =endarr     @ load address of end of array
    sub r1, r1, r0      @ get the number of bytes between start and end of array
    mov r1, r1, asr #2  @ get the number of words between start and end of array
    bl isortptr         @ sort the array

_end:
    b _end

.data
    array:          .word -123, 548, 923, 431, 560, -348
    endarr:

