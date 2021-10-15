 
CC=gcc
BIN=bin
SRC=src

all: clean comp

comp:
	mkdir -p $(BIN)
	cd $(SRC); \
	flex for.l; \
	yacc -vd for.y; \
	$(CC) lex.yy.c y.tab.c -o ../$(BIN)/for.out -L -ll -ly -lm ; \
	rm lex.yy.c y.tab.c y.tab.h y.output
	${BIN}/for.out

debug:
	mkdir -p $(BIN)
	cd $(SRC); \
	flex for.l; \
	yacc -vd for.y; \
	$(CC) lex.yy.c y.tab.c -o ../$(BIN)/for.out -L -ll -lm -ly  -g -DDEBUG; \
	rm lex.yy.c y.tab.c y.tab.h y.output
	${BIN}/for.out
clean:
	rm -rf $(BIN)
