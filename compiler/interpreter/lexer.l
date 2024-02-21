%option noyywrap

%{
#include <cstdio>
#include <cstdlib>
#include <math.h> 
#include "ast.hpp"
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
"and"         { yylval.op = strdup("and");
				return T_and; }   
"array"       { return T_array; }
"begin"       { return T_begin; }
"boolean"     { return T_boolean; }
"char"        { return T_char; }
"dispose"     { return T_dispose; }
"div"         { yylval.op = strdup("div");
				return T_div; }          
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
"mod"         { yylval.op = strdup("mod");
			    return T_mod; }
"new"         { return T_new; }
"nil"         { return T_nil; }
"not"         { yylval.op = strdup("not");
				return T_not; }     
"of"          { return T_of; }
"or"          { yylval.op = strdup("or");
				return T_or; }      
"procedure"   { return T_procedure; }
"program"     { return T_program; }
"real"        { return T_real; } 
"result"      { return T_result; }
"return"      { return T_return; }
"then"        { return T_then; }
"true"        { return T_true; }
"var"         { return T_var; }
"while"       { return T_while; }

":="          { yylval.op = strdup(":=");
				return T_assign; }           
">="          { yylval.op = strdup(">=");
				return T_greaterequal; }     
"<="          { yylval.op = strdup("<=");
				return T_lessequal; }
"<>"          { yylval.op = strdup("<>");
				return T_notequal; }         

{L}({L}|{D}|_)*                        { yylval.idValue = strdup(yytext); return T_id; }           /*regular expression for id*/
{D}+  				        { yylval.intValue= atoi(yytext); return T_int; }            /*regular expression for integers*/
{D}+(\.{D}+((e|E)(\-|\+)?{D}+)?)?      { int point = 0;                                           /*regular expression for real*/
                                          for (int i=0; i<yyleng; ++i) {   //uparxei e sto token?
					     if ((yytext[i]=='e') || (yytext[i]=='E')) { point = i;}
                                          }
                                          if (point!=0) {
                                                 char buf[point], po[yyleng-point];
                                                 double n;
                                                 int p;
                                                 for (int j=0; j<point; ++j) {
                                                       buf[j]= yytext[j];//an vrw e krataw th bash, dld to kommati apo thn arxh ws to e
                                                 }
                                                 n=atof(buf);
	                                         if (yytext[point+1]=='+') { /*an vrw prosimo krataw ek8eth arxizontas meta to prosimo ws to telos*/
                                                    for (int j=point+2; j<yyleng; ++j) {
                                                        po[j-point-2]=yytext[j]; 
                                                    }
                                                    p=atoi(po);
                                                    yylval.realValue = n*pow(10.0, p);
                                                 }
						 else if (yytext[point+1]=='-') {
                                                        for (int j=point+2; j<yyleng; ++j) {
                                                              po[j-point-2]=yytext[j]; 
                                                        }
                                                        p=atoi(po);
                                                        yylval.realValue = n/pow(10.0, p);  
                                                 }    
                                                 else {
                                                     for (int j=point+1; j<yyleng; ++j) {
                                                              po[j-point-1]=yytext[j]; 
                                                     } 
                                                     p=atoi(po);
                                                     yylval.realValue = n*pow(10.0, p);
                                                 }
                                          }
                                          else {yylval.realValue = atof(yytext);}
                                          return T_realnum; }                                           
\"(\\.|[^\n"\\])*\"                     { yylval.stringValue = strdup(yytext); return T_string; }             /*string*/  
\'(.|\\[ntr0\\'"])\'                    { yylval.charValue = strdup(yytext); return T_character; }           /*char*/           
{W}+                                    { /* nothing */ }                                   

 /*expression for comments that count lines */
"(*"               {BEGIN(COMMENT);}
<COMMENT>"*)"      {BEGIN(INITIAL);}
<COMMENT>\n        { lineno++;}
<COMMENT>"*"       { /* nothing */   }
<COMMENT>[^*\n]+   { /* nothing */   }


[:<>=;.,()+*^ @\[\]\/-]  { yylval.op = strdup(yytext); return yytext[0]; } 
{D}+{L}+                 { yyerror("lexical error"); exit(1); }   /*Don't accept id starting with numbers*/ 
.                        { yyerror("lexical error");
                            exit(1);
                         }

\n            {lineno++; }



%%

void yyerror(const char *msg) {
  fprintf(stderr, "in line %d: %s\n", lineno, msg);
  exit(1);
}

