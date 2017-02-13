module MyEnumerable
  def map
    result = []

    each { |element| result << (yield element) }
    result
  end

  def filter
    result = []

    each { |element| result << element unless yield(element) }
    result
  end

  def reject(&block)
    select { |element| !block.call(element) }
  end

  def select
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
    if initial.nil?
      initial = first
      ignore_first = true
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

  def reduce_2(initial = nil)
    each.to_a.unshift(initial) if initial
    each { |item| initial = yield(initial, item) }
    initial
  end

  def any?
    each do |el|
      return true if yield(el)
    end
    false
  end

  def one?
    result = []

    each do |el|
      result << yield(el) if yield(el)
    end
    result.size == 1
  end

  def all?(&block)
    select(&block).size == size
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

    while index <= size - n
      yield original_array[index...(index + n)]
      index += 1
    end
    original_array
  end

  def include?(element)
    any? { |n| n == element }
  end

  def count(*args)
    return size if args.empty?
    select { |x| x == args[0] }.size
  end

  def size
    map { |_| 1 }.reduce(0, &:+)
  end

  def group_by
    hash = Hash.new([])

    each do |el|
      result = yield(el)
      hash[result] += [el]
    end # push in the array that is the value of the hash`s key
    hash
  end

  def min
    reduce do |acc, n|
      acc < n ? acc : n
    end
  end

  def min_by
    reduce do |acc, n|
      yield(acc) < yield(n) ? acc : n
    end
  end

  def max
    reduce do |acc, n|
      acc > n ? acc : n
    end
  end

  def max_by
    reduce do |acc, n|
      yield(acc) > yield(n) ? acc : n
    end
  end

  def minmax
    [min, max]
  end

  def minmax_by(&block)
    [min_by(&block), max_by(&block)]
  end

  def take(n)
    take_while { |_, i| i < n }
  end

  def take_while
    array = []

    each.with_index do |n, i|
      if yield(n, i)
        array << n
      else
        break
      end
    end
    array
  end

  def drop(n)
    drop_while { |_, i| i < n }
  end

  def drop_while
    index = 0

    each.with_index do |n, i|
      if yield(n, i)
        index += 1
      else
        break
      end
    end
    each.to_a[index..-1]
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
