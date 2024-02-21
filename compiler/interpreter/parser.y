%{
#include <cstdio>
#include <cstdlib>
#include "lexer.hpp"
#include "ast.hpp" //orizei to dentro me klaseis


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

%token<idValue>     T_id 
%token<realValue>   T_realnum 
%token<intValue>    T_int 
%token<charValue>   T_character 
%token<stringValue> T_string 
%token T_assign       ":="
%token T_greaterequal ">="
%token T_lessequal    "<="
%token T_notequal     "<>"


%nonassoc<op> '=' '<' '>' "<=" ">=" "<>" // ":="
%left<op>     '+' '-' "or" 
%left<op>     '*' '/' "div" "mod" "and"
%left<op>     "not"
%left<op>     UMINUS
%right<op>    '^' ":="
%left<op>     '@'
//%left<op>     '[' '('

%expect 3

%union {
   int intValue;
   double realValue;
 //  String stringValue; //mhpws oxi pointers kai string anti gia char?
  // String idValue;
  // String charValue;
 //  String op; 
   char *stringValue;
   char *idValue;
   char *charValue;
   char * op;
   
   Program *program;
   Block *block;
   Expr *expr;
   std::vector<Expr *> *expr_list;
   Stmt *stmt;
   std::vector<Stmt *> *stmt_list;
   Call *call;
   std::vector<Expr *> *bracket_expr_list;
}
/*
%type<program> program block1
%type<block> block stmt_list call stmt 
%type<expr> expr l_value r_value l_value1 expr_list new_body bracket_expr_list
*/

%type<program> program
%type<block> block
%type<stmt> stmt
%type<call> call
%type<stmt_list> stmt_list
%type<expr> expr l_value r_value l_value1
%type<expr_list> expr_list
%type<bracket_expr_list> bracket_expr_list

%%

program:
 "program" T_id ';' block '.' { $$ = new Program($2, $4); std::cout << "AST: " << *$$ << std::endl; }
 
block:
 "begin" stmt_list "end"   { $$ = new Block($2); }
;
 
stmt_list:
  stmt                 { $$ = new std::vector<Stmt *>();    //create the list
                         $$-> push_back($1);            }   //put the first element in it
  | stmt_list ';' stmt { $1->push_back($3); $$ = $1;    }
;

stmt: 
 /*epsilon*/                        { $$ = new Block();        }
 |l_value ":="expr                  { $$ = new Assign($1, $3); }
 |block                             { $$ = $1;}
 |call                              { $$ = $1;}
 |"if" expr "then" stmt             { $$ = new If($2, $4);}
 |"if" expr "then" stmt "else" stmt { $$ = new If($2, $4, $6); }
 |"while" expr "do" stmt            { $$ = new While($2, $4); }
 |T_id ':' stmt                     { $$ = new Anwkatwteleia($1, $3); }
 |"goto" T_id                       { $$ = new Goto($2); }
 |"return"
 |"new" l_value                     { $$ = new New($2); }
 |"new" '[' expr ']' l_value        { $$ = new New($3, $5); }
 |"dispose" l_value                 { $$ = new Dispose($2); }
 |"dispose" '[' ']' l_value         { $$ = new Dispose($4); }
;
  
expr:
 l_value  { $$ = $1; }
 |r_value { $$ = $1; }
;

l_value:
  T_id                       { $$ = new Id($1); }
 |"result"
 |T_string                   { $$ = new String($1); }
 |l_value bracket_expr_list  { $$ = new Pinakas($1, $2); }
 |expr '^'                   { $$ = new Pointer($1); }
 |'(' l_value ')'            { $$ = $2; }
;

r_value:
  T_int                   { $$ = new Int($1); }
 |"true"                  { $$ = new BoolConst("true"); }
 |"false"                 { $$ = new BoolConst("false"); }
 |T_realnum               { $$ = new Real($1); }
 |T_character             { $$ = new Char($1); }
 |'(' r_value ')'         { $$ = $2; }
 |"nil"
 |call                    { $$ = $1; }
 | expr '<' expr          { $$ = new BinOp($1, $2, $3); }
 | expr '>' expr          { $$ = new BinOp($1, $2, $3); }
 | expr "<=" expr         { $$ = new BinOp($1, $2, $3); }
 | expr ">=" expr         { $$ = new BinOp($1, $2, $3); }
 | expr '=' expr          { $$ = new BinOp($1, $2, $3); }
 | expr "<>" expr         { $$ = new BinOp($1, $2, $3); }
 | expr '+' expr          { $$ = new BinOp($1, $2, $3); }
 | expr '-' expr          { $$ = new BinOp($1, $2, $3); }
 | expr "or" expr         { $$ = new BinOp($1, $2, $3); }
 | expr '*' expr          { $$ = new BinOp($1, $2, $3); }
 | expr '/' expr          { $$ = new BinOp($1, $2, $3); }
 | expr "and" expr        { $$ = new BinOp($1, $2, $3); }
 | expr "div" expr        { $$ = new BinOp($1, $2, $3); }
 | expr "mod" expr        { $$ = new BinOp($1, $2, $3); }
 |"not" expr              { $$ = new UnaryOp($1, $2); }
 |'+' expr   %prec UMINUS { $$ = new UnaryOp($1, $2); }
 |'-' expr   %prec UMINUS { $$ = new UnaryOp($1, $2); }
 |'@' l_value1            { $$ = new Adress($2); }
;

l_value1: 
 T_id                        { $$ = new Id($1); }
 |"result"
 |T_string                   { $$ = new String($1); }              
 |l_value1 bracket_expr_list { $$ = new Pinakas($1, $2); }
 |'(' l_value ')'            { $$ = $2; }
;

bracket_expr_list:
 '[' expr ']'                       { $$ = new std::vector<Expr *>();  
                                      $$-> push_back($2);             }
 |bracket_expr_list '[' expr ']'    { $1->push_back($3); $$ = $1;     }
; 

call:
  T_id '(' ')'             { $$ = new Call($1); }
  |T_id '(' expr_list ')'  { $$ = new Call($1, $3); }
; 

expr_list:
 expr                      { $$ = new std::vector<Expr *>();
                             $$-> push_back($1);             }
 |expr_list ',' expr       { $1->push_back($3); $$ = $1;     }
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

