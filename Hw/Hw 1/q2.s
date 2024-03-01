       .globl  main

       .text   
main:	lui	s2, 0x12345	# load upper 20 bits to s2
	addi	s2, s2, 0x678	# load the rest of 12 bits 
	
	add 	t0, x0, s2	# create a copy of s2 to t0
	
	addi 	t2, x0, 0	# counter -> i = 0
	addi	t3, x0, 4	# max -> t4 = 4

loop: 	beq	t2, t3, exit	# if the counter (i) is equal to t3 (4), then exit 
	addi	t4, x0, 0xFF	# assign to t4 binary sequence of all zeros except for the last 8 bits being 1's
	and 	t5, t0, t4	# use and to compare the last 8 bits of t0 - extract the last 8 bits of t0 and assign to t5
	
	slli	s4, s4, 8	# shift bit to left 8 bits to make space for new orientation
	add	s4, s4, t5	# add t5 to s4
	srli	t0, t0, 8	# shift bit right 8 bits to move the next 8 bits into place
	
	addi	t2, t2, 1	# increment t2 by 1	
	beq	x0, x0, loop	# go back to beginning of loop
	
exit: 	addi	a7, x0, 34	# syscall 34 to print hex
	addi	a0, s4, 0	# assign s4 to a0 as input
	ecall
	
	addi	a7, x0, 10	# exit
	ecall
	
	
	
	
	
	
	
	