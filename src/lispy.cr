require "./lispy/*"

# EXAMPLE_PROGRAM = "
# (= foo (fn (x: String) (+ x \"foo\")))
# "

EXAMPLE_PROGRAM = "
(3)
"

module Lispy
  puts Parser.new(EXAMPLE_PROGRAM).parse.to_s
end
