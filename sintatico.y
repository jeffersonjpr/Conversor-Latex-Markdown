%{
#include <stdio.h>
#include <stdlib.h>
#include "codigoC.h"

FILE *markdown;
%}

%union {
	char *s;
	int val;
	double dval;
}

%token <s> NOME
%token <conteudo>	CONTEUDO
%token <classe>		CLASSE
%token <pacote>		PACOTE
%token <autor>		AUTOR
%token <titulo>		TITULO
%token ERRO


%start inicio
%%
autor: AUTOR '{' texto RCURLYB{fprintf(newHtml,"</i></br> "); }
autor:	;

texto: texto PALAVRA
%%
int main(int argc, char *argv[]){
	char arquivo[100];
	strcpy(arquivo,argv[1]);
	markdown = fopen(arquivo,"w+");
	return yyparse();
}
