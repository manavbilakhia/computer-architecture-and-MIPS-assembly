@ arrsumsoln.s James Heffernan 2nd March 2023
@ arrsumsoln.s Manav Bilakhia 2nd March 2023
@ This program sums the elements of an array and stores the result in a variable
@ Register use:
@ r0: pointer to array
@ r1: pointer to endarr
@ r2: pointer to sum
@ r3: temporary register
@ r4: counter
@ r5: array length in words
@ r7: system call number

@ Data section
@ array: array of integers
@ endarr: address of last element of array
@ sum: variable to store sum of array elements
        .data
array:  .word -123, 548, 923, 431, 560, -348, 961, 5
endarr: 
sum:    .word 0          	@ initialize sum to zero

        .text
        .global _start

_arrsum:

        push {lr}		        @ set up stack frame
        push {r4}

        ldr r0, =array          @ load address of array
        ldr r1, =endarr         @ load address of endarr
        ldr r2, =sum            @ load address of sum
        
        ldr r3, =array          @ load address of array again
        sub r5, r1, r3          @ calculate array length in words (number of integers)
        lsr r5, r5, #2          @ divide by 4 to get number of words
        mov r4, #0              @ initialize counter to zero

        b loop_start            @ jump to loop start

loop:

        ldr r3, [r0], #4        @ load value of current array element and increment pointer
        add r4, r4, r3          @ add current value to counter

loop_start:
        cmp r5, #0              @ check if there are more words to process
        beq end_loop
        
        subs r5, r5, #1         @ decrement word counter
        b loop                  @ continue loop

end_loop:
       
        str r4, [r2]            @ store sum and return
        pop {r4}
        pop {lr}

_start:
        
        bl _arrsum              @ call _arrsum subroutine

        mov r7, #0              @ exit program
        svc 0
