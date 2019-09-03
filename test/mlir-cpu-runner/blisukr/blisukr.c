#include "tensor_kernels.h"
//#include "../include/blisukr.h"
#include <stdio.h>

void blisukr(int k, float alpha, float beta,  float* A, float*B, float*C, int rs, int cs){
    printf("blisukr\n");

    printf("A0= %f\n", A[0]);
    printf("B0= %f\n", B[0]);
    printf("C0= %f\n", C[0]);
    printf("alpha, beta = %f, %f\n", alpha, beta);
    printf("rs, cs = %d, %d\n", rs,cs);
//    bli_dgemm_haswell_asm_6x8(k, &alpha, A, B, &beta, C, rs, cs, NULL, NULL);
     bli_sgemm_haswell_asm_6x16(k, &alpha, A, B, &beta, C, rs, cs, NULL, NULL);
     printf("after ukr C0= %f\n", C[0]);
}

  /* void blisukr(){    printf("blisukr\n"); */
  /*   return;} */