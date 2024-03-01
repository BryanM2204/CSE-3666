#       CSE 3666 Lab 1

        .globl  main

        .text
main:   

        # GCD examples:
        #     gcd(11, 121) = 11
        #     gcd(24, 60) = 12
        #     gcd(192, 270) = 6
        #     gcd(14, 97) = 1

        # read two positive integers from the console and 
        # save them in s1 and s2 

        # use system call 5 to read integers
        addi    a7, x0, 5
        ecall
        addi    s1, a0, 0       # a in s1

        addi    a7, x0, 5
        ecall
        addi    s2, a0, 0       # b in s2

        # TODO
        # Add you code here
        # compute GCD(a, b) and print it
        
loop:	beq    	s1, s2, exit	# if s1 and s2 are equal - exit
	blt  	s1, s2, else	# if a > b, then move to else
	sub 	s1, s1, s2	# b = b - a
	beq 	x0, x0, loop	# loop back to beginning of while loop
	
else:	sub 	s2, s2, s1	# a = a - b
	beq 	x0, x0, loop	# loop back to beginning of while loop


        # sys call to exit
exit:   addi 	a7, zero, 1	# sysetmcall of 1 to print an integer assigned to a7
	addi 	a0, s1, 0	# the input for syscall 1 is a0, thus use addi to assign s1 to a0
	ecall
	
	addi    a7, x0, 10      
        ecall
