        .text
        .globl  main
msort:	addi	sp, sp, -12	# allocate to stack
	sw	ra, 8(sp)	# save return address to stack
	sw	s2, 4(sp)	# save s2 to stack
	sw	s1, 0(sp)	# save s1 to stack 
	addi	sp, sp, -1028	# allocate 256 elements to stack
	sw	s0, 0(sp)	# save s0 to stack
	blt	x1, a1, skip	# if n > 1, continue rest of msort in skip
	lw	ra, 8(sp)	# load from stack to ra
	lw	s2, 4(sp)	# load from stack to s2
	lw	s1, 0(sp)	# load from stack to s1
	addi	sp, sp, 12	# recover all memory
	lw	s0, 0(sp)	# load from stack
	addi	sp, sp, 1028	# recover memory
	jalr	x0, ra, 0	# return
	
skip:	addi	s1, a1, 0	# saves n to s1
	addi	s2, a0, 0	# saves d[] to s2
	srli	s3, s1, 1	# saves n/2 to s3
	slli	s4, s3, 2	# word alignment of n/2
	
	add	a0, s2, x0	# set d[] to a0
	add	a1, s3, x0	# set n/2 to a1
	jal	ra, msort	# msort(d, n/2)
	
	add	a0, s2, s4	# get the memory address at d[n/2]
	sub	a1, s1, s3	# save n - n/2 to a1
	jal	ra, msort
	
	addi	a0, s0, 0	# save c to a0
	addi	a1, s2, 0	# save d to a1
	addi	a2, s3, 0	# save n/2 to a2
	add	a3, s2, s4	# save &d[n/2] to a3
	sub	a4, s1, s3	# save n - n/2 to a4
	jal	ra, merge	# merge(c, d, n1, &d[n1], n - n1)
	
	addi	a0, s2, 0	# save d[] to a0
	addi	a1, s0, 0	# save c[] to a1
	addi	a2, s1, 0	# save n to a2
	jal	ra, copy	# copy(d, c, n)
