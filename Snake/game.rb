require 'gosu'
require_relative 'snake'
require_relative 'food'

class Game < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "New Game"
    @snake = Snake.new
    @food = Food.new
    @font = Gosu::Font.new(20)
  end

  def update
    if @snake.game_over
    elsif Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
      @snake.turn("left") unless @snake.direction == "right"
    elsif Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
      @snake.turn("right") unless @snake.direction == "left"
    elsif Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_UP
      @snake.turn("up") unless @snake.direction == "down"
    elsif Gosu.button_down? Gosu::KB_DOWN or Gosu::button_down? Gosu::GP_DOWN
      @snake.turn("down") unless @snake.direction == "up"
    end
    @snake.move
    @snake.feed(@food)
  end

  def draw
    @snake.draw
    @food.draw
    @font.draw_text("Score: #{@snake.score}", 10, 10, 0)
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end
end

Game.new.show
