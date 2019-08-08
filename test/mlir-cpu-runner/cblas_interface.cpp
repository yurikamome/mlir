//===- cblas_interface.cpp - Simple Blas subset interface -----------------===//
//
// Copyright 2019 The MLIR Authors.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// =============================================================================
//
// Simple Blas subset interface implementation.
//
//===----------------------------------------------------------------------===//
#include "tensor_kernels.h"
#include "include/cblas.h"
#include <assert.h>

template <typename T, int N> struct ViewType {
  T *data;
  unsigned long offset;
  unsigned long sizes[N];
  unsigned long strides[N];
};

// This is separated out to avoid `unsigned long sizes[0]` which triggers:
//   warning: ISO C++ forbids zero-size array [-Wpedantic]
template <typename T> struct ViewType<T, 0> {
  T *data;
  unsigned long offset;
};

extern "C" void linalg_dot_impl(ViewType<float, 1> *X, ViewType<float, 1> *Y,
                                ViewType<float, 0> *Z) {
  assert(X->sizes[0] == Y->sizes[0] && "Expected X and Y of same size");
  *(Z->data + Z->offset) +=
      cblas_sdot(X->sizes[0], X->data + X->offset, X->strides[0],
                 Y->data + Y->offset, Y->strides[0]);
}

extern "C" void linalg_matmul_impl(ViewType<float, 2> *A, ViewType<float, 2> *B,
                                   ViewType<float, 2> *C) {
  assert(A->strides[1] == B->strides[1]);
  assert(A->strides[1] == C->strides[1]);
  assert(A->strides[1] == 1);
  assert(A->sizes[0] >= A->strides[1]);
  assert(B->sizes[0] >= B->strides[1]);
  assert(C->sizes[0] >= C->strides[1]);
  assert(C->sizes[0] == A->sizes[0]);
  assert(C->sizes[1] == B->sizes[1]);
  assert(A->sizes[1] == B->sizes[0]);
  cblas_sgemm(CBLAS_ORDER::CblasRowMajor, CBLAS_TRANSPOSE::CblasNoTrans,
              CBLAS_TRANSPOSE::CblasNoTrans, C->sizes[0], C->sizes[1],
              A->sizes[1], 1.0f, A->data + A->offset, A->strides[0],
              B->data + B->offset, B->strides[0], 1.0f, C->data + C->offset,
              C->strides[0]);
}

extern "C" void linalg_blisukr_impl(ViewType<double, 2> * A, ViewType<double, 2> *B,
                                     ViewType<double, 2> *C) {
    //bli_dgemm_haswell_asm_6x8(use_k,  &alpha, Abuf+ A_pack_offset, Bbuf+B_pack_offset, &beta, C+ Ascatter[Im] + Bscatter[In], 1*C_range_c*C_range_d, 1, NULL, NULL);
    //  need:  A , B, C, alpha = 1.0, beta = 1.0, row_stride_c, col_stride_c, use_k
    printf("call linalg blisukr_impl\n");
    int row_stride_c = C->sizes[0];
    int col_stride_c = 1;
    int A_offset = 0;
    int B_offset = 0;
    int C_offset = 0;
    int use_k = 256;
    double alpha = 1.0;
    double beta = 1.0;
    bli_dgemm_haswell_asm_6x8(use_k, &alpha, A + A_offset, B+B_offset, &beta, C+C_offset, row_stride_c, 1, NULL, NULL);

    
    
}
