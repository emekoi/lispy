#  Copyright (c) 2018 emekoi
#
#  This library is free software; you can redistribute it and/or modify it
#  under the terms of the MIT license. See LICENSE for details.
#

import os, mofunoise
import lispypkg/[parser]

proc initRepl() =
  let mn = mnInit("> ")
  var input = mn.mnReadLine()

  while input != "!":
    echo input.parse()
    input = mn.mnReadLine()

if paramCount() > 0:
  let f = open(paramStr(1))
  echo f.readAll().parse()
  f.close()
else:
  initRepl()
