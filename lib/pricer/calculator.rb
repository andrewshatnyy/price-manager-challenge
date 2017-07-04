require 'pricer/errors'

module Pricer
  module Calculator
    # Essentially a storage for all percents
    # would be smart to load it from yaml or json
    # but I'm not sure if I have time for this :)

    MARKUPS = {
      _default: 5,
      _work: 1.2,
      drugs: 7.5,
      food: 13,
      electronics: 2
    }

    class << self
      # run - basically the calculator
      # takes options and returns result
      # * validate
      # * build base markup sum
      # * combine percents for the rest of markups
      # * apply markups
      # * return back to float 2 precision
      # 
      def run(options = {})
        validate!(options)

        precision(options[:price]) do |cents| 
          base = cents * percent(get_mark(:_default))
          markups = build_markups(options)
          base * percent(markups)
        end
      end
      
      # get_mark - returns value of a markup
      # * zero if none found
      def get_mark(type)
        MARKUPS[type] || 0
      end

      # precision - maintians cents and returns dolars
      # * remove float
      # * add float 2 back
      def precision(price)
        result = yield price * 100
        (result / 100.00).round(2)
      end

      # build_markups - adds percents for
      # all the rest of markups
      def build_markups(options)
        [
          get_mark(:_work) * options[:people],
          get_mark(options[:material])
        ].reduce(0) { |acc, pc| acc + pc }
      end

      # percent - adds whole one to the precent
      def percent(num)
        (100 + num) / 100.to_f
      end

      # validate! - raises whole bunch of errors
      # to prevent crappy input
      def validate!(options)
        raise Pricer::Errors::BadInput if options.nil?
        [:people, :price, :material].find do |arg|
          if options[arg].nil?
            raise Pricer::Errors::BadInput 
          end
        end
        raise Pricer::Errors::BadInput if options[:people] < 1
      end
    end
  end
end
