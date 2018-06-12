require "./lispy/*"

EXAMPLE_PROGRAM = "
(= foo (fn (x: String) (+ x \"foo\")))
"

module Lispy
  v = Parser.new(EXAMPLE_PROGRAM).parse()

end
