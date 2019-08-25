.ORIG	x3000			; Program starts at this memory address.
	LEA 	R0,PROMPT	; I'm loading into R0 my String prompt "Enter a string to echo." Reason for this is so I can 
	PUTS			; Here I'm writing a string of characters to the screen that being the prompt.
	LD	R1,STRING	; I'm loading into R1 memory address x3100 as that's where the string the user will enter is suppose to start being stored at.
LOOP1	GETC	 		; This is the top of my loop, I'm going to read a character from the keyboard 
	OUT			; After the character has been read in such as G for "Go" I want to physically output that to the console screen.
	LD	R2,ENTER	; I need a new register to load ENTER into, as ENTER isn't suppose to be part of the String entered. I'll use R2.
	NOT	R2,R2		; I negate what ENTER is and store it into R2
	AND	R2,R0,R2	; if-else branch for R2. This is for the loop check BRZ which states loop through following instructions as long as previous instruction is 0.
	BRZ	EXIT		; I'm going to loop through the following code untill I hit "exit" taking me back to loop 1.
	STR	R0,R1,#0	; Here I'm storing the memory address of R1 into R0. R1+0 doesn't change R1 and I want the address of R1 which contains address x3100 stored into R0 so I can print out to the console the character there.
	ADD	R1,R1,#1	; I'm adding 1 to register 1 because I have to keep moving up by one through memory addresses for the String.x3100,x3101,x3102 ect...
	BR	LOOP1		; I'm branching to LOOP1 right after I finish with the next STR instruction. 
EXIT	STR	R2,R1,#0	; This is for storing the null terminator. At this point, R1 is the next address which contains null thus why I'm storing it into R2.
	LD	R0,STRING	; I then load The string address into the first register
	PUTS			; Here I'm going to write the whole String entered by the user after it has finished all the looping for every character.
		
	HALT			; Terminates the program.

PROMPT	.STRINGZ	"Enter String to echo: "	; the label PROMPT is like a variable in c++ or Java. I'm putting my String into the PROMPT label so I can load this into a Register.	
ENTER	.Fill		x000A	; This is for the enter delimiter, it isn't part of the string input by the user.
STRING	.Fill		x3100	; My Label at this address which starts my string of characters.
	.END			; Have to have this SUEDO code as it's where the program ends.