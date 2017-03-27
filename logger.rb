class Enum
  def self.map(array)
    result = []

    array.each { |element| result << (yield element) }
    result
  end

  class << self
    def filter(array)
      result = []

      array.each { |element| result << element unless yield(element) }
      result
    end
  end

  def Enum.reduce(array, initial)
    array.each.to_a.unshift(initial) if initial
    array.each { |item| initial = yield(initial, item) }
    initial
  end
end

p Enum.map([1,2,3]) { |n| n**2 }
p Enum.filter([1,2,3]) { |n| n.odd? }
p Enum.reduce([1,2,3], 0) { |a,n| a + n }

# logger
class Logger
  attr_writer :object
  # self is Logger
  def initialize
    @log = File.open('log.txt', 'a')
  end

  # private_class_method :new

  class << self
    private :new

    def instance
      @instance ||= new
    end
  end

  def log(message)
    # self is instance
    @object.puts(message)
  end
end

LOGGER = Cool::Logger.instance
LOGGER.log('=' * 10)

###################### Tests ######################
class Random
  def multiply
    random * 2
  end

  def random
    rand 2
  end
end

generator = Random.new

# test when 1
def generator.random
  1
end

generator.multiply.zero?

# test when 0
def generator.random
  0
end

generator.multiply.zero?

# Add more classes
class Animal
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def scream
    'ROAAR' + name
  end
end

# Test 1
pesho = Animal.new('Pesho')
pesho.scream == 'ROAARPesho'

# Test 2
stamat = Animal.new('Stamat')
def stamat.name
  'Stamat'
end

stamat.scream == 'ROAARRStamat'
