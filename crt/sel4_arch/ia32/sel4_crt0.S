/*
 * Copyright 2019, Data61, CSIRO (ABN 41 687 119 230)
 *
 * SPDX-License-Identifier: BSD-2-Clause
 */
#include <sel4runtime/gen_config.h>

.section .text
.global _sel4_start
_sel4_start:
	leal __stack_top, %esp
	mov  %esp, %ebp
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
	sub  $0x8, %esp
	push %ebp
	push %ebx
	call __sel4_start_root

	/* should not return */
1:
	jmp  1b

.section .bss
__stack_base:
	.align 16
	.space CONFIG_SEL4RUNTIME_ROOT_STACK
__stack_top:
