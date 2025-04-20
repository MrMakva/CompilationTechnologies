%{
#include <stdio.h>
#include <math.h>
#include <ctype.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

%define api.value.type {double}

%token NUM

%left '-' '+'
%left '*' '/'
%precedence NEG
%right '^'

%%

input:
    %empty
    | input line
;

line:
    '\n'
    | exp '\n' { printf("%.10g\n", $1); }
    | error '\n' { yyerrok; }
;

exp:
    NUM
    | exp '+' exp { $$ = $1 + $3; }
    | exp '-' exp { $$ = $1 - $3; }
    | exp '*' exp { $$ = $1 * $3; }
    | exp '/' exp {
        if ($3 == 0) {
            yyerror("division by zero");
            YYABORT;
        }
        $$ = $1 / $3;
    }
    | '-' exp %prec NEG { $$ = -$2; }
    | exp '^' exp { $$ = pow($1, $3); }
    | '(' exp ')' { $$ = $2; }
;

%%

int yylex() {
    int c = getchar();

    while (c == ' ' || c == '\t') {
        c = getchar();
    }

    if (c == '.' || isdigit(c)) {
        ungetc(c, stdin);
        if (scanf("%lf", &yylval) != 1) {
            yyerror("invalid number");
            return yyerror;
        }
        return NUM;
    }

    if (c == EOF) {
        return YYEOF;
    }

    if (c == '+' || c == '-' || c == '*' || c == '/' || c == '^' || c == '(' || c == ')') {
        return c;
    }

    if (c == '\n') {
        return c;
    }

    yyerror("invalid character");
    return yyerror;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    return yyparse();
}