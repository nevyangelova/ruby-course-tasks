######################### Tic Tac Toe #########################

module TicTacToe
  class Board
    include Enumerable
    attr_accessor :board

    def initialize(board)
      @board = board
    end

    def matrix_size
      board.length - 1
    end

    def main_diagonal
      (0..matrix_size).map do |index|
        board[index][index]
      end
    end

    def secondary_diagonal
      (0..matrix_size).map do |index|
        board[index][matrix_size - index]
      end
    end

    def diagonals
      [main_diagonal, secondary_diagonal]
    end

    def rows
      board
    end

    def columns
      board.transpose
    end
    #
    # def winner_symbol
    #   possible_moves.each do |line|
    #     return line.first if line.uniq.length == 1
    #   end
    # end

    def winner?(symbol)
      possible_moves.any? do |line|
        line.all? { |el| el == symbol }
      end
    end

    def winning_symbol
      return 'o' if winner?('o')
      return 'x' if winner?('x')
    end

    def winner
      winner = winning_symbol
      if winner
        "Player with '#{winner}' is the winner."
      else
        nil
      end
    end

    def possible_moves
      rows + columns + diagonals
    end

    def matrix_index
      0.upto(matrix_size).map do |row|
        0.upto(matrix_size).map do |col|
          [row, col]
        end
      end.flatten(1)
    end

    # def winning_moves
       # symbol = winning_symbol
      # return [] if symbol.nil?
      # moves = []
      #
      # board.each_with_index do |row, index_row|
      #   el.each_with_index do |el, index_col|
      #     moves << [index_row, index_col] if symbol == el
      #   end
      # end
    # end
    def winning_moves
      matrix_index.select do |row, col|
        board[row][col] == winning_symbol
      end
    end
  end
end

board = TicTacToe::Board.new([['x', 'o', 'o'],
                              ['o', 'x', 'x'],
                              ['x', 'o', 'o']])

######################### Rock Paper Scissors #########################

class RockPaperScissors
  include Comparable
  attr_accessor :move

  def initialize(move)
    @move = move
  end

  def rules
    {
      rock: [:scissors, :lizard],
      paper: [:rock, :spock],
      scissors: [:paper, :lizard],
      lizard: [:spock, :paper],
      spock: [:scissors, :rock]
    }
  end

  def <=>(other_player)
    return 0 if move == other_player.move

    if rules[move].include? other_player.move
      1
    else
      -1
    end
  end
end

######################### Friend Database #########################

module Friendship
  class Friend
    attr_accessor :name, :sex, :age

    def initialize(name, sex, age)
      @name = name
      @sex = sex.to_sym
      @age = age
    end

    def male?
      sex == :male
    end

    def female?
      sex == :female
    end

    def over_eighteen?
      age.to_i > 18
    end

    def long_name?
      name.length.to_i > 10
    end

    def matches?(criteria)
      criteria.all? do |key, value|
        case key
        when :name then name == value
        when :sex then sex == value
        when :age then age == value
        when :filter then value.call(self)
        end
      end
    end
  end

  class Database
    include Enumerable
    attr_accessor :data

    def initialize
      @data = []
    end

    def each(&block)
      data.each(&block)
    end

    def add_friend(name, sex, age)
      data << Friend.new(name, sex, age)
    end

    def have_any_friends?
      !data.empty?
    end

    def find(criteria)
      data.select { |friend| friend.matches?(criteria) }
    end

    def unfriend(criteria)
      data.reject! { |friend| friend.matches?(criteria) }
    end
  end
end
