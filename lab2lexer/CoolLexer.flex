%{
#include <iostream>
#include <fstream>
#include <cstdio>
#include <string>

#include "Parser.h"
#include "CoolLexer.h"

#undef YY_DECL
#define YY_DECL int CoolLexer::yylex()

int nesting_level = 0;
int lineno = 1;
%}

white_space       [ \t]*
digit             [0-9]
alpha             [A-Za-z_]
alpha_num         ({alpha}|{digit})
hex_digit         [0-9a-fA-F]
identifier        {alpha}{alpha_num}*
unsigned_integer  {digit}+
hex_integer       0[Xx]{hex_digit}+
exponent          e[+-]?{digit}+
i                 {unsigned_integer}
real              ({i}\.{i}?|{i}?\.{i}){exponent}?
string            \"([^"\n]|\\\")*\"

%x COMMENT
%x SINGLE_LINE_COMMENT
%x STRING
%x CLASS

%option warn nodefault batch noyywrap c++
%option yylineno
%option yyclass="CoolLexer"

%%

\"              { BEGIN(STRING); }
<STRING>\\\n    { lineno++; }
<STRING>\\n     {}
<STRING>[^\\\n\"]+ { /* skip */ }
<STRING>\"      { BEGIN(INITIAL); return TOKEN_STRING; }
<STRING>\n      { Error("Unterminated string literal"); return 0; }
<STRING><<EOF>> { Error("EOF in string literal"); return 0; }

"--"                BEGIN(SINGLE_LINE_COMMENT);
<SINGLE_LINE_COMMENT>[^\n]*   { /* skip */ }
<SINGLE_LINE_COMMENT>\n       { lineno++; BEGIN(INITIAL); }
<SINGLE_LINE_COMMENT><<EOF>>  BEGIN(INITIAL);

"(*"                { nesting_level++; BEGIN(COMMENT); }
<COMMENT>"(*"       { nesting_level++; }
<COMMENT>[^*()\n]+   { /* skip */ }
<COMMENT>"*"        { /* skip */ }
<COMMENT>"("        { /* skip */ }
<COMMENT>")"        { /* skip */ }
<COMMENT>\n         { lineno++; }
<COMMENT><<EOF>>    { Error("EOF in comment"); return 0; }
<COMMENT>"*)"       { nesting_level--; if (nesting_level == 0) BEGIN(INITIAL); }

0{unsigned_integer} { Error("Numbers cannot start with 0"); return 0; }
{hex_integer}       { Error("Hexadecimal numbers are not allowed"); return 0; }
{real}              { Error("Floating point numbers are not allowed"); return 0; }

(?i:class)          return TOKEN_CLASS;
(?i:else)           return TOKEN_ELSE;
(?i:fi)             return TOKEN_FI;
(?i:if)             return TOKEN_IF;
(?i:in)             return TOKEN_IN;
(?i:inherits)       return TOKEN_INHERITS;
(?i:isvoid)         return TOKEN_ISVOID;
(?i:let)            return TOKEN_LET;
(?i:loop)           return TOKEN_LOOP;
(?i:pool)           return TOKEN_POOL;
(?i:then)           return TOKEN_THEN;
(?i:while)          return TOKEN_WHILE;
(?i:case)           return TOKEN_CASE;
(?i:esac)           return TOKEN_ESAC;
(?i:new)            return TOKEN_NEW;
(?i:of)             return TOKEN_OF;
(?i:not)            return TOKEN_NOT;
t(?i:rue)           return TOKEN_TRUE;
f(?i:alse)          return TOKEN_FALSE;
(Int|String|Bool)   return TOKEN_TYPE;

"<-"                return TOKEN_ASSIGN;
"<="                return TOKEN_LEQ;
"<"                 return TOKEN_LT;
"="                 return TOKEN_EQ;
"+"                 return TOKEN_PLUS;
"-"                 return TOKEN_MINUS;
"*"                 return TOKEN_MULT;
"/"                 return TOKEN_DIV;
"~"                 return TOKEN_NEG;
"{"                 return TOKEN_LBRACE;
"}"                 return TOKEN_RBRACE;
"("                 return TOKEN_LPAREN;
")"                 return TOKEN_RPAREN;
";"                 return TOKEN_SEMI;
":"                 return TOKEN_COLON;
"."                 return TOKEN_DOT;
","                 return TOKEN_COMMA;
"@"                 return TOKEN_AT;

{unsigned_integer}  return TOKEN_UNSIGNED_INTEGER;
{identifier}        return TOKEN_IDENTIFIER;

{white_space}       { /* skip spaces */ }
\n                  lineno++;
%%

void CoolLexer::Error(const char* msg) const
{
    std::cerr << "Lexer error (line " << lineno << "): " << msg << '\n';
    std::exit(YY_EXIT_FAILURE);
}