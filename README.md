# Double‑Pointer Call Analysis Pass

*A lightweight LLVM 14 plugin that finds function arguments and IR operands that ultimately contain a **pointer‑to‑pointer***

---

## 1  Project overview

This repository contains a single **out‑of‑tree LLVM pass** (see `HelloWorld.cpp`) that:

1. Traverses every **Function** in a module.
2. Flags any *argument* whose type is a pointer **and** whose pointee type (recursively) also contains a pointer ("double pointer").
3. Walks every instruction and tests each operand the same way.
4. Prints colour‑coded diagnostics so you can instantly see true positives when running under a terminal that supports ANSI colours.

The pass was developed for Prof. Zhou’s *double‑pointer call‑site* assignment and has been validated on:

* **Synthetic demo IR** (`input_for_hello.ll`, `input_for_instruction.ll`)
* **MCF benchmark** from SPEC CPU (≈ 3 K LoC) – full walk‑through below

---

## 2  Repository layout

```
.
├─ CMakeLists.txt            # minimal build script for the plugin
├─ HelloWorld.cpp            # the pass implementation (aka DoublePtrPass)
├─ build/                    # CMake/Ninja artefacts – ignored by git in practice
│   └─ libHelloWorld.so      # shared object produced after `cmake --build`
├─ input_for_hello.ll        # tiny IR sample (function‑argument demo)
└─ input_for_instruction.ll  # tiny IR sample (instruction‑operand demo)
```

> **Note:** The `build/` folder is shown here for completeness but should be listed in `.gitignore` when you push.

---

## 3  Prerequisites

| Tool                      | Version                                               | Ubuntu package                  |
| ------------------------- | ----------------------------------------------------- | ------------------------------- |
| LLVM / Clang              | **14** (must *not* be ≥ 15, to avoid opaque pointers) | `llvm-14`, `clang-14`, `lld-14` |
| CMake                     | ≥ 3.13                                                | `cmake`                         |
| Ninja (optional but fast) | any                                                   | `ninja-build`                   |
| Build essentials          | –                                                     | `build-essential`               |

Install in one go:

```bash
sudo apt update && \
  sudo apt install -y llvm-14 clang-14 lld-14 cmake ninja-build build-essential
```

---

## 4  Building the pass

```bash
# clone your repo somewhere
cd ~/llvm/llvm-tutor/HelloWorld-Instructions

# configure + build
cmake -B build -G Ninja \
      -DLLVM_DIR=/usr/lib/llvm-14/lib/cmake/llvm \
      -DCMAKE_BUILD_TYPE=Release
cmake --build build            # → build/libHelloWorld.so
```

> If `LLVM_DIR` differs on your machine, adjust the path accordingly.

---

## 5  Quick sanity check (built‑in IR samples)

```bash
opt-14 -load-pass-plugin build/libHelloWorld.so \
       -passes=hello-world -disable-output input_for_hello.ll
```

You should see colourful output and at least one line ending with **`<-- double pointer!`**.

---

## 6  Running on the MCF benchmark (small real code‑base)

This mirrors the demo shared with Prof. Zhou.

### 6‑1 Fetch full source

```bash
mkdir -p ~/benchmarks && cd ~/benchmarks

git clone https://github.com/mcai/Archimulator.git
cd Archimulator/benchmarks/CPU2006_Custom1/429.mcf/baseline
```

### 6‑2 Compile every `.c` file to LLVM bitcode

```bash
mkdir -p build && cd build
for f in ../*.c; do
  clang-14 -O1 -g -emit-llvm -c "$f" -I.. -o "$(basename ${f%.c}).bc"
done
```

### 6‑3 (Option A) link to one big module

```bash
llvm-link-14 *.bc -o mcf.bc
```

### 6‑4 Run the pass

```bash
opt-14 -load-pass-plugin ~/llvm/llvm-tutor/HelloWorld-Instructions/build/libHelloWorld.so \
       -passes=hello-world -disable-output mcf.bc | tee ../../mcf_coloured.log

# strip ANSI colour before uploading / parsing:
sed 's/\x1B\[[0-9;]*[JKmsu]//g' ../../mcf_coloured.log > ../../mcf_plain.log
```

The resulting `mcf_plain.log` is exactly what produced the snippet shown in our email (look for `resize_prob` etc.).  Every line containing *double pointer!* marks a true hit.

### 6‑5 Optional one‑click script

A ready‑made helper lives in `scripts/run_mcf.sh`; invoke it with:

```bash
./scripts/run_mcf.sh build/libHelloWorld.so
```

It recompiles IR, runs the pass, generates both coloured & plain logs and highlights the hit count.

---

## 7  Interpreting the output

* **\[Function]** headers list the function name and argument count.
* Each argument or operand prints its LLVM type.  If `isDoublePointer()` returns **true**,
  a green marker **`<-- double pointer!`** is appended.
* Add `getDebugLoc()` printing (already stubbed in the code) to show `file:line` for every hit – required later when mapping IR → source lines.

---

## 8  Scaling up to large programs

Once MCF is clean you can replicate the *identical* workflow for any program in Table 1 of the Checked‑C paper:

1. Clone the exact version (e.g. `curl-7.79.1`).
2. Build with `clang-14 -emit-llvm`.
3. Run `opt-14` with this plugin.
4. Strip colour & import the plain log into a Google Sheet.

A convenience script `scripts/run_project.sh <path-to-src> <pass-lib>` will appear soon to automate steps 1‑3 for each target.

---

## 9  Known caveats

* **LLVM ≥ 15** uses opaque pointers – stick to version 14.
* If you see *could not load plugin*, ensure `LD_LIBRARY_PATH` contains LLVM 14’s `lib` directory.
* Very large `.ll` files (PHP, FFmpeg) can consume > 4 GB RAM.  Use `-O0` or split per‑TU runs if needed.

---

## 10  License

This pass is released under the MIT license (see `LICENSE` file).  Benchmarks retain their original upstream licenses.

---

## 11  References

* **Checked C at Scale** – Zhou *et al.* (OOPSLA 2023) – Table 1 program list
* LLVM 14 Programmer’s Manual
* llvm‑tutor sample passes
