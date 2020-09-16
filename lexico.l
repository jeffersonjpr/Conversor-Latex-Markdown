%option noyywrap yylineno
%{
	//#include "codigoC.h"
	#include <string.h>
	#include <stdio.h>
	#include <stdlib.h>
	#include "sintatico.tab.h"
%}

letra		[a-zA-Z]
numeros		[0-9]
pontos		(\.|\,|\!|\?|\:|\;|"'")
palavra		({pontos}|{numeros}|{letra})+
%%
"{"						{ return yytext[0]; }
"}"						{ return yytext[0]; }
"["						{ return yytext[0]; }
"]"						{ return yytext[0]; }
"\\author"				{ return AUTOR; }
"\\documentclass"		{ return CLASSE; }
"\\usepackage"			{ return PACOTE; }
"\\title"				{ return TITULO; }
"\\date"				{ return DATA; }
"\\begin{document}"		{ return INICIODOC; }
"\\end{document}"		{ return FIMDOC; }
"\\section"				{ return SESSAO; }
"\\chapter"				{ return SESSAO; }
"\\begin{figure}"		 { return INICIOIMAGEM; }
"\\end{figure}"		 	 { return FIMIMAGEM; }
"\\bibliographystyle"   { return BIBSTYLE; }
"\\bibliography"  		{ return BIBIB; }
"\\caption"		 		{ return CAPTION; }
"\\includegraphics"		{ return INCLUDEGRAP; }
"\\citep"				{ return CITEP; }
"\\maketitle"			;
"\\centering"			;
"\\label"				;
{palavra}				{ yylval.s = strdup(yytext); return TEXTO; }
{palavra}[\n]?			{ yylval.s = strdup(yytext); return TEXTOLN; }
[0-9]+					{ yylval.ival = atoi(yytext); return NUMERO; }
.						;
%%
