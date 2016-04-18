// Brad Marquez
// 4/2/16
// result.c

#include <stdio.h>
#include <stdlib.h>
int main() { 
	// Part One
	int oneI = 1; // Declares two integer variables
	int twoI = 2;
	float oneF = 1.0; // Declares two float variables
	float twoF = 2.0;
	char aC = 'a'; // Declares two character variables
	char bC = 'b';
	
	int* Iptr = &oneI; // Declares pointer to an integer variable
	float* Fptr = &oneF; // Declares pointer to a float variable
	char* Cptr = &aC; // Declares pointer to a character variable
	
	oneI = *Iptr; // Assigns address of one integer variable to the pointer
	printf("The value of the integer oneI is now &d.", oneI); // Prints out value of that integer
	twoI = *Iptr; // Repeated with the second integer
	printf("The value of the integer twoI is now &d.", twoI);
	
	oneF = *Fptr; // Repeated past steps with floats
	printf("The value of the float oneF is &f.", oneF);
	twoF = *Fptr;
	printf("The value of the float twoF is &f", twoF);
	
	aC = *Cptr; // Repeated past steps with characters
	printf("The value of the character aC is &c", aC);
	bC = *Cptr;
	printf("The value of the character aC is &c", bC);
	
	// Part Two
	int A = 22; // Initialized integer variables as indicated in spec
	int B = 17;	
	int C = 6;
	int D = 4;
	int E = 9;
	int result;
	
	int* APtr = &A; // pointers to integer variables
	int* BPtr = &B;
	int* CPtr = &C;
	int* DPtr = &D;
	int* EPtr = &E;
	
	// result = ((A - B)) * (C + D)) / E = 5.555
	result = ((*APtr - *BPtr) * (*CPtr + *DPtr)) / *EPtr; // results in 5, should we use float?
	
	printf("The result is equal to %d.", result);
	return 0;
}


 
   
