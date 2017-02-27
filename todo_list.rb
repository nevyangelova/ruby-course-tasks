class Todo
  # finish
  attr_accessor :name, :description, :date

  def initialize(name, description, priority, date)
    @name = name
    @description = description
    @priority = priority
    @date = date
  end

  def priority
    @priority.downcase.to_sym
  end
end

class Organizer
  attr_accessor :data

  def initialize(*data)
    @data = []
  end

  def <<(todo)
    data.push(todo)
  end

  def list(data)
    tasks = data.lines.map do |line|
      status, description, priority, tags = line.split('|', -1).map(&:strip)
      Todo.new(status, description, priority, tags.split(',').map(&:strip))
    end
    tasks
  end
end
