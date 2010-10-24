module ScreenUtil
  extend self
  def clear
    puts "\e[H\e[2J" # clear the screen
  end
end

