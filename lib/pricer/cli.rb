require 'pricer/calculator'
require 'pricer/errors'

module Pricer
  module CLI
    class << self
      # run - accepts pipe input or list of files
      # parses the line
      # runs calculator per line
      # pipe to STDOUT or STDERR depending what't the input
      def run
        ARGF.each_with_index do |line, index|
          begin
            parsed_line = parse(line)
            price = Pricer::Calculator.run(parsed_line)
            STDOUT.puts to_money(price)
          rescue Pricer::Errors::BadInput
            STDERR.puts "Bad Input on line: #{index}. [#{line.inspect}]"
          end
        end
      end

      # to_money - formatter
      # almost like a money gem but dumb
      # * use retarded but cool version of printf
      # * some regexp magic to add commas 
      def to_money(price)
        price = '$%.2f' % [price]
        price.reverse.gsub(/([0-9]{3}(?=([0-9])))/, '\\1,').reverse
      end

      # parce - worries about the input 
      def parse(string)
        serialized = string.chomp
        
        raise Pricer::Errors::BadInput if bad_input?(serialized)
        
        price, people, material = serialized.split(/\,\s/)

        if [price, people, material].any?(&method(:bad_input?))
          raise Pricer::Errors::BadInput
        end
        {
          price: price.tr('$,', '').to_f,
          people: people.to_i,
          material: material.to_sym
        }
      end

      # bad_input? - is when there's no or an empty string
      def bad_input?(string)
        string.nil? || string.empty?
      end
    end
  end
end
