section .data
	cant db "open error", 10
	length equ $- cant
	errnum equ 0xFFFFFFFE

	sys_open equ 2
	sys_write equ 1
	sys_read equ 0
	sys_close equ 3
	sys_lseek equ 8
	sys_brk equ 12

	seek_start equ 0
	seek_end equ 2

section .bss
	msg resb 1

section .text
	global _start

_write:
	mov rax, sys_write
	mov rdi, 1 ;標準出力
	syscall
	ret

_start:
	pop rcx ;コマンドライン引数の数
	pop rbx ;./n_cat
	push rcx

argloop:
	pop rcx
	pop rbx ;コマンドライン引数
	dec rcx
	push rcx
	cmp rcx, 0
	je end

	;open
	mov rax, sys_open
	mov rdi, rbx
	mov rsi, 0
	mov rdx, 0
	syscall

	push rax
	cmp rax, errnum
	je op_error

	mov rax, sys_lseek
	pop rdi
	mov rsi, 0
	mov rdx, seek_end
	syscall

	push rax
	push rdi

	mov rax, sys_lseek
	pop rdi
	mov rsi, 0
	mov rdx, seek_start
	syscall

	push rdi 

	;read
	mov rax, sys_read
	pop rdi
	mov rsi, msg ;書き込み先
	pop rdx ;読み込む文字数
	syscall

	push rax
	
	;write
	mov rsi, msg ;読み込み先
	pop rdx ;書き込む文字数
	call _write

	close:
	mov rax, sys_close
	mov rdi, 0
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
