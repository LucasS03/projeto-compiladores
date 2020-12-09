%{
#include <string.h>
%}

NUM [0-9]+\.?[0-9]*
VARS[a-z]+[0-9]*

INICIO "inicio"
FIM "fim"

IF "IF"
ELSE "ELSE"
WHILE "WHILE"

ESCREVAR "escrevar"
ESCREVAI "escrevai"
ESCREVAT "escrevat"
LEIAR "leiar"
LEIAI "leiai"
LEIAT "leiat"

REAL "real"
INTEIRO "inteiro"
TEXTO "texto"

LETRA [a-zA-Z]

COMENTARIO "@@".*	
ATRIBUICAO "<<"
%%
{INICIO} {return INICIO;}
{FIM} {return FIM;}

{COMENTARIO} { /* ignore */ }
{ATRIBUICAO} {return ATRIBUICAO;}

{IF} {return IF;}
{ELSE} {return ELSE;}
{WHILE} {return WHILE;}

{ESCREVAI} {return ESCREVAI;}
{ESCREVAR} {return ESCREVAR;}
{ESCREVAT} {return ESCREVAT;}
{LEIAR} {return LEIAR;}
{LEIAI} {return LEIAI;}
{LEIAT} {return LEIAT;}

{REAL} {return REAL;}
{INTEIRO} {return INTEIRO;}
{TEXTO} {return TEXTO;}

{VARS} {
	strcpy(yylval.str,yytext);
	return VARS;
}

{LETRA} {
	strcpy(yylval.str,yytext);
	return LETRA;
}

{NUM} {
	yylval.flo = atof(yytext);
	return NUM;
}

[-+()=/*^{};] {return *yytext;}

">" {yylval.fn = 1; return CMP; }
"<" {yylval.fn = 2; return CMP; }
"<>" {yylval.fn = 3; return CMP; }
"==" {yylval.fn = 4; return CMP; }
">=" {yylval.fn = 5; return CMP; }
"<=" {yylval.fn = 6; return CMP; }

[\ \n\t]*	{;}
. {printf("(%s) Ingonrado\n",yytext);}
%%