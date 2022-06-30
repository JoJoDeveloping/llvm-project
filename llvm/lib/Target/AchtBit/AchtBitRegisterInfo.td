//===-- AchtBitRegisterInfo.td - AchtBit Register defs -------------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
//  Declarations that describe the AchtBit register file
//===----------------------------------------------------------------------===//

// 8-bit General purpose register definition.
class AchtBitReg<bits<16> num, string name, list<Register> subregs = [],
             list<string> altNames = []> : RegisterWithSubRegs<name, subregs> {
  field bits<16> Num = num;

  let HWEncoding = num;
  let Namespace = "AchtBit";
  let SubRegs = subregs;
  let AltNames = altNames;
}

// Subregister indices.
let Namespace = "AchtBit" in {
  def sub_lo : SubRegIndex<8>;
  def sub_hi : SubRegIndex<8, 8>;
}

let Namespace = "AchtBit" in { def ptr : RegAltNameIndex; }


//===----------------------------------------------------------------------===//
//  8-bit general purpose registers
//===----------------------------------------------------------------------===//

def RA     : AchtBitReg<0, "a">,     DwarfRegNum<[0]>;
def RB     : AchtBitReg<1, "b">,     DwarfRegNum<[1]>;
def RC     : AchtBitReg<2, "c">,     DwarfRegNum<[2]>;
def RD     : AchtBitReg<3, "d">,     DwarfRegNum<[3]>;
def Rpage  : AchtBitReg<4, "page">,  DwarfRegNum<[4]>;
def Rindex : AchtBitReg<5, "index">, DwarfRegNum<[5]>;
def Rspl   : AchtBitReg<6, "spl">,   DwarfRegNum<[6]>;
def Rsph   : AchtBitReg<7, "sph">,   DwarfRegNum<[7]>;
def Raccu     : AchtBitReg<32, "accu">,     DwarfRegNum<[32]>;


let SubRegIndices = [sub_lo, sub_hi], CoveredBySubRegs = 1 in {
  let RegAltNameIndices = [ptr] in {
    def RAB : AchtBitReg<8, "AB", [RA, RB], ["AB"]>, DwarfRegNum<[8]>;
    def RCD : AchtBitReg<9, "CD", [RC, RD], ["CD"]>, DwarfRegNum<[9]>;
    def RPI : AchtBitReg<10, "PI", [Rpage, Rindex], ["PI"]>, DwarfRegNum<[10]>;
  }
  def RSP : AchtBitReg<11, "SP", [Rspl, Rsph], ["SP"]>, DwarfRegNum<[11]>;
}


//===----------------------------------------------------------------------===//
// Register Classes
//===----------------------------------------------------------------------===//

// Main 8-bit register class.
def GPR8 : RegisterClass<"AchtBit", [i8], 8,
                         (
                             add RA, RB, RC, RD, Rpage, Rindex, Rspl, Rsph)>;
                             
// 8-bit registers usable in rrr insns
def RRR8 : RegisterClass<"AchtBit", [i8], 8,
                         (
                             add RA, RB, RC, RD, Rpage, Rindex)>;

// 8-bit registers that are the accu
def ACCU8 : RegisterClass<"AchtBit", [i8], 8,
                         (
                             add Raccu)>;
                             
                             
// 16-bit pair register class for 16 bit magic
def GPR16 : RegisterClass<"AchtBit", [i16], 8,
                              (
                                  add RAB, RCD, RPI, RSP)>;

// Register class used for the stack read pseudo instruction.
def SPClass : RegisterClass<"AchtBit", [i16], 8, (add RSP)>;


// Status register.
def FLAGS : AchtBitReg<16, "FLAGS">, DwarfRegNum<[16]>;
def CCR : RegisterClass<"AchtBit", [i8], 8, (add FLAGS)> {
  let CopyCost = -1; // Don't allow copying of flags registers
}
def PC : AchtBitReg<17, "FLAGS">, DwarfRegNum<[17]>;