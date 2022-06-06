class Player
  attr_reader :name, :shape
  attr_accessor :win_count
  @@player_list = []

  def initialize(name)
    if @@player_list.length == 0
      shape = "X"
    else
      shape = "O"
    end
    
    @shape = shape
    @name = name
    @@player_list.push(name)
    @win_count = 0
  end

  def play(game)
    puts "#{@name}'s turn. Enter position to play:"
    position = gets.chomp.to_i

    until game.valid_position?(position)
      puts "Invalid, enter an unplayed position from 1-9"
      position = gets.chomp.to_i
    end

    game.update_positions(position, @shape)    
  end

  def player_win?(game)
    game.game_win?(@shape)
  end
end
