#  Copyright (c) 2018 emekoi
#
#  This library is free software; you can redistribute it and/or modify it
#  under the terms of the MIT license. See LICENSE for details.
#

import streams, strutils, strformat

const DELIMETERS = { '(', ')', '\0', ';' }

type
  TokenError* = object of Exception

  TokenType* {.pure.} = enum
    PARSE_END,
    VALUE,
    LIST,
    
  Token* = object
    case kind*: TokenType
    of TokenType.VALUE:
      value*: string
    of TokenType.LIST:
      list*: seq[Token]
    of TokenType.PARSE_END:
      discard
  
  Lexer* = object
    source*: Stream
    line*, col*: int
    pcount: int

proc `$`*(t: Token): string =
  case t.kind:
  of TokenType.VALUE:
    return t.value
  of TokenType.LIST:
    if t.list.len == 0:
      return "()"
    result = "("
    for tok in t.list:
      result &= $tok & " "
    result[result.len - 1] = ')'
  of TokenType.PARSE_END:
    return ""

proc `[]`*(t: Token, idx: SomeInteger): Token =
  return t.list[idx]

proc len*(t: Token): int =
  if t.kind == TokenType.LIST:
    return t.list.len
  raise newException(TokenError, "token is not a list")

proc newLexer*(s: Stream): Lexer =
  result.source = s
  result.pcount = 0
  result.line = 0
  result.col = 0

proc skipWhiteSpace(l: var Lexer) =
  while true:
    var c = l.source.peekChar()
    while c in Whitespace:
      if c in NewLines:
        l.line += 1
        l.col = 0
      discard l.source.readChar()
      c = l.source.peekChar()
    return

# proc peekChar(s: Stream, offset: int): char =
#   let p = s.getPosition()
#   s.setPosition(p + offset)
#   result = s.peekChar()
#   s.setPosition(p)

proc parse*(l: var Lexer): Token =
  let start = l.source.getPosition()
  l.skipWhiteSpace()
  var c = l.source.peekChar()

  if c == '\0':
    return Token(kind: TokenType.PARSE_END)
  elif c == '(':
    result.kind = TokenType.LIST
    discard l.source.readChar()
    var val = l.parse()
    c = l.source.peekChar()
    result.list = @[]
    while val.kind != TokenType.PARSE_END:
      result.list.add(val)
      val = l.parse()    
  elif c == ')':
    discard l.source.readChar()
    return Token(kind: TokenType.PARSE_END)
  elif c == ';':
    while c notin NewLines and c != '\0':
      discard l.source.readChar()
      c = l.source.peekChar()
      echo c.ord
  else:
    result.kind = TokenType.VALUE
    result.value = ""
    while c notin DELIMETERS and c != '\0':
      result.value &= l.source.readChar()
      c = l.source.peekChar()
  l.col += (l.source.getPosition() - start)
