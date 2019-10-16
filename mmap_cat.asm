%define O_READONLY 0
%define PROT_READ 0x1
%define MAP_PRIVATE 0x2

section .data
fname: db 'test.txt', 0

section .text
global _start

; rdi に入っているアドレスの文字列を表示する
print_string:
    push rdi
    call string_length
    pop rsi
    mov rdx, rax
    mov rax, 1
    mov rdi, 1
    syscall
    ret

; rdi に入っている文字列の長さを計算する
; 結果は rax に入れて終了する
string_length:
    xor rax, rax
.loop:
    cmp byte [rdi+rax], 0
    je .end
    inc rax
    jmp .loop
.end:
    ret

_start:

; open の呼び出し. 詳細は後述
mov rax, 2
mov rdi, fname
mov rsi, O_READONLY
mov rdx, 0
syscall

; open によって rax に開いたファイルのファイルディスクリプタが入ってくるので保存しておく
mov r8, rax

; mmap の呼び出し. 詳細は後述
mov rax, 9
mov rdi, 0
mov rsi, 4096
mov rdx, PROT_READ
mov r10, MAP_PRIVATE
mov r9, 0
syscall

; mmap によって割り当てたメモリのアドレスが rax に入ってくるので rdi に保存し print_string で出力する
mov rdi, rax
call print_string

; exit
mov rax, 60
xor rdi, rdi
syscall
