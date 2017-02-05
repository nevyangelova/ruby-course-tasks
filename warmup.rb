######################## Factorial Numbers ########################

def fact(n)
  sum = 1

  while n > 0
    sum *= n
    n -= 1

  end
  sum
end

def fact_reccursive(n)
  return n * fact_reccursive(n - 1) if n > 1

  n
end

######################## Lucas Numbers ########################

def nth_lucas(n)
  a = 2
  b = 1
  array = [a, b]

  while n > 1
    temp = a
    a = b
    b = temp + b
    n -= 1

    array << b
  end
  a
end

def first_lucas(n)
  array = []
  (1..n).each { |num| array << nth_lucas(num) }

  array
end

######################## Counts Digits ########################

def count_digits(n)
  if n >= 0
    n.to_s.length
  else
    n.to_s.length - 1
  end
end

def count_digits2(n)
  n.abs.to_s.length
end

# NOTE: not working with negative numbers
def count_digits3(n)
  count = 0
  while n > 0
    count += 1
    n /= 10
  end
  count
end

######################## Sum Digits ########################

def sum_digits(n)
  if n > 0
    n % 10 + sum_digits(n / 10)
  else
    n
  end
end

def sum_digits_2(n)
  sum = 0
  while n > 0
    last_number = n % 10
    n /= 10
    sum += last_number
  end
  sum
end

def sum_digits_3(n)
  return n % 10 + sum_digits_3(n / 10) if n > 0
  n
end

######################## Factorial Recursive ########################

def factorial_digits(n)
  sum = 0
  n.to_s.each_char do |i|
    sum += fact(i.to_i)
  end

  sum
end

######################## Fibonacci Numbers ########################

def fib_number(n)
  return 1 if n <= 1
  a = 1
  b = 1
  array = [a, b]

  while n > 2
    sum = a + b
    a = b
    b = sum

    array.push sum
    n -= 1
  end

  array.join.to_i
end

######################## Hack Numbers ########################

def hack?(n)
  binary_n = n.to_s(2)
  binary_n == binary_n.reverse && binary_n.count('1').odd?
end

def next_hack(n)
  n += 1
  until hack?(n)
    n += 1
  end
  n
end

def next_hack_2(n)
  n += 1
  n += 1 until hack?(n)
  n
end

######################## Count Letters ########################

def count_vowels(str)
  str.downcase.count('aeiouy')
end

def count_consonants(str)
  count = 0
  str.each_char do |char|
    if ('a'..'z').include?(char) && count_vowels(char).zero?
      count += 1
    end
  end
  count
end

######################## Numbers Reverse ########################

def number_reverse(n)
  n.to_s.reverse.to_i
end

def palindrome?(n)
  n.to_s == n.to_s.reverse
end

######################## Palindrome Scores ########################

def p_score(n)
  score = 1

  while n != number_reverse(n)
    score += 1
    n = n + number_reverse(n)
  end
  score
end

def p_score_2(n)
  score = 1

  until palindrome?(n)
    score += 1
    n = n + number_reverse(n)
  end
  score
end

def p_score_3(n)
  return 1 if palindrome?(n)

  1 + p_score_3(n + number_reverse(n))
end

######################## Prime Numbers ########################

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

def first_primes(n)
  array = []
  number_to_check = 2

  until array.length == n
    array << number_to_check if prime?(number_to_check)
    number_to_check += 1
  end
  array
end

######################## Numbers in string ########################

def sum_of_numbers_in_string(str)
  numbers_in_string = str.split(/[a-zA-Z]/)
  number_length = numbers_in_string.length
  index = 0
  sum = 0

  while index < number_length
    current = numbers_in_string[index].to_i
    sum += current

    index += 1
  end
  sum
end

######################## Anagrams ########################

def anagrams?(a, b)
  a.chars.sort == b.chars.sort
end

def balanced?(n)
  array = n.to_s.split('')
  index = 0

  while index < array.length
    array[index] = array[index].to_i
    index += 1
  end

  count = array.length / 2
  left = sum_digits_3(array.first(count).join('').to_i)
  right = sum_digits_3(array.last(count).join('').to_i)

  left == right
end

def zero_insert(n)
  array = n.to_s.split('')
  index = 0

  while index < array.length
    if array[index] == array[index + 1] ||
       ((array[index].to_i + array[index + 1].to_i) % 10).zero?
      array.insert(index + 1, 0)
    end

    index += 1
  end
  array.join('').to_i
end
