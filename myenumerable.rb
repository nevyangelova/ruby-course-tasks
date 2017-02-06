module MyEnumerable
  def map
    result = []

    each { |element| result << (yield element) }
    result
  end

  def filter
    result = []

    each { |element| result << element if yield element }
    result
  end

  def reject
    result = []

    each { |element| result << element if yield element }
    result
  end

  def reduce(initial = nil)
    if initial
      each { |item| initial = yield(initial, item) }
    else
      initial = self.arr.first
    end
    initial
  end

  def any?(&block)
    !filter(&block).empty?
  end

  def one?(&block)
    filter(&block).size == 1
  end

  def one_2?
    result = []

    each do |el|
      result << yield(el) if yield(el)
    end
    result.size == 1
  end

  def all?(&block)
    filter(&block).size == size
  end

  def all_2?
    each { |n| true if yield(n) }
  end

  # Yield each consequative n elements.
  def each_cons(n)
    result = []
    index = 0

    while index < n
      each do |el|
        result << el
      end
    end
  end

  def include?(element)
    # Your code goes here.
  end

  # Count the occurences of an element in the collection. If no element is
  # given, count the size of the collection.
  def count(element = nil)
    return size if element.nil?

    filter { |x| x == element }.size
  end

  # Count the size of the collection.
  def size
    map { |_| 1 }.reduce(0, &:+)
  end

  # Groups the collection by result of the block.
  # Returns a hash where the keys are the evaluated
  # result from the block and the values are arrays
  # of elements in the collection that correspond to
  # the key.
  def group_by
  end

  def min
    # Your code goes here.
  end

  def min_by
    # Your code goes here.
  end

  def max
    # Your code goes here.
  end

  def max_by
    # Your code goes here.
  end

  def minmax
    # Your code goes here.
  end

  def minmax_by
    # Your code goes here.
  end

  def take(n)
    # Your code goes here.
  end

  def take_while
    # Your code goes here.
  end

  def drop(n)
    # Your code goes here.
  end

  def drop_while
    # Your code goes here.
  end
end

class MyArray
  include MyEnumerable

  attr_reader :arr

  def initialize(arr)
    @arr = arr
  end

  def each(&block)
    @arr.each(&block)
  end
end
