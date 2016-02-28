#
#	Nelly Liu Peng
#	CS 264-02 Computer Organization and Assembly Programming
#	Lab2 
#	2/13/15
#

########################################################
##                      Data area                     ##
########################################################
.data

buffer:
	.space 150  			# 150 bytes allocated in memory
passBuffer:
	.space 11				# 11 bytes for secret user password

welcome:		
	.asciiz "This program performs the following 5 options:\n\n"
optionList:  	
	.asciiz "Option 1: Add two numbers.\nOption 2: Multiply four numbers.\nOption 3: Read a string. Compute frequency of characters. Print reversed string.\nOption 4: Print the Fibonacci sequence.\nOption 5: Exit.\n"
option1:    	 
	.asciiz "Option 1: Add two numbers. \n"
option2:		
	.asciiz "Option 2: Multiply four numbers. \n"
option3:			
	.asciiz "Option 3: Read and store a string. Compute frequency of characters. Print reversed string. \n"
option4:		
	.asciiz "Option 4: Print the Fibonacci sequence. \n"
option5:			
	.asciiz "Option 5: Exit."
optionSecret:
	.asciiz "\nInput 264? "
password:	
	.asciiz "Davarpanah"
	
select:			
	.asciiz "\n\nWhat do you want the program to do next? Please choose one from above: "
selection:			
	.asciiz "\nYou selected >>> "
invalid:		
	.asciiz "You selected an invalid option. Please choose (1,2,3,4,5) from above: "

prompt1.1:														# Option 1: Add two numbers.
	.asciiz "Enter first integer: "
prompt1.2:	
	.asciiz "Enter second integer: "
output1:			
	.asciiz "Sum = "
prompt2.1:														# Option 2: Multiply four numbers.
	.asciiz "Enter an integer: "
prompt2.2: 
	.asciiz "Enter last integer: "
output2:
	.asciiz "Product = "
prompt3:														# Option 3: Read and store a string. Compute frequency of chars. Print reversed string.
	.asciiz "Enter a string (up to 150 characters) to store in memory: "
output3.1:
	.asciiz "Frequencies of each character = \n"
output3.2:
	.asciiz ": "
output3.3:
	.asciiz "Reversed string = "
output3.4:
	.asciiz "\n"
prompt4:														# Option 4: Print the Fibonacci sequence.
	.asciiz "Enter an integer for its Fibonacci sequence: "
output4.1:
	.asciiz "Fibonacci Sequence = "
output4.2:
	.asciiz " Done!"
space:	
	.asciiz " "
output5:														# Option 5: Exit.
	.asciiz "\nThank you for using our services. Program terminated.\n"
prompt6:														# Option 264: Store identity in heap
	.asciiz "\nNumber of bytes to allocate? (Must be multiple of 4): "
output6.1:
	.asciiz "The memory was allocated at address(decimal base): "
output6.2:
	.asciiz "\nIdentity in HEAP\n"

	
########################################################
##                     Text area                      ##
########################################################
.text

main:	
# Display welcome message
	la		$a0, welcome
	li		$v0, 4
	syscall
# Display 5 options available 
	la		$a0, optionList
	li		$v0, 4
	syscall
# Display select message
selectAgain:
	la		$a0, select
	li		$v0, 4
	syscall
#----------------- Selection of option -----------------#
# Read integer input
validLoop:
	li      $v0, 5
	syscall
# Defining valid options 
	addi 	$s0, $0, 1				
	addi 	$s1, $0, 2
	addi 	$s2, $0, 3
	addi 	$s3, $0, 4
	addi 	$s4, $0, 5
	addi	$s5, $0, 264			# PART2: Secret option
# Check for valid input
	beq 	$v0, $s0, valid1
	beq 	$v0, $s1, valid2
	beq 	$v0, $s2, valid3
	beq 	$v0, $s3, valid4
	beq 	$v0, $s4, valid5
	beq		$v0, $s5, secret
	la		$a0, invalid			# "You selected an invalid option. Please choose (1,2,3,4,5) from above: "
	li		$v0, 4
	syscall
	j validLoop						# Repeat loop until input valid	
#------------------ Option 1 selected ------------------#
valid1:
# Display selection message
	la		$a0, selection			# "\nYou selected >>> "
	li		$v0, 4
	syscall
	la		$a0, option1			# "Option 1: Add two numbers. \n"
	li		$v0, 4	
	syscall
# Request first integer
	la		$a0, prompt1.1			# "Enter first integer: "
	li		$v0, 4
	syscall
	li      $v0, 5				  	# Read first integer input
	syscall
	add 	$t0, $0, $v0			# Store first integer into $t0
# Request second integer
	la		$a0, prompt1.2			# "Enter second integer: "
	li		$v0, 4
	syscall
	li      $v0, 5			  		# Read second integer input
	syscall
	add		$t0, $t0, $v0			# Add second integer to $t0
# Display sum
	la		$a0, output1
	li		$v0, 4
	syscall
	add		$a0, $0, $t0			# $a0 = sum of two integers
	li     	$v0, 1	
	syscall							# Display sum
	j selectAgain					# Ask user for next option
#------------------ Option 2 selected ------------------#
valid2:
# Display selection message			# "\nYou selected >>> "
	la		$a0, selection
	li		$v0, 4
	syscall
	la		$a0, option2			# "Option 2: Multiply four numbers. \n"
	li		$v0, 4
	syscall
# Request integers
	addi 	$t0, $0, 1				# $t0 = 1, initialization for multiplication purposes
	addi 	$t2, $0, 3              # $t2 = 3, ending factor for loop purposes
	addi 	$t3, $0, 0				# $t3 = counter, for loop purposes
integers:
	la		$a0, prompt2.1			# "Enter an integer: "
	li		$v0, 4
	syscall
	li      $v0, 5			  		# Read integer input
	syscall
	add 	$t1, $0, $v0			# Store integer into $t1
	mul 	$t0, $t0, $t1			# Multiply integers
	addi	$t3, $t3, 1				# Increase counter $t3 +1
	bne		$t3, $t2, integers		# Request last integer if 3 integers already requested
# Request last integer
	la		$a0, prompt2.2			# "Enter last integer: "
	li		$v0, 4
	syscall
	li   	$v0, 5			  		# Read last (fourth) integer input
	syscall
	mul		$t0, $t0, $v0			# Multiply last integer
# Display product
	la		$a0, output2
	li		$v0, 4
	syscall
	add		$a0, $0, $t0			# $a0 = product of four integers
	li      $v0, 1	
	syscall							# Display product
	j selectAgain					# Ask user for next option
#------------------ Option 3 selected ------------------#
valid3:
# Display selection message	
	la		$a0, selection			# "\nYou selected >>> "
	li		$v0, 4
	syscall
	la		$a0, option3			# "Option 3: Read and store a string. Compute frequency of characters. Print reversed string. \n"
	li		$v0, 4
	syscall	
# Request a string
	la		$a0, prompt3			# "Enter a string (up to 150 characters) to store in memory: "
	li		$v0, 4
	syscall	
# Store string input in memory	
	li		$v0, 8					# Read string
	la 		$a0, buffer 			# $a0 contains address where string is to be stored
    li 		$a1, 150     			# $a1 specifies number of chars to read
    syscall							# String stored in memory!
# Print message
	la		$a0, output3.1			# Print "Frequencies of each character = "
	li		$v0, 4	
	syscall							
# Calculate length of string in memory
	la		$a0, buffer
	jal 	strLength
	add		$t0, $0, $v0			# $t0 = String.length
	add		$t1, $0, $0				# $t1 = outer index       
	la 		$s0, buffer 			# $s0 contains address where string is stored
	sub		$sp, $sp, $t0			# Allocate enough space to put string in stack (for reversing string purposes)
	add		$t6, $0, $sp			# $t6 = address of stack being filled with chars
# Calculate frequency of each character
while:
	la 		$s1, buffer 			# $s1 contains address where string is stored		#####################################################
	bge		$t1, $t0, oWhile		# while ($t1 < string.length) do:					# 	<-- HIGH LEVEL CODE FOR COUNTING CHARS:			#
	add		$t2, $0, $0				# $t2 = inner index			 						#													#
	add		$t3, $0, $0				# $t3 = frequency									#	int i = 0;										#
while2:																					#	while (i < str.length) {						#
	bge		$t2, $t0, oWhile2		# while ($t2 < string.length) do:					#		int j = 0;									#
	lb		$t4, 0($s0)				# $t4 contains the char to be compared				#		int frequency = 0;							#
	lb		$t5, 0($s1)				# $t5 will hold subsequent chars					#		while (j < str.length) {					#
	bne		$t4, $t5, wSkip																#			if (str.charAt(i) == str.charAt(j))		#
	addi	$t3, $t3, 1				# $t3 frequency++ if chars $t4 and $t5 are equal	#				frequency++;						#
wSkip:																					#			j++;									#
	addi	$t2, $t2, 1				# Increment inner index								#		}											#
	addi	$s1, $s1, 1				# Increment address pointer $s1 grab next char		#		System.out.println("Frequency of " +		#
	j 		while2																		#							str.charAt(i) + ": " +	#
oWhile2:																				#							frequency);				#
# Printing the results																	#		i++;										#
	add		$a0, $0, $t4																#	}												#
	li		$v0, 11																		#####################################################
	syscall							# Print the char $t4 to be compared
	la		$a0, output3.2
	li		$v0, 4	
	syscall							# Print ": "
	add 	$a0, $0, $t3	
	li		$v0, 1
	syscall							# Print frequency of current char $t4
	la		$a0, output3.4
	li		$v0, 4	
	syscall							# Print "\n"	
# Save char in stack (for reversing the string purposes)	
	sb		$t4, 0($t6) 			# Store char in stack	
# Continue to the next char to be compared	
	addi	$t1, $t1, 1				# Increment outer index
	addi	$s0, $s0, 1				# Increment address pointer $s0; grab next char
	addi	$t6, $t6, 1				# Increment stack pointer $t6
	j 		while
oWhile:

# Print the reversed string
	la		$a0, output3.3
	li		$v0, 4
	syscall							# Print "Reversed string = "
	addi	$t6, $t6, -1			# Pop first element in stack: null char
	add		$t8, $sp, -1			# For comparison purposes
pop:
	beq		$t6, $t8, oPop			# Branch when all chars popped
	lb		$t7, 0($t6)				# $t7 = rightmost char of string				
	add		$a0, $0, $t7
	li		$v0, 11
	syscall							# Print $t7
	addi	$t6, $t6, -1			# Pop char from stack
	j		pop	
oPop:	
	add		$sp, $sp, $t0			# Deallocate stack
	j selectAgain					# Ask user for next option	
	
strLength:
	addi	$v0, $0, -1				# $v0 = counter for occurrences
strLoop:
	lb		$t1, 0($a0)				# $t1 contains a char from string
	beqz	$t1, strExit			# If end of string, exit loop
	addi	$v0, $v0, 1				# Increment counter
	addi	$a0, $a0, 1				# Search for next char
	j 		strLoop
strExit:
	jr		$ra						# $v0 will be returned with string size
#------------------ Option 4 selected ------------------#
valid4:
# Display selection message
	la		$a0, selection			# "\nYou selected >>> "
	li		$v0, 4
	syscall
	la		$a0, option4			# "Option 4: Print the Fibonacci sequence. \n"
	li		$v0, 4
	syscall	
# Request an integer
	la		$a0, prompt4			# "Enter an integer for its Fibonacci sequence: "
	li		$v0, 4
	syscall	
	li		$v0, 5					# Read integer
	syscall
	add 	$t7, $0, $v0			# Store user's input into $t7
	addi	$t8, $t7, 1				# $t8 = $t7 + 1, to allow enough loops to print correct series of numbers
# Print Fibonacci numbers up to user's input	
	la		$a0, output4.1 			# Print "Fibonacci Sequence = "
	li		$v0, 4
	syscall	
	add		$t0, $0, $0			
	add		$t0, $0, $t0			# $t0 = 0, for loop initialization purposes	
print:
	add		$a0, $0, $t0			# Copy counter to argument $a0
	bgt		$t0, $t8, stopPrint		# Exit for loop when $t0 > user's input +1 
	jal		Fibonacci
	add 	$t1, $0, $v0			# Store Fibonacci number into $t1
	bgt		$t1, $t7, stopPrint		# Stop printing, number reached	
	add 	$a0, $0, $t1			# Print each $t1 (Fibonacci number)
	li 		$v0, 1
	syscall  						# Print integer									#############################################
	la		$a0, space																#	<-- HIGH LEVEL CODE FOR FIBONACCI:		#
	li		$v0, 4																	#									  		#
	syscall							# Print space in between integers				#	public static void main(String[] a) {	#
	addi 	$t0, $t0, 1				# Increase loop counter 						#		for (int i=0; i<=INPUT+1; i++) {	#
	j		print																	#			int num = Fib(i);				#
stopPrint:																			#			if (num > INPUT)				#
	la		$a0, output4.2			# Sequence done!								#				break;						#
	li		$v0, 4																	#			System.out.print(num + " "); 	#
	syscall																			#		}									#
	j 		selectAgain				# Ask user for next option						#	}									 	#
																					#											#
# Recursive procedure for Fibonacci	sequence										#	public static int Fib(int n) {			#														
Fibonacci:																			#		if (n==0)							#
	addi	$sp, $sp, -12			# Allocate space in the stack					#			return 0;						#
	sw		$s0, 0($sp)				# Save $s0										#		else if (n==1)						#
	sw		$s1, 4($sp)				# Save $s1										#			return 1;						#
	sw		$ra, 8($sp)				# Save $ra										#		else								#
	add		$s0, $0, $a0			# $s0 = $a0										#			return (Fib(n-1) + Fib(n-2));	#
	bne 	$s0, $0, else			# if ($a0 == 0)									#	}										#
	add		$v0, $0, $0				# return $v0 = 0								#############################################
	j 		exit
else:	
	addi	$t2, $0, 1				# $t2 = 1, for comparison purposes
	bne		$s0, $t2, else2			# if ($a0 == 1)
	addi	$v0, $0, 1				# return $v0 = 1
	j		exit
else2:
	addi	$a0, $s0, -1			
	jal 	Fibonacci				# Call Fibonacci($a0 - 1)
	add		$s1, $0, $v0			# $s1 = Fibonacci($a0 - 1)
	addi	$a0, $s0, -2	
	jal 	Fibonacci				# Call Fibonacci($a0 - 2)
	add		$v0, $s1, $v0			# $v0 = Fibonacci($a0 - 1) + Fibonacci($a0 - 2)
exit:
	lw		$ra, 8($sp)				# Restore $ra	
	lw		$s1, 4($sp)				# Restore $s1
	lw		$s0, 0($sp)				# Restore $s0
	addi	$sp, $sp, 12			# Deallocate space in the stack
	jr		$ra
#------------------ Option 5 selected ------------------#
valid5:
# Display messages
	la		$a0, selection			# "\nYou selected >>> "
	li		$v0, 4
	syscall
	la		$a0, option5			# "Option 5: Exit."
	li		$v0, 4
	syscall			
	la		$a0, output5			# "\nThank you for using our services. Program terminated.\n"
	li		$v0, 4
	syscall
EXIT:
	li		$v0, 10					# Exit the program
	syscall							# Bye!
	
#------------------ Option 264 selected ------------------#
secret:
# Display input selected
	la		$a0, optionSecret		# "Input 264? "
	li		$v0, 4		
	syscall
# User should have input secret password by now 
	li		$v0, 8	
	la		$a0, passBuffer			# Store secret password	
	li 		$a1, 12					
	syscall							# $a0 = address of user's password		
	la		$a1, password			# $a1 = address of password "Davarpanah"
	jal 	comparePass
	beqz	$v0, secretPart3		# If correct password, go to secret part 3
	la		$a0, invalid			# If incorrect password, display invalid input						
	li		$v0, 4
	syscall
	j validLoop						# Repeat loop until input valid	
	
comparePass:
	add 	$t0, $0, $a0			# $t0 = user's pass address
	add 	$t1, $0, $a1			# $t1 = "Davarpanah" address
pLoop:
	lb		$t2, 0($t0)				# $t2 = a byte from user's password
	lb		$t3, 0($t1)				# $t3 = a byte from "Davarpanah"
	beqz	$t3, match
	beqz	$t2, mismatch
	seq		$t4, $t2, $t3			# $t4 = 1 if bytes match
	beqz	$t4, mismatch			# if $t4 = 0, mismatch passwords
	addi	$t0, $t0, 1				# Go to the next byte and compare
	addi	$t1, $t1, 1	
	j 		pLoop
mismatch:	
	addi 	$v0, $0, 1
	j 		pEnd
match:
	addi	$v0, $0, 0
pEnd:
	jr		$ra
#--------------------- Secret Part 3 ---------------------#	
secretPart3:
# Print request for bytes allocation message	
	la		$a0, prompt6		 	# "\nNumber of bytes to allocate? "
	li		$v0, 4
	syscall
	li		$v0, 5					# Read input
	syscall			
	add		$t0, $0, $v0			# $t0 = number of bytes to allocate
	add 	$a0, $0, $t0			
	li		$v0, 9
	syscall							# Storage allocated!
	add		$t1, $0, $v0			# $t1 = address where memory was allocated
	move	$t2, $t1				# Make a copy of $t1
# Print confirmation of allocation of memory
	la 		$a0, output6.1			# "The memory was allocated at address(decimal base): "
	li		$v0, 4
	syscall
	add		$a0, $0, $t1
	li		$v0, 1
	syscall							# Print address
# Dynamically store identity in heap

		#####										    	#####
		#												    	#
		#	Could not figure out how to complete this task :(	#
		#													    #
		#####										     	#####
	
# Print after identity stored in heap	
	la		$a0, output6.2		 	# "\nIdentity in HEAP\n"
	li		$v0, 4
	syscall
	j 		EXIT