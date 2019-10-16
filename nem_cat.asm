section .data
fname: db "test.asm", 0

global _start

_start:

mov rax, 2
mov rdi, fname
mov rsi, 0
mov rdx, 0
syscall

mov rdi, rax
mov rax, 0
sub rsp, 24
;mov rdi, 0
mov rsi, [rsp]
mov rdx, 3
syscall

mov rax, 1
mov rdi, 1
mov rsi, rsp
mov rdx, 3
syscall

mov rax, 60
mov rdi, 0
syscall
