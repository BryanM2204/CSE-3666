#       CSE 3666 Lab 2

        .globl  main

        .text
main:   
        # use system call 5 to read integer
        addi    a7, x0, 5
        ecall
        addi    s1, a0, 0       # copy to s1

        # TODO
        # Add you code here
        #   reverse bits in s1 and save the results in s2
        #   print s1 in binary, with a system call
        #   print newline
        #   print '=' if s1 is palindrome, otherwise print s2 in binary
        #   print newline
        addi 	t0, s1, 0	# t0 = s1
        addi  	s2, zero, 0	# s2 = 0
        addi 	s3, zero, 0	# s3 = 0
        addi	s4, zero, 32	# s4 = 32
        addi 	s5, zero, 0	# s5 = 0
        
for:	bge 	s3, s4, next	# if s3 and s4 are equal - go to next
	slli	s2, s2, 1	# bit shift left for 1
	andi  	s5, t0, 1	# compares binary digits of t0 and 1
	or 	s2, s2, s5	# then, it compares s2 and the previous line
	srli	t0, t0, 1	# shift t0 right by 1
	
	addi	s3, s3, 1	# increment variable i
	beq	x0, x0, for	# loop back to beginning
        
        
next:	addi 	a0, s1, 0	# prints out s1
	addi 	a7, zero, 35
	ecall
	addi 	a0, zero, 10	# prints out newline
	addi 	a7, zero, 11
	ecall
	
if:	bne	s1, s2, else	# if s1 and s2 are equal - print equal sign
	addi 	a0, zero, '='
	addi 	a7, zero, 11
	ecall
	beq 	x0, x0, exit
	
else:	addi 	a0, s2, 0	# else - prints out s2
	addi 	a7, zero, 35
	ecall
	
        # exit
exit:   addi 	a0, zero, 10	# prints out newline
	addi 	a7, zero, 11
	ecall

	addi    a7, x0, 10      
        ecall