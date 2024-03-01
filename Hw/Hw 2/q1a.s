	.globl  main

        .text
        
main:   addi	s4, x0, 100
	addi 	s1, x0, 0

loop:	slli	t0, s1, 2	# t0 = i * 4 - convert to word size
	add	t2, t0, s2	# compute address of A[i]
	lw	t1, 0(t2)	# loads the cotents at A[i] to t1
	addi	t1, t1, 4	# increments the contents at A[i] by 4
	add	t3, t0, s3	# Comptues address of B[i]
	sw	t1, 0(t3)	# saves the contents of A[i] to B[i]
	
	lw	t1, 4(t2)	# A[i] already saved to t2, so A[i+1] is offset of 4
	addi	t1, t1, 4	# add 4 to contents
	sw	t1, 4(t3)	# repeat same procedure with B[i+1]
		
	lw	t1, 8(t2)	# repeat the pattern
	addi	t1, t1, 4
	sw	t1, 8(t3)
	
	lw	t1, 12(t2)	# repeat the pattern
	addi	t1, t1, 4
	sw	t1, 8(t3)
	
	addi	s1, s1, 4	# incrememnt i counter
	
test:	bne	s1, s4, loop