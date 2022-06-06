class Board
  attr_accessor :board, :positions_played
  def initialize
    @positions = [1,2,3,4,5,6,7,8,9]
    @positions_played = {1 => 0, 2 => 0, 3 => 0,
                         4 => 0, 5 => 0, 6 => 0,
                         7 => 0, 8 => 0, 9 => 0}
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
    if @positions_played[position] > 0
      puts "Cannot play here"
      return
    end
    @positions[position - 1] = shape
    @positions_played[position] += 1
    update_board
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
    @positions_played[position] < 1
  end

  def game_win?(shape)
    win_conds = [[@positions[0], @positions[1], @positions[2]],
                [@positions[3], @positions[4], @positions[5]],
                [@positions[6], @positions[7], @positions[8]],
                [@positions[0], @positions[3], @positions[6]],
                [@positions[1], @positions[4], @positions[7]],
                [@positions[2], @positions[5], @positions[8]],
                [@positions[1], @positions[4], @positions[8]],
                [@positions[2], @positions[4], @positions[6]]]
    win_conds.any? do |win_cond|
      win_cond.all? do |position|
        position == shape
      end
    end
  end

  def game_tie?
    @positions_played.all? { |count| count == 1 }
  end
end
