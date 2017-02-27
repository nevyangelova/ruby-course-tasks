class Proxy
  def method_missing(method, *args, &block)
    proc { |obj| obj.send(method, *args, &block) }
  end

  def to_proc
    proc { |obj| obj }
  end
end

P = Proxy.new

# p [1, 2, 3].map(&P**2)

# p [[1], [2], [3]].map(&P.select(&:even?))

# p [1,2,3].map(&P)

def self.method_missing(*args)
  args.join(' ')
end

module Enumerable
  def split_up(lengths:, step1: nil, pad: [])
    step1 ||= lengths
    result = each_slice(step1).to_a
    result[-1] = result[-1].push(*pad)
    result.map { |subarr| subarr.take(lengths) }
  end
end
