require_relative('player.rb')
require_relative('board.rb')

# Game initialization
play_game = ""
puts "Enter name of player 1"
player1 = Player.new(gets.chomp)
puts "Enter name of player 2"
player2 = Player.new(gets.chomp)

# Game loop
until play_game == "q"
  game = Board.new
  game.show_board

  puts <<-RULES
    1. Player 1 is "X" and will start first
    2. Player 2 is "O" and will start second    
    3. First player to place three of their marks in a horizontal, vertical, 
    or diagonal row is the winner.
    4. Enter the position number you wish to play each round.
    5. You cannot play a position that has already been played.

  RULES

  loop do
    player1.play(game)
    if player1.player_win?(game)
      game.show_board
      player1.win_count += 1
      puts "Player #{player1.name} wins!\n"
      break
    elsif game.board_full?
      puts "Tie game!\n"
      game.show_board
      break
    end

    game.show_board

    player2.play(game)
    if player2.player_win?(game)
      game.show_board
      player2.win_count += 1
      puts "Player #{player2.name} wins!\n"
      break
    elsif game.board_full?
      puts "Tie game!\n"
      game.show_board
      break
    end

    game.show_board
  end

  puts "Do you want to play another game? Enter \"q\" to quit."
  play_game = gets.chomp
end

puts "\nPlayer #{player1.name} won #{player1.win_count} games."
puts "Player #{player2.name} won #{player2.win_count} games."
