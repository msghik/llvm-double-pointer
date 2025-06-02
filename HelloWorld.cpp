//=============================================================================
// FILE:
//    HelloWorld.cpp
//
// DESCRIPTION:
//    Visits all functions in a module, prints their names and the number of
//    arguments via stderr. Strictly speaking, this is an analysis pass (i.e.
//    the functions are not modified). However, in order to keep things simple
//    there's no 'print' method here (every analysis pass should implement it).
//
// USAGE:
//    New PM
//      opt -load-pass-plugin=libHelloWorld.dylib -passes="hello-world" `\`
//        -disable-output <input-llvm-file>
//
//
// License: MIT
//=============================================================================
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Type.h"

using namespace llvm;

//-----------------------------------------------------------------------------
// HelloWorld implementation
//-----------------------------------------------------------------------------
// No need to expose the internals of the pass to the outside world - keep
// everything in an anonymous namespace.
namespace {

  static bool containsPointer(Type *Ty) {
    if (!Ty) return false;
  
    if (auto *PTy = dyn_cast<PointerType>(Ty)) {
      return !PTy->isOpaque();
    }
  
    if (auto *ArrTy = dyn_cast<ArrayType>(Ty))
      return containsPointer(ArrTy->getElementType());
  
    if (auto *StructTy = dyn_cast<StructType>(Ty)) {
      for (Type *Elt : StructTy->elements())
        if (containsPointer(Elt))
          return true;
    }
  
    return false;
  }
  
  static bool isDoublePointer(Type *ArgTy) {
    auto *FirstPtr = dyn_cast<PointerType>(ArgTy);
    if (!FirstPtr || FirstPtr->isOpaque())
      return false;
    return containsPointer(FirstPtr->getElementType());
  }
  
  void visitor(Function &F) {
    // Function header
    errs().changeColor(raw_ostream::CYAN, true);
    errs() << "\n[Function] ";
    errs().resetColor();
    errs() << F.getName() << "\n";
  
    errs().changeColor(raw_ostream::MAGENTA);
    errs() << "  Number of arguments: ";
    errs().resetColor();
    errs() << F.arg_size() << "\n";
  
    unsigned ArgIdx = 0;
    for (const Argument &Arg : F.args()) {
      errs().changeColor(raw_ostream::YELLOW);
      errs() << "    [Arg " << ArgIdx << "] Type: ";
      errs().resetColor();
      Arg.getType()->print(errs());
  
      if (isDoublePointer(Arg.getType())) {
        errs().changeColor(raw_ostream::GREEN, true);
        errs() << "   <-- double pointer!";
        errs().resetColor();
      }
  
      errs() << "\n";
      ++ArgIdx;
    }
  
    // Instructions
    for (BasicBlock &BB : F) {
      for (Instruction &I : BB) {
        errs().changeColor(raw_ostream::CYAN, true);
        errs() << "  [Instruction] ";
        errs().resetColor();
        I.print(errs());
        errs() << "\n";
  
        for (unsigned i = 0; i < I.getNumOperands(); ++i) {
          Value *Op = I.getOperand(i);
          Type *OpType = Op->getType();
  
          errs().changeColor(raw_ostream::YELLOW);
          errs() << "    [Operand " << i << "] Type: ";
          errs().resetColor();
          OpType->print(errs());
  
          if (Op->hasName())
            errs() << " (" << Op->getName() << ")";
  
          if (isDoublePointer(OpType)) {
            errs().changeColor(raw_ostream::GREEN, true);
            errs() << "   <-- double pointer!";
            errs().resetColor();
          }
  
          errs() << "\n";
        }
      }
    }
  
    errs() << "\n";
  }
  
  } // end anonymous namespace
// New PM implementation
struct HelloWorld : PassInfoMixin<HelloWorld> {
  // Main entry point, takes IR unit to run the pass on (&F) and the
  // corresponding pass manager (to be queried if need be)
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &) {
    visitor(F);
    return PreservedAnalyses::all();
  }

  // Without isRequired returning true, this pass will be skipped for functions
  // decorated with the optnone LLVM attribute. Note that clang -O0 decorates
  // all functions with optnone.
  static bool isRequired() { return true; }
};

//-----------------------------------------------------------------------------
// New PM Registration
//-----------------------------------------------------------------------------
llvm::PassPluginLibraryInfo getHelloWorldPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "HelloWorld", LLVM_VERSION_STRING,
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "hello-world") {
                    FPM.addPass(HelloWorld());
                    return true;
                  }
                  return false;
                });
          }};
}

// This is the core interface for pass plugins. It guarantees that 'opt' will
// be able to recognize HelloWorld when added to the pass pipeline on the
// command line, i.e. via '-passes=hello-world'
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getHelloWorldPluginInfo();
}
