require_relative 'food'

class Snake
  attr_reader :direction, :game_over, :score

  def initialize
    @snake_head = Gosu::Image.new("media/snake_square.bmp")
    @vel = 1
    @direction = "right"
    @snake_body = [[0, 0]]
    @grow = false
    @score = 0
  end

  def turn(dir)
    @direction = dir
  end

  def move
    snake_x = @snake_body[0][0]
    snake_y = @snake_body[0][1]
    new_pos = []

    case @direction
    when 'up'
      new_pos << snake_x
      new_pos << (snake_y - @vel) % 480
    when 'right'
      new_pos << (snake_x + @vel) % 640
      new_pos << snake_y
    when 'down'
      new_pos << snake_x
      new_pos << (snake_y + @vel) % 480
    when 'left'
      new_pos << (snake_x - @vel) % 640
      new_pos << snake_y
    end

    if @snake_body.include? new_pos
      @game_over = true
    else
      @snake_body.insert(0, new_pos)
      @snake_body.pop unless @grow
    end
    @grow = false
  end

  def feed(food)
    @snake_body.each do |x, y|
      if Gosu::distance(food.x, food.y, x, y) < 10
        #(limit_up_x..limit_down_x).include?(x) && (limit_up_y..limit_down_y).include?(y)
        food.pos_init
        @score += 1
        @vel += 0.5
        @grow = true
      end
    end
  end

  def draw
    @snake_body.each do |x, y|
      @snake_head.draw(x, y, 1)
    end
  end
end
