add_llvm_component_group(AchtBit)

set(LLVM_TARGET_DEFINITIONS AchtBit.td)

# tablegen(LLVM AchtBitGenAsmMatcher.inc -gen-asm-matcher)
# tablegen(LLVM AchtBitGenAsmWriter.inc -gen-asm-writer)
tablegen(LLVM AchtBitGenCallingConv.inc -gen-callingconv)
# tablegen(LLVM AchtBitGenDAGISel.inc -gen-dag-isel)
# tablegen(LLVM AchtBitGenDisassemblerTables.inc -gen-disassembler)
tablegen(LLVM AchtBitGenInstrInfo.inc -gen-instr-info)
# tablegen(LLVM AchtBitGenMCCodeEmitter.inc -gen-emitter)
tablegen(LLVM AchtBitGenRegisterInfo.inc -gen-register-info)

add_public_tablegen_target(AchtBitCommonTableGen)

add_llvm_target(AchtBitCodeGen
  AchtBitTargetMachine.cpp

  LINK_COMPONENTS
#  AsmPrinter
#  CodeGen
#  Core
#  MC
#  SelectionDAG
  AchtBitDesc
  AchtBitInfo
#  Support
  Target

  ADD_TO_COMPONENT
  AchtBit
  )

