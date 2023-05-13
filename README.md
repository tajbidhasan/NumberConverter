# NumberConverter
Here's a breakdown of the main components of my code:
1.	Data Section:
•	Various strings are defined using the .asciiz directive. These strings include prompts, error messages, and labels for different number systems.
•	The userInput is a 32-byte space reserved to store user input.
2.	Text Section (Main):
•	The program starts at the main label, which first calls the Menu subroutine and then exits the program using the li $v0, 10 syscall (system call) to terminate the program.
3.	Menu Subroutine:
•	The Menu subroutine displays a menu of options and prompts the user to enter a choice.
•	The user's choice is read and validated.
•	Depending on the choice, the program jumps to one of the subroutines (bhd, hbd, dbh) or exits the program.
•	If an invalid choice is entered, an error message is displayed, and the menu is shown again.
4.	Subroutines:
•	bhd: Binary to Hexadecimal and Decimal conversion.
•	hbd: Hexadecimal to Binary and Decimal conversion.
•	dbh: Decimal to Binary and Hexadecimal conversion.
Each subroutine follows a similar structure:
•	Display a specific prompt.
•	Read user input.
•	Call the appropriate conversion subroutine (BtoD, HtoD, StoD) to convert the input to decimal form.
•	If the input is invalid, display an error message.
•	Display the converted decimal number.
•	Perform additional conversions and display the results.
•	Return to the Menu subroutine.
5.	Conversion Subroutines:
•	StoD: String to Decimal conversion.
•	HtoD: Hexadecimal to Decimal conversion.
•	BtoD: Binary to Decimal conversion.
Each subroutine converts a number in a specific format to its decimal representation. These subroutines use various arithmetic operations and ASCII manipulation to extract digits and calculate the decimal value.
6.	Error Handling:
•	If the user input is invalid (contains characters outside the acceptable range), appropriate error messages are displayed.
The code is written in MIPS assembly language, a low-level programming language commonly used for MIPS processors. It interacts with the user through the console using syscalls for input/output operations. The program provides a basic framework for number conversion, allowing users to convert between different number systems.


