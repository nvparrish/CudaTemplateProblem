/*
 * kernel.cu.h
 *
 *  Created on: Jul 31, 2015
 *      Author: nvparrish
 */

#ifndef KERNEL_CU_H_
#define KERNEL_CU_H_

#include "kernel.cu.h"
#include <curand.h>
#include <curand_kernel.h>

template<typename T>
__global__ void gpuCalcPower(T *d_data, int size, int power, T *d_out);

template<typename T>
void gpuCalcPowerWrapper(int blockNum, int blockSize,
		T *d_data, int size, int power, T *d_out);

__global__ void init_rand(curandState *state);
__global__ void make_rand(curandState *state, float *randArray);

#endif /* KERNEL_CU_H_ */
