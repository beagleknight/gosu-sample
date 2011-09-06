require 'gosu'

module ZOrder
  Background, Stars, Player, UI = *0..3
end

require './player'
require './star'

class GameWindow < Gosu::Window
  def initialize
    super(640, 480, false)
    self.caption = "Tutorial de Gosu"
    @background_image = Gosu::Image.new(self, "media/annie.png", true)
    @player = Player.new(self)
    @player.warp(320, 240)
    @star_anim = Gosu::Image::load_tiles(self, "media/star.png",25, 25, false)
    @stars = Array.new
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
  end

  def update
    if button_down? Gosu::Button::KbLeft or
      button_down? Gosu::Button::GpLeft then
      @player.turn_left
    end

    if button_down? Gosu::Button::KbRight or
      button_down? Gosu::Button::GpRight then
      @player.turn_right
    end

    if button_down? Gosu::Button::KbUp or
      button_down? Gosu::Button::GpButton0 then
      @player.accelerate
    end

    @player.move
    @player.collect_stars(@stars)

    if rand(100) < 4 and @stars.size < 25 then
      @stars.push(Star.new(@star_anim))
    end
  end

  def draw
    @player.draw
    @background_image.draw(0, 0, ZOrder::Background)
    @stars.each { |star| star.draw }
    @font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)
  end

  def button_down(id)
    if id == Gosu::Button::KbEscape
      close
    end
  end
end

window = GameWindow.new
window.show

