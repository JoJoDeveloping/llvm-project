//===-- AchtBitTargetMachine.cpp - Define TargetMachine for AchtBit -----------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
//
//===----------------------------------------------------------------------===//

#include "AchtBitTargetMachine.h"
#include "llvm/CodeGen/Passes.h"
#include "llvm/CodeGen/TargetLoweringObjectFileImpl.h"
#include "llvm/CodeGen/TargetPassConfig.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/MC/TargetRegistry.h"
#include "llvm/Target/TargetMachine.h"
using namespace llvm;


Target &llvm::getTheAchtBitTarget() {
  static Target theAchtBitTarget;
  return theAchtBitTarget;
}

extern "C" LLVM_EXTERNAL_VISIBILITY void LLVMInitializeSparcTargetInfo() {
  RegisterTarget<> X(getTheAchtBitTarget(), "AchtBit", "AchtBit", "AchtBit");
}


extern "C" LLVM_EXTERNAL_VISIBILITY void LLVMInitializeAchtBitTarget() {
  // Register the target.
  RegisterTargetMachine<AchtBitTargetMachine> X(getTheAchtBitTarget());
}

static std::string computeDataLayout() {
  // AchtBit is typically big endian, but some are little.
  std::string Ret = "e";
  Ret += "-m:e";

  // 16 bit pointers
    Ret += "-p:16:16";
  return Ret;
}
static Reloc::Model getEffectiveRelocModel(Optional<Reloc::Model> RM) {
  return RM.getValueOr(Reloc::Static);
}

AchtBitTargetMachine::AchtBitTargetMachine(
    const Target &T, const Triple &TT, StringRef CPU, StringRef FS,
    const TargetOptions &Options, Optional<Reloc::Model> RM,
    Optional<CodeModel::Model> CM, CodeGenOpt::Level OL, bool isJIT)
    : LLVMTargetMachine(T, computeDataLayout(), TT, CPU, FS, Options,
                        getEffectiveRelocModel(RM),
                        getEffectiveCodeModel(CM, CodeModel::Small),
                        OL),
      TLOF(std::make_unique<TargetLoweringObjectFileELF>()) {
  assert(!isJIT);
  initAsmInfo();
}

AchtBitTargetMachine::~AchtBitTargetMachine() = default;

namespace {
/// AchtBit Code Generator Pass Configuration Options.
class AchtBitPassConfig : public TargetPassConfig {
public:
  AchtBitPassConfig(AchtBitTargetMachine &TM, PassManagerBase &PM)
    : TargetPassConfig(TM, PM) {}

  AchtBitTargetMachine &getAchtBitTargetMachine() const {
    return getTM<AchtBitTargetMachine>();
  }

  void addIRPasses() override;
  bool addInstSelector() override;
  void addPreEmitPass() override;
};
} // namespace

TargetPassConfig *AchtBitTargetMachine::createPassConfig(PassManagerBase &PM) {
  return new AchtBitPassConfig(*this, PM);
}

void AchtBitPassConfig::addIRPasses() {
  addPass(createAtomicExpandPass());

  TargetPassConfig::addIRPasses();
}

bool AchtBitPassConfig::addInstSelector() {
//  addPass(createAchtBitISelDag(getAchtBitTargetMachine()));
  return false;
}

void AchtBitPassConfig::addPreEmitPass(){

}
