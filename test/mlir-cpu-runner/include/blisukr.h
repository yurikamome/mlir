#ifndef MLIR_CPU_RUNNER_BLISUKR_H_
#define MLIR_CPU_RUNNER_BLISUKR_H_

extern "C" void blisukr(int k, float alpha, float beta,  float* A, float*B, float*C, int rs, int cs);
//extern "C"  void blisukr();

#endif
