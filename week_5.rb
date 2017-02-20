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
  # finish
  def split_up(lengths:, step: :length, pad: [])
    if step == length
      each_slice(lengths)
    elsif step != length
      slice(step..)
    end
  end
end
