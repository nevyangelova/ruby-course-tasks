
def all_same_length?(arr)
  len = arr.first.length
  all?(arr) { |el| el.length == len }
end

def each(data)
  index = 0
  while index < data.length
    yield data[index]
    index += 1
  end
end

def each2(data, &block)
  index = 0
  while index < data.length
    block.call(data[index])
    index += 1
  end
end

def transform_value(x)
  yield x
end

def map(items)
  index = 0
  result = []
  while index < items.length
    value = yield items[index]
    result << value
    index += 1
  end

  result
end

def map_2
  Array.new.tap do |arr|
    each do |element|
      value = yield element
      arr << value
    end
  end
end

def filter
  Array.new.tap do |arr|
    each do |element|
      arr << element if (yield element)
    end
  end
end

def first
  element = nil

  each do |x|
    element = x
    break
  end

  element
end

class MyHash
  def initialize(myhash = {})
    @myhash = myhash
  end

  def to_array
    array = []
    @myhash.each do |key, value|
      array << [key, value]
    end
    array
  end
end

def reduce(initial = nil)
  skip_first = false

  if initial.nil?
    initial = first
    skip_first = true
  end

  each do |x|
    if skip_first
      skip_first = false
      next
    end
    initial = yield initial, x
  end

  initial
end

def negate_block(&block)
  proc { |x| !block.call(x) }
end

def reject(&block)
  filter(negate_block(&block))
end

def size
  map { |_| 1 }.reduce(0, &:+)
end

def any?(&block)
  filter(&block).empty?
end

def all?(&block)
  filter(&block).size == size
end

def include?(element)
  # Your code goes here
end

def count(element = nil)
  return size if element.nil?

  filter { |x| x == element }.size
end

def all_2?(array)
  array.each do |n|
    true if yield(n)
  end
end

def all_prime?(arr)
  arr.all? { |n| prime?(n) }
end

def to_hash
  Hash[*flatten]
end

def index_by
  map { |value| [yield(value), value] }.to_hash
end
