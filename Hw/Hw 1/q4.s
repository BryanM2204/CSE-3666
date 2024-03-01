       .globl  main

       .text
       
# a = s1, i = s2, r = s3
 
loop:	bge	s2, s1, exit	# if i >= a (s2 >= s1), exit loop
	andi	t0, s2, 0xA5	# perform and instruction with s2 (i) = store into t0
	beq	t0, x0, else	# if t0 is equal to 0, move to else label
	slli	t2, s2, 8	# bit shift to the left by 8, and store at t2
	xor	s3, s3, t2	# r ^= (i << 8)
		
	addi	s2, s2, 1	# increment s2 by 1 
	beq	x0, x0, loop	# return to beginning of loop
	
else:	srli 	t1, s2, 4	# shift bit to the right by 4
	add	s3, s3, t1 	# add t1 to s3 (s3 += t1)
	
	addi	s2, s2, 1	# increment s2 by 1
	beq 	x0, x0, loop	# return to beginning of loop

