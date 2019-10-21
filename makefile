test : test.asm
	nasm -f elf64 -o test.o test.asm
	ld -o test test.o
	./test
	rm test.o
	rm test

comm: command.asm
	nasm -f elf64 -o c.o command.asm
	ld -o c c.o
	rm c.o
