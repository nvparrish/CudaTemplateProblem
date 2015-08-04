/*
 * MyClass.h
 *
 *  Created on: Jul 31, 2015
 *      Author: nvparrish
 */

#ifndef MYCLASS_H_
#define MYCLASS_H_

#include "kernel.cu.h"

template<typename T>
void gpuCalcPowerWrapper(int blockNum, int blockSize,
		T *d_data, int size, int power, T *d_out);

class MyClass {
private:
	int power;

public:
	MyClass(int power);

	template<typename T> void calcPower(T* d_data, int size, T* d_result);
};

template<typename T>
void MyClass::calcPower(T* d_data, int size, T* d_result){
	int blockNum = size/256 + (size%256 == 0? 0: 1);
	int blockSize = 256;

	gpuCalcPowerWrapper(blockNum, blockSize, d_data, size, power, d_result);
	return;
}

#endif /* MYCLASS_H_ */
