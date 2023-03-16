@ LinkedList.s James Heffernan 2nd March 2023
@ LinkedList.s Manav Bilakhia 2nd March 2023
@  This program builds a heap as a singly-linked list of nodes that
@  are then used to build a singly-linked list of numbers.
@       mknodes: builds a linked list of free nodes from an 
@                 unstructured heap space. 
@       new:    returns a node from the free list
@       insert: inserts an integer into a linked list, in order.

.text
.global _start

@ mknodes takes a heap address in r0, a heap size in r1, and a node size in r2
@  and returns a pointer to the first free node in the heap in r0
@  (the list is built with free pointing to the last node in the heap area,
@   which points to the previous one, etc.
@ (NODESIZE-byte) nodes, pointed to by free.  
@ NOTE:  the list is built with free pointing to the last node in the
@    heap area, which points to the previous one, etc.  The reason for
@    this construction is to be sure that you get nodes by calling
@    "new" rather than by rebuilding the heap yourself!  
@ Register usage:
@ inputs:
@ r0 contains a pointer to the heap
@ r1 contains the heapsize
@ r2 contains the nodesize
@
@ return values
@ r0: points to the first free node in the heap
mknodes:
    add r3, r0, r1          @ r3 starts by pointing to the last 
    sub r3, r3, r2          @   node-sized block in the heap
    push {r3, r4}           @ push this last node to the stack to return later, save r4
mkloop: sub r4, r3, r2      @ r1 points to previous node-sized block
    str r4, [r3, #NEXT]     @ link the t0->node to point to t1 node
    mov r3, r4              @ back r3 up by one node
    cmp r3, r0
    bne mkloop              @ repeat if not at heap-start
    str r7, [r3, #NEXT]     @ ground node (first block in heap)
    pop {r0, r4}            @ pop the return value of the stack, restore r4
    bx lr

@ new takes a pointer to the first "free" node in the heap in r0
@  and returns a pointer to a new node, and a pointer to the new
@  first "free" node in the heap in r1
@  (the new node is pulled off the stack from free)
@  ( returns NIL if none available)
@ inputs:
@    r7: points to the first "free" node in the heap
@ outputs:
@    r0: the node we have "created" (pulled off the stack from free)
@    r1: the new value of free
new:
        cmp r0, r7
        beq newret              @ if (r0 == NIL) return
        sub r1, r0, #NODESIZE   @ point to next node
newret: bx lr                   @ return r0, r1

@ insert behaves as described in the lab text
@ inputs:
@	 r0: should contain N
@	 r1: should contain a pointer to our linked list (listptr)
@	 r2: should contain a pointer to free 
@
@ outputs:
@ 	r0 should contain the new pointer to our linked list
@	r1 should contain the new pointer to free
insert:
        cmp r1, r7              @ if (
        beq inbase              @ listptr == NIL
        ldr r3, [r1, #DATA]     @ r3 = listptr->data
        cmp r3, r0              @ ||
        bge inbase              @ listptr->data >= N
                                @ )
        // Recursive case
        push {r1, lr}           @ save r1 and return address
        ldr r1, [r1, #NEXT]     @ set argument r1 = listptr->next for recursive call to insert 
        bl insert               @ insert(r, listptr->next, r3)
        mov r3, r1
        pop {r1, lr}            @ restore r1 and return address
        str r0, [r1, #NEXT]     @ listptr->next = r0 (from insert())
        mov r0, r1              @ r0 = arg r1
        mov r1, r3              @ r1 = r1 from insert()
        bx lr                   @ return r0, r1 from insert()

inbase: push {r4}
        push {r0, r1, lr}       @ save r0 and return address
        mov r0, r2              @ set argument r0 = the first "free" node in the heap for call to new
        bl new                  @ r0 = tmpptr, and r1 is now the new pointer to free
        mov r3, r0
        mov r4, r1
        pop {r0, r1, lr}        @ restore r0, r1, and return address
        str r0, [r3, #DATA]     @ tmpptr->data = N;
        str r1, [r3, #NEXT]     @ tmpptr->next = listptr
        mov r1, r4              @ r1 pointer to free
        pop {r4}
        mov r0, r3              @ return r0 from new
        bx lr                   @ return tmpptr

@ result behaves as described in the lab text
@ inputs:
@       r0: should contain a pointer to our linked list (listptr)
@       r1: should contain a pointer to the start of the result block
result:
    push {r0, r1, r2}
rwhile: ldr r2, [r0, #DATA]     @ r2 = node data
        str r2, [r1, #0]        @ store data in result block
        add r1, r1, #4          @ increment result block pointer
        ldr r0, [r0, #NEXT]     @ go to next node in the linked list
rwhilecond: cmp r0, r7
    bne rwhile  // while r0 != nil
    pop {r0, r1, r2}
    bx lr 

_start:
    push {r7, r8, r9, lr}       @ save return address to the stack
    mov r7, #NIL                @ global variable holding the NIL value
    
    ldr r0, =heap               @ move the address of heap into r1
    mov r1, #HEAPSIZE           @ initially pass NIL as the list pointer to insert
  	mov r2, #NODESIZE
    bl mknodes

    mov r1, r7                  @ initially pass NIL as the list pointer to insert()
	mov r2, r0                  @  and pointer to free (r0 from mknodes)
    ldr r3, =input              @ r3 = input base address, iterator curPtr
    ldr r9, =inp_end            @ r9 = input end base address, constant to check if we should break loop
    b forcond
for: 
    ldr r0, [r3, #0]            @ r0 = *curPtr, for [!!!]
    push {r3}
    bl insert                   @ insert(r0, r1, r2)
    pop {r3}
    mov r2, r1                  @ r2 = new pointer to free
    mov r1, r0                  @ r1 = new listptr
    add r3, r3, #4              @ r3 += 4
forcond: cmp r3, r9              
    bne for                     @ curPtr < inp_end
    

    @ Linked listptr still in r0
    ldr r1, =res
    bl result
	
    pop {r7, r8, r9, lr}
_end:
	b _end
	
.data
	@ Node constants
	.equ NEXT, 0
	.equ DATA, 4

	@ Constants
	.equ NODESIZE, 8
	.equ HEAPSIZE, 120 @ Can hold 15 nodes (NODESIZE * 15)
	.equ NIL, 0

    res: .space HEAPSIZE
	heap: .space HEAPSIZE
	input: .word 5, 8, 3, 6, 2, 9
	inp_end: