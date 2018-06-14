#  Copyright (c) 2018 emekoi
#
#  This library is free software; you can redistribute it and/or modify it
#  under the terms of the MIT license. See LICENSE for details.
#

import pegs

# var parser = peg"""
# letter <- [\letter\d]
# symbol <- letter+
# parens <- \( parens \) / symbol
# """

# letter <- [!\d _]
# comment <- ';' @ \n
# ignore <- (\s / comment)*
let parser = peg"""
number <- { (\d[_]*)+ ('.'(\d[_]*)+)? }
string <- '"' { (!'"' _)* } '"'

symbol <- { [_0-9]+ }

expr <- (number / string / symbol) / expr

# sexp <- \( sexp \) / ({expr} (\s)*)*
"""

proc parse*(input: string): string =
  if input =~ parser:
    return repr matches
  else:
    return ""
