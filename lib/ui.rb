class Ui
  class <<self
    def yellow(s)
      self.puts s.colorize(:yellow)
    end

    def red(s)
      self.puts s.colorize(:red)
    end

    def green(s)
      self.puts s.colorize(:green)
    end

    def light_blue(s)
      self.puts s.colorize(:light_blue)
    end

    def puts(s)
      Kernel.puts(s)
    end

    def get_user_input
      gets.chomp.to_i
    end
  end
end
