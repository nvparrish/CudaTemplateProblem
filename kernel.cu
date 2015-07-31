/*
 * kernel.cu
 *
 *  Created on: Jul 31, 2015
 *      Author: nvparrish
 */

#include "kernel.cu.h"

template<typename T>
__global__ void gpuCalcPower(T *d_data, int size, int power, T *d_out){
	int idx = blockIdx.x * blockDim.x + threadIdx.x;

	if(idx >= size) return;

	if(power < 1){
		d_out[idx] = -1;
		return;
	}

	T value = d_data[idx];
	T product = value;
	for(int ii = 1; ii < power; ii++){
		product *= value;
	}

	d_out[idx] = product;

	return;
}

template<typename T>
void gpuCalcPowerWrapper(int blockNum, int blockSize,
T *d_data, int size, int power, T* d_out){
	gpuCalcPower<<<blockNum, blockSize>>>(d_data, size, power, d_out);
	return;
}

__global__ void init_rand(curandState *state){
	int idx = blockIdx.x * blockDim.x + threadIdx.x;
	curand_init(1337, idx, 0, &state[idx]);
}

__global__ void make_rand(curandState *state, float *randArray){
	int idx = blockIdx.x * blockDim.x + threadIdx.x;
	randArray[idx] = curand_uniform(&state[idx]);
}
