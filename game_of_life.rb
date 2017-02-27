# Game of life specific module
module GameOfLife
  # Boards constructor
  class Board
    include Enumerable
    attr_accessor :data

    def initialize(*data)
      @data = data
    end

    def each(&block)
      data.each(&block)
    end

    def [](x, y)
      alive?(x, y)
    end

    def next_generation
      survivors = []

      data.each do |x, y|
        survivors << [x, y] if will_be_born?(x, y) || will_survive?(x, y)
        survivors.push(*candidates(x, y))
      end

      Board.new(*survivors.uniq)
    end

    def candidates(x, y)
      neighbours(x, y).select { |i, j| will_be_born?(i, j) }
    end

    def neighbours(x, y)
      [
        [x - 1, y - 1], [x - 1, y], [x - 1, y + 1],
        [x + 1, y - 1], [x + 1, y], [x + 1, y + 1],
        [x, y - 1], [x, y + 1]
      ]
    end

    def alive_neighbours(x, y)
      neighbours(x, y).select { |i, j| alive?(i, j) }
    end

    def alive?(x, y)
      data.include?([x, y])
    end

    def will_survive?(x, y)
      (2..3).cover?(alive_neighbours(x, y).count) && alive?(x, y)
    end

    def will_be_born?(x, y)
      alive_neighbours(x, y).count == 3 && !alive?(x, y)
    end
  end
end

board = GameOfLife::Board.new [1, 2], [1, 3]

board.each do |x, y|
  puts "The cell at (#{x}, #{y}) is alive"
end
