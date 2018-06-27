#  Copyright (c) 2018 emekoi
#
#  This library is free software; you can redistribute it and/or modify it
#  under the terms of the MIT license. See LICENSE for details.
#

import os, streams
import lispypkg/[repl, parser]

if paramCount() > 0:
  let f = open(paramStr(1)).newFileStream()
  defer: f.close()
  echo f.readAll().parse()
else:
  repl()
