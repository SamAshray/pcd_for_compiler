%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
char st[100][10];
int top = -1;
char temp[3] = "t0";
extern int yylex();
extern char* yytext;
void yyerror(char*);
int indent = 0;

void push();
void gen();
void gen_asgn();
void gen_comp();
void gen_umin();
void gen_inc_dec(char);
void Lcond();
void L1();
void Update();
void Body();
void goto_L1();
void End();
void printIndent();
%}
%token ID NUM INC DEC FOR LE GE EQ NE OR AND
%right '='
%left OR AND
%left '>' '<' LE GE EQ NE
%left '+' '-'
%left '*' '/'
%right UMINUS
%left '!'

%%

S           : ST {printf("Input accepted\n"); exit(0);}
ST          : FOR {L1();} '(' E ';' E2 {Lcond();} ';'{Update();} E {goto_L1();}')' {Body();} DEF {End();}
            ;
DEF         : '{' BODY '}'
            | E';'
            | ST
            |
            ;
BODY        : BODY BODY
            | E ';'
            | ST
            |
            ;

E           : E3 '=' {push();} E {gen_asgn();}
            | E '+' {push();} E {gen();}
            | E '-' {push();} E{gen();}
            | E '*' {push();} E{gen();}
            | E '/' {push();} E{gen();}
            | E INC {push();}{gen_inc_dec('+');}
            | E DEC {push();}{gen_inc_dec('-');}
            | NUM{push();}
            | E3
            ;

E3          : ID {push();};


E2          : E '<' {push();} E{gen_comp();}
            | E '>' {push();} E{gen_comp();}
            | E LE {push();} E{gen_comp();}
            | E GE {push();} E{gen_comp();}
            | E EQ {push();} E{gen_comp();}
            | E NE {push();} E{gen_comp();}
            | E OR {push();} E{gen_comp();}
            | E AND {push();} E{gen_comp();}
            ;
%%

void yyerror(char* s) {
    printf("%s",s);
  exit(1);
}
int main() {
    printf("Enter the expression:\n");
    yyparse();
    return 0;
}

void push(){
    strcpy(st[++top],yytext);
}

void gen(){
    printIndent();
    printf("%s = %s %s %s\n", temp, st[top-2], st[top-1],st[top]);
    top -=2;
    strcpy(st[top], temp);
    temp[1]++; // gen new temp var
}

void gen_comp(){
    printIndent();
    printf("%s = %s %s %s\n",temp, st[top-2], st[top-1],st[top]);
    top -=2;
    strcpy(st[top], temp);
    temp[1]++;
}

void gen_umin(){
    printIndent();
    printf("%s = -%s\n", temp, st[top]);
    top --;
    strcpy(st[top], temp);
    temp[1]++; // gen new temp var
}

void gen_inc_dec(char op){
    printIndent();
    printf("%s = %s %c 1\n", temp, st[top-1], op);
    printIndent();
    printf("%s = %s\n", st[top-1], temp);
    top -=1;
    strcpy(st[top], temp);
    temp[1]++;
}

void gen_asgn(){
    printIndent();
    printf("%s = %s\n", st[top-2],st[top]);
    top -=3;
}

void L1(){
    printIndent();
    printf("\nL1: \n");
    indent++;
}

void goto_L1(){
    printIndent();
    printf("goto L1\n\n");
    indent--;
}

void Update(){
    printIndent();
    printf("UPDATE: \n");
    indent++;
}

void Body(){
    printIndent();
    printf("BODY: \n");
    indent++;
}

void Lcond(){
    printIndent();
    printf("%s = not %s\n", temp, st[top]);
    printIndent();
    printf("if %s goto END\n", temp);
    printIndent();
    printf("goto BODY\n\n");

    temp[1]++;
}

void End(){
    printIndent();
    printf("goto UPDATE\n\n");
    indent-=2;
    printIndent();
    printf("END: \n\tend of for loop \n\n");
}
void printIndent(){
    for(int i=0;i< indent;i++){
        printf("\t");
    }
}
