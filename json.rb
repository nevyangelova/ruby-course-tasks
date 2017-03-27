module My
  class JSON
    class << self
      def parse(json)
        first, *mid, last = json.tr('"', '').split(":")
        first = first.tr('{', '')
        last = last.tr('}', '')
        parsed = [first, *(parse_comma_for_array(mid)), last].flatten
        Hash[*parsed].map do |key, value|
          key = key.strip
          value = value.strip
          [key, to_array(value)]
        end.to_h
      end

      private

      def to_array(str)
        if str.include? ']'
          str.tr('[]', '').split(', ')
        else
          str
        end
      end

      def parse_comma_for_array(array)
        array.map { |el| parse_comma(el) }
      end

      def parse_comma(element)
        *first, last = element.split(',')
        [first.join(','), last]
      end
    end
  end
end

####################### Keyword args ##############################

class Ninja
  def name(first_name, last_name, fullname: false)
    if fullname
      "#{first_name} #{last_name}"
    else
      first_name
    end
  end

  def weapons(hash, weapon = 'spoon')
    str = "I have a #{weapon}"
    hash.each do |option, value|
      str += "\n#{weapon} has #{option}: #{value}"
    end
    str
  end
end

pesho = Ninja.new
puts pesho.weapons size: '10', history: 'Ancient spoon from Galifrey'
puts pesho.name('Petur', 'Petrov')
puts pesho.name 'Petur', 'Petrov'

def calculate(grade:, height:, weigth:)
  grade + height + weigth
end

p calculate(grade: 100, height: 200, weigth: 300)

p 'Keywords test: '
def keywords(age, **kws)
  kws
end

p keywords(20, name: 'Pesho', last_name: 'Petrov', had_lunch: true)
