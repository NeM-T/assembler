section .data
	cant db "open error", 10
	length equ $- cant
	errnum equ 0xFFFFFFFE

section .bss
	msg resb 1

section .text
	global _start

_write:
	mov rax, 1
	mov rdi, 1
	syscall
	ret

_start:
	pop rcx
	pop rbx
	push rcx

argloop:
	open:
	pop rcx
	pop rbx
	dec rcx
	push rcx
	cmp rcx, 0
	je end

	;open
	mov rax, 2
	mov rdi, rbx
	mov rsi, 0
	mov rdx, 0
	syscall

	cmp rax, errnum
	je op_error

	push rax

	wrloop:
		;read
		mov rax, 0
		pop rdi
		mov rsi, msg
		mov rdx, 1
		syscall
		
		cmp rax, 0
		je close

		push rdi
		;write
		mov rsi, msg
		mov rdx, 1
		call _write
	jmp wrloop

	close:
	mov rax, 3
	mov rdi, 0
	mov rsi, 0
	mov rdx, 0
	syscall
jmp argloop

op_error:
	mov rsi, cant
	mov rdx, length
	call _write

end:
	;exit
	mov rax, 60
	mov rdi, 0
	syscall
