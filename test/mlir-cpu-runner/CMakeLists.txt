set(LLVM_OPTIONAL_SOURCES
  cblas.cpp
  cblas_interface.cpp
  )
#find_library(/home/li23/ruimlir/llvm-project/llvm/projects/mlir/test/mlir-cpu-runner/blisukr/foo.so foo)
#add_library(foo SHARED IMPORTED)

add_llvm_library(cblas SHARED cblas.cpp)
target_compile_definitions(cblas PRIVATE cblas_EXPORTS)
add_llvm_library(cblas_interface SHARED cblas_interface.cpp)
#set_property(TARGET foo PROPERTY IMPORTED_LOCATION "/home/li23/ruimlir/llvm-project/llvm/projects/mlir/test/mlir-cpu-runner/blisukr/libfoo.so")
target_link_libraries(cblas_interface PRIVATE cblas "/home/li23/ruimlir/llvm-project/llvm/projects/mlir/test/mlir-cpu-runner/blisukr/libfoo.so")




