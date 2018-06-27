#  Copyright (c) 2018 emekoi
#
#  This library is free software; you can redistribute it and/or modify it
#  under the terms of the MIT license. See LICENSE for details.
#

import os, streams, mofunoise
import parser

let mn = mnInit("> ")

proc read(): string =
  mn.mnReadLine()

proc eval(str: string): string =
  $str.parse()

proc print(str: string) =
  echo str

proc repl*() =
  var input = read()

  while input != "!":
    input.eval().print()
    input = read()
