//===-- AchtBitInstrInfo.td - Target Description for AchtBit ---*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file describes the AchtBit instructions in TableGen format.
//
//===----------------------------------------------------------------------===//


//===----------------------------------------------------------------------===//
// AchtBit specific DAG Nodes.
//===----------------------------------------------------------------------===//

// Target-independent type requirements, but with target-specific formats.
def SDT_CallSeqStart : SDCallSeqStart<[SDTCisVT<0, i32>,
                                       SDTCisVT<1, i32>]>;
def SDT_CallSeqEnd   : SDCallSeqEnd<[SDTCisVT<0, i32>,
                                     SDTCisVT<1, i32>]>;

class AchtBitInst8<bits<8> opc, dag outs, dag ins, string opcodestr, string argstr,
               list<dag> pattern>
    : Instruction {
  field bits<8> Inst = opc;

  let Namespace = "AchtBit";

  dag OutOperandList = outs;
  dag InOperandList = ins;
  let AsmString = opcodestr # "\t" # argstr;
  let Pattern = pattern;
}

class AchtBitInst16<dag outs, dag ins, string opcodestr, string argstr,
               list<dag> pattern>
    : Instruction {
  field bits<16> Inst;

  let Namespace = "AchtBit";

  dag OutOperandList = outs;
  dag InOperandList = ins;
  let AsmString = opcodestr # "\t" # argstr;
  let Pattern = pattern;
}

class AchtBitInst24<dag outs, dag ins, string opcodestr, string argstr,
               list<dag> pattern>
    : Instruction {
  field bits<24> Inst;

  let Namespace = "AchtBit";

  dag OutOperandList = outs;
  dag InOperandList = ins;
  let AsmString = opcodestr # "\t" # argstr;
  let Pattern = pattern;
}


let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in {
def NOP : AchtBitInst8<0b00000000, (outs ), (ins ),
                  "nop", "", []>;
                  }