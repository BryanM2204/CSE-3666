        .globl  main

        .text

main:	addi	a7, x0, 5	# syscall for taking in an integer as input
	ecall
	
	addi	s1, a0, 0	# s1 = input() which was stored in a0
	addi	t0, x0, 1	# t0 = 1 for comparison in loop
	addi	s2, x0, 0	# counter for number of times function runs
	
loop:	beq	s1, t0, exit	# if s1 is equal to 1, then exit the loop
	andi	t1, s1, 1	# checks to see if the final bit of s1 is a 1 where 1 means its odd and 0 means even
	beq 	t1, x0, even	# if it is a 0, go to even label
	
	addi	t2, s1, 0	# create a copy of s1
	slli	s1, s1, 1	# bit shift to the left by 1 in order to multiply by 2 - then add t2 
	add	s1, s1, t2	# s1 += t2 = 3n
	addi	s1, s1, 1	# add by 1 (3n + 1)
	
	addi	s2, s2, 1	# incrememnt counter by 1
	beq	x0, x0, loop	# return to beginning of loop
	
even:	srli	s1, s1, 1	# shift right by 1 bit = divides by 2 
	addi	s2, s2, 1	# incrememnt s2 counter by 1
	beq	x0, x0, loop	# return back to the loop

exit:	addi	a7, x0, 1	# syscall for printing an integer
	addi	a0, s2, 0	# store s2 into a0
	ecall
	
	addi	a7, x0, 10	# exit program with code 0 
	ecall
	