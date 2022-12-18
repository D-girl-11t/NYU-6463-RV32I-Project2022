Group 4

Members: Andy Dung, Dhana Laxmi Sirigireddy 
////////////////////////////////////////////////////////////////////////////////////////////////

Test cases:

Load values into register:

0002f293	andi x0, x0, 0 # Clear register t0
00037313	andi x1, x1, 0 # Clear register t1
0003f393	andi x2, x2, 0 # Clear register t2
000e7e13	andi x3, x3, 0 # Clear register t3
0ff00293	addi x5 x0 255	(li x0, FF) # Load a 8-bit number to t0
00010337	lui x6 16	(li x1, FFFF) # Load a 16-bit number to t1
fff30313	addi x6 x6 -1	(li x1, FFFF) # Load a 16-bit number to t1
fff00393	addi x7 x0 -1	(li x2, FFFFFFFF) # Load a 32-bit number to t2
fff00e13	addi x28 x0 -1	(li x3, 7FFFFFFFFFFFFFFF) # Load a 64-bit number to t3

This will load values into x5, x6, x7, and x28.

////////////////////////////////////////////////////////////////////////////////////////////////

Data between registers:

0002f293	andi x5 x5 0	# Clear register t0
00037313	andi x6 x6 0	# Clear register t1
04a00293	addi x5 x0 146	# Load register t0 with a value
00028313	addi x6 x5 0

This will put 146 into x5 and put x5 which is 146 into x6.

////////////////////////////////////////////////////////////////////////////////////////////////

Store half-words, also get N number out to x7 and x8:

0002F293	andi x5 x5 0	# Clear register x5
00037313	andi x6 x6 0	# Clear register x6
40028293	addi x5, x5, 1024	# Load register x5 with address 0x800000000
01529293	slli x5, x5, 21	# Load register x5 with an address 0x80000004
00428293	addi x6, x6, 95	# Load register x6 with a half-word 8'b10010101
05f30313	sh x6 0(x5)	# Store the half-word value in x6 to DMEM(x5) = DMEM(0x80000004)
00629023
010E0E13	addi x28 x28 16
010E1E13	slli x28 x28 16 #to access N number
000E2383	lw x7 0(x28) 	#load first N number to x7
004E0E13	addi x28, x28, 4 #next N number address
000E2403	lw x8 0(x28)	#load second N number to x7

////////////////////////////////////////////////////////////////////////////////////////////////

Logical operations:
AND:

405282B3	sub x5, x5, x5 # Clear x5
40630333	sub x6, x6, x6 # Clear x6
7FF28293	addi x5, x5, 2047 # x5 = 11'b11111111111
55530313	addi x6, x6, 1365 #x6 = 11'b10101010101
0062F2B3	and x5, x5, x6 # Logical AND operation, x5 should be 11'b10101010101


XORI:

405282B3	sub x5 x5 x5	# Clear x5
40630333	sub x6 x6 x6	# Clear x6
7FF28293	addi x5 x5 2047	# x5 = 11'b11111111111
5552C293	xori x5 x5 1365	# Logical xori-Immediate operation, x5 should be 11'b01010101010

////////////////////////////////////////////////////////////////////////////////////////////////

Looping: file name is ledtest_imem

00128293	addi x5, x5, 1#set number #1
7D030313	addi x6, x6, 2000 #set number #2
064E8E93	addi x29, x29, 100 #set limit x29 to 100
01031313	slli x6, x6, 16 #make x6 very big

LOOP:
00628E63	beq x5, x6, END #if x5 = x6 end
00138393	addi x7, x7, 1 #else x7 increment by 1
01D38463	beq x7, x29, LOOP5 #if x7 is smaller than x29 = 100
FF5FF06F	jal x0, LOOP #loop again, until x7 is 100

LOOP5:
00128293	addi x5, x5, 1 #when x7 reaches 100, increment x5 by 1
407383B3	sub x7, x7, x7 #make x7 zero again
FE9FF06F	jal x0, LOOP #go back to x7 loop

END:

x6 is very large and x7 will only increment x5 every 100 counts, so x5 would take quite some time to reach x6, originally built to see if I can slowdown the output enought to see led change state.

////////////////////////////////////////////////////////////////////////////////////////////////

Complex functions
////////////////////////////////////////////////////////////////////////////////////////////////
Sum of odd number squared for numbers < N

odd_imem.mem:

00030313	addi x6, x6, 0 		#this could be omitted
000F0F13	addi x30, x30, 0 	#this could also be omitted
001E0E13	addi x28, x28, 1 	# set x28 to 1 so we can compare the least 						   		   significant bit with it
3E828293	addi x5, x5, 1000	#the number will represent the N we will use

LoopN: 					#loop to the number N
02530663	beq x6, x5, END 	#see if x6 is the same as N and thus end this 					  	 		 program
00130313	addi x6, x6, 1 		#increment x6 by 1
00137393	andi x7, x6, 1 		#and x6 with 1 to check if x6 is a odd number
01C38463	beq x7, x28, SQUARE 	#if x6 is an odd number go to SQUARE
FF1FF06F	jal x0, LoopN 		#if x6 is not an odd number go back to the start 							of the loop

SQUARE:
006E8EB3	add x29, x29, x6 	#add the number x6 to x29
001F0F13	addi x30, x30, 1 	#increment x30 by 1, x30 is used for tracking 						  			how many times we’ve added x6
006F0463	beq x30, x6, RESET 	#if x30 equals to x6 it means we squared x6 						    			and added it to x29
FF5FF06F	jal x0, SQUARE 		#go back to the start of the SQUARE loop

RESET:
41EF0F33	sub x30, x30, x30 	#reset x30 to 0 so the SQUARE loop could use it again
FD9FF06F	jal x0, LoopN 		#go to LoopN

END:
01D02023	sw x29 0(x0) 		#store x29 to DMEM(0)
fffffff3        halt

This program will add the square of odd numbers from 0 to 1000, and store it to x29, and at last it will store x29 into the first memory address.

////////////////////////////////////////////////////////////////////////////////////////////////

Euclidean_imem.mem:
0fc28293	addi x5, x5, 252#set number #1
06930313	addi x6, x6, 105 #set number #2
00429293	slli x5, x5, 4
00631313	slli x6, x6, 6
EUCLIDEAN:

02628263	beq x5, x6, STORE #see if x7 is the 0 thus ending this program
00534463	blt x6, x5, FIVEG
0062c863	blt x5, x6, SIXG
FIVEG:
406282b3	sub x5, x5, x6 #x5 = x5 - x6
fe534ee3	blt x6, x5, FIVEG #start again if x5 is still larger than x6
fedff06f	jal x0, EUCLIDEAN #go back to the start of the EUCLIDEAN if x6 is larger than x5

SIXG:
40530333	sub x6, x6, x5 #x6 = x6 - x5
fe62cee3	blt x5, x6, SIXG #start again if x6 is still larger than x6
fe1ff06f	jal x0, EUCLIDEAN #go back to the start of the EUCLIDEAN if x5 is larger than x6
STORE:
010e0e13	addi x28 x28 16	
010e1e13	slli x28 x28 16	
010e0e13	addi x28 x28 16 #to create the address 00100010 for switch
004e0e13	addi x28 x28 4 #create the address 00100014 for LED
005e2023	sw x5 0(x28) #take the value calculated and store in x5 and put it in DMEM(x28)
000e2e83	lw x29 0(x28)
fffffff3	halt

This program will calculate the greatest common denominator between 2 numbers, my program uses the values on wikipedia as base which is 252 and 105, and I times them by 16 and 64 to become 4032 and 6720, and their GCD is 1344, which this program will correctly calculate and store to x5 and also DMEM(LED).

////////////////////////////////////////////////////////////////////////////////////////////////




