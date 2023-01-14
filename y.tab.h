/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    START = 258,
    STOP = 259,
    IF = 260,
    ELSE = 261,
    WHILE = 262,
    READ = 263,
    WRITE = 264,
    INT = 265,
    CHAR = 266,
    STRING = 267,
    ARRAY = 268,
    ASSIGN = 269,
    L = 270,
    G = 271,
    EQ = 272,
    LE = 273,
    GE = 274,
    NE = 275,
    ID = 276,
    CONST_INT = 277,
    CONST_CHAR = 278,
    CONST_STRING = 279,
    CONST_ARRAY = 280
  };
#endif
/* Tokens.  */
#define START 258
#define STOP 259
#define IF 260
#define ELSE 261
#define WHILE 262
#define READ 263
#define WRITE 264
#define INT 265
#define CHAR 266
#define STRING 267
#define ARRAY 268
#define ASSIGN 269
#define L 270
#define G 271
#define EQ 272
#define LE 273
#define GE 274
#define NE 275
#define ID 276
#define CONST_INT 277
#define CONST_CHAR 278
#define CONST_STRING 279
#define CONST_ARRAY 280

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
#line 27 "specification.y"
union val
{
#line 27 "specification.y"

    int i_val;
    char *p_val;

#line 113 "y.tab.h"

};
#line 27 "specification.y"
typedef union val YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
