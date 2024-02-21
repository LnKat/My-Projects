%option noyywrap

%{
#define T_eof 0
#define T_if 1004
#define T_then 1005
#define T_do 1006
#define T_begin 1007
#define T_end 1008
#define T_and 1009
#define T_of 1010
#define T_array 1011
#define T_else 1012
#define T_integer 1013
#define T_or 1014
#define T_true 1015
#define T_label 1016
#define T_procedure 1017
#define T_var 1018
#define T_boolean 1019
#define T_false 1020
#define T_mod 1021
#define T_program 1022
#define T_while 1023
#define T_char 1024
#define T_forward 1025
#define T_new 1026
#define T_real 1027
#define T_dispose 1028
#define T_function 1029
#define T_nil 1030
#define T_result 1031
#define T_div 1032
#define T_goto 1033
#define T_not 1034
#define T_return 1035

#define T_id 1036
#define T_realnum 1037
#define T_int 1038
#define T_character 1039
#define T_string 1040
#define T_assign 1041
#define T_greaterequal 1042
#define T_lessequal 1043
#define T_notequal 1040

int lineno=1;
%}

L [A-Za-z]
D [0-9]

%x COMMENT

%% 
 /* reserved words */
"and"         { return T_and; }
"array"       { return T_array; }
"begin"       { return T_begin; }
"boolen"      { return T_boolean; }
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
"var"         { return T_var; }
"while"       { return T_while; }

":="          { return T_assign; }
">="          { return T_greaterequal; }
"<="          { return T_lessequal; }
"<>"          { return T_notequal; }

{L}({L}|{D}|_)*                            { return T_id; }                 /*regular expression for id*/
{D}+  				            { return T_int; }                /*regular expression for integers*/
{D}+(\.{D}+((e|E)(\-|\+)?{D}+)?)?          { return T_realnum; }            /*regular expression for real*/
\"(\\.|[^\n"\\])*\"                        {return T_string;}
\'(.|\\[ntr0\\'"])\'                       { return T_character; }          /*regular expression for char*/            
[\t\r]+                                    { /* nothing */ }                                   


 /*expression for comments that counts lines */
"(*"               {BEGIN(COMMENT);}
<COMMENT>"*)"      {BEGIN(INITIAL);}
<COMMENT>\n        { lineno++;}
<COMMENT>"*"       { /* nothing */   }
<COMMENT>[^*\n]+   { /* nothing */   }


[:<>=;.,()+*^ @\[\]\/-]   { return yytext[0]; } 
{D}+{L}+                  { printf("Illegal expression on line %d\n", lineno); exit(1); }
.                         { fprintf(stderr, "Illegal character with code %d on line %d\n", yytext[0],lineno);
                            exit(1);
                          }

\n            {lineno++; }



%%

#ifdef yyFlexLexer
int main () {
  yyFlexLexer lexer;
  int token;
  do {
    token = lexer.yylex();
    printf("token=%d, lexeme=\"%s\"\n", token, lexer.YYText());
    printf("number of lines = %d\n", lineno);
  } while (token != T_eof);
}
#else
int main () {
  int token;
  do {
    token = yylex();
    printf("token=%d, lexeme=\"%s\"\n", token, yytext);
    printf("number of lines = %d\n", lineno);
  } while (token != T_eof);
}
#endif

