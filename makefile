test : test.asm
	nasm -f elf64 -o test.o test.asm
	ld -o test test.o
	./test
	rm test.o
	rm test

n_cat : nem_cat.asm
	nasm -f elf64 -o n_cat.o nem_cat.asm
	ld -o n_cat n_cat.o
	./n_cat
	rm n_cat.o
	rm n_cat
