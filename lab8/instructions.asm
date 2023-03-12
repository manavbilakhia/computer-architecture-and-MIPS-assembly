lw $a0, 0($sp)              
addiu $a1, $sp, 4   
addiu $a2, $a1, 4
sll $v0, $a0, 2
addu $a2, $a2, $v0
jal 0x400024
sll $0, $0, 0
li $v0, 10
syscall         
main: addi $sp, $sp, -4
sw $ra, 0($sp)
lui $at, 0x1001
ori $a0, $at, 4 
addi $v0, $0, 4
syscall
label4: jal label1
lui $at, 0x1001
ori $s1, $at, 96
lw $s1, 0($s1)
lui $at, 0x1001
ori $s3, $at, 144
lui $at, 0x1001
ori $a0, $at, 156
lw $s2, 12($a0)
addu $a0, $0, $s3
lui $a1, 0x1001
jal label2
beq $v0, $0, label3
lui $at, 0x1001
ori $a0, $at, 200
addi $v0, $0, 4
syscall
j label4
lui $at, 0x1001
label3: ori $a0, $at, 212
addi $v0, $0, 4
syscall
lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra
label1: addi $sp, $sp, -4
sw $a0, 0($sp)
lui $at, 0x1001 
ori $a0, $at, 52
addi $v0, $0, 4
syscall
lui $a0, 0x1001
addi $a1, $0, 12
addi $v0, $0, 8
syscall
lui $at, 0x1001
ori $a0, $at, 84
addi $v0, $0, 4
syscall
lui $a0, 0x1001
addi $v0, $0, 4
syscall
lw $a0, 0($sp)
addi $sp, $sp, 4
jr $ra
label2: addi $sp, $sp, -8
sw $a0, 0($sp)
sw $a1, 4($sp) 
li $t0, 0    
li $t1, 8
li $v0, 1
add $t3, $a1, $t1
label6:slt $at, $a1, $t3
beq $at, $0, label4
lb $t1, 0($a0) #password is here
lb $t2, 0($a1) #password is here
addi $t2, $t2, 1
bne $t1, $t2, label5
addi $a0, $a0, 1
addi $a1, $a1, 1
j label6
li $v0, 0
label5:lw $a0, 0($sp)
label4: lw $a1, 4($sp)
addi $sp, $sp, 8
jr $ra