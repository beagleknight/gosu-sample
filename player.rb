class Player
  attr_reader :score

  def initialize(window)
    @image = Gosu::Image.new(window, "media/tibbers.jpg", false)
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    #@beep = Gosu::Sample.new(window, "media/beep.wav")
    @score = 0
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def turn_left
    @angle -= 4.5
  end

  def turn_right
    @angle += 4.5
  end

  def accelerate
    @vel_x += Gosu::offset_x(@angle, 0.5)
    @vel_y += Gosu::offset_y(@angle, 0.5)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480
    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def collect_stars(stars)
    stars.reject! do |star|
      if Gosu::distance(@x, @y, star.x, star.y) < 35 then
        @score += 10
        #@beep.play
        true
      else
        false
      end
    end
  end

  def draw
    @image.draw_rot(@x, @y, ZOrder::Player, @angle)
  end
end
