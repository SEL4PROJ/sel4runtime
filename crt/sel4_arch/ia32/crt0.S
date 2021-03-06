/*
 * Copyright 2019, Data61, CSIRO (ABN 41 687 119 230)
 *
 * SPDX-License-Identifier: BSD-2-Clause
 */
.section .text
.global _start
_start:
	mov %esp, %ebp

	/*
	 * GCC expects that a C function is always entered via a call
	 * instruction and that the stack is 16-byte aligned before such an
	 * instruction (leaving it 16-byte aligned + 1 word from the
	 * implicit push when the function is entered).
	 *
	 * If additional items are pushed onto the stack, the stack must be
	 * manually re-aligned before before pushing the arguments for the
	 * call instruction to __sel4_start_c.
	 */
	sub  $0xc, %esp
	push %ebp
	call __sel4_start_c

	/* should not return */
1:
	jmp  1b
