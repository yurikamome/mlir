compile blis ukr lib:
under mlir/test/mlir-cpu-runner/blisukr,
gcc --std=c99 -mavx2 -O3 -mfma  -ffp-contract=fast -shared -fpic -rdynamic -o libfoo.so blisukr.c

copy libfoo.so to $BUILD_DIR/lib



run mlir-tiled gemm example with blis ukr:

1. generate loop-ir
$INSTALL$/bin/mlir-opt -linalg-lower-to-loops -cse -canonicalize ./tryblisgemm.mlir  > temp.loops
2. delete generated loop-nest gemm implementation in temp.loops, add a general gemm call at the same place.  An example is shown in gemm_align.mlir.loops.
3. lower to llvm dialect and run
$INSTALL$/bin/mlir-opt  -linalg-lower-to-llvm-dialect ./temp.loops | ./bin/mlir-cpu-runner -e matmul -entry-point-result=f32  -shared-libs=/home/li23/latest_mlir/llvm-project/build/lib/libcblas_interface.so > dump.txt 
