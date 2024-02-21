%option noyywrap

%{
#include <cstdio>
#include <cstdlib>
#include "lexer.hpp"
#include "parser.hpp"



int lineno=1;
%}

L [A-Za-z]
D [0-9]
W [ \t\r]

%x COMMENT

%% 
 /* reserved words */
"and"         { return T_and; }
"array"       { return T_array; }
"begin"       { return T_begin; }
"boolean"     { return T_boolean; }
"char"        { return T_char; }
"dispose"     { return T_dispose; }
"div"         { return T_div; }
"do"          { return T_do; }
"else"        { return T_else; }
"end"         { return T_end; }
"false"       { return T_false; }
"forward"     { return T_forward; }
"function"    { return T_function; }
"goto"        { return T_goto; }
"if"          { return T_if; }
"integer"     { return T_integer; }
"label"       { return T_label; }
"mod"         { return T_mod; }
"new"         { return T_new; }
"nil"         { return T_nil; }
"not"         { return T_not; }
"of"          { return T_of; }
"or"          { return T_or; }
"procedure"   { return T_procedure; }
"program"     { return T_program; }
"real"        { return T_real; }
"result"      { return T_result; }
"return"      { return T_return; }
"then"        { return T_then; }
"true"        { return T_true; }
"while"       { return T_while; }
"var"         { return T_var; }

":="          { return T_assign; }
">="          { return T_greaterequal; }
"<="          { return T_lessequal; }
"<>"          { return T_notequal; }

{L}({L}|{D}|_)*                         { return T_id; }                 /*regular expression for id*/
{D}+  				         { return T_int; }                /*regular expression for integers*/
{D}+(\.{D}+((e|E)(\-|\+)?{D}+)?)?       { return T_realnum; }            /*regular expression for real*/
\"(\\.|[^\n"\\])*\"                     { return T_string; }             /*regular expression for string*/
\'(.|\\[ntr0\\'"])\'                    { return T_character; }          /*regular expression for char*/            
{W}+                                    { /* nothing */ }                                   

 /*expression for comments that counts lines */
"(*"               {BEGIN(COMMENT);}
<COMMENT>"*)"      {BEGIN(INITIAL);}
<COMMENT>\n        { lineno++;}
<COMMENT>"*"       { /* nothing */   }
<COMMENT>[^*\n]+   { /* nothing */   }


[:<>=;.,()+*^ @\[\]\/-]  { return yytext[0]; } 
{D}+{L}+                 { yyerror("lexical error"); exit(1); }   /*Don't accept id starting with numbers*/ 
.                        { yyerror("lexical error");
                            exit(1);
                         }

\n                       {lineno++; }



%%

void yyerror(const char *msg) {
  fprintf(stderr, "in line %d: %s\n", lineno, msg);
  exit(1);
}

