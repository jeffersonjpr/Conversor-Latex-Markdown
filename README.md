# Tradutor Simples Latex para Markdown
<div align="center">
 
![visitor badge](https://visitor-badge.laobi.icu/badge?page_id=Conversor-Latex-Markdown&title=Viewers)
</div>

1° Trabalho da disciplina de Compiladores.  
Trabalho feito com o intuito de aplicar os conceitos aprendidos na primeira parte, do semestre de Compiladores.  

### Principais assuntos abordados neste trabalho:
* Analise Léxica (Flex)
* Analise Sintática (Bison)

### Integrantes do grupo
* **Jefferson Michael de Azevedo Junior**
  * Aluno de Ciência da Computação na UTFPR.
* **Nicholas Damasceno Pinto**
  * Aluno de Ciência da Computação na UTFPR.

### MakeFile
'''console    
conversor: sintatico.y lexico.l
	clear
	flex lexico.l
	bison -d sintatico.y
	gcc -o conversor.out lex.yy.c sintatico.tab.c -lfl
	./conversor.out teste1.lex markdown.md
clean:
	rm lex.yy.c sintatico.tab.c sintatico.tab.h
teste1:
	./conversor.out teste1.lex markdown.md
teste2:
	./conversor.out teste2.lex markdown.md
'''
