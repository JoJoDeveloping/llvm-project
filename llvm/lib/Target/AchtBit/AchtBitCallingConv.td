//===-- AchtBitCallingConv.td - Calling Conventions for AchtBit ----*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
// This describes the calling conventions for AchtBit architecture.
// Normal functions use a special calling convention, solved in code.
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// AchtBit Return Value Calling Convention
//===----------------------------------------------------------------------===//

// Special return value calling convention for runtime functions.
def RetCC_AchtBit_BUILTIN : CallingConv<[
  CCIfType<[i8], CCAssignToReg<[RA, RB]>>,
  CCIfType<[i16], CCAssignToReg<[RAB, RCD]>>
]>;

//===----------------------------------------------------------------------===//
// AchtBit Argument Calling Conventions
//===----------------------------------------------------------------------===//

// The calling conventions are implemented in custom C++ code

// Calling convention for variadic functions.
def ArgCC_AchtBit_Vararg : CallingConv<[
  // i8 are always passed through the stack with a byte slot and byte alignment.
  CCIfType<[i8], CCAssignToStack<1, 1>>,
  // i16 are always passed through the stack with an alignment of 1.
  CCAssignToStack<2, 1>
]>;

//===----------------------------------------------------------------------===//
// Callee-saved register lists.
//===----------------------------------------------------------------------===//

def CSR_Normal : CalleeSavedRegs<(add)>; // nothing
def CSR_Interrupts : CalleeSavedRegs<(add RA, RB, RC, RD, Rpage, Rindex)>;
