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
