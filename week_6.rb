class Hash
  def transform_values
    return enum_for(:transform_values) unless block_given?
    result = self.class.new
    each do |key, value|
      result[key] = yield(value)
    end
    result
  end
end

e = Enumerator.new(ObjectSpace, :each_object)
#-> ObjectSpace.enum_for(:each_object)

############################################################
to_three = Enumerator.new do |yielder|
  3.times do |x|
    yielder << x
  end
end

to_three_with_string = to_three.with_object('foo')
to_three_with_string.each do |x, string|
  puts string + x.to_s
end

############################################################
User = Struct.new(:name, :age)

users = [User.new('Bob', 37), User.new('Sally', 23),
         User.new('Andrew', 18), User.new('Bil', 48)]

users_over_nineteen = ->(user) { user.age > 19 }

users.lazy.select(&users_over_nineteen)
     .map(&:name)
     .map(&:length)
     .to_a
# pry reads them as new rows and it wont work in it(has to be 1 row)
############################################################
User = Struct.new(:name, :age)

users = [User.new('Bob', 37), User.new('Sally', 23),
         User.new('Andrew', 18), User.new('Bil', 48)]

users.lazy.select do |user|
  # lazy doesnt make in between arrays! Just implements all methods on one user
  p 'Selecting ' + user.name
  user.age > 19
end.map do |user|
  p 'Mapping to name ' + user.name
  user.name
end.map do |name|
  p 'Counting letters ' + name
  name.length
end.to_a

filter_names = ->(user) { user.name.length > 6 }
take_age = ->(user) { user.age }

users.lazy.select(&filter_names).map(&take_age)

############################################################
def fibonacci
  Enumerator.new do |yielder|
    a = b = 1

    loop do
      yielder << a
      a, b = b, a + b
    end
  end
end

fibonacci.lazy.select(&:even?).first(10)
# lazy says 'when you find first 10 stop iterating'
# method that takes enum and makes it 'lazy' so it doesnt take all numbers
# implemented on one element instead of all array! Thats why fast with 'first'
############################################################
array = [1, 2, 3, 4, 5, 6]
enum = array.to_enum(:map)
enum.each { |n| n if n.even? }

############################################################
array = [1, 2, 3, 4]
enum = array.select
enum.each { |n| n if n.even? }

############################################################
hash = { one: 1, two: 2 }
enum = hash.map
enum.each { |_, value| value * 10 }

############################################################
enum = Enumerator.new do |yielder|
  n = 0
  loop do
    yielder << n
    n += 1
  end
end

enum.first(10)

############################################################
class Enumerator
  def lazy_select(&block)
    self.class.new do |yielder|
      each do |n|
        yielder << n if block[n]
      end
    end
  end
end

enum.lazy_select { |n| n if n.even? }.first(5)

############################################################
enum = 5.times
enum.map { puts 'lalala' }

############################################################
enum = 1.upto 10
enum.reduce(:+)

############################################################
enum = 5.downto 0
enum.map { |n| n if n.even? }

############################################################
def prime?(n)
  return false if n <= 1

  count = 2
  limit = n / count

  while count <= limit
    return false if (n % count).zero?

    count += 1
  end
  true
end

def return_primes # to_enum accept methods that yield
  # they create new object from Enumerator that would point to that method
  # it will stop the endless loop until next yield is needed
  number = 1

  loop do
    yield number if prime?(number)
    number += 1
  end
end

def prime_enum
  Enumerator.new do |yielder|
    n = 1
    loop do
      yielder << n if prime? n
      n += 1
    end
  end
end

def prime_enum_2
  to_enum(:return_primes)
end

e = enum_for(:return_primes)

class Queue
  attr_accessor :data

  def initialize(*data)
    @data = []
    @data.push(*data)
  end

  def each(&block)
    data.each(&block)
  end

  def pop
    data.pop
  end

  def push(element)
    data.unshift(element)
    self
  end
end

class Stack
  attr_accessor :data

  def initialize
    @data = []
  end

  def each(&block)
    data.each(&block)
  end

  def pop
    data.pop
  end

  def push(*elements)
    data.push(elements)
    self
  end
end

class Set
  
end
