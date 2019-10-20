section .text
    global _start

_start:
  call .printNumberOfArgs
  call .printNewline
  call .printArg
  call .printNewline
  call .exit

.printNumberOfArgs:
  pop rbx
  pop rcx 
  add rcx, 48
  push rcx
  mov rsi, rsp
  mov rdx, 3
  push rbx 
  call .print

  pop rbx
  pop rcx
  push rbx
  ret

.printArg:
  pop rcx
  mov rsi, [rsp]
  mov rdx, 10
  push rcx 
  jmp .print
  ret

.printNewline:
  pop rbx
  push 10
  mov rsi, rsp
  mov rdx, 1
  push rbx
  call .print

  pop rbx
  pop rcx
  push rbx
  ret
  
.print:
  mov rax, 1
  mov rdi, 1
  syscall
  ret

.exit:
  mov rax, 60
  mov rdi, 0
  syscall