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
