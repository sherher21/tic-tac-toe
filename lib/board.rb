class Board
  attr_accessor :board
  def initialize
    @positions = [1,2,3,4,5,6,7,8,9]
    @board = <<-BOARD
    
      #{@positions[0]} | #{@positions[1]} | #{@positions[2]}
     -----------
      #{@positions[3]} | #{@positions[4]} | #{@positions[5]}
     -----------
      #{@positions[6]} | #{@positions[7]} | #{@positions[8]}

    BOARD
  end

  def show_board
    puts @board
  end

  def update_positions(position, shape)
    if valid_position?(position)
      @positions[position - 1] = shape
      update_board
    else
      puts "Cannot play here"
    end
  end

  def update_board
    @board = <<-BOARD
    
      #{@positions[0]} | #{@positions[1]} | #{@positions[2]}
     -----------
      #{@positions[3]} | #{@positions[4]} | #{@positions[5]}
     -----------
      #{@positions[6]} | #{@positions[7]} | #{@positions[8]}

    BOARD
  end

  def valid_position?(position)
    @positions[position - 1] == position
  end

  def game_over?(shape)
    win_conds = [[@positions[0], @positions[1], @positions[2]],
                [@positions[3], @positions[4], @positions[5]],
                [@positions[6], @positions[7], @positions[8]],
                [@positions[0], @positions[3], @positions[6]],
                [@positions[1], @positions[4], @positions[7]],
                [@positions[2], @positions[5], @positions[8]],
                [@positions[0], @positions[4], @positions[8]],
                [@positions[2], @positions[4], @positions[6]]]
    win_conds.any? do |win_cond|
      win_cond.all? do |position|
        position == shape
      end
    end
  end

  def board_full?
    @positions.all? { |position| position =~ /[^0-9]/}
  end
end
