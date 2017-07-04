require 'minitest/autorun'
require 'minitest/pride'
require 'pricer/cli'

class PricerCLITest < Minitest::Test
  def test_parse_string_to_args
    args = {
      price: 1_299.99,
      people: 3,
      material: :food
    }

    assert_equal args, Pricer::CLI.parse('$1,299.99, 3 people, food')
  end

  def test_bad_input_with_random_words_as_input
    begin
      Pricer::CLI.parse('some random stuff')
      assert false
    rescue Pricer::Errors::BadInput 
      assert true
    end
  end
  def test_bad_input_with_empty_input
    begin
      Pricer::CLI.parse('\n')
      assert false
    rescue Pricer::Errors::BadInput 
      assert true
    end
  end


  def test_format_price_to_money
    assert_equal '$1,299.99', Pricer::CLI.to_money(1_299.99)
  end
end