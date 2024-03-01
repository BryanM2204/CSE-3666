
	.data
	.align	2	
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
	
	.globl  main

        .text
        
main:	

	addi	s0, x0, 0	# i counter set to 0
	addi	s1, x0, 0	# j counter set to 0 
	
	addi	s2, x0, 16	# set max that i can be
	addi	s3, x0, 8	# set max that j can be
	
for:	bge	s0, s2, exit	# if i >= 16, exit
	blt	s1, s3, nested	# if j < 8, go to nested label
	
	addi	s1, x0, 0	# reset j
	
	addi	s0, s0, 1	# increment i by 1
	beq	x0, x0, for	# move back to beginning of for loop
	
nested: 
	slli	t0, s0, 8	# multiply i by 256
	add	t0, t0, s1	# add by j and save to t0
	
	slli	t1, s0, 5	# multiply i by 32 - the first index represents i * 32
	slli	t2, s1, 2	# second index of array represents j * 4
	
	add	t3, t1, t2	# add t1 and t2 to get the address of the nested array
	add	s9, s9, t3	# move s9 to specific address of T[i][j]
	
	sw	t0, 0(s9)	# saved calculated answer from t0 to the memory address at s9

	addi	s1, s1, 1	# incrememnt j by 1
	beq	x0, x0, for	# return back to beginning of for loop
	
	
exit:	addi	a7, x0, 10	# exit 
	ecall