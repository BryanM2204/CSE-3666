# CSE 3666
        
        .data                   #data segment
        .align 2

src:   .word   
  0,   1,   2,   3,   4,   5,   6,   7,   8,   9,
 10,  11,  12,  13,  14,  15,  16,  17,  18,  19,
 20,  21,  22,  23,  24,  25,  26,  27,  28,  29,
 30,  31,  32,  33,  34,  35,  36,  37,  38,  39,
 40,  41,  42,  43,  44,  45,  46,  47,  48,  49,
 50,  51,  52,  53,  54,  55,  56,  57,  58,  59,
 60,  61,  62,  63,  64,  65,  66,  67,  68,  69,
 70,  71,  72,  73,  74,  75,  76,  77,  78,  79,
 80,  81,  82,  83,  84,  85,  86,  87,  88,  89,
 90,  91,  92,  93,  94,  95,  96,  97,  98,  99,
100, 101, 102, 103, 104, 105, 106, 107, 108, 109,
110, 111, 112, 113, 114, 115, 116, 117, 118, 119,
120, 121, 122, 123, 124, 125, 126, 127

dst:    .space  1024

        .text
        .globl  main

main: 
        lui     s1, 0x10010     # hard-coded src address
        addi    s3, s1, 512     # s3 is the destination array

        # read n, the number of words to shuffle
        # n is even and 2 <= n <= 128
        addi    a7, x0, 5
        ecall

        # n is in a0

        # TODO:
        # write a loop to shuffle n words
        # the address of the source array src is in s1
        # the address of the destination array dst is in s3
        # register s2 will store the address of the second half of src
        # the folloiwng code can use any t and a registers 
        # sorc is s1 and dst is in s3
       	
       	addi	s4, x0, 0	# create i increment counter
       	
       	addi	s5, a0, 0	# load n from a0 to t2
       	slli	s6, s5, 2	# shift n to the left, multiplying by 4 in order to align with word size - save to s6
       	
       	srli	s5, s5, 1	# shift right by 1 - divide by 2
       	srli	s6, s6, 1	# shift it right by 1 - divides by 2 (n/2)
       	
       	add 	s2, s1, s6	# Load the address of the middle part of array to s2
       	
	addi	t5, s4, 0	# create temporary variable i for copy
	add	t1, s1, s6	# add n/2 in bytes to s1 in in order to obtain starting point of the right hand side and save to t1
	
	
copy:	beq	t5, s5, shuff	# if i is equal to n/2 (non byte) - move on to shuffle
	slli	t0, t5, 2	# t0 = i * 4
	
	add	t2, t1, t0	# incrememnt t1 (copy of s1 at middle) by t0, so as to move to each element in the array for each iteration
	lw	t3, 0(t2)	# load the element that is at the address t2 to t3
	add	t4, t0, s2	# increment s2 by t0 in order to move to the position that matches t1, save that address to t4
	sw	t3, 0(t4)	# save the card (t3) to t4 in s2
	
	addi	t5, t5, 1	# increment i by 1
	beq	zero, zero, copy	# loop back to beginning
	

shuff:  beq	s4, s5, exit	# if i >= n/2 - go to exit
	addi	t0, s4, 0	# save the counter to t0
	slli	t0, t0, 2	# shift i 2 bits to left - multiplies by 4 - represents word (i * size of word)
	
	add	t1, s1, t0	# Goes to location of left[i] and saves the address to t1
	lw	t2, 0(t1)	# loads the card that is at left[i] and saves the card at t2
	
	add	t3, t0, t0	# Double i
	add	t4, s3, t3	# go to destination array dst[i+i]
	sw	t2, 0(t4)	# save the loaded card to the address at dst[i+i]
	
	
	add 	t5, s2, t0	# Goes to location of right[i] and save address to t5
	lw	t2, 0(t5)	# loads the card that is at address t5 and save to t2
	
	addi	t3, t3, 4	# i + i + 1
	add	t4, s3, t3	# goes to destination array at dst[i+i+1] and save the address at this location to t4
	sw	t2, 0(t4)	# save the loaded card to the address at dst[i+i+1] (t4)
	
	addi	s4, s4, 1	# increment i by 1
	beq 	x0, x0, shuff	# goes to beginning of loop
	


exit:   addi    a7, x0, 10      # syscall to exit
        ecall   