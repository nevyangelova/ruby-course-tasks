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

  def first
    each { |el| return el }
  end

  def first_2
    found = nil
    each do |element|
      found = element
      break
    end
    found
  end

  def reduce(initial = nil)
    # initial = nil is for the user to have the option to start the reduce from
    # wherever they want
    if initial.nil?
      ignore_first = true
      initial = first
    end
    index = 0

    each do |item|
      unless ignore_first && index.zero?
        initial = yield(initial, item)
      end
      index += 1
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
    each { |n| return false unless yield(n) }

    true
  end

  # Yield each consequative n elements.
  def each_cons(n)
    original_array = []
    index = 0
    each { |el| original_array << el }

    while index <= length - n
      yield original_array[index...(index + n)]
      index += 1
    end
    original_array
  end

  def include?(element)
    filter(yield(element)).empty?
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

  attr_reader :data

  def initialize(*data)
    @data = data
  end

  def each(&block)
    @data.each(&block)
  end
end
