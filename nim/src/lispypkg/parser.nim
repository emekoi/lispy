#  Copyright (c) 2018 emekoi
#
#  This library is free software; you can redistribute it and/or modify it
#  under the terms of the MIT license. See LICENSE for details.
#

import pegs, sequtils

# var parser = peg"""
# letter <- [\letter\d]
# symbol <- letter+
# parens <- \( parens \) / symbol
# """

# letter <- [!\d _]
# comment <- ';' @ \n
# ignore <- (\s / comment)*
# string <- '"' { (!'"' _)* } '"'
# expr <- (number / string / symbol) / expr
# sexp <- \( sexp \) / ({expr} (\s)*)*


# skip   <- \s*
# number <- { '-'? (\d[_]*)+ ('.'(\d[_]*)+)? }
# # string <- \" { (!\" _)* } \"
# symbol <- { \S+ }
# expr   <- skip (number / symbol / expr)


let parser = peg"""
sexp     <- ^ skip expr $

comment  <- ";" @ \n
skip     <- (comment / \white)*

expr     <- skip (number / string / symbol / expr)
number   <- skip { "-"? (\d"_"*)+ ("." (\d"_"*)+)? }
string   <- skip "\"" { (!\" _)* } "\""
symbol   <- skip { \S+ }
"""

proc parse*(input: string): string =
  # result = $toSeq(input.findAll(parser))
  if input =~ parser:
    return repr matches
  else:
    return ""
