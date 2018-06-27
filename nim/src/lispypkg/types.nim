#  Copyright (c) 2018 emekoi
#
#  This library is free software; you can redistribute it and/or modify it
#  under the terms of the MIT license. See LICENSE for details.
#

import hashes

type
  ValueType* = enum
    SYMBOL,
    STRING,
    NUMBER,
    LIST
    # FUNC

  Value* = object
    case kind*: ValueType
    of SYMBOL:
      symbol*: tuple[hash: Hash, str: string]
    of STRING:
      str*: string
    of NUMBER:
      num* float
    of LIST:
      list*: tuple[car, cdr: Value]
    # of FUNC:
    #   fn*: p

    # Symbol(hash: Hash)
    # String(str: string)
    # Number(num: float)
    # Func(fn: proc(): Value)
