.data
	list1: .word 60, 45, 22, 80, 10
	size:   .word   5
	str: .asciiz "Array in MIPS\n"
.text

main:
	la $a0, str
	li $v0, 4 #print string
	syscall #WRITE CODE HERE
	la $t1, list1 #unsorted array

	lui $t2, 0x1001 #load list1
	lw $s1, size #n = 5
	move $s3, $s1 #n = 5
	li $t0, 0 #i=0
	li $s0, 0 #j=0
	add $t4, $0, $t2
	add $t5, $0, $t2
	subi $s1, $s1, 1
outer_loop:
	li $t1, 0 #j=0
	subi $s0, $s0, 1 #n = 5 - 1
	add $t3, $0, $t2

inner_loop:
	lw $s4, 0($t3) #a[j]
	addi $t3, $t3, 4
	lw $s5, 0($t3)#a[j+1]
	addi $s0, $s0, 1 #j++
	blt $s3, $s4, cond
swap:
	sw $s4, 0($t3)
	sw $s5, -4($t3)
	lw $s5, 0($t3)
cond:
	bne $s0, $s3, inner_loop #if j != n-1
addi $t0, $t0, 1 # i++
bne $t0, $s1, outer_loop
##print numbers
print_list:
            .data
space:    .asciiz "\n" #new-line between numbers
        .text
	li $s2, 0  #loop counter      
                 
printing_loop:
        beq $s2, $s3, exit   #check if all numbers in the array are printed   
        lw $a0, 0($t2) 
        li $v0, 1
        syscall 
        la $a0, space
        li $v0, 4
        syscall
        addi $s2, $s2, 1              
       	addi $t2, $t2, 4           
	j printing_loop 

exit:
	li $v0, 10
	syscall 
