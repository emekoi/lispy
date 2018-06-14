require "./value"

private DELIMETER = "();"

struct Char
  def delimeter?
    self.whitespace? || self.in_set?(DELIMETER)
  end
end

module Lispy
  class Parser
    @@PARSE_END = Value.new(:PARSE_END)
    @@PARSE_ERR = Value.new(:PARSE_ERR)

    private def peek
      result = @data.read_char
      @data.seek(-1, IO::Seek::Current)
      result
    end

    def initialize(data : String)
      @data = IO::Memory.new(data)
      @line = 0
      @col = 0
    end

    def to_s
      String.new @data.peek
    end

    private def skip_blanks
      while (c = peek) && c.whitespace?
        if c == '\n'
          @line += 1
          @col = 0
        end
        c = @data.read_char
        @col += 1
      end
    end

    private def parse_number : Value
      buf = @data.read_char.to_s
      while (c = peek) && c.number?
        buf += @data.read_char.to_s
      end

      case c
      when c && c.delimeter?
        Value.new(buf.to_i32)
      when '.'
        buf += @data.read_char.to_s
        while (c = peek) && c.number?
          buf += @data.read_char.to_s
        end
        if c == ' '
          Value.new(buf.to_f32)
        end
      end

      while (c = peek) && !c.delimeter?
        buf += @data.read_char.to_s
      end

      Value.new(Symbol.new(buf))
    end

    private def parse_string : Value
      @data.read_char
      result = ""
      while (c = peek) && c != '"'
        result += @data.read_char.to_s
      end
      @data.read_char
      Value.new(result)
    end

    private def parse_symbol : Value
      buf = @data.read_char.to_s
      while (c = peek) && !c.delimeter?
        buf += @data.read_char.to_s
      end

      if buf == "nil"
        Value.nil
      else
        Value.new(Symbol.new(buf))
      end
    end

    def parse : Value
      skip_blanks()

      if (c = peek)
        puts c.ord
        case c
        when ';'
          while (c = peek) && c != '\n'
            @data.read_char
          end
          Value.nil
        when ')'
          @data.read_char
          @@PARSE_END
        when '('
          @data.read_char
          result = [] of Value
          while (value = self.parse) != @@PARSE_END
            # puts value.to_s
            result << value
            value = self.parse
          end

          if result.size > 0
            Value.new(result)
          else
            Value.nil
          end
        when '"'
          parse_string()
        when .number?
          parse_number()
        else
          parse_symbol()
        end
      else
        @@PARSE_END
      end
    end
  end
end
