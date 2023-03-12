#  Linked structures in assembler       D. Hemmendinger  24 January 2009
#  Linked structures in assembler       J. Rieffel 15 February 2011
#  Linked structures in assembler       M. Bilakhia 15 February 2011
#  Discussed algorithm with James Heffernan
# (removed dependance on in-line constant definitions)
#  This program builds a heap as a singly-linked list of nodes that
#  are then used to build a singly-linked list of numbers.
#       mknodes: builds a linked list of free nodes from an 
#                 unstructured heap space. 
#       new:    (you complete it) returns a node from the free list
#       insert: (you write) inserts an integer into a linked list, in order.
#       print:  (you write) traverses a list and prints its contents neatly

## System calls
PR_INT = 1
PR_STR = 4

## Node structure
NEXT     = 0                                                                    ## offset to next pointer
DATA     = 4                                                                    ## offset to data
DATASIZE = 4                                            
NODESIZE = 8                                                                    ##DATA + DATASIZE       bytes per node
NUMNODES = 15                                                           
HEAPSIZE = 120                                                                  ##NODESIZE*NUMNODES
NIL      = 0                                                                    ## for null pointer

       .data  
space:  .asciiz " "                                 
input: .word 2 0 6 3 1                                                          ## you add more numbers here  (no more than NUMNODES)
                                  
inp_end:                                        
INSIZE = 1                                                                      #(inp_end - input)/4    # number of input array elements

heap:   .space  HEAPSIZE           # storage for nodes 

nofree: .asciiz "Out of free nodes; terminating program\n"

        .align 2
        .text   
main:           
                                addi $sp, $sp, -4       
                                sw $ra, 0($sp)  
                                li $s7, NIL                                     # global variable holding the NIL value
                                la $a0, heap                                    # pass the heap address to mknodes
                                li $a1, HEAPSIZE	                        # and its size
                                li $a2, NODESIZE 	                        # and the size of a node
                                jal mknodes     
                                move $a1, $s7                                   # initially our linked list will be empty (nil)
                                move $a2, $v0                                   # presuming $v0 contains a pointer to free after mknodes is called
                                la $t3, input                                   # $t3 points to the input array
                                la $t4, inp_end                                 # $t4 points to the end of the input array
                                j loop_cond                                     # jump to the loop condition

loop:           
                                lw $a0, 0($t3)                                  # load the next input value into $a0
                                jal insert_recursive                            # insert it into the linked list
                                move $a1, $v0                                   # move the new linked list pointer to $a1
                                move $a2, $v1                                   # move the new free pointer to $a2
                                addi $t3, $t3, 4                                # increment the input array pointer

loop_cond:                              
                                bne $t3, $t4, loop                              # if we haven't reached the end of the input array, loop
                                move $a0, $v0                                   # move the linked list pointer to $a0
                                jal printLinkedList     


done:           
                                lw $ra, 0($sp)                                  # restore return address
                                addi $sp, $sp, 4                                # restore stack pointer
                                jr $ra

# mknodes takes a heap address in a0, its byte-size in a1, and node size in a2
#  and partitions it into a singly-linked list of nodesize
# (NODESIZE-byte) nodes, pointed to by free.  
# NOTE:  the list is built with free pointing to the last node in the
#    heap area, which points to the previous one, etc.  The reason for
#    this construction is to be sure that you get nodes by calling
#    "new" rather than by rebuilding the heap yourself!  
# Register usage:
# inputs:
# $a0 contains a pointer to the heap
# $a1 contains the heapsize
# $a2 contains the nodesize

# used registers
# $t0: pointer to block that will become a node
# $t1: pointer to previous block (will become next node)

# $v0: points to the first free node in the heap
mknodes:
                                add $t0, $a0, $a1                               # t0 starts by pointing to the last
                                sub $t0, $t0, $a2                               # node-sized block in the heap
                                move  $v0, $t0                                  # set output v0 to point to that first node
mkloop:                         
                                sub $t1, $t0, $a2                               # t1 points to previous node-sized block
                                sw  $t1, NEXT($t0)                              # link the t0->node to point to t1 node
                                move $t0, $t1                                   # back up t0 by one node
                                bne $t0, $a0, mkloop                            # repeat if not at heap-start
                                sw $s7, NEXT($t1)                               # ground node (first block in heap)
                                jr $ra

# Removes a node from free (passed in via $a0), returning a pointer to the node in $v0,
# and a pointer to the new free in $v1
#  ( returns NIL if none available)
# inputs:
#    $a0: points to the first "free" node in the heap
# outputs:
#    $v0: the node we have "created" (pulled off the stack from free)
#    $v1: the new value of free (we don't want to clobber $a0 when we change free, right? right?)
new:
                                move $v0, $a0                                   # $v0 = free
                                beq $a0, $s7, returnNew                         # if free is nil, return nil
                                addi $v1, $a0 NODESIZE                          # $v1 = free->next

returnNew:
                                jr $ra

#insert behaves as described in the lab text
# inputs:
#	 $a0: should contain N
#	 $a1: should contain a pointer to our linked list
#	 $a2: should contain a pointer to free
#
# outputs:
# 	$v0 should contain the new pointer to our linked list
#	$v1 should contain the new pointer to free
insert_recursive:
                                beq $a1, $s7, insert_recursive_base_case        # if listptr is nil, insert at the beginning
                                lw $t0, DATA($a1)                               # $t0 = listptr->data
                                ble $a0, $t0, insert_recursive_base_case        # if N <= listptr->data, insert at the beginning
                                #start recursive call
                                addi $sp, $sp, -4                               # push $ra
                                sw $ra, 0($sp)
                                addi $sp, $sp, -4                               # push $a1
                                sw $a1, 0($sp)
                                lw $a1, NEXT($a1)                               # listptr = listptr->next
                                jal insert_recursive                            # recursive call
                                lw $a1, 0($sp)                                  # pop $a1
                                addi $sp, $sp, 4
                                lw $ra, 0($sp)                                  # pop $ra
                                addi $sp, $sp, 4
                                #end recursive call
                                sw $v0, NEXT($a1)                               # listptr->next = insert_recursive(listptr->next, N, free)
                                move $v0, $a1                                   # return listptr
                                jr $ra

insert_recursive_base_case:
                                addi $sp, $sp, -4                               # push $ra
                                sw $ra, 0($sp)
                                addi $sp, $sp, -4                               # push $a0
                                sw $a0, 0($sp)                          
                                move $a0, $a2                                   # free = new(free)
                                jal new
                                lw $a0, 0($sp)                                  # pop $a0
                                addi $sp, $sp, 4
                                lw $ra, 0($sp)                                  # pop $ra
                                addi $sp, $sp, 4
                                sw $a0, DATA($v0)                               # new(free)->data = N
                                sw $a1, NEXT($v0)                               # new(free)->next = listptr
                                #move $v0, $v1                                  # return new(free)
                                jr $ra



# print behaves as described in the lab text
# inputs:
#        $a0: should contain a pointer to our linked list (listptr)
#outputs: none 
#side effects: prints the contents of the linked list

printLinkedList:
                                move $t0, $a0                                   # $t0 = listptr                    
                                move $t1, $a0                                   # $t1 = listptr           
                                j printLinkedListWhile                          # jump to while loop

printLinkedListWhileBody:       
                                li $v0, PR_INT                                  # print listptr->data
                                lw $a0, DATA($t0)                               # $a0 = listptr->data
                                syscall                                 
                                li $v0, PR_STR                                  # print " "
                                la $a0, space                                   # $a0 = " "
                                syscall                                 
                                lw $t0, NEXT($t0)                               # listptr = listptr->next

printLinkedListWhile:                   
                                bne $t0, $s7, printLinkedListWhileBody          # while (listptr != nil) {
                                move $a0, $t1                                   # $a0 = listptr
                                jr $ra                                          # return listptr