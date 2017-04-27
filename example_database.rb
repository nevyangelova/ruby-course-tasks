######################### Friend Database #########################

module Friendship
  class Friend
    attr_accessor :name, :sex, :age

    def initialize(name, sex, age)
      @name = name
      @sex = sex.to_sym
      @age = age
    end

    def male?
      sex == :male
    end

    def female?
      sex == :female
    end

    def over_eighteen?
      age.to_i > 18
    end

    def long_name?
      name.length.to_i > 10
    end

    def matches?(criteria)
      criteria.all? do |key, value|
        case key
        when :name then name == value
        when :sex then sex == value
        when :age then age == value
        when :filter then value.call(self)
        end
      end
    end
  end

  class Database
    include Enumerable
    attr_accessor :data

    def initialize
      @data = []
    end

    def each(&block)
      data.each(&block)
    end

    def add_friend(name, sex, age)
      data << Friend.new(name, sex, age)
    end

    def have_any_friends?
      !data.empty?
    end

    def find(criteria)
      data.select { |friend| friend.matches?(criteria) }
    end

    def unfriend(criteria)
      data.reject! { |friend| friend.matches?(criteria) }
    end
  end
end
