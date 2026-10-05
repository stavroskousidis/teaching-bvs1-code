# BVS1 – Betriebssysteme: Course Code

This is the student code repository for **BVS1 – Betriebssysteme** at TH Köln, ICCT.

The repository starts with a deliberately minimal RV64 program that prints:

```text
Hello BVS1
```

It will grow throughout the semester into a small educational operating system.

## Course Workflow

Clone this repository **once** inside the Ubuntu 26.04 course VM:

```bash
git clone https://github.com/stavroskousidis/teaching-bvs1-code.git
cd teaching-bvs1-code
```

No GitHub account is required.

Your clone is your local semester repository. Keep it throughout the course and commit meaningful working states locally.

Do not push your work to this repository, and do not pull new course states unless explicitly instructed.

## Check, Build, and Run

```bash
make check
make
make run
```

Expected guest output:

```text
Hello BVS1
```

Exit QEMU with **Ctrl-a**, then **x**.

Useful inspection targets:

```bash
make inspect
make disasm
```

Generated files are written to `build/`.

## Environment

The supported development environment is the course-provided Ubuntu 26.04 VM named `bvs1`.

Inside that VM:

- Git and Make manage the local code and build,
- the RISC-V cross-toolchain produces RV64 code,
- QEMU emulates the RV64 `virt` teaching machine.

The initial guest program contains **no operating system**. That is the starting point of the course.
