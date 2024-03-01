        .text
        .globl  main
        
foo:	addi	sp, sp, -20	# allocate memory to stack
	sw	ra, 16(sp)	# save return address to stack
	sw	a1, 12(sp)	# save a1 to stack
	sw	a0, 8(sp)	# save a0 to stack
	sw	s3, 4(sp)	# save memory address of d[i] to stack
	sw	s2, 0(sp)	# save s2 to stack

	
	addi	s1, x0, 0	# s1 = count
	addi	s2, x0, 0	# s2 = i counter
	
			
for:	beq	s2, a1, f_exit	# if n==i, then go to exit

	slli	t0, s2, 2	# word alignment of i
	add	s3, a0, t0	# go to memory address at d[i]
	add	a0, s3, x0	# save s3 to a0 
	sub	a1, a1, s2	# assign n - i to a1
	
	jal	ra, bar		# go to bar
	bge 	x0, a0, skip	# if t <= 0, then go to exit
	
	addi	s1, s1, 1 	# incrememnt counter by 1
	
	
skip: 	addi	s2, s2, 1	# i += 1
	beq	x0, x0, for	# go back to beginning of for loop
	
	
f_exit:	lw	ra, 16(sp)	# load return address from stack
	lw	a1, 12(sp)	# load a1 from stack
	lw	a0, 8(sp)	# load a0 from stack
	lw	s3, 4(sp)	# load s3 from stack
	lw	s2, 0(sp)	# load s2 from stack

	addi	sp, sp, 20	# recover memory
	jalr	x0, ra, 0	# return
