//===-- AchtBit.td - Describe the AchtBit Target Machine -------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

include "llvm/Target/Target.td"

//===----------------------------------------------------------------------===//
// Registers, calling conventions, instruction descriptions.
//===----------------------------------------------------------------------===//

include "AchtBitRegisterInfo.td"
include "AchtBitCallingConv.td"
include "AchtBitInstrInfo.td"

//===----------------------------------------------------------------------===//
// RISC-V processors supported.
//===----------------------------------------------------------------------===//

def : ProcessorModel<"generic-rv32", NoSchedModel, []>;
//===----------------------------------------------------------------------===//
// Define the RISC-V target.
//===----------------------------------------------------------------------===//

def AchtBitInstrInfo : InstrInfo {
  let guessInstructionProperties = 0;
}

def AchtBitAsmParser : AsmParser {
  let ShouldEmitMatchRegisterAltName = 1;
  let AllowDuplicateRegisterNames = 1;
}

def AchtBitAsmWriter : AsmWriter {
  int PassSubtarget = 1;
}

def AchtBit : Target {
  let InstructionSet = AchtBitInstrInfo;
  let AssemblyParsers = [AchtBitAsmParser];
  let AssemblyWriters = [AchtBitAsmWriter];
  let AllowRegisterRenaming = 1;
}
