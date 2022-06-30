# LLVM

## Where is the backend?

llvm/lib/Target/AchtBit

## How to build

```
mkdir llvm # the folder that will contain everything
cd llvm
git clone git@gitlab.cs.uni-saarland.de:8bit-2022/llvm-project.git llvm-project
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
mkdir -p $SCRIPT_DIR/build
mkdir -p $SCRIPT_DIR/install
cd $SCRIPT_DIR/build
cmake -G Ninja \
       -DLLVM_ENABLE_PROJECTS=clang \
       -DLLVM_ENABLE_ASSERTIONS:BOOL=ON \
       -DLLVM_ENABLE_EH:BOOL=ON \
       -DLLVM_ENABLE_RTTI:BOOL=ON \
       -DLLVM_INCLUDE_TESTS:BOOL=OFF \
       -DLLVM_USE_SPLIT_DWARF=ON \
       -DLLVM_PARALLEL_LINK_JOBS=2 \
       -DCMAKE_INSTALL_PREFIX:PATH="$SCRIPT_DIR/install" \
       -DCMAKE_BUILD_TYPE:STRING=Release \
       -DLLVM_TARGETS_TO_BUILD=Sparc \
       -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD=AchtBit \
       $SCRIPT_DIR/llvm-project/llvm/
