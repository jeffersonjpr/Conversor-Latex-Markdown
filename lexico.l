%option noyywrap
%{
	#include "codigoC.h"
	#include "lexico.tab.h"
}%
%%
"{"			{ return yytext[0]; }
"}"			{ return yytext[0]; }
[a−zA−Z0-9]+	{ return NAME; }
%%
