%{

	#include <stdio.h>
	#include <stdlib.h>
	#include <math.h>
	#include <string.h>	
	#include "lib.h"

	int yylex();
	void yyerror (char *s) {
		printf("%s\n", s);
	}

%}

%union {
	float flo;
	int fn;
	char str[50];
	Ast *a;
}

%token <flo>NUM
%token <str>VARS
%token <str>STRING
%token INICIO FIM 
%token SE SENAO ENQUANTO
%token TEXTO INTEIRO REAL
%token ESCREVAR ESCREVAT ESCREVAI
%token LEIAI LEIAR LEIAT
%token <fn> CMP

%right ATRIBUICAO
%left '+' '-'
%left '*' '/' '%'
%right '^' SQRT
%left CMP

%type <a> exp list stmt prog aString

%nonassoc IFX VARPREC VARPREC2 NEG VET declint declfloat declstring

%%

val: INICIO prog FIM
	;

prog: stmt { eval($1); }
	| prog stmt { eval($2); }
	;
	
	
stmt: 
	SE '(' exp ')' '{' list '}' %prec IFX { $$ = newflow('I', $3, $6, NULL); }
	| SE '(' exp ')' '{' list '}' SENAO '{' list '}' { $$ = newflow('I', $3, $6, $10); }
	| ENQUANTO '(' exp ')' '{' list '}' { $$ = newflow('W', $3, $6, NULL); }

	| VARS ATRIBUICAO exp %prec VARPREC { $$ = newasgn($1,$3); }
	| VARS ATRIBUICAO STRING %prec VARPREC2 { $$ = newasgnS($1, newast('$', newValorValS($3), NULL)); }

	| INTEIRO VARS %prec declint { $$ = newvari('U',$2); }
	| REAL VARS %prec declfloat { $$ = newvari('V',$2); }
	| TEXTO VARS %prec declstring { $$ = newvari('X',$2); }

	| INTEIRO VARS ATRIBUICAO exp { $$ = newast('G', newvari('U',$2) , $4); }
	| REAL VARS ATRIBUICAO exp { $$ = newast('D', newvari('V',$2) , $4); }
	| TEXTO VARS ATRIBUICAO STRING { $$ = newast('H', newvari('X',$2) , newValorValS($4)); }

	| LEIAR '(' VARS ')' {  $$ = newvari('S', $3); }
	| LEIAI '(' VARS ')' {  $$ = newvari('S', $3); }
	| LEIAT '(' VARS ')' {  $$ = newvari('T', $3); }

	| ESCREVAR '(' exp')' { $$ = newast('p', $3, NULL); }
	| ESCREVAI '(' exp')' { $$ = newast('u', $3, NULL); }
	| ESCREVAT '(' aString ')' { $$ = $3; }
	;

aString: VARS { $$ = searchVar('z', $1); }
	| STRING { $$ = newast('Z', newValorValS($1), NULL); }
	;

list: stmt { $$ = $1; }
		| list stmt { $$ = newast('L', $1, $2);	}
		;
	
exp: 
	exp '+' exp { $$ = newast('+', $1, $3); }
	| exp '-' exp { $$ = newast('-', $1, $3); }
	| exp '*' exp { $$ = newast('*', $1, $3); }
	| exp '/' exp { $$ = newast('/', $1, $3); }
	| exp '%' exp { $$ = newast('%', $1, $3); }
	| '(' exp ')' { $$ = $2; }
	| exp '^' exp { $$ = newast('^', $1, $3);  }
	| SQRT '(' exp ',' exp ')' { $$ = newast('~', $3, $5); }

	| exp CMP exp { $$ = newcmp($2, $1, $3); }
	| '-' exp %prec NEG { $$ = newast('M',$2,NULL); }
	| NUM { $$ = newnum($1); }
	| VARS	%prec VET { $$ = newValorVal($1); }
	;

;

%%

#include "lex.yy.c"

int main(){

	yyin = fopen("fibonacci.sena", "r");
	// yyin = fopen("fatorial.sena", "r");
	// yyin = fopen("juros.sena", "r");
	// yyin = fopen("media_ponderada_ifce.sena", "r");
	// yyin = fopen("area_retangulo.sena", "r");
	// yyin = fopen("in.sena", "r");

	yyparse();
	yylex();
	fclose(yyin);
	
	return 0;
}

