all : sena.l sena.y
	clear
	flex -i sena.l
	bison sena.y
	gcc sena.tab.c -o sena-analisador -lfl -lm
	clear
	./sena-analisador
