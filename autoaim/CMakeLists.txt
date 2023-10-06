cmake_minimum_required(VERSION 3.15)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++20")
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}")
find_package(TensorRT REQUIRED)
message(STATUS "Found TensorRT version ${TensorRT_VERSION}")
message(STATUS "TensorRT libraries: ${TensorRT_LIBRARIES}")
message(STATUS "TensorRT include directories: ${TensorRT_INCLUDE_DIRS}")

find_package(OpenCV 4 REQUIRED)
find_package(Eigen3 REQUIRED)
find_package(Ceres 2 REQUIRED)
find_package(fmt REQUIRED)

include_directories(${OpenCV_INCLUDE_DIRS})
include_directories(${EIGEN3_INCLUDE_DIR})
include_directories(${TensorRT_INCLUDE_DIRS})
include_directories(${CERES_INCLUDE_DIRS})

find_package(yaml-cpp REQUIRED)
add_definitions(-DYAMLCPP_USE_DEPRECATED)

aux_source_directory(predictor predictor_src)
aux_source_directory(TRT_detector antitop_src)
find_path(CUDA_INCLUDE_DIRS cuda.h HINTS "${CUDA_TOOLKIT_ROOT_DIR}/include")
include_directories(${CUDA_INCLUDE_DIRS})
include_directories(/usr/src/tensorrt/samples/common)
add_library(logger /usr/src/tensorrt/samples/common/logger.cpp)

add_library(autoaim STATIC autoaim.cpp armor_tracker.cpp ${predictor_src} ${antitop_src})
target_link_libraries(autoaim PRIVATE logger ${OpenCV_LIBS} ${TensorRT_LIBARIES} ${CERES_LIBRARIES} fmt::fmt nvonnxparser cuda)
