## Insertion sort with a subroutine to print.
## Manav Bilakhia 9 February 2023

                .data
before_message: .asciiz "Before sorting: \n"
after_message:  .asciiz "\nAfter sorting: \n"
space:          .asciiz " "
array:          .word -123, 548, 923, 431, 560, -348, 961
endarr:
                .text
                .align 2

main:
                li $v0, 4                       # print string
                la $a0, before_message          # $a0 = before_message
                syscall
                la $a0, array                   # a0 points into array
                la $a1, endarr                  # a1 points to end of array
                sub $a1, $a1, $a0               # Get the difference in bytes
                srl $a1, $a1, 2                 # Get the difference in words
                addi $sp, $sp, -4               # push ret addr on stack
                sw $ra, 0($sp)                  # push ret addr on stack      
                jal print_array                 # call print_array 
                jal isortptr                    # call isortptr
                li $v0, 4                       # print string
                la $a0, after_message           # $a0 = after_message
                syscall
                la $a0, array                   # a0 points into array
                la $a1, endarr                  # a1 points to end of array
                sub $a1, $a1, $a0               # Get the difference in bytes
                srl $a1, $a1, 2                 # Get the difference in words
                jal print_array                 # call print_array
                lw $ra, 0($sp)                  # pop ret addr off stack
	            addi $sp, $sp, 4                # pop ret addr off stack
                jr $ra

isortptr:
                sll $t1, $a1, 2                 # asize * 4
                add $t1, $t1, $a0               # a + asize * 4
                move $t2, $a0                   # int *p = a       
                move $t3, $0                    # int *q
                move $t4, $0                    # int tmp
                addi $t2, $t2, 4                # ++p
                j outer_loop
    
outer_loop:
                bge $t2, $t1, done              # for (p < a + asize)
                lw $t4, 0($t2)                  # tmp = *p
                move $t3, $t2                   # int *q = p
    
inner_loop:
                ble $t3, $a0, end_inner_loop    # while (q > a)
                lw $t0, -4($t3)                 # $t0 = *(q - 1)
                ble $t0, $t4, end_inner_loop    # if (*(q - 1) > tmp)
                sw $t0, 0($t3)                  # *q = *(q - 1)
                addi $t3, $t3, -4               # q--
                j inner_loop

end_inner_loop:
                sw $t4, 0($t3)                  # *q = tmp
                addi $t2, $t2, 4                # p++
                j outer_loop

done:
                jr $ra


##James Heffernan helped me out with this part
print_array:    
                move $t1 $a0                    # $t1 = a
                move $t2 $0                     # $t2 = i
                move $t3 $a0                    # $t3 = a0
                j EndLoop                       # jump to end of loop

Loop:           
                li $v0, 1                       # print integer  
                lw $t0 0($t1)                   # $t0 = *a
                move $a0, $t0                   # $a0 = $t0 
                syscall     
                li $v0, 4                       # print string
                la $a0, space                   # $a0 = space
                syscall     
                addi $t1 $t1 4                  # a++
                addi $t2 $t2 1                  # i++

EndLoop:        
                blt $t2 $a1 Loop                # while (i < asize)
                move $a0 $t3                    # $a0 = a
                jr $ra     