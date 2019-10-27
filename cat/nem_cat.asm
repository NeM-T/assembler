section .data
	cant db "open error", 10
	length equ $- cant
	errnum equ 0xFFFFFFFE
	sys_open equ 2
	sys_write equ 1
	sys_read equ 0
	sys_close equ 3
	sys_fstat equ 5

section .bss
	msg resb 1

	struc stat
		.st_dev resb 8 ;デバイスID
		.st_ino resb 8 ;inode_number
		.st_mode resb 4 ;アクセス保護
		.st_nlink resb 8 ;ハードリンク数
		.st_uid resb 4 ;ユーザーID
		.st_gid resb 4 ;グループID
		.st_rdev resb 8 ;デバイスID　特殊ファイルの場合
		.st_size resb 8 ;byte_size
		.st_blksize resb 8 ;ファイルシステムのブロックサイズ
		.st_blocks resb 8 ;割り当てられたブロック数
		.st_atime resb 8 ;最終アクセス時刻
		.st_mtime resb 8 ;最終修正時刻
		.st_ctime resb 8 ;最終常態変更時刻
	endstruc

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

	mov rax, sys_fstat
	pop rdi
	mov rsi, stat ;struct stat *statbuf
	syscall

	push rdi

	cmp rax, errnum
	je op_error

	;read
	mov rax, sys_read
	pop rdi
	mov rsi, msg ;書き込み先
	mov rdx, stat.st_size ;読み込む文字数
	syscall
	
	;write
	mov rsi, msg ;読み込み先
	mov rdx, stat.st_size ;書き込む文字数
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
