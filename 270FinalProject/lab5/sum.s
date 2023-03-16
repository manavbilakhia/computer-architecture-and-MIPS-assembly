@ sum.s James Heffernan  1 March 2023
@ sum.s Manav Bilakhia  1 March 2023
@ Elementary program to add three numbers and store and print the sum.
@ Register use:
@ R1:  current number
@ R2:  sum of the three numbers

.global _start
_start:

       LDR     R1, =NUM1    @ R1 points to NUM1 (address of NUM1)
       LDR     R2, [R1, #0] @ R2 = NUM1
       LDR     R1, =NUM2    @ R1 points to NUM2 (address of NUM2)
       LDR     R3, [R1, #0] @ R3 = NUM2
       ADD     R2, R2, R3   

       LDR     R1, =NUM3    @ R1 points to NUM3 (address of NUM3)
       LDR     R3, [R1, #0] @ R3 = NUM3
       ADD     R2, R2, R3   @ R2 = NUM1 + NUM2 + NUM3

       LDR     R1, =SUM     @ R1 points to SUM (address of SUM)
       STR     R2, [R1, #0] @ SUM = R2
@ data section:
@ 3 variables to store the three numbers and the sum

.data
NUM1:   .word    1000       @ 1st number        
NUM2:   .word    -2         @ 2nd number    
NUM3:   .word    -1         @ 3rd number     
SUM:    .space   4          @ sum of the three numbers    