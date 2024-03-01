#       CSE 3666 Lab 2

        .globl  main

        .text
main:   addi	s1, x0, 0	# initialize s1 to 0
	addi	t1, x0, 31	# tracks the bits to shift

loop:	srl  	t0, s0, t1 	# shift content of t0 t1 bits to right
	andi	t0, t0, 1 	# mask to isolate bit
	beq 	t0, x0, skip 	# if the bit is 0, do not increment s1
	addi 	s1, s1, 1 	# increment the counter

skip:	addi	t1, t1, -1 	# decrement by 1
	bge 	t1, x0, loop 	# if counter is greater than or equal to 0, then return to loop
	

        
        
        
