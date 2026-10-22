# BVS1 – Betriebssysteme: Course Code

This branch is the **Checkpoint 1 process scaffold**.

## What is provided

- `start.S` and `linker.ld`;
- UART output support in the starter;
- `context.h`: the saved RV64 CPU context representation;
- `context.S`: the provided `context_switch(current_context, next_context)`;
- Make/QEMU integration;
- `make check-cp1`: an observable-behaviour checker.

## What is deliberately not provided

There is no:

- `process.h`;
- `process.c`;
- `libprocess.a`;
- implementation of `process_create()`, `process_run()`, `process_yield()`, or `process_exit()`.

For Checkpoint 1, that C-level process abstraction is your work.

A useful strategy is to reuse the seeded worker from Exercise 02 unchanged. In Exercise 02 it ran against the provided `libprocess.a`; for CP1, the same application should run against your own process implementation.

The build automatically compiles C files that you add at the repository root, so adding files such as `process.c` and `process.h` does not require changing the source list.

## Build and check

```bash
make check
make
make run
make check-cp1
```

The CP1 checker expects the announced seeded process behaviour:

```text
exercise: seed 11
process: before yield 34
os: process yielded
process: result 177
os: process exited 177
```

Passing the checker is preparation evidence only. The mandatory checkpoint also requires individual explanation of the implementation.

## Environment

Use the course-provided Ubuntu 26.04 VM. Exit QEMU with **Ctrl-a**, release the keys, then press **x**.
