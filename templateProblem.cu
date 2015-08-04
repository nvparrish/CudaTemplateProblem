/*
 * templateProblem.cu
 *
 *  Created on: Jul 31, 2015
 *      Author: nvparrish
 */
#include "MyClass.h"
#include "kernel.cu.h"
#include <curand.h>
#include <curand_kernel.h>
#include <iostream>

int main(int argc, char* argv[]){
	int dataSize = 1024;

	// Create device values for the input and output values
	float* d_floatData;
	float* d_floatDataResult;
	cudaMalloc((void**)&d_floatData, sizeof(float) * dataSize );
	cudaMalloc((void**)&d_floatDataResult, sizeof(float) * dataSize );

	// Generate random values
	curandState *d_state;
	cudaMalloc((void**)&d_state, dataSize);
	init_rand<<<dataSize/256, 256>>>(d_state);
	make_rand<<<dataSize/256, 256>>>(d_state, d_floatData);

	// Instantiate the class
	MyClass powerClass(5);
	powerClass.calcPower<float>(d_floatData, dataSize, d_floatDataResult);

	// Copy the data back to take a look at it
	float* data;
	data = (float*)malloc(sizeof(float)*dataSize);
	cudaMemcpy(data, d_floatDataResult, sizeof(float)*dataSize, cudaMemcpyDeviceToHost);
	for(int ii = 0; ii < 128; ii++){
		for(int jj = 0; jj < 8; jj++){
			std::cout << data[ii<<3+jj] << " ";
		}
		std::cout << std::endl;
	}

	// Free all the memory allocated with cudaMalloc
	cudaFree(d_state);
	cudaFree(d_floatData);
	cudaFree(d_floatDataResult);
}



