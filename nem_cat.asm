section .data
	fname db "test.txt", 0
	cant db "cannot open", 10
	length equ $- cant
	errnum equ 0xFFFFFFFE

section .bss
	msg resb 1
	command resb 1

section .text
	global _start

_write:
	mov rax, 1
	mov rdi, 1
	syscall
	ret

_start:
	pop rcx
	add rcx, 48
	push rcx
	mov rsi, rsp
	mov rdx, 1
	call _write

argloop:
	pop rcx
	dec rcx
	cmp rcx, 48
	push rcx
	je end

	;read filename
	

	open:
	mov rax, 2
	mov rdi, fname
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
		je write_newline

		push rdi
		;write
		mov rsi, msg
		mov rdx, 1
		call _write
	jmp wrloop

write_newline:
	;close
	mov rax, 3
	mov rdi, 0
	mov rsi, 0
	mov rdx, 0
	syscall

	;改行
	mov rsi, 10
	mov rdx, 1
	call _write
	;jmp argloop

op_error:
	mov rsi, cant
	mov rdx, length
	call _write

end:
	;exit
	mov rax, 60
	mov rdi, 0
	syscall
