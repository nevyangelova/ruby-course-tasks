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
      data[x, y].alive?(x, y)
    end

    def next_generation
      survivors = []
      @data.each do |x, y|
        survivors << [x, y] if alive?(x, y) || will_be_born?(x, y) || will_survive?(x, y)
      end

      Board.new(*survivors) # new instance with coordinates after calculations
    end

    def neighbours(x, y)
      possible_neighbours = [
        [x - 1, y - 1], [x - 1, y], [x - 1, y + 1],
        [x + 1, y - 1], [x + 1, y], [x + 1, y + 1],
        [x, y - 1], [x, y + 1]
      ]
      index = 0
      alive_neighbours = []

      possible_neighbours.each_with_index do |_, ind|
        i, j = possible_neighbours[ind]
        if alive?(i, j)
          alive_neighbours << [i, j]
        end
        index += 1
      end
      alive_neighbours
    end

    def alive?(x, y)
      data.include?([x, y])
    end

    def will_survive?(x, y)
      neighbours(x, y).count == (2..3) && alive?(x, y)
    end

    def will_be_born?(x, y)
      neighbours(x, y).count == 3 && !alive?(x, y)
    end
  end
end

board = GameOfLife::Board.new [1, 2], [1, 3]

board.each do |x, y|
  puts "The cell at (#{x}, #{y}) is alive"
end
