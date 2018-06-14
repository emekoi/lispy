#  Copyright (c) 2018 emekoi
#
#  This library is free software; you can redistribute it and/or modify it
#  under the terms of the MIT license. See LICENSE for details.
#

import hashes, patty

variantp Value:
  Symbol(hash: Hash)
  String(str: string)
  Number(num: float)
  Func(fn: proc(): Value)
