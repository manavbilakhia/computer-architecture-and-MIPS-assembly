## Sum an array with a subroutine.
## Manav Bilakhia 9 February 2023

PR_INT = 1         
        .data
message: .asciiz "The sum of the array is: "
array:  .word -123, 548, 923, 431, 560, -348, 961
endarr:
        .text
        .align 2
main:   la $a0, array        # a0 points into array
        la $a1, endarr       # a1 points to array end
        #Changes to part 1
        sub $a1 $a1 $a0      # Get the difference in bytes
        srl $a1 $a1, 2       # Get the difference in words

	addi $sp, $sp, -4    # push 
	sw $ra, 0($sp)       # ret addr on stack
        jal arrsum
	lw $ra, 0($sp)       # pop
	addi $sp, $sp, 4     # ret addr
        #Changes to part 3
        add $t3, $0, $v0     # copy sum into $t3
        li $v0, 4            # system call code for printing a string
        la $a0, message      # load the address of the message into $a0
        syscall
        add $a0, $0, $t3     # copy sum into $a0
        addi $v0, $0, PR_INT # print code in $v0
        syscall

        jr $ra                  

## array-summation subroutine
## register use:
##	$a0: parameter: array addr; used as pointer to current element
##	$a1: parameter: number of words in arr
##	$v0: accumulator and return value
##	$t2: temporary copy of current array element

        #changes to part 4
arrsum: move $v0, $0         # v0 accumulates sum
        move $t0 $0          # t0 is the counter
        j cond
sum:    lw $t2, 0($a0)       # get next array element
        add $v0, $v0, $t2    # add it in
        addi $a0, $a0, 4     # point to next word
        addi $t0 $t0 1        
cond:   blt $t0, $a1, sum    # while a0 < endarr do.
        jr $ra