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
#include <stdio.h>
#include "include/cblas.h"
#include "include/blisukr.h"
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

extern "C" void linalg_fill_viewf32_f32(ViewType<float, 0> *X, float f) {
  *(X->data + X->offset) = f;
}

extern "C" void linalg_fill_viewxf32_f32(ViewType<float, 1> *X, float f) {
  for (unsigned i = 0; i < X->sizes[0]; ++i)
    *(X->data + X->offset + i * X->strides[0]) = f;
}

extern "C" void linalg_dot_viewxf32_viewxf32_viewf32(ViewType<float, 1> *X,
                                                     ViewType<float, 1> *Y,
                                                     ViewType<float, 0> *Z) {
  assert(X->strides[0] == 1);
  assert(Y->strides[0] == 1);
  assert(X->sizes[0] == Y->sizes[0] && "Expected X and Y of same size");
  *(Z->data + Z->offset) +=
      cblas_sdot(X->sizes[0], X->data + X->offset, X->strides[0],
                 Y->data + Y->offset, Y->strides[0]);
}
extern "C" void linalg_matmul_viewxxf32_viewxxf32_viewxxf32(
    ViewType<float, 2> *A, ViewType<float, 2> *B, ViewType<float, 2> *C) {
    printf("Aoffset = %d\n", A->offset);
    printf("Boffset = %d\n", B->offset);
    printf("Coffset = %d\n", C->offset);

    printf("A strides0 = %d, strides1 = %d\n", A->strides[0], A->strides[1]);
    printf("B strides0 = %d, strides1 = %d\n", B->strides[0], B->strides[1]);
    printf("C strides0 = %d, strides1 = %d\n", C->strides[0], C->strides[1]);
    printf("A sizes0 = %d, sizes1 = %d\n", A->sizes[0], A->sizes[1]);
    printf("B sizes0 = %d, sizes1 = %d\n", B->sizes[0], B->sizes[1]);
    printf("C sizes0 = %d, sizes1 = %d\n", C->sizes[0], C->sizes[1]);
    assert(A->strides[1] == B->strides[1]);
    assert(A->sizes[0] == B->sizes[0] );
    blisukr(A->sizes[0], 1.0, 1.0, A->data + A->offset, B->data + A->offset, C->data + C->offset, C->strides[0], C->strides[1] );
    
}

// extern "C" void linalg_matmul_viewxxf32_viewxxf32_viewxxf32(
//     ViewType<float, 2> *A, ViewType<float, 2> *B, ViewType<float, 2> *C) {
//   assert(A->strides[1] == B->strides[1]);
//   assert(A->strides[1] == C->strides[1]);
//   assert(A->strides[1] == 1);
//   assert(A->sizes[0] >= A->strides[1]);
//   assert(B->sizes[0] >= B->strides[1]);
//   assert(C->sizes[0] >= C->strides[1]);
//   assert(C->sizes[0] == A->sizes[0]);
//   assert(C->sizes[1] == B->sizes[1]);
//   assert(A->sizes[1] == B->sizes[0]);
//   cblas_sgemm(CBLAS_ORDER::CblasRowMajor, CBLAS_TRANSPOSE::CblasNoTrans,
//               CBLAS_TRANSPOSE::CblasNoTrans, C->sizes[0], C->sizes[1],
//               A->sizes[1], 1.0f, A->data + A->offset, A->strides[0],
//               B->data + B->offset, B->strides[0], 1.0f, C->data + C->offset,
//               C->strides[0]);
// }
