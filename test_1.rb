
######################### Cool numbers #########################

def cool_numbers(n)
  ordinal = case n % 100
  when 11, 12, 13 then n.to_s + 'th'
           else
             case n % 10
             when 1 then n.to_s + 'st'
             when 2 then n.to_s + 'nd'
             when 3 then n.to_s + 'rd'
             else n.to_s + 'th'
             end
           end
  ordinal
end

######################### Tic Tac Toe #########################

module TicTacToe
  class Board
    include Enumerable
    attr_accessor :data

    def initialize(data)
      @data = data
    end

    def each(&block)
      data.each(&block)
    end

    def cell(x, y)
      data[x][y]
    end

    def winner
      @symbol = nil
      if data[0].all? { |n| n == "x" } || data[1].all? { |n| n == "x" } || data[2].all? { |n| n == "x" }
        @symbol = "x"
      elsif data[0].all? { |n| n == "o" } || data[1].all? { |n| n == "o" } || data[2].all? { |n| n == "o" }
        @symbol = "o"
      elsif [data[0][0], data[1][1], data[2][2]].all? { |n| n == "x" } || [data[0][2], data[1][1], data[2][0]].all? { |n| n == "x" }
        @symbol = "x"
      elsif [data[0][0], data[1][1], data[2][2]].all? { |n| n == "o" } || [data[0][2], data[1][1], data[2][0]].all? { |n| n == "o" }
        @symbol = "o"
      elsif ([data[0][0], data[1][0], data[2][0]].all? { |n| n == "x" } || [data[0][2], data[1][2], data[2][2]].all? { |n| n == "x" } ||
        [data[0][1], data[1][1], data[2][1]].all? { |n| n == "x" })
        @symbol = "x"
      elsif ([data[0][0], data[1][0], data[2][0]].all? { |n| n == "o" } || [data[0][2], data[1][2], data[2][2]].all? { |n| n == "o" } ||
        [data[0][1], data[1][1], data[2][1]].all? { |n| n == "o" })
        @symbol = "o"
      end
      if @symbol == nil
        @symbol
      else
        "Player with '#{@symbol}' is the winner."
      end
    end

    def make_hash(data)
      result = {}
      array = []

      data.each_with_index do |row, index_row|
        row.each_with_index do |col, index_col|
          array << [index_row, index_col]
          result[array] = col
          array = []
        end
      end
      result
    end

    def winning_moves
      winner
      moves = []

      make_hash(data).each do |first_arr, value|
        moves.push(first_arr) if value == @symbol
      end
      moves.flatten(1)
    end
  end
end

board = TicTacToe::Board.new([['x', 'o', 'o'],
                              ['o', 'x', 'x'],
                              ['x', 'o', 'o']])

######################### Rock Paper Scissors #########################

class RockPaperScissors
  attr_accessor :move
  def initialize(move)
    @move = move
  end

  def gameplay
    {
      rock: [:scissors, :lizard],
      paper: [:rock, :spock],
      scissors: [:paper, :lizard],
      lizard: [:spock, :paper],
      spock: [:scissors, :rock]
    }
  end

  def <(other_player)
    gameplay[other_player.move].include? move
  end

  def <=(other_player)
    gameplay[other_player.move].include?(move) || move == other_player.move
  end

  def ==(other_player)
    move == other_player.move
  end

  def >(other_player)
    gameplay[move].include? other_player.move
  end

  def >=(other_player)
    gameplay[move].include?(other_player.move) || move == other_player.move
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
