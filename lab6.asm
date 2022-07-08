.data
str1: .asciiz "Enter number for n:\n"
str2: .asciiz "Enter number for r:\n"
str3: .asciiz "\nThe smallest number is:\n"
nless: .asciiz "\nn should not be less than r: re-enter the values.\n"
.text

main:
	la $a0,str1
	li $v0,4
	syscall
	#accept number 1
	li $v0,5
	syscall
	move $s0,$v0 #save n into register s0

	la $a0,str2
	li $v0,4
	syscall
	#accept number 2
	li $v0,5
	syscall
	move $s1,$v0 #save r into register s1
	blt $s0, $s1, nlessthanr #ask for user to re-input
	li $v0, 1 #set base of factorio to 1
	
	move $a0, $s0 #move n to $a0 
	li $a1, 1 #loop counter variable
	jal fact # call fact
	move $s3, $v0 #$s3 = n!
	
	li $v0, 1 #reset $v0
	move $a0, $s1 #move r to $a0
	li $a1, 1 #loop coutner variable
	jal fact
	move $s4, $v0 #r = $s4
	
	sub $s6, $s0, $s1 #s6 = n-r
	li $v0, 1 #reset $v0
	move $a0, $s6 #move n-r to $a0
	li $a1, 1 #reset loop counter
	jal fact
	move $s5, $v0 #s5 = (n-r)!

	b compute
fact:
	mul $v0, $v0, $a1 #fact = fact * i
	addi $a1, $a1, 1
	ble $a1, $a0, fact #while n <= i
	jr $ra #return to call

nlessthanr:
	la $a0, nless
	li $v0, 4
	syscall
	b main
	
compute: 
	mul $t0, $s5, $s4 # (n-r)! * r!
	div $t1, $s3, $t0 # n!/((n-r!)*r!)
	move $a0, $t1 #print number
	li $v0, 1
	syscall

exit:
li $v0,10
syscall