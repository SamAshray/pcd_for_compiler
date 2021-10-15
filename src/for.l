%{
#include "y.tab.h"
void yyerror(char*);
%}

digit [0-9]

%%

[\t \n]                               ;
for                         return FOR;
{digit}+                    return NUM;
[A-Za-z]([A-Za-z]|{digit})*   return ID;
"<="                        return LE;
">="                        return GE;
"=="                        return EQ;
"!="                        return NE;
"||"                        return OR;
"&&"                        return AND;
"++"                        return INC;
"--"                        return DEC;
.                           return yytext[0];

%%
int yywrap(){
    return 1;
};
