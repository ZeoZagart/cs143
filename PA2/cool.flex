/*
 *  The scanner definition for COOL.
 */

/*
 *  Stuff enclosed in %{ %} in the first section is copied verbatim to the
 *  output, so headers and global definitions are placed here to be visible
 * to the code in the file.  Don't remove anything that was here initially
 */
%{
#include <cool-parse.h>
#include <stringtab.h>
#include <utilities.h>
#include <string.h>

/* The compiler assumes these identifiers. */
#define yylval cool_yylval
#define yylex  cool_yylex

/* Max size of string constants */
#define MAX_STR_CONST 1025
#define YY_NO_UNPUT   /* keep g++ happy */

extern FILE *fin; /* we read from this file */

/* define YY_INPUT so we read from the FILE fin:
 * This change makes it possible to use this scanner in
 * the Cool compiler.
 */
#undef YY_INPUT
#define YY_INPUT(buf,result,max_size) \
	if ( (result = fread( (char*)buf, sizeof(char), max_size, fin)) < 0) \
		YY_FATAL_ERROR( "read() in flex scanner failed");

char string_buf[MAX_STR_CONST]; /* to assemble string constants */
char *string_buf_ptr;

extern int curr_lineno;
extern int verbose_flag;
int comment_nesting = 0;

extern YYSTYPE cool_yylval;

/*
 *  Add Your own definitions here
 */

%}

/*
 * Definitions
 */

INT_CONST       [0-9]+
STR_CONST       \"[^"\0\n]*\"
TYPEID          [A-Z][_a-zA-Z0-9]*
OBJECTID        [a-z][_a-zA-Z0-9]*
INLINE_COMMENT  --[^\n\0]*
SELF            self
SELF_TYPE       SELF_TYPE

%Start COMMENT_BLOCK

%%

<INITIAL,COMMENT_BLOCK>"(*"    {
                                    comment_nesting++;
                                    BEGIN COMMENT_BLOCK;
                                }

<COMMENT_BLOCK>[^\0\n()*]*      { ; }

<COMMENT_BLOCK>\n               { curr_lineno++; }

<COMMENT_BLOCK>[()*]         { ; }

<COMMENT_BLOCK>"*)"             { comment_nesting--;
                                    if (comment_nesting == 0) { BEGIN 0; }
                                }

<COMMENT_BLOCK>\0               {
                                    cool_yylval.error_msg = "EOF inside comment block";
                                    return ERROR;
                                }
                                 
                                 
"*)"             {  cool_yylval.error_msg = "Unmatched *)";
                    return ERROR;
                 }

"\n"             { curr_lineno++; }
[ \f\r\t\v]      { ;}
{INLINE_COMMENT} { ;}
class       { return CLASS; }
else        { return ELSE; }
fi         { return FI; }
if          { return IF; }
in          { return IN; }
inherits    { return INHERITS; }
let         { return LET; }
loop        { return LOOP; }
pool        { return POOL; }
then        { return THEN; }
while       { return WHILE; }
case        { return CASE; }
esac        { return ESAC; }
of          { return OF; }
not          { return NOT; }
new         { return NEW; }
isvoid      { return ISVOID; }
"=>"		     { return (DARROW); }
"<-"             { return ASSIGN; }
"<="             { return LE; }
true             {
                     cool_yylval.boolean = 1;
                     return BOOL_CONST;
                 }
false            {
                     cool_yylval.boolean = 0;
                     return BOOL_CONST;
                 }
{INT_CONST}      {
                      cool_yylval.symbol = inttable.add_string(yytext);
                      return INT_CONST;
                 }
{STR_CONST}      {
                     if( yytext[yyleng - 1] == '\\' )
                         yymore();
                     else {
                         cool_yylval.symbol = stringtable.add_string(yytext);
                         return STR_CONST;
                     }
                 }
{TYPEID}         {
                     cool_yylval.symbol = idtable.add_string(yytext);
                     return TYPEID;
                 }
{OBJECTID}       {
                     cool_yylval.symbol = idtable.add_string(yytext);
                     return OBJECTID;
                 }
                

"+" { return int('+'); }
"-" { return int('-'); }
"*" { return int('*'); }
"/" { return int('/'); }
"<" { return int('<'); }
"=" { return int('='); }
"." { return int('.'); }
";" { return int(';'); }
"~" { return int('~'); }
"{" { return int('{'); }
"}" { return int('}'); }
"(" { return int('('); }
")" { return int(')'); }
":" { return int(':'); }
"@" { return int('@'); }
"," { return int(','); }
.   {
        cool_yylval.error_msg = yytext;
        return ERROR;
    }

 /*
  * Keywords are case-insensitive except for the values true and false,
  * which must begin with a lower-case letter.
  */


 /*
  *  String constants (C syntax)
  *  Escape sequence \c is accepted for all characters c. Except for 
  *  \n \t \b \f, the result is c.
  *
  */


%%
