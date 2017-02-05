
######################## Numbers to digits ########################

def number_to_digits(n)
  n.to_s.chars.map(&:to_i)
end

######################## Digits to numbers ########################

def digits_to_number(digits)
  digits.reduce(0) { |a, b| a * 10 + b }
end

def digits_to_number_2(array)
  new_number = 0
  array.each do |number|
    new_number *= 10 + number
  end
  new_number
end

######################## Histogram ########################

def grayscale_histogram(image)
  histogram = Array.new(256, 0)
  row = 0
  column = 0

  while row < image.length
    column = 0

    while column < image[row].length
      histogram[image[row][column]] += 1
      column += 1
    end

    row += 1
  end
  histogram
end

def grayscale_histogram_2(image)
  histogram = Array.new(256, 0)

  image.each do |row|
    row.each do |col|
      histogram[col] += 1
    end
  end
  histogram
end

######################## Max scalar product ########################

def max_scalar_product(v1, v2)
  v1 = v1.sort
  v2 = v2.sort
  index = 0
  sum = 0

  until index > v1.length
    sum += v1[index].to_i * v2[index].to_i

    index += 1
  end
  sum
end

######################## Max scalar product ########################

def max_span(numbers)
  array_length = numbers.length
  index = 0
  max_span = []
  last_number = array_length

  while index < array_length
    while last_number > index
      if numbers[index] == numbers[last_number]
        max_span << (last_number - index + 1)

        break
      end
      last_number -= 1
    end
    last_number = array_length
    index += 1
  end
  max_span.max
end

def max_span_2(numbers)
  length = numbers.length
  max_span = []

  numbers.each_with_index do |element, index|
    numbers.reverse.each_with_index do |last_el, last_index|
      if element == last_el
        max_span << length - (last_index + index)
      end
    end
  end
  max_span.max
end

######################## Invert ########################

def invert(hash)
  new_hash = {}

  hash.each do |key, value|
    if new_hash[value]
      old_val = new_hash[value]
      new_hash[value] = []
      new_hash[value] << old_val
      new_hash[value] << key
      new_hash[value].flatten!
    else
      new_hash[value] = key
    end
  end
end

######################## Sum matrix ########################

def sum_matrix(m)
  array = m.flatten

  array.reduce(0) { |sum, x| sum + x }
end

def sum_matrix_2(m)
  array = m.flatten
  sum = 0
  array.each { |x| sum += x }
  sum
end

######################## Matrix Bombing plan ########################

def matrix_bombing_plan(matrix)
  result = {}

  matrix.each_with_index do |row, index_row|
    row.each_with_index do |_, index_col|
      bombed_matrix = bomb_matrix(matrix, index_row, index_col)

      result[[index_row, index_col]] = sum_matrix_2(bombed_matrix)
    end
  end
  result
end

def neighbours_coordinates(matrix, x, y)
  possible_neighbours = [
    [x - 1, y - 1], [x - 1, y], [x - 1, y + 1],
    [x + 1, y - 1], [x + 1, y], [x + 1, y + 1],
    [x, y - 1], [x, y + 1]
  ]
  index = 0
  neighbours = []

  while index < possible_neighbours.length
    i, j = possible_neighbours[index]
    valid_indexes = (0..matrix.length)

    if valid_indexes.include?(i) && valid_indexes.include?(j)
      neighbours << [i, j]
    end
    index += 1
  end
  neighbours
end

def bomb_matrix(matrix, x, y)
  neighbours = neighbours_coordinates(matrix, x, y)
  bombed_matrix = []
  target_value = matrix[x][y]

  matrix.each_with_index do |row, index_row|
    row.each_with_index do |value, index_col|
      if neighbours.include?([index_row, index_col]) && value >= target_value
        value -= target_value
      end
      bombed_matrix[index_row] ||= []
      bombed_matrix[index_row][index_col] ||= value
    end
  end
  bombed_matrix
end

######################## Group ########################

def group(arr)
  n = 0
  new_arr = []
  final_arr = []

  while n < arr.length
    current = arr[n]
    next_num = arr[n + 1]

    if current == next_num
      new_arr << arr[n]
    else
      new_arr << arr[n]
      final_arr << new_arr

      new_arr = []
    end
    n += 1
  end
  final_arr
end

def group_2(arr)
  arr.group_by { |x| x }.values
end

######################## Max consecutive ########################

def max_consecutive(items)
  count = 1
  max_count = 0

  items.each_with_index do |n, i|
    if n == items[i + 1]
      count += 1
    else
      max_count = count if count > max_count
      count = 1
    end
  end

  max_count
end
