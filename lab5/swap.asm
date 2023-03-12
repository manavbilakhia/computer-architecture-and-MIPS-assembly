#   swap.asm	Manav Bilakhia	     4 February 2023
#   Elementary program to add three numbers and store and print the sum.
#   Register use:
#      $t0: address of array
#      $t1: address of i
#      $t2: value of ar[i]
#      $t3: address of j
#      $t4: value of ar[j]

        .data                        # FYI: start of data section
ar:     .word 5, 17, -3, 22, 120, -1 # initialize array
i1:     .word 2                      # i = 2
i2:     .word 3                      # j = 3

        .text                        # FYI: start of code section
        .align 2                     # FYI: align to start code on a word boundary
        .globl main                  # FYI: make 'main' visible to the simulator
main:                                # main() {
        la $t0, ar                   #   a = &ar
        lw $t1, i1                   #   i = *i1
        sll $t1, $t1, 2              #   i = i * 4
        add $t1, $t1, $t0            #   i = i + a
        lw $t2, 0($t1)               #   ari = ar[i]
        lw $t3, i2                   #   j = *i2
        sll $t3, $t3, 2              #   j = j * 4
        add $t3, $t3, $t0            #   j = j + a
        lw $t4, 0($t3)               #   arj = ar[j]
        sw $t4, 0($t1)               #   ar[i] = arj
        sw $t2, 0($t3)               #   ar[j] = ari
        jr   $ra                     #   return control to the simulator
                                     # }