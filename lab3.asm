#demo program to print largest of 2 numbers
.data
str1: .asciiz "\nEnter number A:\n"
str2: .asciiz "\nEnter number B:\n"
space: .asciiz " "
errorStr: .asciiz "\nError: number less than 0\n"
notPrime: .asciiz "\nNo prime numbers between A and B!\n"
.text
la $a0,str1
li $v0,4
syscall
#accept number 1
li $v0,5
syscall
move $s0,$v0 #save num 1 into register s0
blt $s0,$0,error
beq $s1, 1, printNotPrime #if 1 not prime
la $a0,str2
li $v0,4
syscall
#accept number 2
li $v0,5
syscall
move $s1,$v0 #save sum 2 into register s1
blt $s1,$0,error
beq, $s1, 1, printNotPrime #if 1 not prime
li $s2, 0 #total prime nums
li $s3, 2 #initial value

loopPrime:
beq $s0, $s3, printPrime
div $s0, $s3#divided A(n) by incrementing num
mfhi $s4 #move remainder to reg 10
beq $s4, $0, printNotPrime
addi $s3, $s3, 1
b loopPrime

error:
la $a0,errorStr
li $v0,4
syscall
li $v0, 5
b exit

printNotPrime:
beq $s0, $s1, testNoPrime #exit if $s0 = $s1 
addi $s0, $s0, 1 #num is not prime, add 1 to $s0
li $s3, 2
b loopPrime

testNoPrime: #print no prime numebrs if not prime numbers exist or exit
beq $s2, $0, noPrime
b exit

noPrime: #print no prime numbers exit then exit
la $a0,notPrime
li $v0,4
syscall
li $v0, 5
b exit

printPrime:
move $a0,$s0 #print prime number
li $v0,1
syscall
la $a0,space
li $v0,4
syscall
beq $s0, $s1, exit #exit if $s0 = $s1 
addi $s0, $s0, 1 #add 1 to $s0
addi $s2, $s2, 1 #add 1 to $2
li $s3, 2
b loopPrime

exit:
li $v0,10
syscall
