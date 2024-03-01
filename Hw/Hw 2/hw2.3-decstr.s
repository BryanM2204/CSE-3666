# Addition of decimal strings

# strings are stored in global data section 
        .data   
dst:    .space  128
str1:   .space  128
str2:   .space  128

# instructions are in text section
        .text
main: 
        # load adresses of strings into s1, s2, and s3
        # s3 is dst, where we store the result 

        lui     s3, 0x10010 
        addi    s1, s3, 128
        addi    s2, s1, 128

        # read the first number as a string
        addi    a0, s1, 0
        addi    a1, x0, 100
        addi    a7, x0, 8
        ecall

        # read the second number as a string
        addi    a0, s2, 0
        addi    a1, x0, 100
        addi    a7, x0, 8
        ecall

        # useful constants
        addi    a4, x0, '0'
        addi    a5, x0, 10

        #TODO
        # write a loop to find out the number of decimal digits in str1
        # the loop searches for the first character that is less than '0' 

        # Note that we assume str1, str2, and dst have the same number of 
        # decimal digits. 

        # We then write a loop to add str1 and str2, and save the result in 
        # dst. 
        # Remember that dst should have a terminating NULL.

        # find the length


        # end of the loop
        # print the result
        add	t1, s1, x0	# create a copy of s1
        add	t2, s2, x0	# create copy of s2
        
        addi	t0, x0, -1	# i
        addi	s4, x0, 0	# carry tracker
        
loop:	lb 	t3, 0(t1)	# loads values from str1 into t3
	blt	t3, a4, adding	# if the loaded value is less than the value of '0', leave loop
	addi	t1, t1, 1	# moves t1 by 1 to next value
	addi	t0, t0, 1	# adds one to counter of t0
	beq	x0, x0, loop	# loops to beginning

	
adding:	blt	t0, x0, print	# if t0 is equal to null, go to print
	
	add	t1, s1, t0	# memory address of s1 at s1 offset by t0
	add 	t3, s2, t0	# memory address of s2 at s2 offset by t0
	add	t6, s3, t0	# memoyr address of s3 at s3 offset by t0
	
	lb	t2, 0(t1)	# get ascii at that index
	lb	t4, 0(t3)	# get ascii at index
	
	sub	t2, t2, a4	# subtract the ascii value of t1 by the ascii of 0 to get the number
	sub	t4, t4, a4	# convert to decimal by subtracting ascii value of 0
	
	add	t5, t2, t4	# sum of the two digits
	add	t5, t5, s4	# add the remainder
	add	s4, x0, x0	# reset remainder
	
	bge	t5, a5, carry	# if the sum is greater than or equal to 10, deal with carry
	
	add	t5, t5, a4	# convert back to ascii
	
	sb	t5, 0(t6)	# stores byte back into t6
	
	addi	t0, t0, -1	# decrease counter by 1

	beq	x0, x0, adding	# loop back

carry:	sub	t5, t5, a5	# subtract 10 to get singular digit
	addi	s4, x0, 1	# add one to the remainder counter
	add	t5, t5, a4	# convert t5 back to ascii
	sb	t5, 0(t6)	# save the ascii character back to t6
	addi	t0, t0, -1	# decrease counter i by 1
	beq	x0, x0, adding	# go back to loop
        
        
print:
        addi    a0, s3, 0
        addi    a7, x0, 4
        ecall

        # exit
        addi    a7, x0, 10
        ecall
