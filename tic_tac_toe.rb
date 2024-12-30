class TicTacToe
  WINNING_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], # Rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], # Columns
    [0, 4, 8], [2, 4, 6]             # Diagonals
  ].freeze

  def initialize
    @board = Array.new(9, :empty)
    @current_player = :X
  end

  def play
    puts "Welcome to Tic-Tac-Toe!"
    display_board

    loop do
      player_move
      display_board
      if winner?
        puts "Player #{@current_player} wins!"
        break
      elsif draw?
        puts "It's a draw!"
        break
      else
        switch_player
      end
    end

    puts "Play again? (y/n)"
    reset_game if gets.chomp.downcase == 'y'
  end

  private

  def display_board
    rows = @board.each_slice(3).map { |row| row.map { |cell| cell == :empty ? " " : cell }.join(" | ") }
    puts rows.join("\n--+---+--\n")
  end

  def player_move
    loop do
      print "Player #{@current_player}, choose a position (1-9): "
      input = gets.chomp.to_i - 1
      if !valid_move?(input)
        puts "Invalid move. Please try again."
        next
      end
      @board[input] = @current_player
      break
    end
  end

  def valid_move?(position)
    position.between?(0, 8) && @board[position] == :empty
  end

  def winner?
    WINNING_COMBINATIONS.any? { |combo| winning_combo?(combo) }
  end

  def winning_combo?(combo)
    combo.all? { |index| @board[index] == @current_player }
  end

  def draw?
    @board.none? { |cell| cell == :empty }
  end

  def switch_player
    @current_player = @current_player == :X ? :O : :X
  end

  def reset_game
    @board = Array.new(9, :empty)
    @current_player = :X
    play
  end
end

game = TicTacToe.new
game.play
