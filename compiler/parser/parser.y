%{
#include <cstdio>
#include "lexer.hpp"
%}
//%define parse.error verbose  /*to help me debug the parser*/

%token T_if "if"
%token T_then "then"
%token T_do "do"
%token T_begin "begin"
%token T_end "end"
%token T_and "and"
%token T_of "of"
%token T_array "array"
%token T_else "else"
%token T_integer "integer"
%token T_or "or"
%token T_true "true"
%token T_label "label"
%token T_procedure "procedure"
%token T_var "var"
%token T_boolean "boolean"
%token T_false "false"
%token T_mod "mod"
%token T_program "program"
%token T_while "while"
%token T_char "char"
%token T_forward "forward"
%token T_new "new"
%token T_real "real"
%token T_dispose "dispose"
%token T_function "function"
%token T_nil "nil"
%token T_result "result"
%token T_div "div"
%token T_goto "goto"
%token T_not "not"
%token T_return "return"

%token T_id 
%token T_realnum 
%token T_int 
%token T_character 
%token T_string 
%token T_assign       ":="
%token T_greaterequal ">="
%token T_lessequal    "<="
%token T_notequal     "<>"


%nonassoc '=' '<' '>' "<=" ">=" "<>"// ":="
%left '+' '-' "or" 
%left '*' '/' "div" "mod" "and" 
%left "not"
%left UMINUS
%right '^' ":="
%left '@'
%left '[' '('

%expect 1

%%

program:
  "program" T_id ';' body '.'
;

body:
  local_list block
  |block
;

local_list:
  local
  |local_list local 
;
 
local: 
  var_list
  |decl2
  |decl3
  |decl4
;

/* declaration1 is var_list: local= "var" (id ("," id)* ":" type ";")+  */

var_list:
	var_list var_body
	|"var" var_body
;

var_body:
	T_id id_list ':' type ';'
;

id_list:
	/*epsilon*/
	|',' T_id id_list
;		
	
 /* declaration2: "label" id ( "," id )* ";" */

decl2: "label" T_id id_list ';'
;

decl3: 
  header ';' body ';'
;


decl4: 
  "forward" header ';'
;

header: 
  "procedure" T_id '(' formal_list ')'
  |"function" T_id '(' formal_list ')' ':' type
;

formal_list:
  /*epsilon*/
  |formal
  |formal_list ';' formal
;   
/*
formal:
  T_id type_list
  |"var" T_id type_list
;
 
type_list: 
  ':' type 
  | ',' T_id type_list
;
*/

formal:
  T_id id_list1 ':' type
  |"var" T_id id_list1 ':' type
;

id_list1:
  /*epsilon*/
  | ',' T_id id_list1
;
  
type:
   "boolean"
  |"integer"
  |"real"
  |"char"
  |"array" "of" type
  |"array" '[' T_int ']' "of" type
  |'^' type
; 

block:
 "begin" stmt_list "end"
;

stmt_list:
 stmt
 |stmt_list ';' stmt
; 
 
stmt: 
 /*epsilon*/ 
 |l_value ":="expr
 |block
 |call
 |"if" expr "then" stmt
 |"if" expr "then" stmt "else" stmt
 |"while" expr "do" stmt
 |T_id ':' stmt
 |"goto" T_id
 |"return"
 |"new" l_value
 |"new" '[' expr ']' l_value
 |"dispose" l_value
 |"dispose" '[' ']' l_value
;

expr:
 l_value
 |r_value
;

l_value:
  T_id
 |"result"
 |T_string
 |l_value '[' expr ']'
 |expr '^'
 |'(' l_value ')'
;

r_value:
  T_int
 |"true"
 |"false"
 |T_realnum
 |T_character
 |'(' r_value ')'
 |"nil"
 |call
 | expr '<' expr 
 | expr '>' expr
 | expr "<=" expr
 | expr ">=" expr
 | expr '=' expr
 | expr "<>" expr
 | expr '+' expr
 | expr '-' expr
 | expr '*' expr
 | expr '/' expr
 | expr "and" expr
 | expr "div" expr
 | expr "mod" expr
 | expr "or" expr
 |"not" expr 
 |'+' expr   %prec UMINUS
 |'-' expr   %prec UMINUS
 |'@' l_value1
;

l_value1: 
 T_id
 |"result"
 |T_string
 |l_value1 '[' expr ']'
 |'(' l_value ')'
;

call:
 T_id '(' ')'        
 |T_id '(' expr_list ')'
;

expr_list:
 expr
 |expr_list ',' expr 
; 
 
%%
extern int lineno;
int main() {
  //#ifdef YYDEBUG
  // yydebug = 1;
  //#endif
  int result = yyparse();
  if (result == 0) printf("Success.\n");
  return result;
}

