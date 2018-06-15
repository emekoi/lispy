#  Copyright (c) 2018 emekoi
#
#  This library is free software; you can redistribute it and/or modify it
#  under the terms of the MIT license. See LICENSE for details.
#

import os, streams, mofunoise
import lispypkg/[parser]

proc initRepl() =
  let mn = mnInit("> ")
  var input = mn.mnReadLine()

  while input != "!":
    var l = input.newStringStream().newLexer()
    echo l.parse()
    input = mn.mnReadLine()

if paramCount() > 0:
  let f = open(paramStr(1))
  var l = f.newFileStream().newLexer()
  echo l.parse()
  f.close()
else:
  initRepl()
