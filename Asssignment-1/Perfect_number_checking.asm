#Assignment 1
#Sayan Mukhopadhyay(13CS30028)
#Ravi Bansal(13CS30026)
#Group No-56
.data 
input: .asciiz "Enter a positive integer\n"
output: .asciiz "The number "
output1: .asciiz " is a perfect number\n"
negoutput: .asciiz " is not a perfect numnber\n"

.text
main:
	la $a0,input #print a string to take input
	li $v0,4
	syscall      
	li $v0,5
	syscall		#taking an integer as input in $v0
	move $t0,$v0 #storing input integer in $t0
	li $t1,2	#initializing counter of loop from 2 as 1 is always a factor
	li $t2,1    #initializing sum as 1 as 1 is always a factor
	#checking if input is 1
	beq $t0,1,input1
	b loop       #if input is not 1 then continue to the loop part
	input1:      #if input is 1 then print not a perfect number and exit the program
		la $a0,output  
		li $v0,4
		syscall
		li $v0,1
		move $a0,$t0	#printing the number 1
		syscall
		la $a0,negoutput	#printing that 1 is not a perfect number
		li $v0,4
		syscall
		li $v0,10
		syscall     #exit the program

	loop:
		bge $t1,$t0,endloop #check if counter<n or not
		rem $t3,$t0,$t1     #if yes then calculate remainder of n and counter and store in t3
		beqz $t3,addvalue   #check remainder of n/counter is 0 or not
		b endif            #if no then exit if
		addvalue:
			add $t2,$t2,$t1	#add counter to sum if remainder is 0
			
		endif:
		add $t1,$t1,1       #increment counter by 1
		b loop				#continue looping
	endloop:
		beq $t2,$t0,print   #check if sum is equal to or not
		la $a0,output
		li $v0,4
		syscall				#not a perfect number if not equal
		li $v0,1
		move $a0,$t0		#printing the input number
		syscall
		la $a0,negoutput	# printing that it is not a perfect number
		li $v0,4
		syscall
		b end2if
		print:
			la $a0,output
			li $v0,4
			syscall         #perfect number if sum and n are equal
			li $v0,1
			move $a0,$t0	#printing the input number
			syscall
			la $a0,output1	#printinh that it is a perfect number
			li $v0,4
			syscall
		end2if:
			li $v0,10
			syscall             #exit sytem call
