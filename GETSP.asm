	.ORIG	x3000		; THis is the memory address that the program will start.			
	LEA 	R0,PROMPT	; Here I'm going to load my String prompt into R0 so I can display the prompt
	PUTS			; I'm using this special command to put the String prompt onto the console.
	LD	R1,STRING	; Here I am loading my String label or memory adress x3100 to R1. This is the starting address which will contain the first character input by the user.
LOOP1	GETC			; Now that I have loaded the character into R1 I want to read in that character.
	AND	R5,R0,0		; What I'm doing here is making R0 zero and storing that into R5. I need to have a clean register for the packed String.
	ADD	R5,R0,R5	; I'm now adding R0 which is zero to R5, essentially this is so that R5 contains the ascii value at memory address x3100 for example.	
	OUT			; I'm now physically outputing to the console the character entered by the user say "G" for example.	
	LD	R2,ENTER	; I need to use a different register for ENTER as I don't want that to be part of my String.
	NOT	R2,R2		; I essentially negate enter being loaded into R2 so ENTER won't effect the String.
	AND	R2,R0,R2	; Here I'm going to and out R0 with R2.
	BRZ	EXIT		; As long as the previous result is zero I'm going to loop through the following instructions till I hit my EXIT label.
	STR	R0,R1,#0	; I'm going to physically store what's in R1 into R0 which as of now is x3100 and through each pass of the loop the memory address will update because each memory address x3100,x3101 will contain a different character.
	GETC			; The following instructions are essentially for the second character for the packed string. I'm now reading in the second character in regards to the packed string.
	OUT			; I'm going to physically output to the console what's there.
	LD	R2,ENTER	; I need to do the same thing as I did earlier for the first character. The first character will take the first 8 bits and the second character takes the last 8 bits.
	NOT	R2,R2		; I'm delimiting ENTER	
	AND	R2,R0,R2	; I'm anding out R0 with R2 and putting that into R2 which contains ENTER delimited.
	BRZ	EXIT		; I'm going to loop through the following instructions as long as the previous result is zero untill I hit my EXIT lable.
	ADD	R0,R0,R0	; This line and the following seven I'm adding what's in R0 to itself 8 times. This will inherently shift the bits. 
	ADD	R0,R0,R0	
	ADD	R0,R0,R0
	ADD	R0,R0,R0
	ADD	R0,R0,R0
	ADD	R0,R0,R0
	ADD	R0,R0,R0
	ADD	R0,R0,R0
	ADD	R0,R0,R5		
	STR	R0,R1,#0	; I'm storing R1 into R0 the same way as for the first character because I need two characters for each memory address.			
	ADD	R1,R1,#1	; I'm going to add 1 to R1 and store this into R1. This will update the memory address in the next pass of the loop to the next memory address. If the first two characters are in x3100, for the next pass the next two characters will be in x3101.
	BR	LOOP1		; This tells me to go back to the start of the loop	
EXIT	STR	R2,R1,#0	; I'm storing R1 into R2 because I need a null for the end of the String. Lets say I'm at x3100 at this point. R1 is x3101 which contains null which is what I want, and I store that into R2 as it's a free register.	
	LD	R0,STRING	; I'm loading the memory address into R0 so In the next instruction I can put the packed String onto the console display.
	PUTSP				
	HALT			; HALT terminates the program.			
PROMPT	.STRINGZ	"Enter String to echo: "	; I made a variable named PROMPT. It's the same thing as a variable in Java or c++. This label or variable contains my String prompt.		
ENTER	.Fill		x000A				; This label contains the delimiter for ENTER or a line feed/new line.
STRING	.Fill		x3100				; The STRING label contains my starting memory address which will contain the characters entered by the user.
	.END						; PSEUDO instruction .END which is the end of the program