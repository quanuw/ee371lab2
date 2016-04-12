// Brad Marquez
// 4/2/16
// result.c

#include <stdio.h>
#include <stdlib.h>
void convertBinary(int);
void convertHelp(int, int);
int main() { // results in 5, should we use float?
	int A = 22;
	int B = 17;	
	int C = 6;
	int D = 4;
	int E = 9;
	int result;
	
	int* APtr = &A;
	int* BPtr = &B;
	int* CPtr = &C;
	int* DPtr = &D;
	int* EPtr = &E;
	
	// result = ((A - B)) * (C + D)) / E
	result = ((*APtr - *BPtr) * (*CPtr + *DPtr)) / *EPtr;
	
	printf("The result is equal to %d.", result);
	return 0;
}


 
   
