%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//#include "codigoC.h"
extern int yylineno;
extern int yylex();
extern int yyparse();
extern int yyerror();
extern FILE *yyin;

int contTab = -1;
int contenum = 0, enumLista[10];
FILE *markdown;
int contadorSection = 0;
void fp(char *c);
void fphash(int hashcount);
void fpenum(int contenum, int contTab);
%}

%union {
	char* s;
	int ival;
	double dval;
}

%token <s> TEXTO
%token <s> TEXTOLN
%token <ival> NUMERO

%token CLASSE PACOTE AUTOR TITULO DATA INICIODOC FIMDOC SESSAO INICIOIMAGEM FIMIMAGEM CAPTION
%token INCLUDEGRAP BIBSTYLE BIBIB CITEP	INICIOITEM FIMITEM ITEM INICIOENUME FIMENUME
%right '['

//%start latex

%%
latex: configuracao identificacao configuracao principal

configuracao: CLASSE'{'ignorar'}'configuracao
configuracao: PACOTE'{'ignorar'}'configuracao
configuracao: PACOTE'['ignorar']''{'ignorar'}'configuracao
configuracao: ;

identificacao: TITULO {fp("# **");} '{' texto '}' {fprintf(markdown,"**\n");} identificacao
identificacao: AUTOR {fp("");} '{' texto '}' {fprintf(markdown,"  \r\n");} identificacao
identificacao: DATA {fp("");} '{' texto '}' {fprintf(markdown,"  \r\n");} identificacao
identificacao: ;

principal: INICIODOC corpoLista FIMDOC

corpoLista: SESSAO '{' {fprintf(markdown,"\n## %i. ",contadorSection++);} texto '}' {fp("\n");} corpoLista
corpoLista: imagems corpoLista
corpoLista: texto corpoLista
corpoLista: BIBSTYLE '{' ignorar '}'corpoLista
corpoLista: BIBIB '{' ignorar '}'corpoLista
corpoLista: CITEP '{' ignorar '}'corpoLista
corpoLista: itemize corpoLista
corpoLista: enumerate corpoLista
corpoLista: ;

itemize: INICIOITEM {contTab += 1;} corpoItem FIMITEM {contTab -= 1;}
corpoItem: ITEM {fphash(contTab);} texto corpoItem
corpoItem: itemize corpoItem
corpoItem: ;

enumerate: INICIOENUME {contenum += 1; contTab+= 1;} corpoEnum FIMENUME {contenum -= 1; contTab -= 1;}
corpoEnum: ITEM {fpenum(contenum, contTab);} texto corpoEnum
corpoEnum: enumerate corpoEnum
corpoEnum: ;


imagems: INICIOIMAGEM '['ignorar']' corpoImagem FIMIMAGEM corpoLista
imagems: INICIOIMAGEM corpoImagem FIMIMAGEM corpoLista

corpoImagem: includegraphics captions

includegraphics: INCLUDEGRAP {fp("\n![");} '[' ignorar ']' {fp("](");} '{' texto {fp(")\n");} '}'

captions: CAPTION {fp("*");} '{' texto   {fp("*  \n");} '}'
captions: ;

texto: NUMERO { fprintf(markdown,"%i",$1); } texto2
texto: TEXTO { fprintf(markdown,"%s",$1); } texto2
texto: TEXTOLN { fprintf(markdown,"%s \n",$1); } texto2
texto2: NUMERO { fprintf(markdown," %i",$1); } texto2
texto2: TEXTO { fprintf(markdown," %s",$1); } texto2
texto2: TEXTOLN { fprintf(markdown," %s \n",$1); } texto2
texto2: ;

ignorar: NUMERO ignorar
ignorar: TEXTO ignorar
ignorar: ;
%%
int main(int argc, char *argv[]){
	// argv[1] arquivo.lex LaTeX
	// argv[2] arquivo.markdown Markdown
	char arquivo[100];
	strcpy(arquivo,argv[2]);
	printf("%s\n", arquivo);
	markdown = fopen(arquivo,"w+");
	yyin = fopen(argv[1], "r");
	return yyparse();
}
int yyerror (char *s){
  return printf("Erro encontrado: %s linha %i\n", s, yylineno);
}
void fp(char *c){
	fprintf(markdown,c);
}
void fphash(int hashcount){
	for(; hashcount > 0; hashcount--){
		fprintf(markdown,"	");
	}
	fprintf(markdown,"- ");
}

void fpenum(int contenum, int contTab){
	for(; contTab > 0; contTab--){
		fprintf(markdown,"	");
	}
	fprintf(markdown,"%i. ",enumLista[contenum]++);
}
