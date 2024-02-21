//mhpws na valw ifndef kai endif?
//#pragma once

//#include <iostream>
//#include <map>
//#include <vector>


#ifndef __AST_HPP__
#define __AST_HPP__

#include <iostream>
#include <vector>


class AST {
public:
	virtual ~AST() {}
	virtual void printOn(std::ostream &out) const = 0;
};


inline std::ostream & operator<< (std::ostream &out, const AST &t) {  //kati sxetika me ton telesth << kai thn ektupwsh
	t.printOn(out);
	return out;
}


class Stmt: public AST {
public:
	// virtual void run() const = 0;
}; 


class Expr: public AST {
public:
	//virtual int eval() const = 0;
};
  
 
class Block: public Stmt {
public:
	Block(std::vector<Stmt *> *stmt_list= new std::vector<Stmt *>())
	: stmt_list(stmt_list) 
	{
       //empty body
	}
    
    ~Block() {
    	for (Stmt *s : *stmt_list) delete s;
    }
	virtual void printOn(std::ostream &out) const override {
    	out << "Block(";
    	bool first = true;
    	for (Stmt *s : *stmt_list) {
        	if (!first) out << ", ";
            first = false;
            out << *s;
		}
		out << ")";
	}
  
private:
	std::vector<Stmt *> *stmt_list;
};


class Program: public AST {
public:
	Program(char *v, Block *b)
	: var(v), block(b)
	{
    	//empty body
	}
 
	~Program() { delete block; }
 
	virtual void printOn(std::ostream &out) const override {
    	out << "Program(" << var << ", " << *block << ")";
	}
 
private:
	char *var;
	Block *block;
};


class Assign: public Stmt {
public:
	Assign(Expr *e, Expr *r)
	: l_value(e), expr(r) 
	{
      //empty body
	}
 
    ~Assign() { delete l_value; delete expr; }
    
	virtual void printOn(std::ostream &out) const override {
		out << "Assign(" << *l_value << ", " << *expr << ")";
	}
 
private:
	Expr *l_value;
	Expr *expr;
};


class Pinakas: public Expr {
public:
 Pinakas(Expr *e, std::vector<Expr *> *bracket_expr_list )
 : l_value(e), bracket_expr_list(bracket_expr_list)
 {
    //empty body
 }
 ~Pinakas() { delete l_value; for (Expr *r : *bracket_expr_list) delete r; }
 virtual void printOn(std::ostream &out) const override {
   out << "Pinakas(" << *l_value << ", ";
   bool first = true;
   for (Expr *r : *bracket_expr_list) {
      if (!first) out << ", ";
      first = false;
      out << *r;
   }
   out << ")";
 }
 
private:
  Expr *l_value;
  std::vector<Expr *> *bracket_expr_list;
};


class Call: public Expr, public Stmt {
public:
 Call(char *v, std::vector<Expr *> *expr_list = new std::vector<Expr *>())
 : var(v), expr_list(expr_list) 
 {
   //empty body
 }
 ~Call() { for (Expr *e : *expr_list) delete e; }
 virtual void printOn(std::ostream &out) const override {
   out << "Call(" << var;
   for (Expr *e : *expr_list) {
      out << ", " << *e;
   }  
   out << ")";
}

private:
 char *var;
 std::vector<Expr *> *expr_list;
};


class If: public Stmt {
public:
  If(Expr *c, Stmt *s1, Stmt *s2 = nullptr)
  : cond(c), stmt1(s1), stmt2(s2) 
  {
    //empty body
  }
  ~If() { delete cond; delete stmt1; delete stmt2; }
  virtual void printOn(std::ostream &out) const override {
    out << "If(" << *cond << ", " << *stmt1;
    if (stmt2 != nullptr) out << ", " << *stmt2;
    out << ")";
  }
  
private:
  Expr *cond;
  Stmt *stmt1;
  Stmt *stmt2;
};


class While: public Stmt {
public:
 While(Expr *e, Stmt *s)
 : expr(e), stmt(s) 
 {
   //empty body
 }
 ~While() { delete expr; delete stmt; }
 virtual void printOn(std::ostream &out) const override {
    out << "While(" << *expr << ", " << *stmt << ")";
 }
 
 private:
 Expr *expr;
 Stmt *stmt;
};


class Anwkatwteleia: public Stmt {
public:
 Anwkatwteleia(char *v, Stmt *s)
 : var(v), stmt(s)
 {
   //empty body
 }
 ~Anwkatwteleia() { delete stmt; }
 virtual void printOn(std::ostream &out) const override {
  out << "Anwkatwteleia(" << var << ", " <<  *stmt << ")";
 }
 
 private:
  char *var;
  Stmt *stmt;
};


class Goto: public Stmt {
public:
 Goto(char *v)
 : var(v) 
 {
   //empty body
 }
 
 virtual void printOn(std::ostream &out) const override {
   out << "Goto" << var << ")";
 }
 
 private:
  char *var;
};


class New: public Stmt {
public:
 New(Expr *e)
 : l_value(e)
 {
   //empty body
 }
 ~New() { delete l_value; }
 
 New(Expr *t, Expr *e)
 : body(t), l_value(e)
 {
   //empty body
 }
 
 virtual void printOn(std::ostream &out) const override {
   out << "New(" << *body << ", " << *l_value << ")";
 }
 
private:
 Expr *body;
 Expr *l_value;
};

class Dispose: public Stmt {
public:
 Dispose(Expr *e)
 : l_value(e) 
 {
 
 }
 ~Dispose() { delete l_value; }
 
 virtual void printOn(std::ostream &out) const override {
   out << "Dispose(" << *l_value << ")";
 }
 
private:
 Expr *l_value;  
};



class Id: public Expr {
public:
  Id(char *v)
  : var(v) 
  {
    //empty body
  }
  
  virtual void printOn(std::ostream &out) const override {
    out << "Id(" << var << ")";
  }
  
private:
  char *var;
};


class String: public Expr{
public:
  String(char *s)
  : var(s) 
  {
    //empty body
  }
  
  virtual void printOn(std::ostream &out) const override {
    out << "String(" << var << ")";
  }
  
private:
  char *var;        
};


class Pointer: public Expr {
public:
 Pointer(Expr *e)
 : expr(e)
 {
   //empty body
 }
  
 virtual void printOn(std::ostream &out) const override {
  out << "Pointer(" << *expr << ")" ;
 } 
 
 private:
 Expr *expr;
};


class Real: public Expr {
public: 
 Real(double r)
 : var(r) 
 {
   //empty body
 }
 
 virtual void printOn(std::ostream &out) const override {
  out << "Real(" << var << ")" ;
 }
 
private:
 double var; 
};


class Char: public Expr {
public:
 Char(char *c)
 : var(c)
 {
   //empty body
 }
 
 virtual void printOn(std::ostream &out) const override {
  out << "Char(" << var << ")";
 } 
 
private:
 char *var;   
};


class Int: public Expr {
public:
 Int(int n)
 : num(n) 
 {
   //empty body
 }
 
  virtual void printOn(std::ostream &out) const override {
    out << "Int(" << num << ")";
  }
  
private:
  int num;
};
 
 
class BoolConst: public Expr {
public:
	BoolConst(bool b)
	: bv(b) 
	{
		//empty body
	}
	
	virtual void printOn(std::ostream &out) const override {
		out << "BoolConst(" << (bv ? "true" : "false") << ")";
	}
	
	/*virtual int eval() const override {
		return bv;
	}*/
	
private:
	bool bv;	
};

 
class BinOp: public Expr {
public:
 BinOp(Expr *l, char *o, Expr *r)
 : left(l), op(o), right(r)
 {
    //empty body
 }
 ~BinOp() { delete left; delete right; }
 virtual void printOn(std::ostream &out) const override {
  out <<  op << "(" << *left << ", " << *right << ")";
 }
 
private:
 Expr *left;
 char *op;
 Expr *right;
};
  
  
class UnaryOp: public Expr {
public:
 UnaryOp(char *o, Expr *e)
 : op(o), expr(e)
 {
   //empty body
 }
 
 virtual void printOn(std::ostream &out) const override {
  out << op << *expr ;
 }
 ~UnaryOp() { delete expr; }
 private:
  char *op;
  Expr *expr;
};  


class Adress: public Expr {
public:
 Adress(Expr *e)
 : expr(e)
 {
   //empty body
 }
 ~Adress() { delete expr; }
 
 virtual void printOn(std::ostream &out) const override {
   out << *expr ;
 }
 
 private:
 Expr *expr;
};

#endif
