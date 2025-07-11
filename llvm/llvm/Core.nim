## ===-- llvm-c/Core.h - Core Library C Interface ------------------*- C -*-===*\
## |*                                                                            *|
## |* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
## |* Exceptions.                                                                *|
## |* See https://llvm.org/LICENSE.txt for license information.                  *|
## |* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
## |*                                                                            *|
## |*===----------------------------------------------------------------------===*|
## |*                                                                            *|
## |* This header declares the C interface to libLLVMCore.a, which implements    *|
## |* the LLVM intermediate representation.                                      *|
## |*                                                                            *|
## \*===----------------------------------------------------------------------===

## !!!Ignored construct:  # LLVM_C_CORE_H [NewLine] # LLVM_C_CORE_H [NewLine] # llvm-c/Deprecated.h [NewLine] # llvm-c/ErrorHandling.h [NewLine] # llvm-c/ExternC.h [NewLine] # llvm-c/Types.h [NewLine]
##  @defgroup LLVMC LLVM-C: C interface to LLVM
##
##  This module exposes parts of the LLVM library as a C API.
##
##  @{
##
##  @defgroup LLVMCTransforms Transforms
##
##  @defgroup LLVMCCore Core
##
##  This modules provide an interface to libLLVMCore, which implements
##  the LLVM intermediate representation as well as other related types
##  and utilities.
##
##  Many exotic languages can interoperate with C code but have a harder time
##  with C++ due to name mangling. So in addition to C, this interface enables
##  tools written in such languages.
##
##  @{
##
##  @defgroup LLVMCCoreTypes Types and Enumerations
##
##  @{
##   External users depend on the following values being stable. It is not safe
##  to reorder them. typedef enum {  Terminator Instructions LLVMRet = 1 , LLVMBr = 2 , LLVMSwitch = 3 , LLVMIndirectBr = 4 , LLVMInvoke = 5 ,  removed 6 due to API changes LLVMUnreachable = 7 , LLVMCallBr = 67 ,  Standard Unary Operators LLVMFNeg = 66 ,  Standard Binary Operators LLVMAdd = 8 , LLVMFAdd = 9 , LLVMSub = 10 , LLVMFSub = 11 , LLVMMul = 12 , LLVMFMul = 13 , LLVMUDiv = 14 , LLVMSDiv = 15 , LLVMFDiv = 16 , LLVMURem = 17 , LLVMSRem = 18 , LLVMFRem = 19 ,  Logical Operators LLVMShl = 20 , LLVMLShr = 21 , LLVMAShr = 22 , LLVMAnd = 23 , LLVMOr = 24 , LLVMXor = 25 ,  Memory Operators LLVMAlloca = 26 , LLVMLoad = 27 , LLVMStore = 28 , LLVMGetElementPtr = 29 ,  Cast Operators LLVMTrunc = 30 , LLVMZExt = 31 , LLVMSExt = 32 , LLVMFPToUI = 33 , LLVMFPToSI = 34 , LLVMUIToFP = 35 , LLVMSIToFP = 36 , LLVMFPTrunc = 37 , LLVMFPExt = 38 , LLVMPtrToInt = 39 , LLVMIntToPtr = 40 , LLVMBitCast = 41 , LLVMAddrSpaceCast = 60 ,  Other Operators LLVMICmp = 42 , LLVMFCmp = 43 , LLVMPHI = 44 , LLVMCall = 45 , LLVMSelect = 46 , LLVMUserOp1 = 47 , LLVMUserOp2 = 48 , LLVMVAArg = 49 , LLVMExtractElement = 50 , LLVMInsertElement = 51 , LLVMShuffleVector = 52 , LLVMExtractValue = 53 , LLVMInsertValue = 54 , LLVMFreeze = 68 ,  Atomic operators LLVMFence = 55 , LLVMAtomicCmpXchg = 56 , LLVMAtomicRMW = 57 ,  Exception Handling Operators LLVMResume = 58 , LLVMLandingPad = 59 , LLVMCleanupRet = 61 , LLVMCatchRet = 62 , LLVMCatchPad = 63 , LLVMCleanupPad = 64 , LLVMCatchSwitch = 65 } LLVMOpcode ;
## Error: expected ';'!!!

type
  ##
  ##  Emits an error if two values disagree, otherwise the resulting value is
  ##  that of the operands.
  ##
  ##  @see Module::ModFlagBehavior::Error
  ##
  TypeKind* {.size: sizeof(cint).} = enum
    VoidTypeKind = 0 ## < type with no size
    HalfTypeKind = 1 ## < 16 bit floating point type
    FloatTypeKind = 2 ## < 32 bit floating point type
    DoubleTypeKind = 3 ## < 64 bit floating point type
    X86FP80TypeKind = 4 ## < 80 bit floating point type (X87)
    FP128TypeKind = 5 ## < 128 bit floating point type (112-bit mantissa)
    PPC_FP128TypeKind = 6 ## < 128 bit floating point type (two 64-bits)
    LabelTypeKind = 7 ## < Labels
    IntegerTypeKind = 8 ## < Arbitrary bit width integers
    FunctionTypeKind = 9 ## < Functions
    StructTypeKind = 10 ## < Structures
    ArrayTypeKind = 11 ## < Arrays
    PointerTypeKind = 12 ## < Pointers
    VectorTypeKind = 13 ## < Fixed width SIMD vector type
    MetadataTypeKind = 14
      ## < Metadata
      ##  15 previously used by LLVMX86_MMXTypeKind
    TokenTypeKind = 16 ## < Tokens
    ScalableVectorTypeKind = 17 ## < Scalable SIMD vector type
    BFloatTypeKind = 18 ## < 16 bit brain floating point type
    X86AMXTypeKind = 19 ## < X86 AMX
    TargetExtTypeKind = 20 ## < Target extension type

  Linkage* {.size: sizeof(cint).} = enum
    ExternalLinkage ## < Externally visible function
    AvailableExternallyLinkage
    LinkOnceAnyLinkage ## < Keep one copy of function when linking (inline)
    LinkOnceODRLinkage
      ## < Same, but only replaced by something
      ##                             equivalent.
    LinkOnceODRAutoHideLinkage ## < Obsolete
    WeakAnyLinkage ## < Keep one copy of function when linking (weak)
    WeakODRLinkage
      ## < Same, but only replaced by something
      ##                             equivalent.
    AppendingLinkage ## < Special purpose, only applies to global arrays
    InternalLinkage
      ## < Rename collisions when linking (static
      ##                                functions)
    PrivateLinkage ## < Like Internal, but omit from symbol table
    DLLImportLinkage ## < Obsolete
    DLLExportLinkage ## < Obsolete
    ExternalWeakLinkage ## < ExternalWeak linkage description
    GhostLinkage ## < Obsolete
    CommonLinkage ## < Tentative definitions
    LinkerPrivateLinkage ## < Like Private, but linker removes.
    LinkerPrivateWeakLinkage ## < Like LinkerPrivate, but is weak.

  Visibility* {.size: sizeof(cint).} = enum
    DefaultVisibility ## < The GV is visible
    HiddenVisibility ## < The GV is hidden
    ProtectedVisibility ## < The GV is protected

  UnnamedAddr* {.size: sizeof(cint).} = enum
    NoUnnamedAddr ## < Address of the GV is significant.
    LocalUnnamedAddr ## < Address of the GV is locally insignificant.
    GlobalUnnamedAddr ## < Address of the GV is globally insignificant.

  DLLStorageClass* {.size: sizeof(cint).} = enum
    DefaultStorageClass = 0
    DLLImportStorageClass = 1 ## < Function to be imported from DLL.
    DLLExportStorageClass = 2 ## < Function to be accessible from DLL.

  CallConv* {.size: sizeof(cint).} = enum
    CCallConv = 0
    FastCallConv = 8
    ColdCallConv = 9
    GHCCallConv = 10
    HiPECallConv = 11
    AnyRegCallConv = 13
    PreserveMostCallConv = 14
    PreserveAllCallConv = 15
    SwiftCallConv = 16
    CXXFASTTLSCallConv = 17
    X86StdcallCallConv = 64
    X86FastcallCallConv = 65
    ARMAPCSCallConv = 66
    ARMAAPCSCallConv = 67
    ARMAAPCSVFPCallConv = 68
    MSP430INTRCallConv = 69
    X86ThisCallCallConv = 70
    PTXKernelCallConv = 71
    PTXDeviceCallConv = 72
    SPIRFUNCCallConv = 75
    SPIRKERNELCallConv = 76
    IntelOCLBICallConv = 77
    X8664SysVCallConv = 78
    Win64CallConv = 79
    X86VectorCallCallConv = 80
    HHVMCallConv = 81
    HHVMCCallConv = 82
    X86INTRCallConv = 83
    AVRINTRCallConv = 84
    AVRSIGNALCallConv = 85
    AVRBUILTINCallConv = 86
    AMDGPUVSCallConv = 87
    AMDGPUGSCallConv = 88
    AMDGPUPSCallConv = 89
    AMDGPUCSCallConv = 90
    AMDGPUKERNELCallConv = 91
    X86RegCallCallConv = 92
    AMDGPUHSCallConv = 93
    MSP430BUILTINCallConv = 94
    AMDGPULSCallConv = 95
    AMDGPUESCallConv = 96

  ValueKind* {.size: sizeof(cint).} = enum
    ArgumentValueKind
    BasicBlockValueKind
    MemoryUseValueKind
    MemoryDefValueKind
    MemoryPhiValueKind
    FunctionValueKind
    GlobalAliasValueKind
    GlobalIFuncValueKind
    GlobalVariableValueKind
    BlockAddressValueKind
    ConstantExprValueKind
    ConstantArrayValueKind
    ConstantStructValueKind
    ConstantVectorValueKind
    UndefValueValueKind
    ConstantAggregateZeroValueKind
    ConstantDataArrayValueKind
    ConstantDataVectorValueKind
    ConstantIntValueKind
    ConstantFPValueKind
    ConstantPointerNullValueKind
    ConstantTokenNoneValueKind
    MetadataAsValueValueKind
    InlineAsmValueKind
    InstructionValueKind
    PoisonValueValueKind
    ConstantTargetNoneValueKind
    ConstantPtrAuthValueKind

  IntPredicate* {.size: sizeof(cint).} = enum
    IntEQ = 32 ## < equal
    IntNE ## < not equal
    IntUGT ## < unsigned greater than
    IntUGE ## < unsigned greater or equal
    IntULT ## < unsigned less than
    IntULE ## < unsigned less or equal
    IntSGT ## < signed greater than
    IntSGE ## < signed greater or equal
    IntSLT ## < signed less than
    IntSLE ## < signed less or equal

  RealPredicate* {.size: sizeof(cint).} = enum
    RealPredicateFalse ## < Always false (always folded)
    RealOEQ ## < True if ordered and equal
    RealOGT ## < True if ordered and greater than
    RealOGE ## < True if ordered and greater than or equal
    RealOLT ## < True if ordered and less than
    RealOLE ## < True if ordered and less than or equal
    RealONE ## < True if ordered and operands are unequal
    RealORD ## < True if ordered (no nans)
    RealUNO ## < True if unordered: isnan(X) | isnan(Y)
    RealUEQ ## < True if unordered or equal
    RealUGT ## < True if unordered or greater than
    RealUGE ## < True if unordered, greater than, or equal
    RealULT ## < True if unordered or less than
    RealULE ## < True if unordered, less than, or equal
    RealUNE ## < True if unordered or not equal
    RealPredicateTrue ## < Always true (always folded)

  LandingPadClauseTy* {.size: sizeof(cint).} = enum
    LandingPadCatch ## < A catch clause
    LandingPadFilter ## < A filter clause

  ThreadLocalMode* {.size: sizeof(cint).} = enum
    NotThreadLocal = 0
    GeneralDynamicTLSModel
    LocalDynamicTLSModel
    InitialExecTLSModel
    LocalExecTLSModel

  AtomicOrdering* {.size: sizeof(cint).} = enum
    AtomicOrderingNotAtomic = 0 ## < A load or store which is not atomic
    AtomicOrderingUnordered = 1
      ## < Lowest level of atomicity, guarantees
      ##                                      somewhat sane results, lock free.
    AtomicOrderingMonotonic = 2
      ## < guarantees that if you take all the
      ##                                      operations affecting a specific address,
      ##                                      a consistent ordering exists
    AtomicOrderingAcquire = 4
      ## < Acquire provides a barrier of the sort
      ##                                    necessary to acquire a lock to access other
      ##                                    memory with normal loads and stores.
    AtomicOrderingRelease = 5
      ## < Release is similar to Acquire, but with
      ##                                    a barrier of the sort necessary to release
      ##                                    a lock.
    AtomicOrderingAcquireRelease = 6
      ## < provides both an Acquire and a
      ##                                           Release barrier (for fences and
      ##                                           operations which both read and write
      ##                                            memory).
    AtomicOrderingSequentiallyConsistent = 7
      ## < provides Acquire semantics
      ##                                                  for loads and Release
      ##                                                  semantics for stores.
      ##                                                  Additionally, it guarantees
      ##                                                  that a total ordering exists
      ##                                                  between all
      ##                                                  SequentiallyConsistent
      ##                                                  operations.

  AtomicRMWBinOp* {.size: sizeof(cint).} = enum
    AtomicRMWBinOpXchg ## < Set the new value and return the one old
    AtomicRMWBinOpAdd ## < Add a value and return the old one
    AtomicRMWBinOpSub ## < Subtract a value and return the old one
    AtomicRMWBinOpAnd ## < And a value and return the old one
    AtomicRMWBinOpNand ## < Not-And a value and return the old one
    AtomicRMWBinOpOr ## < OR a value and return the old one
    AtomicRMWBinOpXor ## < Xor a value and return the old one
    AtomicRMWBinOpMax
      ## < Sets the value if it's greater than the
      ##                             original using a signed comparison and return
      ##                             the old one
    AtomicRMWBinOpMin
      ## < Sets the value if it's Smaller than the
      ##                             original using a signed comparison and return
      ##                             the old one
    AtomicRMWBinOpUMax
      ## < Sets the value if it's greater than the
      ##                            original using an unsigned comparison and return
      ##                            the old one
    AtomicRMWBinOpUMin
      ## < Sets the value if it's greater than the
      ##                             original using an unsigned comparison and return
      ##                             the old one
    AtomicRMWBinOpFAdd
      ## < Add a floating point value and return the
      ##                             old one
    AtomicRMWBinOpFSub
      ## < Subtract a floating point value and return the
      ##                           old one
    AtomicRMWBinOpFMax
      ## < Sets the value if it's greater than the
      ##                            original using an floating point comparison and
      ##                            return the old one
    AtomicRMWBinOpFMin
      ## < Sets the value if it's smaller than the
      ##                            original using an floating point comparison and
      ##                            return the old one
    AtomicRMWBinOpUIncWrap
      ## < Increments the value, wrapping back to zero
      ##                                when incremented above input value
    AtomicRMWBinOpUDecWrap
      ## < Decrements the value, wrapping back to
      ##                                the input value when decremented below zero
    AtomicRMWBinOpUSubCond
      ## <Subtracts the value only if no unsigned
      ##                                  overflow
    AtomicRMWBinOpUSubSat ## <Subtracts the value, clamping to zero

  DiagnosticSeverity* {.size: sizeof(cint).} = enum
    DSError
    DSWarning
    DSRemark
    DSNote

  InlineAsmDialect* {.size: sizeof(cint).} = enum
    InlineAsmDialectATT
    InlineAsmDialectIntel

  ModuleFlagBehavior* {.size: sizeof(cint).} = enum
    ModuleFlagBehaviorError
      ##
      ##  Emits a warning if two values disagree. The result value will be the
      ##  operand for the flag from the first module being linked.
      ##
      ##  @see Module::ModFlagBehavior::Warning
      ##
    ModuleFlagBehaviorWarning
      ##
      ##  Adds a requirement that another module flag be present and have a
      ##  specified value after linking is performed. The value must be a metadata
      ##  pair, where the first element of the pair is the ID of the module flag
      ##  to be restricted, and the second element of the pair is the value the
      ##  module flag should be restricted to. This behavior can be used to
      ##  restrict the allowable results (via triggering of an error) of linking
      ##  IDs with the **Override** behavior.
      ##
      ##  @see Module::ModFlagBehavior::Require
      ##
    ModuleFlagBehaviorRequire
      ##
      ##  Uses the specified value, regardless of the behavior or value of the
      ##  other module. If both modules specify **Override**, but the values
      ##  differ, an error will be emitted.
      ##
      ##  @see Module::ModFlagBehavior::Override
      ##
    ModuleFlagBehaviorOverride
      ##
      ##  Appends the two values, which are required to be metadata nodes.
      ##
      ##  @see Module::ModFlagBehavior::Append
      ##
    ModuleFlagBehaviorAppend
      ##
      ##  Appends the two values, which are required to be metadata
      ##  nodes. However, duplicate entries in the second list are dropped
      ##  during the append operation.
      ##
      ##  @see Module::ModFlagBehavior::AppendUnique
      ##
    ModuleFlagBehaviorAppendUnique

##
##  Attribute index are either LLVMAttributeReturnIndex,
##  LLVMAttributeFunctionIndex or a parameter number from 1 to N.
##

const
  AttributeReturnIndex* = 0'u
    ##  ISO C restricts enumerator values to range of 'int'
    ##  (4294967295 is too large)
    ##  LLVMAttributeFunctionIndex = ~0U,
  AttributeFunctionIndex* = -1

type AttributeIndex* = cuint

##
##  Tail call kind for LLVMSetTailCallKind and LLVMGetTailCallKind.
##
##  Note that 'musttail' implies 'tail'.
##
##  @see CallInst::TailCallKind
##

type TailCallKind* {.size: sizeof(cint).} = enum
  TailCallKindNone = 0
  TailCallKindTail = 1
  TailCallKindMustTail = 2
  TailCallKindNoTail = 3

const
  FastMathAllowReassoc* = (1 shl 0)
  FastMathNoNaNs* = (1 shl 1)
  FastMathNoInfs* = (1 shl 2)
  FastMathNoSignedZeros* = (1 shl 3)
  FastMathAllowReciprocal* = (1 shl 4)
  FastMathAllowContract* = (1 shl 5)
  FastMathApproxFunc* = (1 shl 6)
  FastMathNone* = 0
  FastMathAll* =
    FastMathAllowReassoc or FastMathNoNaNs or FastMathNoInfs or FastMathNoSignedZeros or
    FastMathAllowReciprocal or FastMathAllowContract or FastMathApproxFunc

##
##  Flags to indicate what fast-math-style optimizations are allowed
##  on operations.
##
##  See https://llvm.org/docs/LangRef.html#fast-math-flags
##

type FastMathFlags* = cuint

const
  GEPFlagInBounds* = (1 shl 0)
  GEPFlagNUSW* = (1 shl 1)
  GEPFlagNUW* = (1 shl 2)

##
##  Flags that constrain the allowed wrap semantics of a getelementptr
##  instruction.
##
##  See https://llvm.org/docs/LangRef.html#getelementptr-instruction
##

type GEPNoWrapFlags* = cuint

##
##  @}
##
##  Deallocate and destroy all ManagedStatic variables.
##     @see llvm::llvm_shutdown
##     @see ManagedStatic

proc shutdown*() {.importc: "LLVMShutdown", dynlib: LLVMLib.}
## ===-- Version query -----------------------------------------------------===
##
##  Return the major, minor, and patch version of LLVM
##
##  The version components are returned via the function's three output
##  parameters or skipped if a NULL pointer was supplied.
##

proc getVersion*(
  major: ptr cuint, minor: ptr cuint, patch: ptr cuint
) {.importc: "LLVMGetVersion", dynlib: LLVMLib.}

## ===-- Error handling ----------------------------------------------------===

proc createMessage*(
  message: cstring
): cstring {.importc: "LLVMCreateMessage", dynlib: LLVMLib.}

proc disposeMessage*(
  message: cstring
) {.importc: "LLVMDisposeMessage", dynlib: LLVMLib.}

##
##  @defgroup LLVMCCoreContext Contexts
##
##  Contexts are execution states for the core LLVM IR system.
##
##  Most types are tied to a context instance. Multiple contexts can
##  exist simultaneously. A single context is not thread safe. However,
##  different contexts can execute on different threads simultaneously.
##
##  @{
##

type
  DiagnosticHandler* = proc(a1: DiagnosticInfoRef, a2: pointer)
  YieldCallback* = proc(a1: ContextRef, a2: pointer)

##
##  Create a new context.
##
##  Every call to this function should be paired with a call to
##  LLVMContextDispose() or the context will leak memory.
##

proc contextCreate*(): ContextRef {.importc: "LLVMContextCreate", dynlib: LLVMLib.}
##
##  Obtain the global context instance.
##

proc getGlobalContext*(): ContextRef {.
  importc: "LLVMGetGlobalContext", dynlib: LLVMLib
.}

##
##  Set the diagnostic handler for this context.
##

proc contextSetDiagnosticHandler*(
  c: ContextRef, handler: DiagnosticHandler, diagnosticContext: pointer
) {.importc: "LLVMContextSetDiagnosticHandler", dynlib: LLVMLib.}

##
##  Get the diagnostic handler of this context.
##

proc contextGetDiagnosticHandler*(
  c: ContextRef
): DiagnosticHandler {.importc: "LLVMContextGetDiagnosticHandler", dynlib: LLVMLib.}

##
##  Get the diagnostic context of this context.
##

proc contextGetDiagnosticContext*(
  c: ContextRef
): pointer {.importc: "LLVMContextGetDiagnosticContext", dynlib: LLVMLib.}

##
##  Set the yield callback function for this context.
##
##  @see LLVMContext::setYieldCallback()
##

proc contextSetYieldCallback*(
  c: ContextRef, callback: YieldCallback, opaqueHandle: pointer
) {.importc: "LLVMContextSetYieldCallback", dynlib: LLVMLib.}

##
##  Retrieve whether the given context is set to discard all value names.
##
##  @see LLVMContext::shouldDiscardValueNames()
##

proc contextShouldDiscardValueNames*(
  c: ContextRef
): Bool {.importc: "LLVMContextShouldDiscardValueNames", dynlib: LLVMLib.}

##
##  Set whether the given context discards all value names.
##
##  If true, only the names of GlobalValue objects will be available in the IR.
##  This can be used to save memory and runtime, especially in release mode.
##
##  @see LLVMContext::setDiscardValueNames()
##

proc contextSetDiscardValueNames*(
  c: ContextRef, `discard`: Bool
) {.importc: "LLVMContextSetDiscardValueNames", dynlib: LLVMLib.}

##
##  Destroy a context instance.
##
##  This should be called for every call to LLVMContextCreate() or memory
##  will be leaked.
##

proc contextDispose*(c: ContextRef) {.importc: "LLVMContextDispose", dynlib: LLVMLib.}
##
##  Return a string representation of the DiagnosticInfo. Use
##  LLVMDisposeMessage to free the string.
##
##  @see DiagnosticInfo::print()
##

proc getDiagInfoDescription*(
  di: DiagnosticInfoRef
): cstring {.importc: "LLVMGetDiagInfoDescription", dynlib: LLVMLib.}

##
##  Return an enum LLVMDiagnosticSeverity.
##
##  @see DiagnosticInfo::getSeverity()
##

proc getDiagInfoSeverity*(
  di: DiagnosticInfoRef
): DiagnosticSeverity {.importc: "LLVMGetDiagInfoSeverity", dynlib: LLVMLib.}

proc getMDKindIDInContext*(
  c: ContextRef, name: cstring, sLen: cuint
): cuint {.importc: "LLVMGetMDKindIDInContext", dynlib: LLVMLib.}

proc getMDKindID*(
  name: cstring, sLen: cuint
): cuint {.importc: "LLVMGetMDKindID", dynlib: LLVMLib.}

##
##  Maps a synchronization scope name to a ID unique within this context.
##

proc getSyncScopeID*(
  c: ContextRef, name: cstring, sLen: csize_t
): cuint {.importc: "LLVMGetSyncScopeID", dynlib: LLVMLib.}

##
##  Return an unique id given the name of a enum attribute,
##  or 0 if no attribute by that name exists.
##
##  See http://llvm.org/docs/LangRef.html#parameter-attributes
##  and http://llvm.org/docs/LangRef.html#function-attributes
##  for the list of available attributes.
##
##  NB: Attribute names and/or id are subject to change without
##  going through the C API deprecation cycle.
##

proc getEnumAttributeKindForName*(
  name: cstring, sLen: csize_t
): cuint {.importc: "LLVMGetEnumAttributeKindForName", dynlib: LLVMLib.}

proc getLastEnumAttributeKind*(): cuint {.
  importc: "LLVMGetLastEnumAttributeKind", dynlib: LLVMLib
.}

##
##  Create an enum attribute.
##

proc createEnumAttribute*(
  c: ContextRef, kindID: cuint, val: uint64
): AttributeRef {.importc: "LLVMCreateEnumAttribute", dynlib: LLVMLib.}

##
##  Get the unique id corresponding to the enum attribute
##  passed as argument.
##

proc getEnumAttributeKind*(
  a: AttributeRef
): cuint {.importc: "LLVMGetEnumAttributeKind", dynlib: LLVMLib.}

##
##  Get the enum attribute's value. 0 is returned if none exists.
##

proc getEnumAttributeValue*(
  a: AttributeRef
): uint64 {.importc: "LLVMGetEnumAttributeValue", dynlib: LLVMLib.}

##
##  Create a type attribute
##

proc createTypeAttribute*(
  c: ContextRef, kindID: cuint, typeRef: TypeRef
): AttributeRef {.importc: "LLVMCreateTypeAttribute", dynlib: LLVMLib.}

##
##  Get the type attribute's value.
##

proc getTypeAttributeValue*(
  a: AttributeRef
): TypeRef {.importc: "LLVMGetTypeAttributeValue", dynlib: LLVMLib.}

##
##  Create a ConstantRange attribute.
##
##  LowerWords and UpperWords need to be NumBits divided by 64 rounded up
##  elements long.
##

proc createConstantRangeAttribute*(
  c: ContextRef,
  kindID: cuint,
  numBits: cuint,
  lowerWords: ptr uint64,
  upperWords: ptr uint64,
): AttributeRef {.importc: "LLVMCreateConstantRangeAttribute", dynlib: LLVMLib.}

##
##  Create a string attribute.
##

proc createStringAttribute*(
  c: ContextRef, k: cstring, kLength: cuint, v: cstring, vLength: cuint
): AttributeRef {.importc: "LLVMCreateStringAttribute", dynlib: LLVMLib.}

##
##  Get the string attribute's kind.
##

proc getStringAttributeKind*(
  a: AttributeRef, length: ptr cuint
): cstring {.importc: "LLVMGetStringAttributeKind", dynlib: LLVMLib.}

##
##  Get the string attribute's value.
##

proc getStringAttributeValue*(
  a: AttributeRef, length: ptr cuint
): cstring {.importc: "LLVMGetStringAttributeValue", dynlib: LLVMLib.}

##
##  Check for the different types of attributes.
##

proc isEnumAttribute*(
  a: AttributeRef
): Bool {.importc: "LLVMIsEnumAttribute", dynlib: LLVMLib.}

proc isStringAttribute*(
  a: AttributeRef
): Bool {.importc: "LLVMIsStringAttribute", dynlib: LLVMLib.}

proc isTypeAttribute*(
  a: AttributeRef
): Bool {.importc: "LLVMIsTypeAttribute", dynlib: LLVMLib.}

##
##  Obtain a Type from a context by its registered name.
##

proc getTypeByName2*(
  c: ContextRef, name: cstring
): TypeRef {.importc: "LLVMGetTypeByName2", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCCoreModule Modules
##
##  Modules represent the top-level structure in an LLVM program. An LLVM
##  module is effectively a translation unit or a collection of
##  translation units merged together.
##
##  @{
##
##
##  Create a new, empty module in the global context.
##
##  This is equivalent to calling LLVMModuleCreateWithNameInContext with
##  LLVMGetGlobalContext() as the context parameter.
##
##  Every invocation should be paired with LLVMDisposeModule() or memory
##  will be leaked.
##

proc moduleCreateWithName*(
  moduleID: cstring
): ModuleRef {.importc: "LLVMModuleCreateWithName", dynlib: LLVMLib.}

##
##  Create a new, empty module in a specific context.
##
##  Every invocation should be paired with LLVMDisposeModule() or memory
##  will be leaked.
##

proc moduleCreateWithNameInContext*(
  moduleID: cstring, c: ContextRef
): ModuleRef {.importc: "LLVMModuleCreateWithNameInContext", dynlib: LLVMLib.}

##
##  Return an exact copy of the specified module.
##

proc cloneModule*(
  m: ModuleRef
): ModuleRef {.importc: "LLVMCloneModule", dynlib: LLVMLib.}

##
##  Destroy a module instance.
##
##  This must be called for every created module or memory will be
##  leaked.
##

proc disposeModule*(m: ModuleRef) {.importc: "LLVMDisposeModule", dynlib: LLVMLib.}
##
##  Soon to be deprecated.
##  See https://llvm.org/docs/RemoveDIsDebugInfo.html#c-api-changes
##
##  Returns true if the module is in the new debug info mode which uses
##  non-instruction debug records instead of debug intrinsics for variable
##  location tracking.
##

proc isNewDbgInfoFormat*(
  m: ModuleRef
): Bool {.importc: "LLVMIsNewDbgInfoFormat", dynlib: LLVMLib.}

##
##  Soon to be deprecated.
##  See https://llvm.org/docs/RemoveDIsDebugInfo.html#c-api-changes
##
##  Convert module into desired debug info format.
##

proc setIsNewDbgInfoFormat*(
  m: ModuleRef, useNewFormat: Bool
) {.importc: "LLVMSetIsNewDbgInfoFormat", dynlib: LLVMLib.}

##
##  Obtain the identifier of a module.
##
##  @param M Module to obtain identifier of
##  @param Len Out parameter which holds the length of the returned string.
##  @return The identifier of M.
##  @see Module::getModuleIdentifier()
##

proc getModuleIdentifier*(
  m: ModuleRef, len: ptr csize_t
): cstring {.importc: "LLVMGetModuleIdentifier", dynlib: LLVMLib.}

##
##  Set the identifier of a module to a string Ident with length Len.
##
##  @param M The module to set identifier
##  @param Ident The string to set M's identifier to
##  @param Len Length of Ident
##  @see Module::setModuleIdentifier()
##

proc setModuleIdentifier*(
  m: ModuleRef, ident: cstring, len: csize_t
) {.importc: "LLVMSetModuleIdentifier", dynlib: LLVMLib.}

##
##  Obtain the module's original source file name.
##
##  @param M Module to obtain the name of
##  @param Len Out parameter which holds the length of the returned string
##  @return The original source file name of M
##  @see Module::getSourceFileName()
##

proc getSourceFileName*(
  m: ModuleRef, len: ptr csize_t
): cstring {.importc: "LLVMGetSourceFileName", dynlib: LLVMLib.}

##
##  Set the original source file name of a module to a string Name with length
##  Len.
##
##  @param M The module to set the source file name of
##  @param Name The string to set M's source file name to
##  @param Len Length of Name
##  @see Module::setSourceFileName()
##

proc setSourceFileName*(
  m: ModuleRef, name: cstring, len: csize_t
) {.importc: "LLVMSetSourceFileName", dynlib: LLVMLib.}

##
##  Obtain the data layout for a module.
##
##  @see Module::getDataLayoutStr()
##
##  LLVMGetDataLayout is DEPRECATED, as the name is not only incorrect,
##  but match the name of another method on the module. Prefer the use
##  of LLVMGetDataLayoutStr, which is not ambiguous.
##

proc getDataLayoutStr*(
  m: ModuleRef
): cstring {.importc: "LLVMGetDataLayoutStr", dynlib: LLVMLib.}

proc getDataLayout*(
  m: ModuleRef
): cstring {.importc: "LLVMGetDataLayout", dynlib: LLVMLib.}

##
##  Set the data layout for a module.
##
##  @see Module::setDataLayout()
##

proc setDataLayout*(
  m: ModuleRef, dataLayoutStr: cstring
) {.importc: "LLVMSetDataLayout", dynlib: LLVMLib.}

##
##  Obtain the target triple for a module.
##
##  @see Module::getTargetTriple()
##

proc getTarget*(m: ModuleRef): cstring {.importc: "LLVMGetTarget", dynlib: LLVMLib.}
##
##  Set the target triple for a module.
##
##  @see Module::setTargetTriple()
##

proc setTarget*(
  m: ModuleRef, triple: cstring
) {.importc: "LLVMSetTarget", dynlib: LLVMLib.}

##
##  Returns the module flags as an array of flag-key-value triples.  The caller
##  is responsible for freeing this array by calling
##  \c LLVMDisposeModuleFlagsMetadata.
##
##  @see Module::getModuleFlagsMetadata()
##

proc copyModuleFlagsMetadata*(
  m: ModuleRef, len: ptr csize_t
): ptr ModuleFlagEntry {.importc: "LLVMCopyModuleFlagsMetadata", dynlib: LLVMLib.}

##
##  Destroys module flags metadata entries.
##

proc disposeModuleFlagsMetadata*(
  entries: ptr ModuleFlagEntry
) {.importc: "LLVMDisposeModuleFlagsMetadata", dynlib: LLVMLib.}

##
##  Returns the flag behavior for a module flag entry at a specific index.
##
##  @see Module::ModuleFlagEntry::Behavior
##

proc moduleFlagEntriesGetFlagBehavior*(
  entries: ptr ModuleFlagEntry, index: cuint
): ModuleFlagBehavior {.
  importc: "LLVMModuleFlagEntriesGetFlagBehavior", dynlib: LLVMLib
.}

##
##  Returns the key for a module flag entry at a specific index.
##
##  @see Module::ModuleFlagEntry::Key
##

proc moduleFlagEntriesGetKey*(
  entries: ptr ModuleFlagEntry, index: cuint, len: ptr csize_t
): cstring {.importc: "LLVMModuleFlagEntriesGetKey", dynlib: LLVMLib.}

##
##  Returns the metadata for a module flag entry at a specific index.
##
##  @see Module::ModuleFlagEntry::Val
##

proc moduleFlagEntriesGetMetadata*(
  entries: ptr ModuleFlagEntry, index: cuint
): MetadataRef {.importc: "LLVMModuleFlagEntriesGetMetadata", dynlib: LLVMLib.}

##
##  Add a module-level flag to the module-level flags metadata if it doesn't
##  already exist.
##
##  @see Module::getModuleFlag()
##

proc getModuleFlag*(
  m: ModuleRef, key: cstring, keyLen: csize_t
): MetadataRef {.importc: "LLVMGetModuleFlag", dynlib: LLVMLib.}

##
##  Add a module-level flag to the module-level flags metadata if it doesn't
##  already exist.
##
##  @see Module::addModuleFlag()
##

proc addModuleFlag*(
  m: ModuleRef,
  behavior: ModuleFlagBehavior,
  key: cstring,
  keyLen: csize_t,
  val: MetadataRef,
) {.importc: "LLVMAddModuleFlag", dynlib: LLVMLib.}

##
##  Dump a representation of a module to stderr.
##
##  @see Module::dump()
##

proc dumpModule*(m: ModuleRef) {.importc: "LLVMDumpModule", dynlib: LLVMLib.}
##
##  Print a representation of a module to a file. The ErrorMessage needs to be
##  disposed with LLVMDisposeMessage. Returns 0 on success, 1 otherwise.
##
##  @see Module::print()
##

proc printModuleToFile*(
  m: ModuleRef, filename: cstring, errorMessage: cstringArray
): Bool {.importc: "LLVMPrintModuleToFile", dynlib: LLVMLib.}

##
##  Return a string representation of the module. Use
##  LLVMDisposeMessage to free the string.
##
##  @see Module::print()
##

proc printModuleToString*(
  m: ModuleRef
): cstring {.importc: "LLVMPrintModuleToString", dynlib: LLVMLib.}

##
##  Get inline assembly for a module.
##
##  @see Module::getModuleInlineAsm()
##

proc getModuleInlineAsm*(
  m: ModuleRef, len: ptr csize_t
): cstring {.importc: "LLVMGetModuleInlineAsm", dynlib: LLVMLib.}

##
##  Set inline assembly for a module.
##
##  @see Module::setModuleInlineAsm()
##

proc setModuleInlineAsm2*(
  m: ModuleRef, `asm`: cstring, len: csize_t
) {.importc: "LLVMSetModuleInlineAsm2", dynlib: LLVMLib.}

##
##  Append inline assembly to a module.
##
##  @see Module::appendModuleInlineAsm()
##

proc appendModuleInlineAsm*(
  m: ModuleRef, `asm`: cstring, len: csize_t
) {.importc: "LLVMAppendModuleInlineAsm", dynlib: LLVMLib.}

##
##  Create the specified uniqued inline asm string.
##
##  @see InlineAsm::get()
##

proc getInlineAsm*(
  ty: TypeRef,
  asmString: cstring,
  asmStringSize: csize_t,
  constraints: cstring,
  constraintsSize: csize_t,
  hasSideEffects: Bool,
  isAlignStack: Bool,
  dialect: InlineAsmDialect,
  canThrow: Bool,
): ValueRef {.importc: "LLVMGetInlineAsm", dynlib: LLVMLib.}

##
##  Get the template string used for an inline assembly snippet
##
##

proc getInlineAsmAsmString*(
  inlineAsmVal: ValueRef, len: ptr csize_t
): cstring {.importc: "LLVMGetInlineAsmAsmString", dynlib: LLVMLib.}

##
##  Get the raw constraint string for an inline assembly snippet
##
##

proc getInlineAsmConstraintString*(
  inlineAsmVal: ValueRef, len: ptr csize_t
): cstring {.importc: "LLVMGetInlineAsmConstraintString", dynlib: LLVMLib.}

##
##  Get the dialect used by the inline asm snippet
##
##

proc getInlineAsmDialect*(
  inlineAsmVal: ValueRef
): InlineAsmDialect {.importc: "LLVMGetInlineAsmDialect", dynlib: LLVMLib.}

##
##  Get the function type of the inline assembly snippet. The same type that
##  was passed into LLVMGetInlineAsm originally
##
##  @see LLVMGetInlineAsm
##
##

proc getInlineAsmFunctionType*(
  inlineAsmVal: ValueRef
): TypeRef {.importc: "LLVMGetInlineAsmFunctionType", dynlib: LLVMLib.}

##
##  Get if the inline asm snippet has side effects
##
##

proc getInlineAsmHasSideEffects*(
  inlineAsmVal: ValueRef
): Bool {.importc: "LLVMGetInlineAsmHasSideEffects", dynlib: LLVMLib.}

##
##  Get if the inline asm snippet needs an aligned stack
##
##

proc getInlineAsmNeedsAlignedStack*(
  inlineAsmVal: ValueRef
): Bool {.importc: "LLVMGetInlineAsmNeedsAlignedStack", dynlib: LLVMLib.}

##
##  Get if the inline asm snippet may unwind the stack
##
##

proc getInlineAsmCanUnwind*(
  inlineAsmVal: ValueRef
): Bool {.importc: "LLVMGetInlineAsmCanUnwind", dynlib: LLVMLib.}

##
##  Obtain the context to which this module is associated.
##
##  @see Module::getContext()
##

proc getModuleContext*(
  m: ModuleRef
): ContextRef {.importc: "LLVMGetModuleContext", dynlib: LLVMLib.}

##  Deprecated: Use LLVMGetTypeByName2 instead.

proc getTypeByName*(
  m: ModuleRef, name: cstring
): TypeRef {.importc: "LLVMGetTypeByName", dynlib: LLVMLib.}

##
##  Obtain an iterator to the first NamedMDNode in a Module.
##
##  @see llvm::Module::named_metadata_begin()
##

proc getFirstNamedMetadata*(
  m: ModuleRef
): NamedMDNodeRef {.importc: "LLVMGetFirstNamedMetadata", dynlib: LLVMLib.}

##
##  Obtain an iterator to the last NamedMDNode in a Module.
##
##  @see llvm::Module::named_metadata_end()
##

proc getLastNamedMetadata*(
  m: ModuleRef
): NamedMDNodeRef {.importc: "LLVMGetLastNamedMetadata", dynlib: LLVMLib.}

##
##  Advance a NamedMDNode iterator to the next NamedMDNode.
##
##  Returns NULL if the iterator was already at the end and there are no more
##  named metadata nodes.
##

proc getNextNamedMetadata*(
  namedMDNode: NamedMDNodeRef
): NamedMDNodeRef {.importc: "LLVMGetNextNamedMetadata", dynlib: LLVMLib.}

##
##  Decrement a NamedMDNode iterator to the previous NamedMDNode.
##
##  Returns NULL if the iterator was already at the beginning and there are
##  no previous named metadata nodes.
##

proc getPreviousNamedMetadata*(
  namedMDNode: NamedMDNodeRef
): NamedMDNodeRef {.importc: "LLVMGetPreviousNamedMetadata", dynlib: LLVMLib.}

##
##  Retrieve a NamedMDNode with the given name, returning NULL if no such
##  node exists.
##
##  @see llvm::Module::getNamedMetadata()
##

proc getNamedMetadata*(
  m: ModuleRef, name: cstring, nameLen: csize_t
): NamedMDNodeRef {.importc: "LLVMGetNamedMetadata", dynlib: LLVMLib.}

##
##  Retrieve a NamedMDNode with the given name, creating a new node if no such
##  node exists.
##
##  @see llvm::Module::getOrInsertNamedMetadata()
##

proc getOrInsertNamedMetadata*(
  m: ModuleRef, name: cstring, nameLen: csize_t
): NamedMDNodeRef {.importc: "LLVMGetOrInsertNamedMetadata", dynlib: LLVMLib.}

##
##  Retrieve the name of a NamedMDNode.
##
##  @see llvm::NamedMDNode::getName()
##

proc getNamedMetadataName*(
  namedMD: NamedMDNodeRef, nameLen: ptr csize_t
): cstring {.importc: "LLVMGetNamedMetadataName", dynlib: LLVMLib.}

##
##  Obtain the number of operands for named metadata in a module.
##
##  @see llvm::Module::getNamedMetadata()
##

proc getNamedMetadataNumOperands*(
  m: ModuleRef, name: cstring
): cuint {.importc: "LLVMGetNamedMetadataNumOperands", dynlib: LLVMLib.}

##
##  Obtain the named metadata operands for a module.
##
##  The passed LLVMValueRef pointer should refer to an array of
##  LLVMValueRef at least LLVMGetNamedMetadataNumOperands long. This
##  array will be populated with the LLVMValueRef instances. Each
##  instance corresponds to a llvm::MDNode.
##
##  @see llvm::Module::getNamedMetadata()
##  @see llvm::MDNode::getOperand()
##

proc getNamedMetadataOperands*(
  m: ModuleRef, name: cstring, dest: ptr ValueRef
) {.importc: "LLVMGetNamedMetadataOperands", dynlib: LLVMLib.}

##
##  Add an operand to named metadata.
##
##  @see llvm::Module::getNamedMetadata()
##  @see llvm::MDNode::addOperand()
##

proc addNamedMetadataOperand*(
  m: ModuleRef, name: cstring, val: ValueRef
) {.importc: "LLVMAddNamedMetadataOperand", dynlib: LLVMLib.}

##
##  Return the directory of the debug location for this value, which must be
##  an llvm::Instruction, llvm::GlobalVariable, or llvm::Function.
##
##  @see llvm::Instruction::getDebugLoc()
##  @see llvm::GlobalVariable::getDebugInfo()
##  @see llvm::Function::getSubprogram()
##

proc getDebugLocDirectory*(
  val: ValueRef, length: ptr cuint
): cstring {.importc: "LLVMGetDebugLocDirectory", dynlib: LLVMLib.}

##
##  Return the filename of the debug location for this value, which must be
##  an llvm::Instruction, llvm::GlobalVariable, or llvm::Function.
##
##  @see llvm::Instruction::getDebugLoc()
##  @see llvm::GlobalVariable::getDebugInfo()
##  @see llvm::Function::getSubprogram()
##

proc getDebugLocFilename*(
  val: ValueRef, length: ptr cuint
): cstring {.importc: "LLVMGetDebugLocFilename", dynlib: LLVMLib.}

##
##  Return the line number of the debug location for this value, which must be
##  an llvm::Instruction, llvm::GlobalVariable, or llvm::Function.
##
##  @see llvm::Instruction::getDebugLoc()
##  @see llvm::GlobalVariable::getDebugInfo()
##  @see llvm::Function::getSubprogram()
##

proc getDebugLocLine*(
  val: ValueRef
): cuint {.importc: "LLVMGetDebugLocLine", dynlib: LLVMLib.}

##
##  Return the column number of the debug location for this value, which must be
##  an llvm::Instruction.
##
##  @see llvm::Instruction::getDebugLoc()
##

proc getDebugLocColumn*(
  val: ValueRef
): cuint {.importc: "LLVMGetDebugLocColumn", dynlib: LLVMLib.}

##
##  Add a function to a module under a specified name.
##
##  @see llvm::Function::Create()
##

proc addFunction*(
  m: ModuleRef, name: cstring, functionTy: TypeRef
): ValueRef {.importc: "LLVMAddFunction", dynlib: LLVMLib.}

##
##  Obtain a Function value from a Module by its name.
##
##  The returned value corresponds to a llvm::Function value.
##
##  @see llvm::Module::getFunction()
##

proc getNamedFunction*(
  m: ModuleRef, name: cstring
): ValueRef {.importc: "LLVMGetNamedFunction", dynlib: LLVMLib.}

##
##  Obtain a Function value from a Module by its name.
##
##  The returned value corresponds to a llvm::Function value.
##
##  @see llvm::Module::getFunction()
##

proc getNamedFunctionWithLength*(
  m: ModuleRef, name: cstring, length: csize_t
): ValueRef {.importc: "LLVMGetNamedFunctionWithLength", dynlib: LLVMLib.}

##
##  Obtain an iterator to the first Function in a Module.
##
##  @see llvm::Module::begin()
##

proc getFirstFunction*(
  m: ModuleRef
): ValueRef {.importc: "LLVMGetFirstFunction", dynlib: LLVMLib.}

##
##  Obtain an iterator to the last Function in a Module.
##
##  @see llvm::Module::end()
##

proc getLastFunction*(
  m: ModuleRef
): ValueRef {.importc: "LLVMGetLastFunction", dynlib: LLVMLib.}

##
##  Advance a Function iterator to the next Function.
##
##  Returns NULL if the iterator was already at the end and there are no more
##  functions.
##

proc getNextFunction*(
  fn: ValueRef
): ValueRef {.importc: "LLVMGetNextFunction", dynlib: LLVMLib.}

##
##  Decrement a Function iterator to the previous Function.
##
##  Returns NULL if the iterator was already at the beginning and there are
##  no previous functions.
##

proc getPreviousFunction*(
  fn: ValueRef
): ValueRef {.importc: "LLVMGetPreviousFunction", dynlib: LLVMLib.}

##  Deprecated: Use LLVMSetModuleInlineAsm2 instead.

proc setModuleInlineAsm*(
  m: ModuleRef, `asm`: cstring
) {.importc: "LLVMSetModuleInlineAsm", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCCoreType Types
##
##  Types represent the type of a value.
##
##  Types are associated with a context instance. The context internally
##  deduplicates types so there is only 1 instance of a specific type
##  alive at a time. In other words, a unique type is shared among all
##  consumers within a context.
##
##  A Type in the C API corresponds to llvm::Type.
##
##  Types have the following hierarchy:
##
##    types:
##      integer type
##      real type
##      function type
##      sequence types:
##        array type
##        pointer type
##        vector type
##      void type
##      label type
##      opaque type
##
##  @{
##
##
##  Obtain the enumerated type of a Type instance.
##
##  @see llvm::Type:getTypeID()
##

proc getTypeKind*(ty: TypeRef): TypeKind {.importc: "LLVMGetTypeKind", dynlib: LLVMLib.}
##
##  Whether the type has a known size.
##
##  Things that don't have a size are abstract types, labels, and void.a
##
##  @see llvm::Type::isSized()
##

proc typeIsSized*(ty: TypeRef): Bool {.importc: "LLVMTypeIsSized", dynlib: LLVMLib.}
##
##  Obtain the context to which this type instance is associated.
##
##  @see llvm::Type::getContext()
##

proc getTypeContext*(
  ty: TypeRef
): ContextRef {.importc: "LLVMGetTypeContext", dynlib: LLVMLib.}

##
##  Dump a representation of a type to stderr.
##
##  @see llvm::Type::dump()
##

proc dumpType*(val: TypeRef) {.importc: "LLVMDumpType", dynlib: LLVMLib.}
##
##  Return a string representation of the type. Use
##  LLVMDisposeMessage to free the string.
##
##  @see llvm::Type::print()
##

proc printTypeToString*(
  val: TypeRef
): cstring {.importc: "LLVMPrintTypeToString", dynlib: LLVMLib.}

##
##  @defgroup LLVMCCoreTypeInt Integer Types
##
##  Functions in this section operate on integer types.
##
##  @{
##
##
##  Obtain an integer type from a context with specified bit width.
##

proc int1TypeInContext*(
  c: ContextRef
): TypeRef {.importc: "LLVMInt1TypeInContext", dynlib: LLVMLib.}

proc int8TypeInContext*(
  c: ContextRef
): TypeRef {.importc: "LLVMInt8TypeInContext", dynlib: LLVMLib.}

proc int16TypeInContext*(
  c: ContextRef
): TypeRef {.importc: "LLVMInt16TypeInContext", dynlib: LLVMLib.}

proc int32TypeInContext*(
  c: ContextRef
): TypeRef {.importc: "LLVMInt32TypeInContext", dynlib: LLVMLib.}

proc int64TypeInContext*(
  c: ContextRef
): TypeRef {.importc: "LLVMInt64TypeInContext", dynlib: LLVMLib.}

proc int128TypeInContext*(
  c: ContextRef
): TypeRef {.importc: "LLVMInt128TypeInContext", dynlib: LLVMLib.}

proc intTypeInContext*(
  c: ContextRef, numBits: cuint
): TypeRef {.importc: "LLVMIntTypeInContext", dynlib: LLVMLib.}

##
##  Obtain an integer type from the global context with a specified bit
##  width.
##

proc int1Type*(): TypeRef {.importc: "LLVMInt1Type", dynlib: LLVMLib.}
proc int8Type*(): TypeRef {.importc: "LLVMInt8Type", dynlib: LLVMLib.}
proc int16Type*(): TypeRef {.importc: "LLVMInt16Type", dynlib: LLVMLib.}
proc int32Type*(): TypeRef {.importc: "LLVMInt32Type", dynlib: LLVMLib.}
proc int64Type*(): TypeRef {.importc: "LLVMInt64Type", dynlib: LLVMLib.}
proc int128Type*(): TypeRef {.importc: "LLVMInt128Type", dynlib: LLVMLib.}
proc intType*(numBits: cuint): TypeRef {.importc: "LLVMIntType", dynlib: LLVMLib.}
proc getIntTypeWidth*(
  integerTy: TypeRef
): cuint {.importc: "LLVMGetIntTypeWidth", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCCoreTypeFloat Floating Point Types
##
##  @{
##
##
##  Obtain a 16-bit floating point type from a context.
##

proc halfTypeInContext*(
  c: ContextRef
): TypeRef {.importc: "LLVMHalfTypeInContext", dynlib: LLVMLib.}

##
##  Obtain a 16-bit brain floating point type from a context.
##

proc bFloatTypeInContext*(
  c: ContextRef
): TypeRef {.importc: "LLVMBFloatTypeInContext", dynlib: LLVMLib.}

##
##  Obtain a 32-bit floating point type from a context.
##

proc floatTypeInContext*(
  c: ContextRef
): TypeRef {.importc: "LLVMFloatTypeInContext", dynlib: LLVMLib.}

##
##  Obtain a 64-bit floating point type from a context.
##

proc doubleTypeInContext*(
  c: ContextRef
): TypeRef {.importc: "LLVMDoubleTypeInContext", dynlib: LLVMLib.}

##
##  Obtain a 80-bit floating point type (X87) from a context.
##

proc x86FP80TypeInContext*(
  c: ContextRef
): TypeRef {.importc: "LLVMX86FP80TypeInContext", dynlib: LLVMLib.}

##
##  Obtain a 128-bit floating point type (112-bit mantissa) from a
##  context.
##

proc fP128TypeInContext*(
  c: ContextRef
): TypeRef {.importc: "LLVMFP128TypeInContext", dynlib: LLVMLib.}

##
##  Obtain a 128-bit floating point type (two 64-bits) from a context.
##

proc pPCFP128TypeInContext*(
  c: ContextRef
): TypeRef {.importc: "LLVMPPCFP128TypeInContext", dynlib: LLVMLib.}

##
##  Obtain a floating point type from the global context.
##
##  These map to the functions in this group of the same name.
##

proc halfType*(): TypeRef {.importc: "LLVMHalfType", dynlib: LLVMLib.}
proc bFloatType*(): TypeRef {.importc: "LLVMBFloatType", dynlib: LLVMLib.}
proc floatType*(): TypeRef {.importc: "LLVMFloatType", dynlib: LLVMLib.}
proc doubleType*(): TypeRef {.importc: "LLVMDoubleType", dynlib: LLVMLib.}
proc x86FP80Type*(): TypeRef {.importc: "LLVMX86FP80Type", dynlib: LLVMLib.}
proc fP128Type*(): TypeRef {.importc: "LLVMFP128Type", dynlib: LLVMLib.}
proc pPCFP128Type*(): TypeRef {.importc: "LLVMPPCFP128Type", dynlib: LLVMLib.}
##
##  @}
##
##
##  @defgroup LLVMCCoreTypeFunction Function Types
##
##  @{
##
##
##  Obtain a function type consisting of a specified signature.
##
##  The function is defined as a tuple of a return Type, a list of
##  parameter types, and whether the function is variadic.
##

proc functionType*(
  returnType: TypeRef, paramTypes: ptr TypeRef, paramCount: cuint, isVarArg: Bool
): TypeRef {.importc: "LLVMFunctionType", dynlib: LLVMLib.}

##
##  Returns whether a function type is variadic.
##

proc isFunctionVarArg*(
  functionTy: TypeRef
): Bool {.importc: "LLVMIsFunctionVarArg", dynlib: LLVMLib.}

##
##  Obtain the Type this function Type returns.
##

proc getReturnType*(
  functionTy: TypeRef
): TypeRef {.importc: "LLVMGetReturnType", dynlib: LLVMLib.}

##
##  Obtain the number of parameters this function accepts.
##

proc countParamTypes*(
  functionTy: TypeRef
): cuint {.importc: "LLVMCountParamTypes", dynlib: LLVMLib.}

##
##  Obtain the types of a function's parameters.
##
##  The Dest parameter should point to a pre-allocated array of
##  LLVMTypeRef at least LLVMCountParamTypes() large. On return, the
##  first LLVMCountParamTypes() entries in the array will be populated
##  with LLVMTypeRef instances.
##
##  @param FunctionTy The function type to operate on.
##  @param Dest Memory address of an array to be filled with result.
##

proc getParamTypes*(
  functionTy: TypeRef, dest: ptr TypeRef
) {.importc: "LLVMGetParamTypes", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCCoreTypeStruct Structure Types
##
##  These functions relate to LLVMTypeRef instances.
##
##  @see llvm::StructType
##
##  @{
##
##
##  Create a new structure type in a context.
##
##  A structure is specified by a list of inner elements/types and
##  whether these can be packed together.
##
##  @see llvm::StructType::create()
##

proc structTypeInContext*(
  c: ContextRef, elementTypes: ptr TypeRef, elementCount: cuint, packed: Bool
): TypeRef {.importc: "LLVMStructTypeInContext", dynlib: LLVMLib.}

##
##  Create a new structure type in the global context.
##
##  @see llvm::StructType::create()
##

proc structType*(
  elementTypes: ptr TypeRef, elementCount: cuint, packed: Bool
): TypeRef {.importc: "LLVMStructType", dynlib: LLVMLib.}

##
##  Create an empty structure in a context having a specified name.
##
##  @see llvm::StructType::create()
##

proc structCreateNamed*(
  c: ContextRef, name: cstring
): TypeRef {.importc: "LLVMStructCreateNamed", dynlib: LLVMLib.}

##
##  Obtain the name of a structure.
##
##  @see llvm::StructType::getName()
##

proc getStructName*(
  ty: TypeRef
): cstring {.importc: "LLVMGetStructName", dynlib: LLVMLib.}

##
##  Set the contents of a structure type.
##
##  @see llvm::StructType::setBody()
##

proc structSetBody*(
  structTy: TypeRef, elementTypes: ptr TypeRef, elementCount: cuint, packed: Bool
) {.importc: "LLVMStructSetBody", dynlib: LLVMLib.}

##
##  Get the number of elements defined inside the structure.
##
##  @see llvm::StructType::getNumElements()
##

proc countStructElementTypes*(
  structTy: TypeRef
): cuint {.importc: "LLVMCountStructElementTypes", dynlib: LLVMLib.}

##
##  Get the elements within a structure.
##
##  The function is passed the address of a pre-allocated array of
##  LLVMTypeRef at least LLVMCountStructElementTypes() long. After
##  invocation, this array will be populated with the structure's
##  elements. The objects in the destination array will have a lifetime
##  of the structure type itself, which is the lifetime of the context it
##  is contained in.
##

proc getStructElementTypes*(
  structTy: TypeRef, dest: ptr TypeRef
) {.importc: "LLVMGetStructElementTypes", dynlib: LLVMLib.}

##
##  Get the type of the element at a given index in the structure.
##
##  @see llvm::StructType::getTypeAtIndex()
##

proc structGetTypeAtIndex*(
  structTy: TypeRef, i: cuint
): TypeRef {.importc: "LLVMStructGetTypeAtIndex", dynlib: LLVMLib.}

##
##  Determine whether a structure is packed.
##
##  @see llvm::StructType::isPacked()
##

proc isPackedStruct*(
  structTy: TypeRef
): Bool {.importc: "LLVMIsPackedStruct", dynlib: LLVMLib.}

##
##  Determine whether a structure is opaque.
##
##  @see llvm::StructType::isOpaque()
##

proc isOpaqueStruct*(
  structTy: TypeRef
): Bool {.importc: "LLVMIsOpaqueStruct", dynlib: LLVMLib.}

##
##  Determine whether a structure is literal.
##
##  @see llvm::StructType::isLiteral()
##

proc isLiteralStruct*(
  structTy: TypeRef
): Bool {.importc: "LLVMIsLiteralStruct", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCCoreTypeSequential Sequential Types
##
##  Sequential types represents "arrays" of types. This is a super class
##  for array, vector, and pointer types.
##
##  @{
##
##
##  Obtain the element type of an array or vector type.
##
##  @see llvm::SequentialType::getElementType()
##

proc getElementType*(
  ty: TypeRef
): TypeRef {.importc: "LLVMGetElementType", dynlib: LLVMLib.}

##
##  Returns type's subtypes
##
##  @see llvm::Type::subtypes()
##

proc getSubtypes*(
  tp: TypeRef, arr: ptr TypeRef
) {.importc: "LLVMGetSubtypes", dynlib: LLVMLib.}

##
##   Return the number of types in the derived type.
##
##  @see llvm::Type::getNumContainedTypes()
##

proc getNumContainedTypes*(
  tp: TypeRef
): cuint {.importc: "LLVMGetNumContainedTypes", dynlib: LLVMLib.}

##
##  Create a fixed size array type that refers to a specific type.
##
##  The created type will exist in the context that its element type
##  exists in.
##
##  @deprecated LLVMArrayType is deprecated in favor of the API accurate
##  LLVMArrayType2
##  @see llvm::ArrayType::get()
##

proc arrayType*(
  elementType: TypeRef, elementCount: cuint
): TypeRef {.importc: "LLVMArrayType", dynlib: LLVMLib.}

##
##  Create a fixed size array type that refers to a specific type.
##
##  The created type will exist in the context that its element type
##  exists in.
##
##  @see llvm::ArrayType::get()
##

proc arrayType2*(
  elementType: TypeRef, elementCount: uint64
): TypeRef {.importc: "LLVMArrayType2", dynlib: LLVMLib.}

##
##  Obtain the length of an array type.
##
##  This only works on types that represent arrays.
##
##  @deprecated LLVMGetArrayLength is deprecated in favor of the API accurate
##  LLVMGetArrayLength2
##  @see llvm::ArrayType::getNumElements()
##

proc getArrayLength*(
  arrayTy: TypeRef
): cuint {.importc: "LLVMGetArrayLength", dynlib: LLVMLib.}

##
##  Obtain the length of an array type.
##
##  This only works on types that represent arrays.
##
##  @see llvm::ArrayType::getNumElements()
##

proc getArrayLength2*(
  arrayTy: TypeRef
): uint64 {.importc: "LLVMGetArrayLength2", dynlib: LLVMLib.}

##
##  Create a pointer type that points to a defined type.
##
##  The created type will exist in the context that its pointee type
##  exists in.
##
##  @see llvm::PointerType::get()
##

proc pointerType*(
  elementType: TypeRef, addressSpace: cuint
): TypeRef {.importc: "LLVMPointerType", dynlib: LLVMLib.}

##
##  Determine whether a pointer is opaque.
##
##  True if this is an instance of an opaque PointerType.
##
##  @see llvm::Type::isOpaquePointerTy()
##

proc pointerTypeIsOpaque*(
  ty: TypeRef
): Bool {.importc: "LLVMPointerTypeIsOpaque", dynlib: LLVMLib.}

##
##  Create an opaque pointer type in a context.
##
##  @see llvm::PointerType::get()
##

proc pointerTypeInContext*(
  c: ContextRef, addressSpace: cuint
): TypeRef {.importc: "LLVMPointerTypeInContext", dynlib: LLVMLib.}

##
##  Obtain the address space of a pointer type.
##
##  This only works on types that represent pointers.
##
##  @see llvm::PointerType::getAddressSpace()
##

proc getPointerAddressSpace*(
  pointerTy: TypeRef
): cuint {.importc: "LLVMGetPointerAddressSpace", dynlib: LLVMLib.}

##
##  Create a vector type that contains a defined type and has a specific
##  number of elements.
##
##  The created type will exist in the context thats its element type
##  exists in.
##
##  @see llvm::VectorType::get()
##

proc vectorType*(
  elementType: TypeRef, elementCount: cuint
): TypeRef {.importc: "LLVMVectorType", dynlib: LLVMLib.}

##
##  Create a vector type that contains a defined type and has a scalable
##  number of elements.
##
##  The created type will exist in the context thats its element type
##  exists in.
##
##  @see llvm::ScalableVectorType::get()
##

proc scalableVectorType*(
  elementType: TypeRef, elementCount: cuint
): TypeRef {.importc: "LLVMScalableVectorType", dynlib: LLVMLib.}

##
##  Obtain the (possibly scalable) number of elements in a vector type.
##
##  This only works on types that represent vectors (fixed or scalable).
##
##  @see llvm::VectorType::getNumElements()
##

proc getVectorSize*(
  vectorTy: TypeRef
): cuint {.importc: "LLVMGetVectorSize", dynlib: LLVMLib.}

##
##  Get the pointer value for the associated ConstantPtrAuth constant.
##
##  @see llvm::ConstantPtrAuth::getPointer
##

proc getConstantPtrAuthPointer*(
  ptrAuth: ValueRef
): ValueRef {.importc: "LLVMGetConstantPtrAuthPointer", dynlib: LLVMLib.}

##
##  Get the key value for the associated ConstantPtrAuth constant.
##
##  @see llvm::ConstantPtrAuth::getKey
##

proc getConstantPtrAuthKey*(
  ptrAuth: ValueRef
): ValueRef {.importc: "LLVMGetConstantPtrAuthKey", dynlib: LLVMLib.}

##
##  Get the discriminator value for the associated ConstantPtrAuth constant.
##
##  @see llvm::ConstantPtrAuth::getDiscriminator
##

proc getConstantPtrAuthDiscriminator*(
  ptrAuth: ValueRef
): ValueRef {.importc: "LLVMGetConstantPtrAuthDiscriminator", dynlib: LLVMLib.}

##
##  Get the address discriminator value for the associated ConstantPtrAuth
##  constant.
##
##  @see llvm::ConstantPtrAuth::getAddrDiscriminator
##

proc getConstantPtrAuthAddrDiscriminator*(
  ptrAuth: ValueRef
): ValueRef {.importc: "LLVMGetConstantPtrAuthAddrDiscriminator", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCCoreTypeOther Other Types
##
##  @{
##
##
##  Create a void type in a context.
##

proc voidTypeInContext*(
  c: ContextRef
): TypeRef {.importc: "LLVMVoidTypeInContext", dynlib: LLVMLib.}

##
##  Create a label type in a context.
##

proc labelTypeInContext*(
  c: ContextRef
): TypeRef {.importc: "LLVMLabelTypeInContext", dynlib: LLVMLib.}

##
##  Create a X86 AMX type in a context.
##

proc x86AMXTypeInContext*(
  c: ContextRef
): TypeRef {.importc: "LLVMX86AMXTypeInContext", dynlib: LLVMLib.}

##
##  Create a token type in a context.
##

proc tokenTypeInContext*(
  c: ContextRef
): TypeRef {.importc: "LLVMTokenTypeInContext", dynlib: LLVMLib.}

##
##  Create a metadata type in a context.
##

proc metadataTypeInContext*(
  c: ContextRef
): TypeRef {.importc: "LLVMMetadataTypeInContext", dynlib: LLVMLib.}

##
##  These are similar to the above functions except they operate on the
##  global context.
##

proc voidType*(): TypeRef {.importc: "LLVMVoidType", dynlib: LLVMLib.}
proc labelType*(): TypeRef {.importc: "LLVMLabelType", dynlib: LLVMLib.}
proc x86AMXType*(): TypeRef {.importc: "LLVMX86AMXType", dynlib: LLVMLib.}
##
##  Create a target extension type in LLVM context.
##

proc targetExtTypeInContext*(
  c: ContextRef,
  name: cstring,
  typeParams: ptr TypeRef,
  typeParamCount: cuint,
  intParams: ptr cuint,
  intParamCount: cuint,
): TypeRef {.importc: "LLVMTargetExtTypeInContext", dynlib: LLVMLib.}

##
##  Obtain the name for this target extension type.
##
##  @see llvm::TargetExtType::getName()
##

proc getTargetExtTypeName*(
  targetExtTy: TypeRef
): cstring {.importc: "LLVMGetTargetExtTypeName", dynlib: LLVMLib.}

##
##  Obtain the number of type parameters for this target extension type.
##
##  @see llvm::TargetExtType::getNumTypeParameters()
##

proc getTargetExtTypeNumTypeParams*(
  targetExtTy: TypeRef
): cuint {.importc: "LLVMGetTargetExtTypeNumTypeParams", dynlib: LLVMLib.}

##
##  Get the type parameter at the given index for the target extension type.
##
##  @see llvm::TargetExtType::getTypeParameter()
##

proc getTargetExtTypeTypeParam*(
  targetExtTy: TypeRef, idx: cuint
): TypeRef {.importc: "LLVMGetTargetExtTypeTypeParam", dynlib: LLVMLib.}

##
##  Obtain the number of int parameters for this target extension type.
##
##  @see llvm::TargetExtType::getNumIntParameters()
##

proc getTargetExtTypeNumIntParams*(
  targetExtTy: TypeRef
): cuint {.importc: "LLVMGetTargetExtTypeNumIntParams", dynlib: LLVMLib.}

##
##  Get the int parameter at the given index for the target extension type.
##
##  @see llvm::TargetExtType::getIntParameter()
##

proc getTargetExtTypeIntParam*(
  targetExtTy: TypeRef, idx: cuint
): cuint {.importc: "LLVMGetTargetExtTypeIntParam", dynlib: LLVMLib.}

##
##  @}
##
##
##  @}
##
##
##  @defgroup LLVMCCoreValues Values
##
##  The bulk of LLVM's object model consists of values, which comprise a very
##  rich type hierarchy.
##
##  LLVMValueRef essentially represents llvm::Value. There is a rich
##  hierarchy of classes within this type. Depending on the instance
##  obtained, not all APIs are available.
##
##  Callers can determine the type of an LLVMValueRef by calling the
##  LLVMIsA* family of functions (e.g. LLVMIsAArgument()). These
##  functions are defined by a macro, so it isn't obvious which are
##  available by looking at the Doxygen source code. Instead, look at the
##  source definition of LLVM_FOR_EACH_VALUE_SUBCLASS and note the list
##  of value names given. These value names also correspond to classes in
##  the llvm::Value hierarchy.
##
##  @{
##
##  Currently, clang-format tries to format the LLVM_FOR_EACH_VALUE_SUBCLASS
##  macro in a progressively-indented fashion, which is not desired
##  clang-format off

template for_Each_Value_Subclass*(`macro`: untyped): untyped =
  `macro`(argument)

## !!!Ignored construct:  macro ( BasicBlock ) macro ( InlineAsm ) macro ( User ) macro ( Constant ) macro ( BlockAddress ) macro ( ConstantAggregateZero ) macro ( ConstantArray ) macro ( ConstantDataSequential ) macro ( ConstantDataArray ) macro ( ConstantDataVector ) macro ( ConstantExpr ) macro ( ConstantFP ) macro ( ConstantInt ) macro ( ConstantPointerNull ) macro ( ConstantStruct ) macro ( ConstantTokenNone ) macro ( ConstantVector ) macro ( ConstantPtrAuth ) macro ( GlobalValue ) macro ( GlobalAlias ) macro ( GlobalObject ) macro ( Function ) macro ( GlobalVariable ) macro ( GlobalIFunc ) macro ( UndefValue ) macro ( PoisonValue ) macro ( Instruction ) macro ( UnaryOperator ) macro ( BinaryOperator ) macro ( CallInst ) macro ( IntrinsicInst ) macro ( DbgInfoIntrinsic ) macro ( DbgVariableIntrinsic ) macro ( DbgDeclareInst ) macro ( DbgLabelInst ) macro ( MemIntrinsic ) macro ( MemCpyInst ) macro ( MemMoveInst ) macro ( MemSetInst ) macro ( CmpInst ) macro ( FCmpInst ) macro ( ICmpInst ) macro ( ExtractElementInst ) macro ( GetElementPtrInst ) macro ( InsertElementInst ) macro ( InsertValueInst ) macro ( LandingPadInst ) macro ( PHINode ) macro ( SelectInst ) macro ( ShuffleVectorInst ) macro ( StoreInst ) macro ( BranchInst ) macro ( IndirectBrInst ) macro ( InvokeInst ) macro ( ReturnInst ) macro ( SwitchInst ) macro ( UnreachableInst ) macro ( ResumeInst ) macro ( CleanupReturnInst ) macro ( CatchReturnInst ) macro ( CatchSwitchInst ) macro ( CallBrInst ) macro ( FuncletPadInst ) macro ( CatchPadInst ) macro ( CleanupPadInst ) macro ( UnaryInstruction ) macro ( AllocaInst ) macro ( CastInst ) macro ( AddrSpaceCastInst ) macro ( BitCastInst ) macro ( FPExtInst ) macro ( FPToSIInst ) macro ( FPToUIInst ) macro ( FPTruncInst ) macro ( IntToPtrInst ) macro ( PtrToIntInst ) macro ( SExtInst ) macro ( SIToFPInst ) macro ( TruncInst ) macro ( UIToFPInst ) macro ( ZExtInst ) macro ( ExtractValueInst ) macro ( LoadInst ) macro ( VAArgInst ) macro ( FreezeInst ) macro ( AtomicCmpXchgInst ) macro ( AtomicRMWInst ) macro ( FenceInst ) [NewLine]  clang-format on
##  @defgroup LLVMCCoreValueGeneral General APIs
##
##  Functions in this section work on all LLVMValueRef instances,
##  regardless of their sub-type. They correspond to functions available
##  on llvm::Value.
##
##  @{
##
##  Obtain the type of a value.
##
##  @see llvm::Value::getType()
##  LLVMTypeRef LLVMTypeOf ( LLVMValueRef Val ) ;
## Error: expected ';'!!!

##
##  Obtain the enumerated type of a Value instance.
##
##  @see llvm::Value::getValueID()
##

proc getValueKind*(
  val: ValueRef
): ValueKind {.importc: "LLVMGetValueKind", dynlib: LLVMLib.}

##
##  Obtain the string name of a value.
##
##  @see llvm::Value::getName()
##

proc getValueName2*(
  val: ValueRef, length: ptr csize_t
): cstring {.importc: "LLVMGetValueName2", dynlib: LLVMLib.}

##
##  Set the string name of a value.
##
##  @see llvm::Value::setName()
##

proc setValueName2*(
  val: ValueRef, name: cstring, nameLen: csize_t
) {.importc: "LLVMSetValueName2", dynlib: LLVMLib.}

##
##  Dump a representation of a value to stderr.
##
##  @see llvm::Value::dump()
##

proc dumpValue*(val: ValueRef) {.importc: "LLVMDumpValue", dynlib: LLVMLib.}
##
##  Return a string representation of the value. Use
##  LLVMDisposeMessage to free the string.
##
##  @see llvm::Value::print()
##

proc printValueToString*(
  val: ValueRef
): cstring {.importc: "LLVMPrintValueToString", dynlib: LLVMLib.}

##
##  Obtain the context to which this value is associated.
##
##  @see llvm::Value::getContext()
##

proc getValueContext*(
  val: ValueRef
): ContextRef {.importc: "LLVMGetValueContext", dynlib: LLVMLib.}

##
##  Return a string representation of the DbgRecord. Use
##  LLVMDisposeMessage to free the string.
##
##  @see llvm::DbgRecord::print()
##

proc printDbgRecordToString*(
  record: DbgRecordRef
): cstring {.importc: "LLVMPrintDbgRecordToString", dynlib: LLVMLib.}

##
##  Replace all uses of a value with another one.
##
##  @see llvm::Value::replaceAllUsesWith()
##

proc replaceAllUsesWith*(
  oldVal: ValueRef, newVal: ValueRef
) {.importc: "LLVMReplaceAllUsesWith", dynlib: LLVMLib.}

##
##  Determine whether the specified value instance is constant.
##

proc isConstant*(val: ValueRef): Bool {.importc: "LLVMIsConstant", dynlib: LLVMLib.}
##
##  Determine whether a value instance is undefined.
##

proc isUndef*(val: ValueRef): Bool {.importc: "LLVMIsUndef", dynlib: LLVMLib.}
##
##  Determine whether a value instance is poisonous.
##

proc isPoison*(val: ValueRef): Bool {.importc: "LLVMIsPoison", dynlib: LLVMLib.}
##
##  Convert value instances between types.
##
##  Internally, an LLVMValueRef is "pinned" to a specific type. This
##  series of functions allows you to cast an instance to a specific
##  type.
##
##  If the cast is not valid for the specified type, NULL is returned.
##
##  @see llvm::dyn_cast_or_null<>
##

template declare_Value_Cast*(name: untyped): untyped =
  valueRef

## !!!Ignored construct:  LLVMIsA ## name ( LLVMValueRef Val ) ;
## Error: expected ';'!!!

## !!!Ignored construct:  [NewLine] LLVM_FOR_EACH_VALUE_SUBCLASS ( LLVM_DECLARE_VALUE_CAST ) LLVMValueRef LLVMIsAMDNode ( LLVMValueRef Val ) ;
## Error: did not expect [NewLine]!!!

proc isAValueAsMetadata*(
  val: ValueRef
): ValueRef {.importc: "LLVMIsAValueAsMetadata", dynlib: LLVMLib.}

proc isAMDString*(
  val: ValueRef
): ValueRef {.importc: "LLVMIsAMDString", dynlib: LLVMLib.}

##  Deprecated: Use LLVMGetValueName2 instead.

proc getValueName*(
  val: ValueRef
): cstring {.importc: "LLVMGetValueName", dynlib: LLVMLib.}

##  Deprecated: Use LLVMSetValueName2 instead.

proc setValueName*(
  val: ValueRef, name: cstring
) {.importc: "LLVMSetValueName", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCCoreValueUses Usage
##
##  This module defines functions that allow you to inspect the uses of a
##  LLVMValueRef.
##
##  It is possible to obtain an LLVMUseRef for any LLVMValueRef instance.
##  Each LLVMUseRef (which corresponds to a llvm::Use instance) holds a
##  llvm::User and llvm::Value.
##
##  @{
##
##
##  Obtain the first use of a value.
##
##  Uses are obtained in an iterator fashion. First, call this function
##  to obtain a reference to the first use. Then, call LLVMGetNextUse()
##  on that instance and all subsequently obtained instances until
##  LLVMGetNextUse() returns NULL.
##
##  @see llvm::Value::use_begin()
##

proc getFirstUse*(val: ValueRef): UseRef {.importc: "LLVMGetFirstUse", dynlib: LLVMLib.}
##
##  Obtain the next use of a value.
##
##  This effectively advances the iterator. It returns NULL if you are on
##  the final use and no more are available.
##

proc getNextUse*(u: UseRef): UseRef {.importc: "LLVMGetNextUse", dynlib: LLVMLib.}
##
##  Obtain the user value for a user.
##
##  The returned value corresponds to a llvm::User type.
##
##  @see llvm::Use::getUser()
##

proc getUser*(u: UseRef): ValueRef {.importc: "LLVMGetUser", dynlib: LLVMLib.}
##
##  Obtain the value this use corresponds to.
##
##  @see llvm::Use::get().
##

proc getUsedValue*(u: UseRef): ValueRef {.importc: "LLVMGetUsedValue", dynlib: LLVMLib.}
##
##  @}
##
##
##  @defgroup LLVMCCoreValueUser User value
##
##  Function in this group pertain to LLVMValueRef instances that descent
##  from llvm::User. This includes constants, instructions, and
##  operators.
##
##  @{
##
##
##  Obtain an operand at a specific index in a llvm::User value.
##
##  @see llvm::User::getOperand()
##

proc getOperand*(
  val: ValueRef, index: cuint
): ValueRef {.importc: "LLVMGetOperand", dynlib: LLVMLib.}

##
##  Obtain the use of an operand at a specific index in a llvm::User value.
##
##  @see llvm::User::getOperandUse()
##

proc getOperandUse*(
  val: ValueRef, index: cuint
): UseRef {.importc: "LLVMGetOperandUse", dynlib: LLVMLib.}

##
##  Set an operand at a specific index in a llvm::User value.
##
##  @see llvm::User::setOperand()
##

proc setOperand*(
  user: ValueRef, index: cuint, val: ValueRef
) {.importc: "LLVMSetOperand", dynlib: LLVMLib.}

##
##  Obtain the number of operands in a llvm::User value.
##
##  @see llvm::User::getNumOperands()
##

proc getNumOperands*(
  val: ValueRef
): cint {.importc: "LLVMGetNumOperands", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCCoreValueConstant Constants
##
##  This section contains APIs for interacting with LLVMValueRef that
##  correspond to llvm::Constant instances.
##
##  These functions will work for any LLVMValueRef in the llvm::Constant
##  class hierarchy.
##
##  @{
##
##
##  Obtain a constant value referring to the null instance of a type.
##
##  @see llvm::Constant::getNullValue()
##

proc constNull*(ty: TypeRef): ValueRef {.importc: "LLVMConstNull", dynlib: LLVMLib.}
##  all zeroes
##
##  Obtain a constant value referring to the instance of a type
##  consisting of all ones.
##
##  This is only valid for integer types.
##
##  @see llvm::Constant::getAllOnesValue()
##

proc constAllOnes*(
  ty: TypeRef
): ValueRef {.importc: "LLVMConstAllOnes", dynlib: LLVMLib.}

##
##  Obtain a constant value referring to an undefined value of a type.
##
##  @see llvm::UndefValue::get()
##

proc getUndef*(ty: TypeRef): ValueRef {.importc: "LLVMGetUndef", dynlib: LLVMLib.}
##
##  Obtain a constant value referring to a poison value of a type.
##
##  @see llvm::PoisonValue::get()
##

proc getPoison*(ty: TypeRef): ValueRef {.importc: "LLVMGetPoison", dynlib: LLVMLib.}
##
##  Determine whether a value instance is null.
##
##  @see llvm::Constant::isNullValue()
##

proc isNull*(val: ValueRef): Bool {.importc: "LLVMIsNull", dynlib: LLVMLib.}
##
##  Obtain a constant that is a constant pointer pointing to NULL for a
##  specified type.
##

proc constPointerNull*(
  ty: TypeRef
): ValueRef {.importc: "LLVMConstPointerNull", dynlib: LLVMLib.}

##
##  @defgroup LLVMCCoreValueConstantScalar Scalar constants
##
##  Functions in this group model LLVMValueRef instances that correspond
##  to constants referring to scalar types.
##
##  For integer types, the LLVMTypeRef parameter should correspond to a
##  llvm::IntegerType instance and the returned LLVMValueRef will
##  correspond to a llvm::ConstantInt.
##
##  For floating point types, the LLVMTypeRef returned corresponds to a
##  llvm::ConstantFP.
##
##  @{
##
##
##  Obtain a constant value for an integer type.
##
##  The returned value corresponds to a llvm::ConstantInt.
##
##  @see llvm::ConstantInt::get()
##
##  @param IntTy Integer type to obtain value of.
##  @param N The value the returned instance should refer to.
##  @param SignExtend Whether to sign extend the produced value.
##

proc constInt*(
  intTy: TypeRef, n: culonglong, signExtend: Bool
): ValueRef {.importc: "LLVMConstInt", dynlib: LLVMLib.}

##
##  Obtain a constant value for an integer of arbitrary precision.
##
##  @see llvm::ConstantInt::get()
##

proc constIntOfArbitraryPrecision*(
  intTy: TypeRef, numWords: cuint, words: ptr uint64
): ValueRef {.importc: "LLVMConstIntOfArbitraryPrecision", dynlib: LLVMLib.}

##
##  Obtain a constant value for an integer parsed from a string.
##
##  A similar API, LLVMConstIntOfStringAndSize is also available. If the
##  string's length is available, it is preferred to call that function
##  instead.
##
##  @see llvm::ConstantInt::get()
##

proc constIntOfString*(
  intTy: TypeRef, text: cstring, radix: uint8
): ValueRef {.importc: "LLVMConstIntOfString", dynlib: LLVMLib.}

##
##  Obtain a constant value for an integer parsed from a string with
##  specified length.
##
##  @see llvm::ConstantInt::get()
##

proc constIntOfStringAndSize*(
  intTy: TypeRef, text: cstring, sLen: cuint, radix: uint8
): ValueRef {.importc: "LLVMConstIntOfStringAndSize", dynlib: LLVMLib.}

##
##  Obtain a constant value referring to a double floating point value.
##

proc constReal*(
  realTy: TypeRef, n: cdouble
): ValueRef {.importc: "LLVMConstReal", dynlib: LLVMLib.}

##
##  Obtain a constant for a floating point value parsed from a string.
##
##  A similar API, LLVMConstRealOfStringAndSize is also available. It
##  should be used if the input string's length is known.
##

proc constRealOfString*(
  realTy: TypeRef, text: cstring
): ValueRef {.importc: "LLVMConstRealOfString", dynlib: LLVMLib.}

##
##  Obtain a constant for a floating point value parsed from a string.
##

proc constRealOfStringAndSize*(
  realTy: TypeRef, text: cstring, sLen: cuint
): ValueRef {.importc: "LLVMConstRealOfStringAndSize", dynlib: LLVMLib.}

##
##  Obtain the zero extended value for an integer constant value.
##
##  @see llvm::ConstantInt::getZExtValue()
##

proc constIntGetZExtValue*(
  constantVal: ValueRef
): culonglong {.importc: "LLVMConstIntGetZExtValue", dynlib: LLVMLib.}

##
##  Obtain the sign extended value for an integer constant value.
##
##  @see llvm::ConstantInt::getSExtValue()
##

proc constIntGetSExtValue*(
  constantVal: ValueRef
): clonglong {.importc: "LLVMConstIntGetSExtValue", dynlib: LLVMLib.}

##
##  Obtain the double value for an floating point constant value.
##  losesInfo indicates if some precision was lost in the conversion.
##
##  @see llvm::ConstantFP::getDoubleValue
##

proc constRealGetDouble*(
  constantVal: ValueRef, losesInfo: ptr Bool
): cdouble {.importc: "LLVMConstRealGetDouble", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCCoreValueConstantComposite Composite Constants
##
##  Functions in this group operate on composite constants.
##
##  @{
##
##
##  Create a ConstantDataSequential and initialize it with a string.
##
##  @deprecated LLVMConstStringInContext is deprecated in favor of the API
##  accurate LLVMConstStringInContext2
##  @see llvm::ConstantDataArray::getString()
##

proc constStringInContext*(
  c: ContextRef, str: cstring, length: cuint, dontNullTerminate: Bool
): ValueRef {.importc: "LLVMConstStringInContext", dynlib: LLVMLib.}

##
##  Create a ConstantDataSequential and initialize it with a string.
##
##  @see llvm::ConstantDataArray::getString()
##

proc constStringInContext2*(
  c: ContextRef, str: cstring, length: csize_t, dontNullTerminate: Bool
): ValueRef {.importc: "LLVMConstStringInContext2", dynlib: LLVMLib.}

##
##  Create a ConstantDataSequential with string content in the global context.
##
##  This is the same as LLVMConstStringInContext except it operates on the
##  global context.
##
##  @see LLVMConstStringInContext()
##  @see llvm::ConstantDataArray::getString()
##

proc constString*(
  str: cstring, length: cuint, dontNullTerminate: Bool
): ValueRef {.importc: "LLVMConstString", dynlib: LLVMLib.}

##
##  Returns true if the specified constant is an array of i8.
##
##  @see ConstantDataSequential::getAsString()
##

proc isConstantString*(
  c: ValueRef
): Bool {.importc: "LLVMIsConstantString", dynlib: LLVMLib.}

##
##  Get the given constant data sequential as a string.
##
##  @see ConstantDataSequential::getAsString()
##

proc getAsString*(
  c: ValueRef, length: ptr csize_t
): cstring {.importc: "LLVMGetAsString", dynlib: LLVMLib.}

##
##  Create an anonymous ConstantStruct with the specified values.
##
##  @see llvm::ConstantStruct::getAnon()
##

proc constStructInContext*(
  c: ContextRef, constantVals: ptr ValueRef, count: cuint, packed: Bool
): ValueRef {.importc: "LLVMConstStructInContext", dynlib: LLVMLib.}

##
##  Create a ConstantStruct in the global Context.
##
##  This is the same as LLVMConstStructInContext except it operates on the
##  global Context.
##
##  @see LLVMConstStructInContext()
##

proc constStruct*(
  constantVals: ptr ValueRef, count: cuint, packed: Bool
): ValueRef {.importc: "LLVMConstStruct", dynlib: LLVMLib.}

##
##  Create a ConstantArray from values.
##
##  @deprecated LLVMConstArray is deprecated in favor of the API accurate
##  LLVMConstArray2
##  @see llvm::ConstantArray::get()
##

proc constArray*(
  elementTy: TypeRef, constantVals: ptr ValueRef, length: cuint
): ValueRef {.importc: "LLVMConstArray", dynlib: LLVMLib.}

##
##  Create a ConstantArray from values.
##
##  @see llvm::ConstantArray::get()
##

proc constArray2*(
  elementTy: TypeRef, constantVals: ptr ValueRef, length: uint64
): ValueRef {.importc: "LLVMConstArray2", dynlib: LLVMLib.}

##
##  Create a non-anonymous ConstantStruct from values.
##
##  @see llvm::ConstantStruct::get()
##

proc constNamedStruct*(
  structTy: TypeRef, constantVals: ptr ValueRef, count: cuint
): ValueRef {.importc: "LLVMConstNamedStruct", dynlib: LLVMLib.}

##
##  Get element of a constant aggregate (struct, array or vector) at the
##  specified index. Returns null if the index is out of range, or it's not
##  possible to determine the element (e.g., because the constant is a
##  constant expression.)
##
##  @see llvm::Constant::getAggregateElement()
##

proc getAggregateElement*(
  c: ValueRef, idx: cuint
): ValueRef {.importc: "LLVMGetAggregateElement", dynlib: LLVMLib.}

##
##  Get an element at specified index as a constant.
##
##  @see ConstantDataSequential::getElementAsConstant()
##

#attribute_C_Deprecated(
#  valueRef,
#  getElementAsConstant(valueRef, c, unsigned, idx),
#  "Use LLVMGetAggregateElement instead",
#)
##
##  Create a ConstantVector from values.
##
##  @see llvm::ConstantVector::get()
##

proc constVector*(
  scalarConstantVals: ptr ValueRef, size: cuint
): ValueRef {.importc: "LLVMConstVector", dynlib: LLVMLib.}

##
##  Create a ConstantPtrAuth constant with the given values.
##
##  @see llvm::ConstantPtrAuth::get()
##

proc constantPtrAuth*(
  `ptr`: ValueRef, key: ValueRef, disc: ValueRef, addrDisc: ValueRef
): ValueRef {.importc: "LLVMConstantPtrAuth", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCCoreValueConstantExpressions Constant Expressions
##
##  Functions in this group correspond to APIs on llvm::ConstantExpr.
##
##  @see llvm::ConstantExpr.
##
##  @{
##

proc getConstOpcode*(
  constantVal: ValueRef
): Opcode {.importc: "LLVMGetConstOpcode", dynlib: LLVMLib.}

proc alignOf*(ty: TypeRef): ValueRef {.importc: "LLVMAlignOf", dynlib: LLVMLib.}
proc sizeOfX*(ty: TypeRef): ValueRef {.importc: "LLVMSizeOf", dynlib: LLVMLib.}
proc constNeg*(
  constantVal: ValueRef
): ValueRef {.importc: "LLVMConstNeg", dynlib: LLVMLib.}

proc constNSWNeg*(
  constantVal: ValueRef
): ValueRef {.importc: "LLVMConstNSWNeg", dynlib: LLVMLib.}

proc constNot*(
  constantVal: ValueRef
): ValueRef {.importc: "LLVMConstNot", dynlib: LLVMLib.}

proc constAdd*(
  lHSConstant: ValueRef, rHSConstant: ValueRef
): ValueRef {.importc: "LLVMConstAdd", dynlib: LLVMLib.}

proc constNSWAdd*(
  lHSConstant: ValueRef, rHSConstant: ValueRef
): ValueRef {.importc: "LLVMConstNSWAdd", dynlib: LLVMLib.}

proc constNUWAdd*(
  lHSConstant: ValueRef, rHSConstant: ValueRef
): ValueRef {.importc: "LLVMConstNUWAdd", dynlib: LLVMLib.}

proc constSub*(
  lHSConstant: ValueRef, rHSConstant: ValueRef
): ValueRef {.importc: "LLVMConstSub", dynlib: LLVMLib.}

proc constNSWSub*(
  lHSConstant: ValueRef, rHSConstant: ValueRef
): ValueRef {.importc: "LLVMConstNSWSub", dynlib: LLVMLib.}

proc constNUWSub*(
  lHSConstant: ValueRef, rHSConstant: ValueRef
): ValueRef {.importc: "LLVMConstNUWSub", dynlib: LLVMLib.}

proc constMul*(
  lHSConstant: ValueRef, rHSConstant: ValueRef
): ValueRef {.importc: "LLVMConstMul", dynlib: LLVMLib.}

proc constNSWMul*(
  lHSConstant: ValueRef, rHSConstant: ValueRef
): ValueRef {.importc: "LLVMConstNSWMul", dynlib: LLVMLib.}

proc constNUWMul*(
  lHSConstant: ValueRef, rHSConstant: ValueRef
): ValueRef {.importc: "LLVMConstNUWMul", dynlib: LLVMLib.}

proc constXor*(
  lHSConstant: ValueRef, rHSConstant: ValueRef
): ValueRef {.importc: "LLVMConstXor", dynlib: LLVMLib.}

proc constGEP2*(
  ty: TypeRef, constantVal: ValueRef, constantIndices: ptr ValueRef, numIndices: cuint
): ValueRef {.importc: "LLVMConstGEP2", dynlib: LLVMLib.}

proc constInBoundsGEP2*(
  ty: TypeRef, constantVal: ValueRef, constantIndices: ptr ValueRef, numIndices: cuint
): ValueRef {.importc: "LLVMConstInBoundsGEP2", dynlib: LLVMLib.}

##
##  Creates a constant GetElementPtr expression. Similar to LLVMConstGEP2, but
##  allows specifying the no-wrap flags.
##
##  @see llvm::ConstantExpr::getGetElementPtr()
##

proc constGEPWithNoWrapFlags*(
  ty: TypeRef,
  constantVal: ValueRef,
  constantIndices: ptr ValueRef,
  numIndices: cuint,
  noWrapFlags: GEPNoWrapFlags,
): ValueRef {.importc: "LLVMConstGEPWithNoWrapFlags", dynlib: LLVMLib.}

proc constTrunc*(
  constantVal: ValueRef, toType: TypeRef
): ValueRef {.importc: "LLVMConstTrunc", dynlib: LLVMLib.}

proc constPtrToInt*(
  constantVal: ValueRef, toType: TypeRef
): ValueRef {.importc: "LLVMConstPtrToInt", dynlib: LLVMLib.}

proc constIntToPtr*(
  constantVal: ValueRef, toType: TypeRef
): ValueRef {.importc: "LLVMConstIntToPtr", dynlib: LLVMLib.}

proc constBitCast*(
  constantVal: ValueRef, toType: TypeRef
): ValueRef {.importc: "LLVMConstBitCast", dynlib: LLVMLib.}

proc constAddrSpaceCast*(
  constantVal: ValueRef, toType: TypeRef
): ValueRef {.importc: "LLVMConstAddrSpaceCast", dynlib: LLVMLib.}

proc constTruncOrBitCast*(
  constantVal: ValueRef, toType: TypeRef
): ValueRef {.importc: "LLVMConstTruncOrBitCast", dynlib: LLVMLib.}

proc constPointerCast*(
  constantVal: ValueRef, toType: TypeRef
): ValueRef {.importc: "LLVMConstPointerCast", dynlib: LLVMLib.}

proc constExtractElement*(
  vectorConstant: ValueRef, indexConstant: ValueRef
): ValueRef {.importc: "LLVMConstExtractElement", dynlib: LLVMLib.}

proc constInsertElement*(
  vectorConstant: ValueRef, elementValueConstant: ValueRef, indexConstant: ValueRef
): ValueRef {.importc: "LLVMConstInsertElement", dynlib: LLVMLib.}

proc constShuffleVector*(
  vectorAConstant: ValueRef, vectorBConstant: ValueRef, maskConstant: ValueRef
): ValueRef {.importc: "LLVMConstShuffleVector", dynlib: LLVMLib.}

proc blockAddress*(
  f: ValueRef, bb: BasicBlockRef
): ValueRef {.importc: "LLVMBlockAddress", dynlib: LLVMLib.}

##
##  Gets the function associated with a given BlockAddress constant value.
##

proc getBlockAddressFunction*(
  blockAddr: ValueRef
): ValueRef {.importc: "LLVMGetBlockAddressFunction", dynlib: LLVMLib.}

##
##  Gets the basic block associated with a given BlockAddress constant value.
##

proc getBlockAddressBasicBlock*(
  blockAddr: ValueRef
): BasicBlockRef {.importc: "LLVMGetBlockAddressBasicBlock", dynlib: LLVMLib.}

##  Deprecated: Use LLVMGetInlineAsm instead.

proc constInlineAsm*(
  ty: TypeRef,
  asmString: cstring,
  constraints: cstring,
  hasSideEffects: Bool,
  isAlignStack: Bool,
): ValueRef {.importc: "LLVMConstInlineAsm", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCCoreValueConstantGlobals Global Values
##
##  This group contains functions that operate on global values. Functions in
##  this group relate to functions in the llvm::GlobalValue class tree.
##
##  @see llvm::GlobalValue
##
##  @{
##

proc getGlobalParent*(
  global: ValueRef
): ModuleRef {.importc: "LLVMGetGlobalParent", dynlib: LLVMLib.}

proc isDeclaration*(
  global: ValueRef
): Bool {.importc: "LLVMIsDeclaration", dynlib: LLVMLib.}

proc getLinkage*(
  global: ValueRef
): Linkage {.importc: "LLVMGetLinkage", dynlib: LLVMLib.}

proc setLinkage*(
  global: ValueRef, linkage: Linkage
) {.importc: "LLVMSetLinkage", dynlib: LLVMLib.}

proc getSection*(
  global: ValueRef
): cstring {.importc: "LLVMGetSection", dynlib: LLVMLib.}

proc setSection*(
  global: ValueRef, section: cstring
) {.importc: "LLVMSetSection", dynlib: LLVMLib.}

proc getVisibility*(
  global: ValueRef
): Visibility {.importc: "LLVMGetVisibility", dynlib: LLVMLib.}

proc setVisibility*(
  global: ValueRef, viz: Visibility
) {.importc: "LLVMSetVisibility", dynlib: LLVMLib.}

proc getDLLStorageClass*(
  global: ValueRef
): DLLStorageClass {.importc: "LLVMGetDLLStorageClass", dynlib: LLVMLib.}

proc setDLLStorageClass*(
  global: ValueRef, class: DLLStorageClass
) {.importc: "LLVMSetDLLStorageClass", dynlib: LLVMLib.}

proc getUnnamedAddress*(
  global: ValueRef
): UnnamedAddr {.importc: "LLVMGetUnnamedAddress", dynlib: LLVMLib.}

proc setUnnamedAddress*(
  global: ValueRef, unnamedAddr: UnnamedAddr
) {.importc: "LLVMSetUnnamedAddress", dynlib: LLVMLib.}

##
##  Returns the "value type" of a global value.  This differs from the formal
##  type of a global value which is always a pointer type.
##
##  @see llvm::GlobalValue::getValueType()
##

proc globalGetValueType*(
  global: ValueRef
): TypeRef {.importc: "LLVMGlobalGetValueType", dynlib: LLVMLib.}

##  Deprecated: Use LLVMGetUnnamedAddress instead.

proc hasUnnamedAddr*(
  global: ValueRef
): Bool {.importc: "LLVMHasUnnamedAddr", dynlib: LLVMLib.}

##  Deprecated: Use LLVMSetUnnamedAddress instead.

proc setUnnamedAddr*(
  global: ValueRef, hasUnnamedAddr: Bool
) {.importc: "LLVMSetUnnamedAddr", dynlib: LLVMLib.}

##
##  @defgroup LLVMCCoreValueWithAlignment Values with alignment
##
##  Functions in this group only apply to values with alignment, i.e.
##  global variables, load and store instructions.
##
##
##  Obtain the preferred alignment of the value.
##  @see llvm::AllocaInst::getAlignment()
##  @see llvm::LoadInst::getAlignment()
##  @see llvm::StoreInst::getAlignment()
##  @see llvm::AtomicRMWInst::setAlignment()
##  @see llvm::AtomicCmpXchgInst::setAlignment()
##  @see llvm::GlobalValue::getAlignment()
##

proc getAlignment*(v: ValueRef): cuint {.importc: "LLVMGetAlignment", dynlib: LLVMLib.}
##
##  Set the preferred alignment of the value.
##  @see llvm::AllocaInst::setAlignment()
##  @see llvm::LoadInst::setAlignment()
##  @see llvm::StoreInst::setAlignment()
##  @see llvm::AtomicRMWInst::setAlignment()
##  @see llvm::AtomicCmpXchgInst::setAlignment()
##  @see llvm::GlobalValue::setAlignment()
##

proc setAlignment*(
  v: ValueRef, bytes: cuint
) {.importc: "LLVMSetAlignment", dynlib: LLVMLib.}

##
##  Sets a metadata attachment, erasing the existing metadata attachment if
##  it already exists for the given kind.
##
##  @see llvm::GlobalObject::setMetadata()
##

proc globalSetMetadata*(
  global: ValueRef, kind: cuint, md: MetadataRef
) {.importc: "LLVMGlobalSetMetadata", dynlib: LLVMLib.}

##
##  Erases a metadata attachment of the given kind if it exists.
##
##  @see llvm::GlobalObject::eraseMetadata()
##

proc globalEraseMetadata*(
  global: ValueRef, kind: cuint
) {.importc: "LLVMGlobalEraseMetadata", dynlib: LLVMLib.}

##
##  Removes all metadata attachments from this value.
##
##  @see llvm::GlobalObject::clearMetadata()
##

proc globalClearMetadata*(
  global: ValueRef
) {.importc: "LLVMGlobalClearMetadata", dynlib: LLVMLib.}

##
##  Retrieves an array of metadata entries representing the metadata attached to
##  this value. The caller is responsible for freeing this array by calling
##  \c LLVMDisposeValueMetadataEntries.
##
##  @see llvm::GlobalObject::getAllMetadata()
##

proc globalCopyAllMetadata*(
  value: ValueRef, numEntries: ptr csize_t
): ptr ValueMetadataEntry {.importc: "LLVMGlobalCopyAllMetadata", dynlib: LLVMLib.}

##
##  Destroys value metadata entries.
##

proc disposeValueMetadataEntries*(
  entries: ptr ValueMetadataEntry
) {.importc: "LLVMDisposeValueMetadataEntries", dynlib: LLVMLib.}

##
##  Returns the kind of a value metadata entry at a specific index.
##

proc valueMetadataEntriesGetKind*(
  entries: ptr ValueMetadataEntry, index: cuint
): cuint {.importc: "LLVMValueMetadataEntriesGetKind", dynlib: LLVMLib.}

##
##  Returns the underlying metadata node of a value metadata entry at a
##  specific index.
##

proc valueMetadataEntriesGetMetadata*(
  entries: ptr ValueMetadataEntry, index: cuint
): MetadataRef {.importc: "LLVMValueMetadataEntriesGetMetadata", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCoreValueConstantGlobalVariable Global Variables
##
##  This group contains functions that operate on global variable values.
##
##  @see llvm::GlobalVariable
##
##  @{
##

proc addGlobal*(
  m: ModuleRef, ty: TypeRef, name: cstring
): ValueRef {.importc: "LLVMAddGlobal", dynlib: LLVMLib.}

proc addGlobalInAddressSpace*(
  m: ModuleRef, ty: TypeRef, name: cstring, addressSpace: cuint
): ValueRef {.importc: "LLVMAddGlobalInAddressSpace", dynlib: LLVMLib.}

proc getNamedGlobal*(
  m: ModuleRef, name: cstring
): ValueRef {.importc: "LLVMGetNamedGlobal", dynlib: LLVMLib.}

proc getNamedGlobalWithLength*(
  m: ModuleRef, name: cstring, length: csize_t
): ValueRef {.importc: "LLVMGetNamedGlobalWithLength", dynlib: LLVMLib.}

proc getFirstGlobal*(
  m: ModuleRef
): ValueRef {.importc: "LLVMGetFirstGlobal", dynlib: LLVMLib.}

proc getLastGlobal*(
  m: ModuleRef
): ValueRef {.importc: "LLVMGetLastGlobal", dynlib: LLVMLib.}

proc getNextGlobal*(
  globalVar: ValueRef
): ValueRef {.importc: "LLVMGetNextGlobal", dynlib: LLVMLib.}

proc getPreviousGlobal*(
  globalVar: ValueRef
): ValueRef {.importc: "LLVMGetPreviousGlobal", dynlib: LLVMLib.}

proc deleteGlobal*(globalVar: ValueRef) {.importc: "LLVMDeleteGlobal", dynlib: LLVMLib.}
proc getInitializer*(
  globalVar: ValueRef
): ValueRef {.importc: "LLVMGetInitializer", dynlib: LLVMLib.}

proc setInitializer*(
  globalVar: ValueRef, constantVal: ValueRef
) {.importc: "LLVMSetInitializer", dynlib: LLVMLib.}

proc isThreadLocal*(
  globalVar: ValueRef
): Bool {.importc: "LLVMIsThreadLocal", dynlib: LLVMLib.}

proc setThreadLocal*(
  globalVar: ValueRef, isThreadLocal: Bool
) {.importc: "LLVMSetThreadLocal", dynlib: LLVMLib.}

proc isGlobalConstant*(
  globalVar: ValueRef
): Bool {.importc: "LLVMIsGlobalConstant", dynlib: LLVMLib.}

proc setGlobalConstant*(
  globalVar: ValueRef, isConstant: Bool
) {.importc: "LLVMSetGlobalConstant", dynlib: LLVMLib.}

proc getThreadLocalMode*(
  globalVar: ValueRef
): ThreadLocalMode {.importc: "LLVMGetThreadLocalMode", dynlib: LLVMLib.}

proc setThreadLocalMode*(
  globalVar: ValueRef, mode: ThreadLocalMode
) {.importc: "LLVMSetThreadLocalMode", dynlib: LLVMLib.}

proc isExternallyInitialized*(
  globalVar: ValueRef
): Bool {.importc: "LLVMIsExternallyInitialized", dynlib: LLVMLib.}

proc setExternallyInitialized*(
  globalVar: ValueRef, isExtInit: Bool
) {.importc: "LLVMSetExternallyInitialized", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCoreValueConstantGlobalAlias Global Aliases
##
##  This group contains function that operate on global alias values.
##
##  @see llvm::GlobalAlias
##
##  @{
##
##
##  Add a GlobalAlias with the given value type, address space and aliasee.
##
##  @see llvm::GlobalAlias::create()
##

proc addAlias2*(
  m: ModuleRef, valueTy: TypeRef, addrSpace: cuint, aliasee: ValueRef, name: cstring
): ValueRef {.importc: "LLVMAddAlias2", dynlib: LLVMLib.}

##
##  Obtain a GlobalAlias value from a Module by its name.
##
##  The returned value corresponds to a llvm::GlobalAlias value.
##
##  @see llvm::Module::getNamedAlias()
##

proc getNamedGlobalAlias*(
  m: ModuleRef, name: cstring, nameLen: csize_t
): ValueRef {.importc: "LLVMGetNamedGlobalAlias", dynlib: LLVMLib.}

##
##  Obtain an iterator to the first GlobalAlias in a Module.
##
##  @see llvm::Module::alias_begin()
##

proc getFirstGlobalAlias*(
  m: ModuleRef
): ValueRef {.importc: "LLVMGetFirstGlobalAlias", dynlib: LLVMLib.}

##
##  Obtain an iterator to the last GlobalAlias in a Module.
##
##  @see llvm::Module::alias_end()
##

proc getLastGlobalAlias*(
  m: ModuleRef
): ValueRef {.importc: "LLVMGetLastGlobalAlias", dynlib: LLVMLib.}

##
##  Advance a GlobalAlias iterator to the next GlobalAlias.
##
##  Returns NULL if the iterator was already at the end and there are no more
##  global aliases.
##

proc getNextGlobalAlias*(
  ga: ValueRef
): ValueRef {.importc: "LLVMGetNextGlobalAlias", dynlib: LLVMLib.}

##
##  Decrement a GlobalAlias iterator to the previous GlobalAlias.
##
##  Returns NULL if the iterator was already at the beginning and there are
##  no previous global aliases.
##

proc getPreviousGlobalAlias*(
  ga: ValueRef
): ValueRef {.importc: "LLVMGetPreviousGlobalAlias", dynlib: LLVMLib.}

##
##  Retrieve the target value of an alias.
##

proc aliasGetAliasee*(
  alias: ValueRef
): ValueRef {.importc: "LLVMAliasGetAliasee", dynlib: LLVMLib.}

##
##  Set the target value of an alias.
##

proc aliasSetAliasee*(
  alias: ValueRef, aliasee: ValueRef
) {.importc: "LLVMAliasSetAliasee", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCCoreValueFunction Function values
##
##  Functions in this group operate on LLVMValueRef instances that
##  correspond to llvm::Function instances.
##
##  @see llvm::Function
##
##  @{
##
##
##  Remove a function from its containing module and deletes it.
##
##  @see llvm::Function::eraseFromParent()
##

proc deleteFunction*(fn: ValueRef) {.importc: "LLVMDeleteFunction", dynlib: LLVMLib.}
##
##  Check whether the given function has a personality function.
##
##  @see llvm::Function::hasPersonalityFn()
##

proc hasPersonalityFn*(
  fn: ValueRef
): Bool {.importc: "LLVMHasPersonalityFn", dynlib: LLVMLib.}

##
##  Obtain the personality function attached to the function.
##
##  @see llvm::Function::getPersonalityFn()
##

proc getPersonalityFn*(
  fn: ValueRef
): ValueRef {.importc: "LLVMGetPersonalityFn", dynlib: LLVMLib.}

##
##  Set the personality function attached to the function.
##
##  @see llvm::Function::setPersonalityFn()
##

proc setPersonalityFn*(
  fn: ValueRef, personalityFn: ValueRef
) {.importc: "LLVMSetPersonalityFn", dynlib: LLVMLib.}

##
##  Obtain the intrinsic ID number which matches the given function name.
##
##  @see llvm::Intrinsic::lookupIntrinsicID()
##

proc lookupIntrinsicID*(
  name: cstring, nameLen: csize_t
): cuint {.importc: "LLVMLookupIntrinsicID", dynlib: LLVMLib.}

##
##  Obtain the ID number from a function instance.
##
##  @see llvm::Function::getIntrinsicID()
##

proc getIntrinsicID*(
  fn: ValueRef
): cuint {.importc: "LLVMGetIntrinsicID", dynlib: LLVMLib.}

##
##  Get or insert the declaration of an intrinsic.  For overloaded intrinsics,
##  parameter types must be provided to uniquely identify an overload.
##
##  @see llvm::Intrinsic::getOrInsertDeclaration()
##

proc getIntrinsicDeclaration*(
  `mod`: ModuleRef, id: cuint, paramTypes: ptr TypeRef, paramCount: csize_t
): ValueRef {.importc: "LLVMGetIntrinsicDeclaration", dynlib: LLVMLib.}

##
##  Retrieves the type of an intrinsic.  For overloaded intrinsics, parameter
##  types must be provided to uniquely identify an overload.
##
##  @see llvm::Intrinsic::getType()
##

proc intrinsicGetType*(
  ctx: ContextRef, id: cuint, paramTypes: ptr TypeRef, paramCount: csize_t
): TypeRef {.importc: "LLVMIntrinsicGetType", dynlib: LLVMLib.}

##
##  Retrieves the name of an intrinsic.
##
##  @see llvm::Intrinsic::getName()
##

proc intrinsicGetName*(
  id: cuint, nameLength: ptr csize_t
): cstring {.importc: "LLVMIntrinsicGetName", dynlib: LLVMLib.}

##  Deprecated: Use LLVMIntrinsicCopyOverloadedName2 instead.

proc intrinsicCopyOverloadedName*(
  id: cuint, paramTypes: ptr TypeRef, paramCount: csize_t, nameLength: ptr csize_t
): cstring {.importc: "LLVMIntrinsicCopyOverloadedName", dynlib: LLVMLib.}

##
##  Copies the name of an overloaded intrinsic identified by a given list of
##  parameter types.
##
##  Unlike LLVMIntrinsicGetName, the caller is responsible for freeing the
##  returned string.
##
##  This version also supports unnamed types.
##
##  @see llvm::Intrinsic::getName()
##

proc intrinsicCopyOverloadedName2*(
  `mod`: ModuleRef,
  id: cuint,
  paramTypes: ptr TypeRef,
  paramCount: csize_t,
  nameLength: ptr csize_t,
): cstring {.importc: "LLVMIntrinsicCopyOverloadedName2", dynlib: LLVMLib.}

##
##  Obtain if the intrinsic identified by the given ID is overloaded.
##
##  @see llvm::Intrinsic::isOverloaded()
##

proc intrinsicIsOverloaded*(
  id: cuint
): Bool {.importc: "LLVMIntrinsicIsOverloaded", dynlib: LLVMLib.}

##
##  Obtain the calling function of a function.
##
##  The returned value corresponds to the LLVMCallConv enumeration.
##
##  @see llvm::Function::getCallingConv()
##

proc getFunctionCallConv*(
  fn: ValueRef
): cuint {.importc: "LLVMGetFunctionCallConv", dynlib: LLVMLib.}

##
##  Set the calling convention of a function.
##
##  @see llvm::Function::setCallingConv()
##
##  @param Fn Function to operate on
##  @param CC LLVMCallConv to set calling convention to
##

proc setFunctionCallConv*(
  fn: ValueRef, cc: cuint
) {.importc: "LLVMSetFunctionCallConv", dynlib: LLVMLib.}

##
##  Obtain the name of the garbage collector to use during code
##  generation.
##
##  @see llvm::Function::getGC()
##

proc getGC*(fn: ValueRef): cstring {.importc: "LLVMGetGC", dynlib: LLVMLib.}
##
##  Define the garbage collector to use during code generation.
##
##  @see llvm::Function::setGC()
##

proc setGC*(fn: ValueRef, name: cstring) {.importc: "LLVMSetGC", dynlib: LLVMLib.}
##
##  Gets the prefix data associated with a function. Only valid on functions, and
##  only if LLVMHasPrefixData returns true.
##  See https://llvm.org/docs/LangRef.html#prefix-data
##

proc getPrefixData*(
  fn: ValueRef
): ValueRef {.importc: "LLVMGetPrefixData", dynlib: LLVMLib.}

##
##  Check if a given function has prefix data. Only valid on functions.
##  See https://llvm.org/docs/LangRef.html#prefix-data
##

proc hasPrefixData*(
  fn: ValueRef
): Bool {.importc: "LLVMHasPrefixData", dynlib: LLVMLib.}

##
##  Sets the prefix data for the function. Only valid on functions.
##  See https://llvm.org/docs/LangRef.html#prefix-data
##

proc setPrefixData*(
  fn: ValueRef, prefixData: ValueRef
) {.importc: "LLVMSetPrefixData", dynlib: LLVMLib.}

##
##  Gets the prologue data associated with a function. Only valid on functions,
##  and only if LLVMHasPrologueData returns true.
##  See https://llvm.org/docs/LangRef.html#prologue-data
##

proc getPrologueData*(
  fn: ValueRef
): ValueRef {.importc: "LLVMGetPrologueData", dynlib: LLVMLib.}

##
##  Check if a given function has prologue data. Only valid on functions.
##  See https://llvm.org/docs/LangRef.html#prologue-data
##

proc hasPrologueData*(
  fn: ValueRef
): Bool {.importc: "LLVMHasPrologueData", dynlib: LLVMLib.}

##
##  Sets the prologue data for the function. Only valid on functions.
##  See https://llvm.org/docs/LangRef.html#prologue-data
##

proc setPrologueData*(
  fn: ValueRef, prologueData: ValueRef
) {.importc: "LLVMSetPrologueData", dynlib: LLVMLib.}

##
##  Add an attribute to a function.
##
##  @see llvm::Function::addAttribute()
##

proc addAttributeAtIndex*(
  f: ValueRef, idx: AttributeIndex, a: AttributeRef
) {.importc: "LLVMAddAttributeAtIndex", dynlib: LLVMLib.}

proc getAttributeCountAtIndex*(
  f: ValueRef, idx: AttributeIndex
): cuint {.importc: "LLVMGetAttributeCountAtIndex", dynlib: LLVMLib.}

proc getAttributesAtIndex*(
  f: ValueRef, idx: AttributeIndex, attrs: ptr AttributeRef
) {.importc: "LLVMGetAttributesAtIndex", dynlib: LLVMLib.}

proc getEnumAttributeAtIndex*(
  f: ValueRef, idx: AttributeIndex, kindID: cuint
): AttributeRef {.importc: "LLVMGetEnumAttributeAtIndex", dynlib: LLVMLib.}

proc getStringAttributeAtIndex*(
  f: ValueRef, idx: AttributeIndex, k: cstring, kLen: cuint
): AttributeRef {.importc: "LLVMGetStringAttributeAtIndex", dynlib: LLVMLib.}

proc removeEnumAttributeAtIndex*(
  f: ValueRef, idx: AttributeIndex, kindID: cuint
) {.importc: "LLVMRemoveEnumAttributeAtIndex", dynlib: LLVMLib.}

proc removeStringAttributeAtIndex*(
  f: ValueRef, idx: AttributeIndex, k: cstring, kLen: cuint
) {.importc: "LLVMRemoveStringAttributeAtIndex", dynlib: LLVMLib.}

##
##  Add a target-dependent attribute to a function
##  @see llvm::AttrBuilder::addAttribute()
##

proc addTargetDependentFunctionAttr*(
  fn: ValueRef, a: cstring, v: cstring
) {.importc: "LLVMAddTargetDependentFunctionAttr", dynlib: LLVMLib.}

##
##  @defgroup LLVMCCoreValueFunctionParameters Function Parameters
##
##  Functions in this group relate to arguments/parameters on functions.
##
##  Functions in this group expect LLVMValueRef instances that correspond
##  to llvm::Function instances.
##
##  @{
##
##
##  Obtain the number of parameters in a function.
##
##  @see llvm::Function::arg_size()
##

proc countParams*(fn: ValueRef): cuint {.importc: "LLVMCountParams", dynlib: LLVMLib.}
##
##  Obtain the parameters in a function.
##
##  The takes a pointer to a pre-allocated array of LLVMValueRef that is
##  at least LLVMCountParams() long. This array will be filled with
##  LLVMValueRef instances which correspond to the parameters the
##  function receives. Each LLVMValueRef corresponds to a llvm::Argument
##  instance.
##
##  @see llvm::Function::arg_begin()
##

proc getParams*(
  fn: ValueRef, params: ptr ValueRef
) {.importc: "LLVMGetParams", dynlib: LLVMLib.}

##
##  Obtain the parameter at the specified index.
##
##  Parameters are indexed from 0.
##
##  @see llvm::Function::arg_begin()
##

proc getParam*(
  fn: ValueRef, index: cuint
): ValueRef {.importc: "LLVMGetParam", dynlib: LLVMLib.}

##
##  Obtain the function to which this argument belongs.
##
##  Unlike other functions in this group, this one takes an LLVMValueRef
##  that corresponds to a llvm::Attribute.
##
##  The returned LLVMValueRef is the llvm::Function to which this
##  argument belongs.
##

proc getParamParent*(
  inst: ValueRef
): ValueRef {.importc: "LLVMGetParamParent", dynlib: LLVMLib.}

##
##  Obtain the first parameter to a function.
##
##  @see llvm::Function::arg_begin()
##

proc getFirstParam*(
  fn: ValueRef
): ValueRef {.importc: "LLVMGetFirstParam", dynlib: LLVMLib.}

##
##  Obtain the last parameter to a function.
##
##  @see llvm::Function::arg_end()
##

proc getLastParam*(
  fn: ValueRef
): ValueRef {.importc: "LLVMGetLastParam", dynlib: LLVMLib.}

##
##  Obtain the next parameter to a function.
##
##  This takes an LLVMValueRef obtained from LLVMGetFirstParam() (which is
##  actually a wrapped iterator) and obtains the next parameter from the
##  underlying iterator.
##

proc getNextParam*(
  arg: ValueRef
): ValueRef {.importc: "LLVMGetNextParam", dynlib: LLVMLib.}

##
##  Obtain the previous parameter to a function.
##
##  This is the opposite of LLVMGetNextParam().
##

proc getPreviousParam*(
  arg: ValueRef
): ValueRef {.importc: "LLVMGetPreviousParam", dynlib: LLVMLib.}

##
##  Set the alignment for a function parameter.
##
##  @see llvm::Argument::addAttr()
##  @see llvm::AttrBuilder::addAlignmentAttr()
##

proc setParamAlignment*(
  arg: ValueRef, align: cuint
) {.importc: "LLVMSetParamAlignment", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCCoreValueGlobalIFunc IFuncs
##
##  Functions in this group relate to indirect functions.
##
##  Functions in this group expect LLVMValueRef instances that correspond
##  to llvm::GlobalIFunc instances.
##
##  @{
##
##
##  Add a global indirect function to a module under a specified name.
##
##  @see llvm::GlobalIFunc::create()
##

proc addGlobalIFunc*(
  m: ModuleRef,
  name: cstring,
  nameLen: csize_t,
  ty: TypeRef,
  addrSpace: cuint,
  resolver: ValueRef,
): ValueRef {.importc: "LLVMAddGlobalIFunc", dynlib: LLVMLib.}

##
##  Obtain a GlobalIFunc value from a Module by its name.
##
##  The returned value corresponds to a llvm::GlobalIFunc value.
##
##  @see llvm::Module::getNamedIFunc()
##

proc getNamedGlobalIFunc*(
  m: ModuleRef, name: cstring, nameLen: csize_t
): ValueRef {.importc: "LLVMGetNamedGlobalIFunc", dynlib: LLVMLib.}

##
##  Obtain an iterator to the first GlobalIFunc in a Module.
##
##  @see llvm::Module::ifunc_begin()
##

proc getFirstGlobalIFunc*(
  m: ModuleRef
): ValueRef {.importc: "LLVMGetFirstGlobalIFunc", dynlib: LLVMLib.}

##
##  Obtain an iterator to the last GlobalIFunc in a Module.
##
##  @see llvm::Module::ifunc_end()
##

proc getLastGlobalIFunc*(
  m: ModuleRef
): ValueRef {.importc: "LLVMGetLastGlobalIFunc", dynlib: LLVMLib.}

##
##  Advance a GlobalIFunc iterator to the next GlobalIFunc.
##
##  Returns NULL if the iterator was already at the end and there are no more
##  global aliases.
##

proc getNextGlobalIFunc*(
  iFunc: ValueRef
): ValueRef {.importc: "LLVMGetNextGlobalIFunc", dynlib: LLVMLib.}

##
##  Decrement a GlobalIFunc iterator to the previous GlobalIFunc.
##
##  Returns NULL if the iterator was already at the beginning and there are
##  no previous global aliases.
##

proc getPreviousGlobalIFunc*(
  iFunc: ValueRef
): ValueRef {.importc: "LLVMGetPreviousGlobalIFunc", dynlib: LLVMLib.}

##
##  Retrieves the resolver function associated with this indirect function, or
##  NULL if it doesn't not exist.
##
##  @see llvm::GlobalIFunc::getResolver()
##

proc getGlobalIFuncResolver*(
  iFunc: ValueRef
): ValueRef {.importc: "LLVMGetGlobalIFuncResolver", dynlib: LLVMLib.}

##
##  Sets the resolver function associated with this indirect function.
##
##  @see llvm::GlobalIFunc::setResolver()
##

proc setGlobalIFuncResolver*(
  iFunc: ValueRef, resolver: ValueRef
) {.importc: "LLVMSetGlobalIFuncResolver", dynlib: LLVMLib.}

##
##  Remove a global indirect function from its parent module and delete it.
##
##  @see llvm::GlobalIFunc::eraseFromParent()
##

proc eraseGlobalIFunc*(
  iFunc: ValueRef
) {.importc: "LLVMEraseGlobalIFunc", dynlib: LLVMLib.}

##
##  Remove a global indirect function from its parent module.
##
##  This unlinks the global indirect function from its containing module but
##  keeps it alive.
##
##  @see llvm::GlobalIFunc::removeFromParent()
##

proc removeGlobalIFunc*(
  iFunc: ValueRef
) {.importc: "LLVMRemoveGlobalIFunc", dynlib: LLVMLib.}

##
##  @}
##
##
##  @}
##
##
##  @}
##
##
##  @}
##
##
##  @defgroup LLVMCCoreValueMetadata Metadata
##
##  @{
##
##
##  Create an MDString value from a given string value.
##
##  The MDString value does not take ownership of the given string, it remains
##  the responsibility of the caller to free it.
##
##  @see llvm::MDString::get()
##

proc mDStringInContext2*(
  c: ContextRef, str: cstring, sLen: csize_t
): MetadataRef {.importc: "LLVMMDStringInContext2", dynlib: LLVMLib.}

##
##  Create an MDNode value with the given array of operands.
##
##  @see llvm::MDNode::get()
##

proc mDNodeInContext2*(
  c: ContextRef, mDs: ptr MetadataRef, count: csize_t
): MetadataRef {.importc: "LLVMMDNodeInContext2", dynlib: LLVMLib.}

##
##  Obtain a Metadata as a Value.
##

proc metadataAsValue*(
  c: ContextRef, md: MetadataRef
): ValueRef {.importc: "LLVMMetadataAsValue", dynlib: LLVMLib.}

##
##  Obtain a Value as a Metadata.
##

proc valueAsMetadata*(
  val: ValueRef
): MetadataRef {.importc: "LLVMValueAsMetadata", dynlib: LLVMLib.}

##
##  Obtain the underlying string from a MDString value.
##
##  @param V Instance to obtain string from.
##  @param Length Memory address which will hold length of returned string.
##  @return String data in MDString.
##

proc getMDString*(
  v: ValueRef, length: ptr cuint
): cstring {.importc: "LLVMGetMDString", dynlib: LLVMLib.}

##
##  Obtain the number of operands from an MDNode value.
##
##  @param V MDNode to get number of operands from.
##  @return Number of operands of the MDNode.
##

proc getMDNodeNumOperands*(
  v: ValueRef
): cuint {.importc: "LLVMGetMDNodeNumOperands", dynlib: LLVMLib.}

##
##  Obtain the given MDNode's operands.
##
##  The passed LLVMValueRef pointer should point to enough memory to hold all of
##  the operands of the given MDNode (see LLVMGetMDNodeNumOperands) as
##  LLVMValueRefs. This memory will be populated with the LLVMValueRefs of the
##  MDNode's operands.
##
##  @param V MDNode to get the operands from.
##  @param Dest Destination array for operands.
##

proc getMDNodeOperands*(
  v: ValueRef, dest: ptr ValueRef
) {.importc: "LLVMGetMDNodeOperands", dynlib: LLVMLib.}

##
##  Replace an operand at a specific index in a llvm::MDNode value.
##
##  @see llvm::MDNode::replaceOperandWith()
##

proc replaceMDNodeOperandWith*(
  v: ValueRef, index: cuint, replacement: MetadataRef
) {.importc: "LLVMReplaceMDNodeOperandWith", dynlib: LLVMLib.}

##  Deprecated: Use LLVMMDStringInContext2 instead.

proc mDStringInContext*(
  c: ContextRef, str: cstring, sLen: cuint
): ValueRef {.importc: "LLVMMDStringInContext", dynlib: LLVMLib.}

##  Deprecated: Use LLVMMDStringInContext2 instead.

proc mDString*(
  str: cstring, sLen: cuint
): ValueRef {.importc: "LLVMMDString", dynlib: LLVMLib.}

##  Deprecated: Use LLVMMDNodeInContext2 instead.

proc mDNodeInContext*(
  c: ContextRef, vals: ptr ValueRef, count: cuint
): ValueRef {.importc: "LLVMMDNodeInContext", dynlib: LLVMLib.}

##  Deprecated: Use LLVMMDNodeInContext2 instead.

proc mDNode*(
  vals: ptr ValueRef, count: cuint
): ValueRef {.importc: "LLVMMDNode", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCCoreOperandBundle Operand Bundles
##
##  Functions in this group operate on LLVMOperandBundleRef instances that
##  correspond to llvm::OperandBundleDef instances.
##
##  @see llvm::OperandBundleDef
##
##  @{
##
##
##  Create a new operand bundle.
##
##  Every invocation should be paired with LLVMDisposeOperandBundle() or memory
##  will be leaked.
##
##  @param Tag Tag name of the operand bundle
##  @param TagLen Length of Tag
##  @param Args Memory address of an array of bundle operands
##  @param NumArgs Length of Args
##

proc createOperandBundle*(
  tag: cstring, tagLen: csize_t, args: ptr ValueRef, numArgs: cuint
): OperandBundleRef {.importc: "LLVMCreateOperandBundle", dynlib: LLVMLib.}

##
##  Destroy an operand bundle.
##
##  This must be called for every created operand bundle or memory will be
##  leaked.
##

proc disposeOperandBundle*(
  bundle: OperandBundleRef
) {.importc: "LLVMDisposeOperandBundle", dynlib: LLVMLib.}

##
##  Obtain the tag of an operand bundle as a string.
##
##  @param Bundle Operand bundle to obtain tag of.
##  @param Len Out parameter which holds the length of the returned string.
##  @return The tag name of Bundle.
##  @see OperandBundleDef::getTag()
##

proc getOperandBundleTag*(
  bundle: OperandBundleRef, len: ptr csize_t
): cstring {.importc: "LLVMGetOperandBundleTag", dynlib: LLVMLib.}

##
##  Obtain the number of operands for an operand bundle.
##
##  @param Bundle Operand bundle to obtain operand count of.
##  @return The number of operands.
##  @see OperandBundleDef::input_size()
##

proc getNumOperandBundleArgs*(
  bundle: OperandBundleRef
): cuint {.importc: "LLVMGetNumOperandBundleArgs", dynlib: LLVMLib.}

##
##  Obtain the operand for an operand bundle at the given index.
##
##  @param Bundle Operand bundle to obtain operand of.
##  @param Index An operand index, must be less than
##  LLVMGetNumOperandBundleArgs().
##  @return The operand.
##

proc getOperandBundleArgAtIndex*(
  bundle: OperandBundleRef, index: cuint
): ValueRef {.importc: "LLVMGetOperandBundleArgAtIndex", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCCoreValueBasicBlock Basic Block
##
##  A basic block represents a single entry single exit section of code.
##  Basic blocks contain a list of instructions which form the body of
##  the block.
##
##  Basic blocks belong to functions. They have the type of label.
##
##  Basic blocks are themselves values. However, the C API models them as
##  LLVMBasicBlockRef.
##
##  @see llvm::BasicBlock
##
##  @{
##
##
##  Convert a basic block instance to a value type.
##

proc basicBlockAsValue*(
  bb: BasicBlockRef
): ValueRef {.importc: "LLVMBasicBlockAsValue", dynlib: LLVMLib.}

##
##  Determine whether an LLVMValueRef is itself a basic block.
##

proc valueIsBasicBlock*(
  val: ValueRef
): Bool {.importc: "LLVMValueIsBasicBlock", dynlib: LLVMLib.}

##
##  Convert an LLVMValueRef to an LLVMBasicBlockRef instance.
##

proc valueAsBasicBlock*(
  val: ValueRef
): BasicBlockRef {.importc: "LLVMValueAsBasicBlock", dynlib: LLVMLib.}

##
##  Obtain the string name of a basic block.
##

proc getBasicBlockName*(
  bb: BasicBlockRef
): cstring {.importc: "LLVMGetBasicBlockName", dynlib: LLVMLib.}

##
##  Obtain the function to which a basic block belongs.
##
##  @see llvm::BasicBlock::getParent()
##

proc getBasicBlockParent*(
  bb: BasicBlockRef
): ValueRef {.importc: "LLVMGetBasicBlockParent", dynlib: LLVMLib.}

##
##  Obtain the terminator instruction for a basic block.
##
##  If the basic block does not have a terminator (it is not well-formed
##  if it doesn't), then NULL is returned.
##
##  The returned LLVMValueRef corresponds to an llvm::Instruction.
##
##  @see llvm::BasicBlock::getTerminator()
##

proc getBasicBlockTerminator*(
  bb: BasicBlockRef
): ValueRef {.importc: "LLVMGetBasicBlockTerminator", dynlib: LLVMLib.}

##
##  Obtain the number of basic blocks in a function.
##
##  @param Fn Function value to operate on.
##

proc countBasicBlocks*(
  fn: ValueRef
): cuint {.importc: "LLVMCountBasicBlocks", dynlib: LLVMLib.}

##
##  Obtain all of the basic blocks in a function.
##
##  This operates on a function value. The BasicBlocks parameter is a
##  pointer to a pre-allocated array of LLVMBasicBlockRef of at least
##  LLVMCountBasicBlocks() in length. This array is populated with
##  LLVMBasicBlockRef instances.
##

proc getBasicBlocks*(
  fn: ValueRef, basicBlocks: ptr BasicBlockRef
) {.importc: "LLVMGetBasicBlocks", dynlib: LLVMLib.}

##
##  Obtain the first basic block in a function.
##
##  The returned basic block can be used as an iterator. You will likely
##  eventually call into LLVMGetNextBasicBlock() with it.
##
##  @see llvm::Function::begin()
##

proc getFirstBasicBlock*(
  fn: ValueRef
): BasicBlockRef {.importc: "LLVMGetFirstBasicBlock", dynlib: LLVMLib.}

##
##  Obtain the last basic block in a function.
##
##  @see llvm::Function::end()
##

proc getLastBasicBlock*(
  fn: ValueRef
): BasicBlockRef {.importc: "LLVMGetLastBasicBlock", dynlib: LLVMLib.}

##
##  Advance a basic block iterator.
##

proc getNextBasicBlock*(
  bb: BasicBlockRef
): BasicBlockRef {.importc: "LLVMGetNextBasicBlock", dynlib: LLVMLib.}

##
##  Go backwards in a basic block iterator.
##

proc getPreviousBasicBlock*(
  bb: BasicBlockRef
): BasicBlockRef {.importc: "LLVMGetPreviousBasicBlock", dynlib: LLVMLib.}

##
##  Obtain the basic block that corresponds to the entry point of a
##  function.
##
##  @see llvm::Function::getEntryBlock()
##

proc getEntryBasicBlock*(
  fn: ValueRef
): BasicBlockRef {.importc: "LLVMGetEntryBasicBlock", dynlib: LLVMLib.}

##
##  Insert the given basic block after the insertion point of the given builder.
##
##  The insertion point must be valid.
##
##  @see llvm::Function::BasicBlockListType::insertAfter()
##

proc insertExistingBasicBlockAfterInsertBlock*(
  builder: BuilderRef, bb: BasicBlockRef
) {.importc: "LLVMInsertExistingBasicBlockAfterInsertBlock", dynlib: LLVMLib.}

##
##  Append the given basic block to the basic block list of the given function.
##
##  @see llvm::Function::BasicBlockListType::push_back()
##

proc appendExistingBasicBlock*(
  fn: ValueRef, bb: BasicBlockRef
) {.importc: "LLVMAppendExistingBasicBlock", dynlib: LLVMLib.}

##
##  Create a new basic block without inserting it into a function.
##
##  @see llvm::BasicBlock::Create()
##

proc createBasicBlockInContext*(
  c: ContextRef, name: cstring
): BasicBlockRef {.importc: "LLVMCreateBasicBlockInContext", dynlib: LLVMLib.}

##
##  Append a basic block to the end of a function.
##
##  @see llvm::BasicBlock::Create()
##

proc appendBasicBlockInContext*(
  c: ContextRef, fn: ValueRef, name: cstring
): BasicBlockRef {.importc: "LLVMAppendBasicBlockInContext", dynlib: LLVMLib.}

##
##  Append a basic block to the end of a function using the global
##  context.
##
##  @see llvm::BasicBlock::Create()
##

proc appendBasicBlock*(
  fn: ValueRef, name: cstring
): BasicBlockRef {.importc: "LLVMAppendBasicBlock", dynlib: LLVMLib.}

##
##  Insert a basic block in a function before another basic block.
##
##  The function to add to is determined by the function of the
##  passed basic block.
##
##  @see llvm::BasicBlock::Create()
##

proc insertBasicBlockInContext*(
  c: ContextRef, bb: BasicBlockRef, name: cstring
): BasicBlockRef {.importc: "LLVMInsertBasicBlockInContext", dynlib: LLVMLib.}

##
##  Insert a basic block in a function using the global context.
##
##  @see llvm::BasicBlock::Create()
##

proc insertBasicBlock*(
  insertBeforeBB: BasicBlockRef, name: cstring
): BasicBlockRef {.importc: "LLVMInsertBasicBlock", dynlib: LLVMLib.}

##
##  Remove a basic block from a function and delete it.
##
##  This deletes the basic block from its containing function and deletes
##  the basic block itself.
##
##  @see llvm::BasicBlock::eraseFromParent()
##

proc deleteBasicBlock*(
  bb: BasicBlockRef
) {.importc: "LLVMDeleteBasicBlock", dynlib: LLVMLib.}

##
##  Remove a basic block from a function.
##
##  This deletes the basic block from its containing function but keep
##  the basic block alive.
##
##  @see llvm::BasicBlock::removeFromParent()
##

proc removeBasicBlockFromParent*(
  bb: BasicBlockRef
) {.importc: "LLVMRemoveBasicBlockFromParent", dynlib: LLVMLib.}

##
##  Move a basic block to before another one.
##
##  @see llvm::BasicBlock::moveBefore()
##

proc moveBasicBlockBefore*(
  bb: BasicBlockRef, movePos: BasicBlockRef
) {.importc: "LLVMMoveBasicBlockBefore", dynlib: LLVMLib.}

##
##  Move a basic block to after another one.
##
##  @see llvm::BasicBlock::moveAfter()
##

proc moveBasicBlockAfter*(
  bb: BasicBlockRef, movePos: BasicBlockRef
) {.importc: "LLVMMoveBasicBlockAfter", dynlib: LLVMLib.}

##
##  Obtain the first instruction in a basic block.
##
##  The returned LLVMValueRef corresponds to a llvm::Instruction
##  instance.
##

proc getFirstInstruction*(
  bb: BasicBlockRef
): ValueRef {.importc: "LLVMGetFirstInstruction", dynlib: LLVMLib.}

##
##  Obtain the last instruction in a basic block.
##
##  The returned LLVMValueRef corresponds to an LLVM:Instruction.
##

proc getLastInstruction*(
  bb: BasicBlockRef
): ValueRef {.importc: "LLVMGetLastInstruction", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCCoreValueInstruction Instructions
##
##  Functions in this group relate to the inspection and manipulation of
##  individual instructions.
##
##  In the C++ API, an instruction is modeled by llvm::Instruction. This
##  class has a large number of descendents. llvm::Instruction is a
##  llvm::Value and in the C API, instructions are modeled by
##  LLVMValueRef.
##
##  This group also contains sub-groups which operate on specific
##  llvm::Instruction types, e.g. llvm::CallInst.
##
##  @{
##
##
##  Determine whether an instruction has any metadata attached.
##

proc hasMetadata*(val: ValueRef): cint {.importc: "LLVMHasMetadata", dynlib: LLVMLib.}
##
##  Return metadata associated with an instruction value.
##

proc getMetadata*(
  val: ValueRef, kindID: cuint
): ValueRef {.importc: "LLVMGetMetadata", dynlib: LLVMLib.}

##
##  Set metadata associated with an instruction value.
##

proc setMetadata*(
  val: ValueRef, kindID: cuint, node: ValueRef
) {.importc: "LLVMSetMetadata", dynlib: LLVMLib.}

##
##  Returns the metadata associated with an instruction value, but filters out
##  all the debug locations.
##
##  @see llvm::Instruction::getAllMetadataOtherThanDebugLoc()
##

proc instructionGetAllMetadataOtherThanDebugLoc*(
  instr: ValueRef, numEntries: ptr csize_t
): ptr ValueMetadataEntry {.
  importc: "LLVMInstructionGetAllMetadataOtherThanDebugLoc", dynlib: LLVMLib
.}

##
##  Obtain the basic block to which an instruction belongs.
##
##  @see llvm::Instruction::getParent()
##

proc getInstructionParent*(
  inst: ValueRef
): BasicBlockRef {.importc: "LLVMGetInstructionParent", dynlib: LLVMLib.}

##
##  Obtain the instruction that occurs after the one specified.
##
##  The next instruction will be from the same basic block.
##
##  If this is the last instruction in a basic block, NULL will be
##  returned.
##

proc getNextInstruction*(
  inst: ValueRef
): ValueRef {.importc: "LLVMGetNextInstruction", dynlib: LLVMLib.}

##
##  Obtain the instruction that occurred before this one.
##
##  If the instruction is the first instruction in a basic block, NULL
##  will be returned.
##

proc getPreviousInstruction*(
  inst: ValueRef
): ValueRef {.importc: "LLVMGetPreviousInstruction", dynlib: LLVMLib.}

##
##  Remove an instruction.
##
##  The instruction specified is removed from its containing building
##  block but is kept alive.
##
##  @see llvm::Instruction::removeFromParent()
##

proc instructionRemoveFromParent*(
  inst: ValueRef
) {.importc: "LLVMInstructionRemoveFromParent", dynlib: LLVMLib.}

##
##  Remove and delete an instruction.
##
##  The instruction specified is removed from its containing building
##  block and then deleted.
##
##  @see llvm::Instruction::eraseFromParent()
##

proc instructionEraseFromParent*(
  inst: ValueRef
) {.importc: "LLVMInstructionEraseFromParent", dynlib: LLVMLib.}

##
##  Delete an instruction.
##
##  The instruction specified is deleted. It must have previously been
##  removed from its containing building block.
##
##  @see llvm::Value::deleteValue()
##

proc deleteInstruction*(
  inst: ValueRef
) {.importc: "LLVMDeleteInstruction", dynlib: LLVMLib.}

##
##  Obtain the code opcode for an individual instruction.
##
##  @see llvm::Instruction::getOpCode()
##

proc getInstructionOpcode*(
  inst: ValueRef
): Opcode {.importc: "LLVMGetInstructionOpcode", dynlib: LLVMLib.}

##
##  Obtain the predicate of an instruction.
##
##  This is only valid for instructions that correspond to llvm::ICmpInst.
##
##  @see llvm::ICmpInst::getPredicate()
##

proc getICmpPredicate*(
  inst: ValueRef
): IntPredicate {.importc: "LLVMGetICmpPredicate", dynlib: LLVMLib.}

##
##  Obtain the float predicate of an instruction.
##
##  This is only valid for instructions that correspond to llvm::FCmpInst.
##
##  @see llvm::FCmpInst::getPredicate()
##

proc getFCmpPredicate*(
  inst: ValueRef
): RealPredicate {.importc: "LLVMGetFCmpPredicate", dynlib: LLVMLib.}

##
##  Create a copy of 'this' instruction that is identical in all ways
##  except the following:
##    * The instruction has no parent
##    * The instruction has no name
##
##  @see llvm::Instruction::clone()
##

proc instructionClone*(
  inst: ValueRef
): ValueRef {.importc: "LLVMInstructionClone", dynlib: LLVMLib.}

##
##  Determine whether an instruction is a terminator. This routine is named to
##  be compatible with historical functions that did this by querying the
##  underlying C++ type.
##
##  @see llvm::Instruction::isTerminator()
##

proc isATerminatorInst*(
  inst: ValueRef
): ValueRef {.importc: "LLVMIsATerminatorInst", dynlib: LLVMLib.}

##
##  Obtain the first debug record attached to an instruction.
##
##  Use LLVMGetNextDbgRecord() and LLVMGetPreviousDbgRecord() to traverse the
##  sequence of DbgRecords.
##
##  Return the first DbgRecord attached to Inst or NULL if there are none.
##
##  @see llvm::Instruction::getDbgRecordRange()
##

proc getFirstDbgRecord*(
  inst: ValueRef
): DbgRecordRef {.importc: "LLVMGetFirstDbgRecord", dynlib: LLVMLib.}

##
##  Obtain the last debug record attached to an instruction.
##
##  Return the last DbgRecord attached to Inst or NULL if there are none.
##
##  @see llvm::Instruction::getDbgRecordRange()
##

proc getLastDbgRecord*(
  inst: ValueRef
): DbgRecordRef {.importc: "LLVMGetLastDbgRecord", dynlib: LLVMLib.}

##
##  Obtain the next DbgRecord in the sequence or NULL if there are no more.
##
##  @see llvm::Instruction::getDbgRecordRange()
##

proc getNextDbgRecord*(
  dbgRecord: DbgRecordRef
): DbgRecordRef {.importc: "LLVMGetNextDbgRecord", dynlib: LLVMLib.}

##
##  Obtain the previous DbgRecord in the sequence or NULL if there are no more.
##
##  @see llvm::Instruction::getDbgRecordRange()
##

proc getPreviousDbgRecord*(
  dbgRecord: DbgRecordRef
): DbgRecordRef {.importc: "LLVMGetPreviousDbgRecord", dynlib: LLVMLib.}

##
##  @defgroup LLVMCCoreValueInstructionCall Call Sites and Invocations
##
##  Functions in this group apply to instructions that refer to call
##  sites and invocations. These correspond to C++ types in the
##  llvm::CallInst class tree.
##
##  @{
##
##
##  Obtain the argument count for a call instruction.
##
##  This expects an LLVMValueRef that corresponds to a llvm::CallInst,
##  llvm::InvokeInst, or llvm:FuncletPadInst.
##
##  @see llvm::CallInst::getNumArgOperands()
##  @see llvm::InvokeInst::getNumArgOperands()
##  @see llvm::FuncletPadInst::getNumArgOperands()
##

proc getNumArgOperands*(
  instr: ValueRef
): cuint {.importc: "LLVMGetNumArgOperands", dynlib: LLVMLib.}

##
##  Set the calling convention for a call instruction.
##
##  This expects an LLVMValueRef that corresponds to a llvm::CallInst or
##  llvm::InvokeInst.
##
##  @see llvm::CallInst::setCallingConv()
##  @see llvm::InvokeInst::setCallingConv()
##

proc setInstructionCallConv*(
  instr: ValueRef, cc: cuint
) {.importc: "LLVMSetInstructionCallConv", dynlib: LLVMLib.}

##
##  Obtain the calling convention for a call instruction.
##
##  This is the opposite of LLVMSetInstructionCallConv(). Reads its
##  usage.
##
##  @see LLVMSetInstructionCallConv()
##

proc getInstructionCallConv*(
  instr: ValueRef
): cuint {.importc: "LLVMGetInstructionCallConv", dynlib: LLVMLib.}

proc setInstrParamAlignment*(
  instr: ValueRef, idx: AttributeIndex, align: cuint
) {.importc: "LLVMSetInstrParamAlignment", dynlib: LLVMLib.}

proc addCallSiteAttribute*(
  c: ValueRef, idx: AttributeIndex, a: AttributeRef
) {.importc: "LLVMAddCallSiteAttribute", dynlib: LLVMLib.}

proc getCallSiteAttributeCount*(
  c: ValueRef, idx: AttributeIndex
): cuint {.importc: "LLVMGetCallSiteAttributeCount", dynlib: LLVMLib.}

proc getCallSiteAttributes*(
  c: ValueRef, idx: AttributeIndex, attrs: ptr AttributeRef
) {.importc: "LLVMGetCallSiteAttributes", dynlib: LLVMLib.}

proc getCallSiteEnumAttribute*(
  c: ValueRef, idx: AttributeIndex, kindID: cuint
): AttributeRef {.importc: "LLVMGetCallSiteEnumAttribute", dynlib: LLVMLib.}

proc getCallSiteStringAttribute*(
  c: ValueRef, idx: AttributeIndex, k: cstring, kLen: cuint
): AttributeRef {.importc: "LLVMGetCallSiteStringAttribute", dynlib: LLVMLib.}

proc removeCallSiteEnumAttribute*(
  c: ValueRef, idx: AttributeIndex, kindID: cuint
) {.importc: "LLVMRemoveCallSiteEnumAttribute", dynlib: LLVMLib.}

proc removeCallSiteStringAttribute*(
  c: ValueRef, idx: AttributeIndex, k: cstring, kLen: cuint
) {.importc: "LLVMRemoveCallSiteStringAttribute", dynlib: LLVMLib.}

##
##  Obtain the function type called by this instruction.
##
##  @see llvm::CallBase::getFunctionType()
##

proc getCalledFunctionType*(
  c: ValueRef
): TypeRef {.importc: "LLVMGetCalledFunctionType", dynlib: LLVMLib.}

##
##  Obtain the pointer to the function invoked by this instruction.
##
##  This expects an LLVMValueRef that corresponds to a llvm::CallInst or
##  llvm::InvokeInst.
##
##  @see llvm::CallInst::getCalledOperand()
##  @see llvm::InvokeInst::getCalledOperand()
##

proc getCalledValue*(
  instr: ValueRef
): ValueRef {.importc: "LLVMGetCalledValue", dynlib: LLVMLib.}

##
##  Obtain the number of operand bundles attached to this instruction.
##
##  This only works on llvm::CallInst and llvm::InvokeInst instructions.
##
##  @see llvm::CallBase::getNumOperandBundles()
##

proc getNumOperandBundles*(
  c: ValueRef
): cuint {.importc: "LLVMGetNumOperandBundles", dynlib: LLVMLib.}

##
##  Obtain the operand bundle attached to this instruction at the given index.
##  Use LLVMDisposeOperandBundle to free the operand bundle.
##
##  This only works on llvm::CallInst and llvm::InvokeInst instructions.
##

proc getOperandBundleAtIndex*(
  c: ValueRef, index: cuint
): OperandBundleRef {.importc: "LLVMGetOperandBundleAtIndex", dynlib: LLVMLib.}

##
##  Obtain whether a call instruction is a tail call.
##
##  This only works on llvm::CallInst instructions.
##
##  @see llvm::CallInst::isTailCall()
##

proc isTailCall*(
  callInst: ValueRef
): Bool {.importc: "LLVMIsTailCall", dynlib: LLVMLib.}

##
##  Set whether a call instruction is a tail call.
##
##  This only works on llvm::CallInst instructions.
##
##  @see llvm::CallInst::setTailCall()
##

proc setTailCall*(
  callInst: ValueRef, isTailCall: Bool
) {.importc: "LLVMSetTailCall", dynlib: LLVMLib.}

##
##  Obtain a tail call kind of the call instruction.
##
##  @see llvm::CallInst::setTailCallKind()
##

proc getTailCallKind*(
  callInst: ValueRef
): TailCallKind {.importc: "LLVMGetTailCallKind", dynlib: LLVMLib.}

##
##  Set the call kind of the call instruction.
##
##  @see llvm::CallInst::getTailCallKind()
##

proc setTailCallKind*(
  callInst: ValueRef, kind: TailCallKind
) {.importc: "LLVMSetTailCallKind", dynlib: LLVMLib.}

##
##  Return the normal destination basic block.
##
##  This only works on llvm::InvokeInst instructions.
##
##  @see llvm::InvokeInst::getNormalDest()
##

proc getNormalDest*(
  invokeInst: ValueRef
): BasicBlockRef {.importc: "LLVMGetNormalDest", dynlib: LLVMLib.}

##
##  Return the unwind destination basic block.
##
##  Works on llvm::InvokeInst, llvm::CleanupReturnInst, and
##  llvm::CatchSwitchInst instructions.
##
##  @see llvm::InvokeInst::getUnwindDest()
##  @see llvm::CleanupReturnInst::getUnwindDest()
##  @see llvm::CatchSwitchInst::getUnwindDest()
##

proc getUnwindDest*(
  invokeInst: ValueRef
): BasicBlockRef {.importc: "LLVMGetUnwindDest", dynlib: LLVMLib.}

##
##  Set the normal destination basic block.
##
##  This only works on llvm::InvokeInst instructions.
##
##  @see llvm::InvokeInst::setNormalDest()
##

proc setNormalDest*(
  invokeInst: ValueRef, b: BasicBlockRef
) {.importc: "LLVMSetNormalDest", dynlib: LLVMLib.}

##
##  Set the unwind destination basic block.
##
##  Works on llvm::InvokeInst, llvm::CleanupReturnInst, and
##  llvm::CatchSwitchInst instructions.
##
##  @see llvm::InvokeInst::setUnwindDest()
##  @see llvm::CleanupReturnInst::setUnwindDest()
##  @see llvm::CatchSwitchInst::setUnwindDest()
##

proc setUnwindDest*(
  invokeInst: ValueRef, b: BasicBlockRef
) {.importc: "LLVMSetUnwindDest", dynlib: LLVMLib.}

##
##  Get the default destination of a CallBr instruction.
##
##  @see llvm::CallBrInst::getDefaultDest()
##

proc getCallBrDefaultDest*(
  callBr: ValueRef
): BasicBlockRef {.importc: "LLVMGetCallBrDefaultDest", dynlib: LLVMLib.}

##
##  Get the number of indirect destinations of a CallBr instruction.
##
##  @see llvm::CallBrInst::getNumIndirectDests()
##
##

proc getCallBrNumIndirectDests*(
  callBr: ValueRef
): cuint {.importc: "LLVMGetCallBrNumIndirectDests", dynlib: LLVMLib.}

##
##  Get the indirect destination of a CallBr instruction at the given index.
##
##  @see llvm::CallBrInst::getIndirectDest()
##

proc getCallBrIndirectDest*(
  callBr: ValueRef, idx: cuint
): BasicBlockRef {.importc: "LLVMGetCallBrIndirectDest", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCCoreValueInstructionTerminator Terminators
##
##  Functions in this group only apply to instructions for which
##  LLVMIsATerminatorInst returns true.
##
##  @{
##
##
##  Return the number of successors that this terminator has.
##
##  @see llvm::Instruction::getNumSuccessors
##

proc getNumSuccessors*(
  term: ValueRef
): cuint {.importc: "LLVMGetNumSuccessors", dynlib: LLVMLib.}

##
##  Return the specified successor.
##
##  @see llvm::Instruction::getSuccessor
##

proc getSuccessor*(
  term: ValueRef, i: cuint
): BasicBlockRef {.importc: "LLVMGetSuccessor", dynlib: LLVMLib.}

##
##  Update the specified successor to point at the provided block.
##
##  @see llvm::Instruction::setSuccessor
##

proc setSuccessor*(
  term: ValueRef, i: cuint, `block`: BasicBlockRef
) {.importc: "LLVMSetSuccessor", dynlib: LLVMLib.}

##
##  Return if a branch is conditional.
##
##  This only works on llvm::BranchInst instructions.
##
##  @see llvm::BranchInst::isConditional
##

proc isConditional*(
  branch: ValueRef
): Bool {.importc: "LLVMIsConditional", dynlib: LLVMLib.}

##
##  Return the condition of a branch instruction.
##
##  This only works on llvm::BranchInst instructions.
##
##  @see llvm::BranchInst::getCondition
##

proc getCondition*(
  branch: ValueRef
): ValueRef {.importc: "LLVMGetCondition", dynlib: LLVMLib.}

##
##  Set the condition of a branch instruction.
##
##  This only works on llvm::BranchInst instructions.
##
##  @see llvm::BranchInst::setCondition
##

proc setCondition*(
  branch: ValueRef, cond: ValueRef
) {.importc: "LLVMSetCondition", dynlib: LLVMLib.}

##
##  Obtain the default destination basic block of a switch instruction.
##
##  This only works on llvm::SwitchInst instructions.
##
##  @see llvm::SwitchInst::getDefaultDest()
##

proc getSwitchDefaultDest*(
  switchInstr: ValueRef
): BasicBlockRef {.importc: "LLVMGetSwitchDefaultDest", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCCoreValueInstructionAlloca Allocas
##
##  Functions in this group only apply to instructions that map to
##  llvm::AllocaInst instances.
##
##  @{
##
##
##  Obtain the type that is being allocated by the alloca instruction.
##

proc getAllocatedType*(
  alloca: ValueRef
): TypeRef {.importc: "LLVMGetAllocatedType", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCCoreValueInstructionGetElementPointer GEPs
##
##  Functions in this group only apply to instructions that map to
##  llvm::GetElementPtrInst instances.
##
##  @{
##
##
##  Check whether the given GEP operator is inbounds.
##

proc isInBounds*(gep: ValueRef): Bool {.importc: "LLVMIsInBounds", dynlib: LLVMLib.}
##
##  Set the given GEP instruction to be inbounds or not.
##

proc setIsInBounds*(
  gep: ValueRef, inBounds: Bool
) {.importc: "LLVMSetIsInBounds", dynlib: LLVMLib.}

##
##  Get the source element type of the given GEP operator.
##

proc getGEPSourceElementType*(
  gep: ValueRef
): TypeRef {.importc: "LLVMGetGEPSourceElementType", dynlib: LLVMLib.}

##
##  Get the no-wrap related flags for the given GEP instruction.
##
##  @see llvm::GetElementPtrInst::getNoWrapFlags
##

proc gEPGetNoWrapFlags*(
  gep: ValueRef
): GEPNoWrapFlags {.importc: "LLVMGEPGetNoWrapFlags", dynlib: LLVMLib.}

##
##  Set the no-wrap related flags for the given GEP instruction.
##
##  @see llvm::GetElementPtrInst::setNoWrapFlags
##

proc gEPSetNoWrapFlags*(
  gep: ValueRef, noWrapFlags: GEPNoWrapFlags
) {.importc: "LLVMGEPSetNoWrapFlags", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCCoreValueInstructionPHINode PHI Nodes
##
##  Functions in this group only apply to instructions that map to
##  llvm::PHINode instances.
##
##  @{
##
##
##  Add an incoming value to the end of a PHI list.
##

proc addIncoming*(
  phiNode: ValueRef,
  incomingValues: ptr ValueRef,
  incomingBlocks: ptr BasicBlockRef,
  count: cuint,
) {.importc: "LLVMAddIncoming", dynlib: LLVMLib.}

##
##  Obtain the number of incoming basic blocks to a PHI node.
##

proc countIncoming*(
  phiNode: ValueRef
): cuint {.importc: "LLVMCountIncoming", dynlib: LLVMLib.}

##
##  Obtain an incoming value to a PHI node as an LLVMValueRef.
##

proc getIncomingValue*(
  phiNode: ValueRef, index: cuint
): ValueRef {.importc: "LLVMGetIncomingValue", dynlib: LLVMLib.}

##
##  Obtain an incoming value to a PHI node as an LLVMBasicBlockRef.
##

proc getIncomingBlock*(
  phiNode: ValueRef, index: cuint
): BasicBlockRef {.importc: "LLVMGetIncomingBlock", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCCoreValueInstructionExtractValue ExtractValue
##  @defgroup LLVMCCoreValueInstructionInsertValue InsertValue
##
##  Functions in this group only apply to instructions that map to
##  llvm::ExtractValue and llvm::InsertValue instances.
##
##  @{
##
##
##  Obtain the number of indices.
##  NB: This also works on GEP operators.
##

proc getNumIndices*(
  inst: ValueRef
): cuint {.importc: "LLVMGetNumIndices", dynlib: LLVMLib.}

##
##  Obtain the indices as an array.
##

proc getIndices*(
  inst: ValueRef
): ptr cuint {.importc: "LLVMGetIndices", dynlib: LLVMLib.}

##
##  @}
##
##
##  @}
##
##
##  @}
##
##
##  @defgroup LLVMCCoreInstructionBuilder Instruction Builders
##
##  An instruction builder represents a point within a basic block and is
##  the exclusive means of building instructions using the C interface.
##
##  @{
##

proc createBuilderInContext*(
  c: ContextRef
): BuilderRef {.importc: "LLVMCreateBuilderInContext", dynlib: LLVMLib.}

proc createBuilder*(): BuilderRef {.importc: "LLVMCreateBuilder", dynlib: LLVMLib.}
##
##  Set the builder position before Instr but after any attached debug records,
##  or if Instr is null set the position to the end of Block.
##

proc positionBuilder*(
  builder: BuilderRef, `block`: BasicBlockRef, instr: ValueRef
) {.importc: "LLVMPositionBuilder", dynlib: LLVMLib.}

##
##  Set the builder position before Instr and any attached debug records,
##  or if Instr is null set the position to the end of Block.
##

proc positionBuilderBeforeDbgRecords*(
  builder: BuilderRef, `block`: BasicBlockRef, inst: ValueRef
) {.importc: "LLVMPositionBuilderBeforeDbgRecords", dynlib: LLVMLib.}

##
##  Set the builder position before Instr but after any attached debug records.
##

proc positionBuilderBefore*(
  builder: BuilderRef, instr: ValueRef
) {.importc: "LLVMPositionBuilderBefore", dynlib: LLVMLib.}

##
##  Set the builder position before Instr and any attached debug records.
##

proc positionBuilderBeforeInstrAndDbgRecords*(
  builder: BuilderRef, instr: ValueRef
) {.importc: "LLVMPositionBuilderBeforeInstrAndDbgRecords", dynlib: LLVMLib.}

proc positionBuilderAtEnd*(
  builder: BuilderRef, `block`: BasicBlockRef
) {.importc: "LLVMPositionBuilderAtEnd", dynlib: LLVMLib.}

proc getInsertBlock*(
  builder: BuilderRef
): BasicBlockRef {.importc: "LLVMGetInsertBlock", dynlib: LLVMLib.}

proc clearInsertionPosition*(
  builder: BuilderRef
) {.importc: "LLVMClearInsertionPosition", dynlib: LLVMLib.}

proc insertIntoBuilder*(
  builder: BuilderRef, instr: ValueRef
) {.importc: "LLVMInsertIntoBuilder", dynlib: LLVMLib.}

proc insertIntoBuilderWithName*(
  builder: BuilderRef, instr: ValueRef, name: cstring
) {.importc: "LLVMInsertIntoBuilderWithName", dynlib: LLVMLib.}

proc disposeBuilder*(
  builder: BuilderRef
) {.importc: "LLVMDisposeBuilder", dynlib: LLVMLib.}

##  Metadata
##
##  Get location information used by debugging information.
##
##  @see llvm::IRBuilder::getCurrentDebugLocation()
##

proc getCurrentDebugLocation2*(
  builder: BuilderRef
): MetadataRef {.importc: "LLVMGetCurrentDebugLocation2", dynlib: LLVMLib.}

##
##  Set location information used by debugging information.
##
##  To clear the location metadata of the given instruction, pass NULL to \p Loc.
##
##  @see llvm::IRBuilder::SetCurrentDebugLocation()
##

proc setCurrentDebugLocation2*(
  builder: BuilderRef, loc: MetadataRef
) {.importc: "LLVMSetCurrentDebugLocation2", dynlib: LLVMLib.}

##
##  Attempts to set the debug location for the given instruction using the
##  current debug location for the given builder.  If the builder has no current
##  debug location, this function is a no-op.
##
##  @deprecated LLVMSetInstDebugLocation is deprecated in favor of the more general
##              LLVMAddMetadataToInst.
##
##  @see llvm::IRBuilder::SetInstDebugLocation()
##

proc setInstDebugLocation*(
  builder: BuilderRef, inst: ValueRef
) {.importc: "LLVMSetInstDebugLocation", dynlib: LLVMLib.}

##
##  Adds the metadata registered with the given builder to the given instruction.
##
##  @see llvm::IRBuilder::AddMetadataToInst()
##

proc addMetadataToInst*(
  builder: BuilderRef, inst: ValueRef
) {.importc: "LLVMAddMetadataToInst", dynlib: LLVMLib.}

##
##  Get the dafult floating-point math metadata for a given builder.
##
##  @see llvm::IRBuilder::getDefaultFPMathTag()
##

proc builderGetDefaultFPMathTag*(
  builder: BuilderRef
): MetadataRef {.importc: "LLVMBuilderGetDefaultFPMathTag", dynlib: LLVMLib.}

##
##  Set the default floating-point math metadata for the given builder.
##
##  To clear the metadata, pass NULL to \p FPMathTag.
##
##  @see llvm::IRBuilder::setDefaultFPMathTag()
##

proc builderSetDefaultFPMathTag*(
  builder: BuilderRef, fPMathTag: MetadataRef
) {.importc: "LLVMBuilderSetDefaultFPMathTag", dynlib: LLVMLib.}

##
##  Obtain the context to which this builder is associated.
##
##  @see llvm::IRBuilder::getContext()
##

proc getBuilderContext*(
  builder: BuilderRef
): ContextRef {.importc: "LLVMGetBuilderContext", dynlib: LLVMLib.}

##
##  Deprecated: Passing the NULL location will crash.
##  Use LLVMGetCurrentDebugLocation2 instead.
##

proc setCurrentDebugLocation*(
  builder: BuilderRef, L: ValueRef
) {.importc: "LLVMSetCurrentDebugLocation", dynlib: LLVMLib.}

##
##  Deprecated: Returning the NULL location will crash.
##  Use LLVMGetCurrentDebugLocation2 instead.
##

proc getCurrentDebugLocation*(
  builder: BuilderRef
): ValueRef {.importc: "LLVMGetCurrentDebugLocation", dynlib: LLVMLib.}

##  Terminators

proc buildRetVoid*(
  a1: BuilderRef
): ValueRef {.importc: "LLVMBuildRetVoid", dynlib: LLVMLib.}

proc buildRet*(
  a1: BuilderRef, v: ValueRef
): ValueRef {.importc: "LLVMBuildRet", dynlib: LLVMLib.}

proc buildAggregateRet*(
  a1: BuilderRef, retVals: ptr ValueRef, n: cuint
): ValueRef {.importc: "LLVMBuildAggregateRet", dynlib: LLVMLib.}

proc buildBr*(
  a1: BuilderRef, dest: BasicBlockRef
): ValueRef {.importc: "LLVMBuildBr", dynlib: LLVMLib.}

proc buildCondBr*(
  a1: BuilderRef, `if`: ValueRef, then: BasicBlockRef, `else`: BasicBlockRef
): ValueRef {.importc: "LLVMBuildCondBr", dynlib: LLVMLib.}

proc buildSwitch*(
  a1: BuilderRef, v: ValueRef, `else`: BasicBlockRef, numCases: cuint
): ValueRef {.importc: "LLVMBuildSwitch", dynlib: LLVMLib.}

proc buildIndirectBr*(
  b: BuilderRef, `addr`: ValueRef, numDests: cuint
): ValueRef {.importc: "LLVMBuildIndirectBr", dynlib: LLVMLib.}

proc buildCallBr*(
  b: BuilderRef,
  ty: TypeRef,
  fn: ValueRef,
  defaultDest: BasicBlockRef,
  indirectDests: ptr BasicBlockRef,
  numIndirectDests: cuint,
  args: ptr ValueRef,
  numArgs: cuint,
  bundles: ptr OperandBundleRef,
  numBundles: cuint,
  name: cstring,
): ValueRef {.importc: "LLVMBuildCallBr", dynlib: LLVMLib.}

proc buildInvoke2*(
  a1: BuilderRef,
  ty: TypeRef,
  fn: ValueRef,
  args: ptr ValueRef,
  numArgs: cuint,
  then: BasicBlockRef,
  catch: BasicBlockRef,
  name: cstring,
): ValueRef {.importc: "LLVMBuildInvoke2", dynlib: LLVMLib.}

proc buildInvokeWithOperandBundles*(
  a1: BuilderRef,
  ty: TypeRef,
  fn: ValueRef,
  args: ptr ValueRef,
  numArgs: cuint,
  then: BasicBlockRef,
  catch: BasicBlockRef,
  bundles: ptr OperandBundleRef,
  numBundles: cuint,
  name: cstring,
): ValueRef {.importc: "LLVMBuildInvokeWithOperandBundles", dynlib: LLVMLib.}

proc buildUnreachable*(
  a1: BuilderRef
): ValueRef {.importc: "LLVMBuildUnreachable", dynlib: LLVMLib.}

##  Exception Handling

proc buildResume*(
  b: BuilderRef, exn: ValueRef
): ValueRef {.importc: "LLVMBuildResume", dynlib: LLVMLib.}

proc buildLandingPad*(
  b: BuilderRef, ty: TypeRef, persFn: ValueRef, numClauses: cuint, name: cstring
): ValueRef {.importc: "LLVMBuildLandingPad", dynlib: LLVMLib.}

proc buildCleanupRet*(
  b: BuilderRef, catchPad: ValueRef, bb: BasicBlockRef
): ValueRef {.importc: "LLVMBuildCleanupRet", dynlib: LLVMLib.}

proc buildCatchRet*(
  b: BuilderRef, catchPad: ValueRef, bb: BasicBlockRef
): ValueRef {.importc: "LLVMBuildCatchRet", dynlib: LLVMLib.}

proc buildCatchPad*(
  b: BuilderRef, parentPad: ValueRef, args: ptr ValueRef, numArgs: cuint, name: cstring
): ValueRef {.importc: "LLVMBuildCatchPad", dynlib: LLVMLib.}

proc buildCleanupPad*(
  b: BuilderRef, parentPad: ValueRef, args: ptr ValueRef, numArgs: cuint, name: cstring
): ValueRef {.importc: "LLVMBuildCleanupPad", dynlib: LLVMLib.}

proc buildCatchSwitch*(
  b: BuilderRef,
  parentPad: ValueRef,
  unwindBB: BasicBlockRef,
  numHandlers: cuint,
  name: cstring,
): ValueRef {.importc: "LLVMBuildCatchSwitch", dynlib: LLVMLib.}

##  Add a case to the switch instruction

proc addCase*(
  switch: ValueRef, onVal: ValueRef, dest: BasicBlockRef
) {.importc: "LLVMAddCase", dynlib: LLVMLib.}

##  Add a destination to the indirectbr instruction

proc addDestination*(
  indirectBr: ValueRef, dest: BasicBlockRef
) {.importc: "LLVMAddDestination", dynlib: LLVMLib.}

##  Get the number of clauses on the landingpad instruction

proc getNumClauses*(
  landingPad: ValueRef
): cuint {.importc: "LLVMGetNumClauses", dynlib: LLVMLib.}

##  Get the value of the clause at index Idx on the landingpad instruction

proc getClause*(
  landingPad: ValueRef, idx: cuint
): ValueRef {.importc: "LLVMGetClause", dynlib: LLVMLib.}

##  Add a catch or filter clause to the landingpad instruction

proc addClause*(
  landingPad: ValueRef, clauseVal: ValueRef
) {.importc: "LLVMAddClause", dynlib: LLVMLib.}

##  Get the 'cleanup' flag in the landingpad instruction

proc isCleanup*(
  landingPad: ValueRef
): Bool {.importc: "LLVMIsCleanup", dynlib: LLVMLib.}

##  Set the 'cleanup' flag in the landingpad instruction

proc setCleanup*(
  landingPad: ValueRef, val: Bool
) {.importc: "LLVMSetCleanup", dynlib: LLVMLib.}

##  Add a destination to the catchswitch instruction

proc addHandler*(
  catchSwitch: ValueRef, dest: BasicBlockRef
) {.importc: "LLVMAddHandler", dynlib: LLVMLib.}

##  Get the number of handlers on the catchswitch instruction

proc getNumHandlers*(
  catchSwitch: ValueRef
): cuint {.importc: "LLVMGetNumHandlers", dynlib: LLVMLib.}

##
##  Obtain the basic blocks acting as handlers for a catchswitch instruction.
##
##  The Handlers parameter should point to a pre-allocated array of
##  LLVMBasicBlockRefs at least LLVMGetNumHandlers() large. On return, the
##  first LLVMGetNumHandlers() entries in the array will be populated
##  with LLVMBasicBlockRef instances.
##
##  @param CatchSwitch The catchswitch instruction to operate on.
##  @param Handlers Memory address of an array to be filled with basic blocks.
##

proc getHandlers*(
  catchSwitch: ValueRef, handlers: ptr BasicBlockRef
) {.importc: "LLVMGetHandlers", dynlib: LLVMLib.}

##  Funclets
##  Get the number of funcletpad arguments.

proc getArgOperand*(
  funclet: ValueRef, i: cuint
): ValueRef {.importc: "LLVMGetArgOperand", dynlib: LLVMLib.}

##  Set a funcletpad argument at the given index.

proc setArgOperand*(
  funclet: ValueRef, i: cuint, value: ValueRef
) {.importc: "LLVMSetArgOperand", dynlib: LLVMLib.}

##
##  Get the parent catchswitch instruction of a catchpad instruction.
##
##  This only works on llvm::CatchPadInst instructions.
##
##  @see llvm::CatchPadInst::getCatchSwitch()
##

proc getParentCatchSwitch*(
  catchPad: ValueRef
): ValueRef {.importc: "LLVMGetParentCatchSwitch", dynlib: LLVMLib.}

##
##  Set the parent catchswitch instruction of a catchpad instruction.
##
##  This only works on llvm::CatchPadInst instructions.
##
##  @see llvm::CatchPadInst::setCatchSwitch()
##

proc setParentCatchSwitch*(
  catchPad: ValueRef, catchSwitch: ValueRef
) {.importc: "LLVMSetParentCatchSwitch", dynlib: LLVMLib.}

##  Arithmetic

proc buildAdd*(
  a1: BuilderRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildAdd", dynlib: LLVMLib.}

proc buildNSWAdd*(
  a1: BuilderRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildNSWAdd", dynlib: LLVMLib.}

proc buildNUWAdd*(
  a1: BuilderRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildNUWAdd", dynlib: LLVMLib.}

proc buildFAdd*(
  a1: BuilderRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildFAdd", dynlib: LLVMLib.}

proc buildSub*(
  a1: BuilderRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildSub", dynlib: LLVMLib.}

proc buildNSWSub*(
  a1: BuilderRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildNSWSub", dynlib: LLVMLib.}

proc buildNUWSub*(
  a1: BuilderRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildNUWSub", dynlib: LLVMLib.}

proc buildFSub*(
  a1: BuilderRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildFSub", dynlib: LLVMLib.}

proc buildMul*(
  a1: BuilderRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildMul", dynlib: LLVMLib.}

proc buildNSWMul*(
  a1: BuilderRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildNSWMul", dynlib: LLVMLib.}

proc buildNUWMul*(
  a1: BuilderRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildNUWMul", dynlib: LLVMLib.}

proc buildFMul*(
  a1: BuilderRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildFMul", dynlib: LLVMLib.}

proc buildUDiv*(
  a1: BuilderRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildUDiv", dynlib: LLVMLib.}

proc buildExactUDiv*(
  a1: BuilderRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildExactUDiv", dynlib: LLVMLib.}

proc buildSDiv*(
  a1: BuilderRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildSDiv", dynlib: LLVMLib.}

proc buildExactSDiv*(
  a1: BuilderRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildExactSDiv", dynlib: LLVMLib.}

proc buildFDiv*(
  a1: BuilderRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildFDiv", dynlib: LLVMLib.}

proc buildURem*(
  a1: BuilderRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildURem", dynlib: LLVMLib.}

proc buildSRem*(
  a1: BuilderRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildSRem", dynlib: LLVMLib.}

proc buildFRem*(
  a1: BuilderRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildFRem", dynlib: LLVMLib.}

proc buildShl*(
  a1: BuilderRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildShl", dynlib: LLVMLib.}

proc buildLShr*(
  a1: BuilderRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildLShr", dynlib: LLVMLib.}

proc buildAShr*(
  a1: BuilderRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildAShr", dynlib: LLVMLib.}

proc buildAnd*(
  a1: BuilderRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildAnd", dynlib: LLVMLib.}

proc buildOr*(
  a1: BuilderRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildOr", dynlib: LLVMLib.}

proc buildXor*(
  a1: BuilderRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildXor", dynlib: LLVMLib.}

proc buildBinOp*(
  b: BuilderRef, op: Opcode, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildBinOp", dynlib: LLVMLib.}

proc buildNeg*(
  a1: BuilderRef, v: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildNeg", dynlib: LLVMLib.}

proc buildNSWNeg*(
  b: BuilderRef, v: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildNSWNeg", dynlib: LLVMLib.}

proc buildFNeg*(
  a1: BuilderRef, v: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildFNeg", dynlib: LLVMLib.}

proc buildNot*(
  a1: BuilderRef, v: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildNot", dynlib: LLVMLib.}

proc getNUW*(arithInst: ValueRef): Bool {.importc: "LLVMGetNUW", dynlib: LLVMLib.}
proc setNUW*(
  arithInst: ValueRef, hasNUW: Bool
) {.importc: "LLVMSetNUW", dynlib: LLVMLib.}

proc getNSW*(arithInst: ValueRef): Bool {.importc: "LLVMGetNSW", dynlib: LLVMLib.}
proc setNSW*(
  arithInst: ValueRef, hasNSW: Bool
) {.importc: "LLVMSetNSW", dynlib: LLVMLib.}

proc getExact*(
  divOrShrInst: ValueRef
): Bool {.importc: "LLVMGetExact", dynlib: LLVMLib.}

proc setExact*(
  divOrShrInst: ValueRef, isExact: Bool
) {.importc: "LLVMSetExact", dynlib: LLVMLib.}

##
##  Gets if the instruction has the non-negative flag set.
##  Only valid for zext instructions.
##

proc getNNeg*(nonNegInst: ValueRef): Bool {.importc: "LLVMGetNNeg", dynlib: LLVMLib.}
##
##  Sets the non-negative flag for the instruction.
##  Only valid for zext instructions.
##

proc setNNeg*(
  nonNegInst: ValueRef, isNonNeg: Bool
) {.importc: "LLVMSetNNeg", dynlib: LLVMLib.}

##
##  Get the flags for which fast-math-style optimizations are allowed for this
##  value.
##
##  Only valid on floating point instructions.
##  @see LLVMCanValueUseFastMathFlags
##

proc getFastMathFlags*(
  fPMathInst: ValueRef
): FastMathFlags {.importc: "LLVMGetFastMathFlags", dynlib: LLVMLib.}

##
##  Sets the flags for which fast-math-style optimizations are allowed for this
##  value.
##
##  Only valid on floating point instructions.
##  @see LLVMCanValueUseFastMathFlags
##

proc setFastMathFlags*(
  fPMathInst: ValueRef, fmf: FastMathFlags
) {.importc: "LLVMSetFastMathFlags", dynlib: LLVMLib.}

##
##  Check if a given value can potentially have fast math flags.
##
##  Will return true for floating point arithmetic instructions, and for select,
##  phi, and call instructions whose type is a floating point type, or a vector
##  or array thereof. See https://llvm.org/docs/LangRef.html#fast-math-flags
##

proc canValueUseFastMathFlags*(
  inst: ValueRef
): Bool {.importc: "LLVMCanValueUseFastMathFlags", dynlib: LLVMLib.}

##
##  Gets whether the instruction has the disjoint flag set.
##  Only valid for or instructions.
##

proc getIsDisjoint*(
  inst: ValueRef
): Bool {.importc: "LLVMGetIsDisjoint", dynlib: LLVMLib.}

##
##  Sets the disjoint flag for the instruction.
##  Only valid for or instructions.
##

proc setIsDisjoint*(
  inst: ValueRef, isDisjoint: Bool
) {.importc: "LLVMSetIsDisjoint", dynlib: LLVMLib.}

##  Memory

proc buildMalloc*(
  a1: BuilderRef, ty: TypeRef, name: cstring
): ValueRef {.importc: "LLVMBuildMalloc", dynlib: LLVMLib.}

proc buildArrayMalloc*(
  a1: BuilderRef, ty: TypeRef, val: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildArrayMalloc", dynlib: LLVMLib.}

##
##  Creates and inserts a memset to the specified pointer and the
##  specified value.
##
##  @see llvm::IRRBuilder::CreateMemSet()
##

proc buildMemSet*(
  b: BuilderRef, `ptr`: ValueRef, val: ValueRef, len: ValueRef, align: cuint
): ValueRef {.importc: "LLVMBuildMemSet", dynlib: LLVMLib.}

##
##  Creates and inserts a memcpy between the specified pointers.
##
##  @see llvm::IRRBuilder::CreateMemCpy()
##

proc buildMemCpy*(
  b: BuilderRef,
  dst: ValueRef,
  dstAlign: cuint,
  src: ValueRef,
  srcAlign: cuint,
  size: ValueRef,
): ValueRef {.importc: "LLVMBuildMemCpy", dynlib: LLVMLib.}

##
##  Creates and inserts a memmove between the specified pointers.
##
##  @see llvm::IRRBuilder::CreateMemMove()
##

proc buildMemMove*(
  b: BuilderRef,
  dst: ValueRef,
  dstAlign: cuint,
  src: ValueRef,
  srcAlign: cuint,
  size: ValueRef,
): ValueRef {.importc: "LLVMBuildMemMove", dynlib: LLVMLib.}

proc buildAlloca*(
  a1: BuilderRef, ty: TypeRef, name: cstring
): ValueRef {.importc: "LLVMBuildAlloca", dynlib: LLVMLib.}

proc buildArrayAlloca*(
  a1: BuilderRef, ty: TypeRef, val: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildArrayAlloca", dynlib: LLVMLib.}

proc buildFree*(
  a1: BuilderRef, pointerVal: ValueRef
): ValueRef {.importc: "LLVMBuildFree", dynlib: LLVMLib.}

proc buildLoad2*(
  a1: BuilderRef, ty: TypeRef, pointerVal: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildLoad2", dynlib: LLVMLib.}

proc buildStore*(
  a1: BuilderRef, val: ValueRef, `ptr`: ValueRef
): ValueRef {.importc: "LLVMBuildStore", dynlib: LLVMLib.}

proc buildGEP2*(
  b: BuilderRef,
  ty: TypeRef,
  pointer: ValueRef,
  indices: ptr ValueRef,
  numIndices: cuint,
  name: cstring,
): ValueRef {.importc: "LLVMBuildGEP2", dynlib: LLVMLib.}

proc buildInBoundsGEP2*(
  b: BuilderRef,
  ty: TypeRef,
  pointer: ValueRef,
  indices: ptr ValueRef,
  numIndices: cuint,
  name: cstring,
): ValueRef {.importc: "LLVMBuildInBoundsGEP2", dynlib: LLVMLib.}

##
##  Creates a GetElementPtr instruction. Similar to LLVMBuildGEP2, but allows
##  specifying the no-wrap flags.
##
##  @see llvm::IRBuilder::CreateGEP()
##

proc buildGEPWithNoWrapFlags*(
  b: BuilderRef,
  ty: TypeRef,
  pointer: ValueRef,
  indices: ptr ValueRef,
  numIndices: cuint,
  name: cstring,
  noWrapFlags: GEPNoWrapFlags,
): ValueRef {.importc: "LLVMBuildGEPWithNoWrapFlags", dynlib: LLVMLib.}

proc buildStructGEP2*(
  b: BuilderRef, ty: TypeRef, pointer: ValueRef, idx: cuint, name: cstring
): ValueRef {.importc: "LLVMBuildStructGEP2", dynlib: LLVMLib.}

proc buildGlobalString*(
  b: BuilderRef, str: cstring, name: cstring
): ValueRef {.importc: "LLVMBuildGlobalString", dynlib: LLVMLib.}

##
##  Deprecated: Use LLVMBuildGlobalString instead, which has identical behavior.
##

proc buildGlobalStringPtr*(
  b: BuilderRef, str: cstring, name: cstring
): ValueRef {.importc: "LLVMBuildGlobalStringPtr", dynlib: LLVMLib.}

proc getVolatile*(
  memoryAccessInst: ValueRef
): Bool {.importc: "LLVMGetVolatile", dynlib: LLVMLib.}

proc setVolatile*(
  memoryAccessInst: ValueRef, isVolatile: Bool
) {.importc: "LLVMSetVolatile", dynlib: LLVMLib.}

proc getWeak*(cmpXchgInst: ValueRef): Bool {.importc: "LLVMGetWeak", dynlib: LLVMLib.}
proc setWeak*(
  cmpXchgInst: ValueRef, isWeak: Bool
) {.importc: "LLVMSetWeak", dynlib: LLVMLib.}

proc getOrdering*(
  memoryAccessInst: ValueRef
): AtomicOrdering {.importc: "LLVMGetOrdering", dynlib: LLVMLib.}

proc setOrdering*(
  memoryAccessInst: ValueRef, ordering: AtomicOrdering
) {.importc: "LLVMSetOrdering", dynlib: LLVMLib.}

proc getAtomicRMWBinOp*(
  atomicRMWInst: ValueRef
): AtomicRMWBinOp {.importc: "LLVMGetAtomicRMWBinOp", dynlib: LLVMLib.}

proc setAtomicRMWBinOp*(
  atomicRMWInst: ValueRef, binOp: AtomicRMWBinOp
) {.importc: "LLVMSetAtomicRMWBinOp", dynlib: LLVMLib.}

##  Casts

proc buildTrunc*(
  a1: BuilderRef, val: ValueRef, destTy: TypeRef, name: cstring
): ValueRef {.importc: "LLVMBuildTrunc", dynlib: LLVMLib.}

proc buildZExt*(
  a1: BuilderRef, val: ValueRef, destTy: TypeRef, name: cstring
): ValueRef {.importc: "LLVMBuildZExt", dynlib: LLVMLib.}

proc buildSExt*(
  a1: BuilderRef, val: ValueRef, destTy: TypeRef, name: cstring
): ValueRef {.importc: "LLVMBuildSExt", dynlib: LLVMLib.}

proc buildFPToUI*(
  a1: BuilderRef, val: ValueRef, destTy: TypeRef, name: cstring
): ValueRef {.importc: "LLVMBuildFPToUI", dynlib: LLVMLib.}

proc buildFPToSI*(
  a1: BuilderRef, val: ValueRef, destTy: TypeRef, name: cstring
): ValueRef {.importc: "LLVMBuildFPToSI", dynlib: LLVMLib.}

proc buildUIToFP*(
  a1: BuilderRef, val: ValueRef, destTy: TypeRef, name: cstring
): ValueRef {.importc: "LLVMBuildUIToFP", dynlib: LLVMLib.}

proc buildSIToFP*(
  a1: BuilderRef, val: ValueRef, destTy: TypeRef, name: cstring
): ValueRef {.importc: "LLVMBuildSIToFP", dynlib: LLVMLib.}

proc buildFPTrunc*(
  a1: BuilderRef, val: ValueRef, destTy: TypeRef, name: cstring
): ValueRef {.importc: "LLVMBuildFPTrunc", dynlib: LLVMLib.}

proc buildFPExt*(
  a1: BuilderRef, val: ValueRef, destTy: TypeRef, name: cstring
): ValueRef {.importc: "LLVMBuildFPExt", dynlib: LLVMLib.}

proc buildPtrToInt*(
  a1: BuilderRef, val: ValueRef, destTy: TypeRef, name: cstring
): ValueRef {.importc: "LLVMBuildPtrToInt", dynlib: LLVMLib.}

proc buildIntToPtr*(
  a1: BuilderRef, val: ValueRef, destTy: TypeRef, name: cstring
): ValueRef {.importc: "LLVMBuildIntToPtr", dynlib: LLVMLib.}

proc buildBitCast*(
  a1: BuilderRef, val: ValueRef, destTy: TypeRef, name: cstring
): ValueRef {.importc: "LLVMBuildBitCast", dynlib: LLVMLib.}

proc buildAddrSpaceCast*(
  a1: BuilderRef, val: ValueRef, destTy: TypeRef, name: cstring
): ValueRef {.importc: "LLVMBuildAddrSpaceCast", dynlib: LLVMLib.}

proc buildZExtOrBitCast*(
  a1: BuilderRef, val: ValueRef, destTy: TypeRef, name: cstring
): ValueRef {.importc: "LLVMBuildZExtOrBitCast", dynlib: LLVMLib.}

proc buildSExtOrBitCast*(
  a1: BuilderRef, val: ValueRef, destTy: TypeRef, name: cstring
): ValueRef {.importc: "LLVMBuildSExtOrBitCast", dynlib: LLVMLib.}

proc buildTruncOrBitCast*(
  a1: BuilderRef, val: ValueRef, destTy: TypeRef, name: cstring
): ValueRef {.importc: "LLVMBuildTruncOrBitCast", dynlib: LLVMLib.}

proc buildCast*(
  b: BuilderRef, op: Opcode, val: ValueRef, destTy: TypeRef, name: cstring
): ValueRef {.importc: "LLVMBuildCast", dynlib: LLVMLib.}

proc buildPointerCast*(
  a1: BuilderRef, val: ValueRef, destTy: TypeRef, name: cstring
): ValueRef {.importc: "LLVMBuildPointerCast", dynlib: LLVMLib.}

proc buildIntCast2*(
  a1: BuilderRef, val: ValueRef, destTy: TypeRef, isSigned: Bool, name: cstring
): ValueRef {.importc: "LLVMBuildIntCast2", dynlib: LLVMLib.}

proc buildFPCast*(
  a1: BuilderRef, val: ValueRef, destTy: TypeRef, name: cstring
): ValueRef {.importc: "LLVMBuildFPCast", dynlib: LLVMLib.}

##  Deprecated: This cast is always signed. Use LLVMBuildIntCast2 instead.

proc buildIntCast*(
  a1: BuilderRef, val: ValueRef, destTy: TypeRef, name: cstring
): ValueRef {.importc: "LLVMBuildIntCast", dynlib: LLVMLib.} ## Signed cast!

proc getCastOpcode*(
  src: ValueRef, srcIsSigned: Bool, destTy: TypeRef, destIsSigned: Bool
): Opcode {.importc: "LLVMGetCastOpcode", dynlib: LLVMLib.}

##  Comparisons

proc buildICmp*(
  a1: BuilderRef, op: IntPredicate, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildICmp", dynlib: LLVMLib.}

proc buildFCmp*(
  a1: BuilderRef, op: RealPredicate, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildFCmp", dynlib: LLVMLib.}

##  Miscellaneous instructions

proc buildPhi*(
  a1: BuilderRef, ty: TypeRef, name: cstring
): ValueRef {.importc: "LLVMBuildPhi", dynlib: LLVMLib.}

proc buildCall2*(
  a1: BuilderRef,
  a2: TypeRef,
  fn: ValueRef,
  args: ptr ValueRef,
  numArgs: cuint,
  name: cstring,
): ValueRef {.importc: "LLVMBuildCall2", dynlib: LLVMLib.}

proc buildCallWithOperandBundles*(
  a1: BuilderRef,
  a2: TypeRef,
  fn: ValueRef,
  args: ptr ValueRef,
  numArgs: cuint,
  bundles: ptr OperandBundleRef,
  numBundles: cuint,
  name: cstring,
): ValueRef {.importc: "LLVMBuildCallWithOperandBundles", dynlib: LLVMLib.}

proc buildSelect*(
  a1: BuilderRef, `if`: ValueRef, then: ValueRef, `else`: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildSelect", dynlib: LLVMLib.}

proc buildVAArg*(
  a1: BuilderRef, list: ValueRef, ty: TypeRef, name: cstring
): ValueRef {.importc: "LLVMBuildVAArg", dynlib: LLVMLib.}

proc buildExtractElement*(
  a1: BuilderRef, vecVal: ValueRef, index: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildExtractElement", dynlib: LLVMLib.}

proc buildInsertElement*(
  a1: BuilderRef, vecVal: ValueRef, eltVal: ValueRef, index: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildInsertElement", dynlib: LLVMLib.}

proc buildShuffleVector*(
  a1: BuilderRef, v1: ValueRef, v2: ValueRef, mask: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildShuffleVector", dynlib: LLVMLib.}

proc buildExtractValue*(
  a1: BuilderRef, aggVal: ValueRef, index: cuint, name: cstring
): ValueRef {.importc: "LLVMBuildExtractValue", dynlib: LLVMLib.}

proc buildInsertValue*(
  a1: BuilderRef, aggVal: ValueRef, eltVal: ValueRef, index: cuint, name: cstring
): ValueRef {.importc: "LLVMBuildInsertValue", dynlib: LLVMLib.}

proc buildFreeze*(
  a1: BuilderRef, val: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildFreeze", dynlib: LLVMLib.}

proc buildIsNull*(
  a1: BuilderRef, val: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildIsNull", dynlib: LLVMLib.}

proc buildIsNotNull*(
  a1: BuilderRef, val: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildIsNotNull", dynlib: LLVMLib.}

proc buildPtrDiff2*(
  a1: BuilderRef, elemTy: TypeRef, lhs: ValueRef, rhs: ValueRef, name: cstring
): ValueRef {.importc: "LLVMBuildPtrDiff2", dynlib: LLVMLib.}

proc buildFence*(
  b: BuilderRef, ordering: AtomicOrdering, singleThread: Bool, name: cstring
): ValueRef {.importc: "LLVMBuildFence", dynlib: LLVMLib.}

proc buildFenceSyncScope*(
  b: BuilderRef, ordering: AtomicOrdering, ssid: cuint, name: cstring
): ValueRef {.importc: "LLVMBuildFenceSyncScope", dynlib: LLVMLib.}

proc buildAtomicRMW*(
  b: BuilderRef,
  op: AtomicRMWBinOp,
  `ptr`: ValueRef,
  val: ValueRef,
  ordering: AtomicOrdering,
  singleThread: Bool,
): ValueRef {.importc: "LLVMBuildAtomicRMW", dynlib: LLVMLib.}

proc buildAtomicRMWSyncScope*(
  b: BuilderRef,
  op: AtomicRMWBinOp,
  `ptr`: ValueRef,
  val: ValueRef,
  ordering: AtomicOrdering,
  ssid: cuint,
): ValueRef {.importc: "LLVMBuildAtomicRMWSyncScope", dynlib: LLVMLib.}

proc buildAtomicCmpXchg*(
  b: BuilderRef,
  `ptr`: ValueRef,
  cmp: ValueRef,
  new: ValueRef,
  successOrdering: AtomicOrdering,
  failureOrdering: AtomicOrdering,
  singleThread: Bool,
): ValueRef {.importc: "LLVMBuildAtomicCmpXchg", dynlib: LLVMLib.}

proc buildAtomicCmpXchgSyncScope*(
  b: BuilderRef,
  `ptr`: ValueRef,
  cmp: ValueRef,
  new: ValueRef,
  successOrdering: AtomicOrdering,
  failureOrdering: AtomicOrdering,
  ssid: cuint,
): ValueRef {.importc: "LLVMBuildAtomicCmpXchgSyncScope", dynlib: LLVMLib.}

##
##  Get the number of elements in the mask of a ShuffleVector instruction.
##

proc getNumMaskElements*(
  shuffleVectorInst: ValueRef
): cuint {.importc: "LLVMGetNumMaskElements", dynlib: LLVMLib.}

##
##  \returns a constant that specifies that the result of a \c ShuffleVectorInst
##  is undefined.
##

proc getUndefMaskElem*(): cint {.importc: "LLVMGetUndefMaskElem", dynlib: LLVMLib.}
##
##  Get the mask value at position Elt in the mask of a ShuffleVector
##  instruction.
##
##  \Returns the result of \c LLVMGetUndefMaskElem() if the mask value is
##  poison at that position.
##

proc getMaskValue*(
  shuffleVectorInst: ValueRef, elt: cuint
): cint {.importc: "LLVMGetMaskValue", dynlib: LLVMLib.}

proc isAtomicSingleThread*(
  atomicInst: ValueRef
): Bool {.importc: "LLVMIsAtomicSingleThread", dynlib: LLVMLib.}

proc setAtomicSingleThread*(
  atomicInst: ValueRef, singleThread: Bool
) {.importc: "LLVMSetAtomicSingleThread", dynlib: LLVMLib.}

##
##  Returns whether an instruction is an atomic instruction, e.g., atomicrmw,
##  cmpxchg, fence, or loads and stores with atomic ordering.
##

proc isAtomic*(inst: ValueRef): Bool {.importc: "LLVMIsAtomic", dynlib: LLVMLib.}
##
##  Returns the synchronization scope ID of an atomic instruction.
##

proc getAtomicSyncScopeID*(
  atomicInst: ValueRef
): cuint {.importc: "LLVMGetAtomicSyncScopeID", dynlib: LLVMLib.}

##
##  Sets the synchronization scope ID of an atomic instruction.
##

proc setAtomicSyncScopeID*(
  atomicInst: ValueRef, ssid: cuint
) {.importc: "LLVMSetAtomicSyncScopeID", dynlib: LLVMLib.}

proc getCmpXchgSuccessOrdering*(
  cmpXchgInst: ValueRef
): AtomicOrdering {.importc: "LLVMGetCmpXchgSuccessOrdering", dynlib: LLVMLib.}

proc setCmpXchgSuccessOrdering*(
  cmpXchgInst: ValueRef, ordering: AtomicOrdering
) {.importc: "LLVMSetCmpXchgSuccessOrdering", dynlib: LLVMLib.}

proc getCmpXchgFailureOrdering*(
  cmpXchgInst: ValueRef
): AtomicOrdering {.importc: "LLVMGetCmpXchgFailureOrdering", dynlib: LLVMLib.}

proc setCmpXchgFailureOrdering*(
  cmpXchgInst: ValueRef, ordering: AtomicOrdering
) {.importc: "LLVMSetCmpXchgFailureOrdering", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCCoreModuleProvider Module Providers
##
##  @{
##
##
##  Changes the type of M so it can be passed to FunctionPassManagers and the
##  JIT.  They take ModuleProviders for historical reasons.
##

proc createModuleProviderForExistingModule*(
  m: ModuleRef
): ModuleProviderRef {.
  importc: "LLVMCreateModuleProviderForExistingModule", dynlib: LLVMLib
.}

##
##  Destroys the module M.
##

proc disposeModuleProvider*(
  m: ModuleProviderRef
) {.importc: "LLVMDisposeModuleProvider", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCCoreMemoryBuffers Memory Buffers
##
##  @{
##

proc createMemoryBufferWithContentsOfFile*(
  path: cstring, outMemBuf: ptr MemoryBufferRef, outMessage: cstringArray
): Bool {.importc: "LLVMCreateMemoryBufferWithContentsOfFile", dynlib: LLVMLib.}

proc createMemoryBufferWithSTDIN*(
  outMemBuf: ptr MemoryBufferRef, outMessage: cstringArray
): Bool {.importc: "LLVMCreateMemoryBufferWithSTDIN", dynlib: LLVMLib.}

proc createMemoryBufferWithMemoryRange*(
  inputData: cstring,
  inputDataLength: csize_t,
  bufferName: cstring,
  requiresNullTerminator: Bool,
): MemoryBufferRef {.importc: "LLVMCreateMemoryBufferWithMemoryRange", dynlib: LLVMLib.}

proc createMemoryBufferWithMemoryRangeCopy*(
  inputData: cstring, inputDataLength: csize_t, bufferName: cstring
): MemoryBufferRef {.
  importc: "LLVMCreateMemoryBufferWithMemoryRangeCopy", dynlib: LLVMLib
.}

proc getBufferStart*(
  memBuf: MemoryBufferRef
): cstring {.importc: "LLVMGetBufferStart", dynlib: LLVMLib.}

proc getBufferSize*(
  memBuf: MemoryBufferRef
): csize_t {.importc: "LLVMGetBufferSize", dynlib: LLVMLib.}

proc disposeMemoryBuffer*(
  memBuf: MemoryBufferRef
) {.importc: "LLVMDisposeMemoryBuffer", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCCorePassManagers Pass Managers
##  @ingroup LLVMCCore
##
##  @{
##
##  Constructs a new whole-module pass pipeline. This type of pipeline is
##     suitable for link-time optimization and whole-module transformations.
##     @see llvm::PassManager::PassManager

proc createPassManager*(): PassManagerRef {.
  importc: "LLVMCreatePassManager", dynlib: LLVMLib
.}

##  Constructs a new function-by-function pass pipeline over the module
##     provider. It does not take ownership of the module provider. This type of
##     pipeline is suitable for code generation and JIT compilation tasks.
##     @see llvm::FunctionPassManager::FunctionPassManager

proc createFunctionPassManagerForModule*(
  m: ModuleRef
): PassManagerRef {.importc: "LLVMCreateFunctionPassManagerForModule", dynlib: LLVMLib.}

##  Deprecated: Use LLVMCreateFunctionPassManagerForModule instead.

proc createFunctionPassManager*(
  mp: ModuleProviderRef
): PassManagerRef {.importc: "LLVMCreateFunctionPassManager", dynlib: LLVMLib.}

##  Initializes, executes on the provided module, and finalizes all of the
##     passes scheduled in the pass manager. Returns 1 if any of the passes
##     modified the module, 0 otherwise.
##     @see llvm::PassManager::run(Module&)

proc runPassManager*(
  pm: PassManagerRef, m: ModuleRef
): Bool {.importc: "LLVMRunPassManager", dynlib: LLVMLib.}

##  Initializes all of the function passes scheduled in the function pass
##     manager. Returns 1 if any of the passes modified the module, 0 otherwise.
##     @see llvm::FunctionPassManager::doInitialization

proc initializeFunctionPassManager*(
  fpm: PassManagerRef
): Bool {.importc: "LLVMInitializeFunctionPassManager", dynlib: LLVMLib.}

##  Executes all of the function passes scheduled in the function pass manager
##     on the provided function. Returns 1 if any of the passes modified the
##     function, false otherwise.
##     @see llvm::FunctionPassManager::run(Function&)

proc runFunctionPassManager*(
  fpm: PassManagerRef, f: ValueRef
): Bool {.importc: "LLVMRunFunctionPassManager", dynlib: LLVMLib.}

##  Finalizes all of the function passes scheduled in the function pass
##     manager. Returns 1 if any of the passes modified the module, 0 otherwise.
##     @see llvm::FunctionPassManager::doFinalization

proc finalizeFunctionPassManager*(
  fpm: PassManagerRef
): Bool {.importc: "LLVMFinalizeFunctionPassManager", dynlib: LLVMLib.}

##  Frees the memory of a pass pipeline. For function pipelines, does not free
##     the module provider.
##     @see llvm::PassManagerBase::~PassManagerBase.

proc disposePassManager*(
  pm: PassManagerRef
) {.importc: "LLVMDisposePassManager", dynlib: LLVMLib.}

##
##  @}
##
##
##  @defgroup LLVMCCoreThreading Threading
##
##  Handle the structures needed to make LLVM safe for multithreading.
##
##  @{
##
##  Deprecated: Multi-threading can only be enabled/disabled with the compile
##     time define LLVM_ENABLE_THREADS.  This function always returns
##     LLVMIsMultithreaded().

proc startMultithreaded*(): Bool {.importc: "LLVMStartMultithreaded", dynlib: LLVMLib.}
##  Deprecated: Multi-threading can only be enabled/disabled with the compile
##     time define LLVM_ENABLE_THREADS.

proc stopMultithreaded*() {.importc: "LLVMStopMultithreaded", dynlib: LLVMLib.}
##  Check whether LLVM is executing in thread-safe mode or not.
##     @see llvm::llvm_is_multithreaded

proc isMultithreaded*(): Bool {.importc: "LLVMIsMultithreaded", dynlib: LLVMLib.}
##
##  @}
##
##
##  @}
##
##
##  @}
##
