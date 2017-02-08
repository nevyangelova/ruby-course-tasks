class Array

  def to_hash
    hash = {}

    each do |key, value|
      hash[key] = value
    end
    hash
  end

  def index_by
    hash = {}

    each do |el|
      hash[yield(el)] = el
    end

    hash
  end

  def occurences_count
    hash = Hash.new(0)
    each do |el|
      hash[el] += 1
    end

    hash
  end

  def subarray_count(subarray)
    count = 0
    arr = self
    (0...arr.length).each do |n|
      count += 1 if subarray == arr[n...(n + subarray.size)]
    end

    count
  end
end
