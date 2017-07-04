require 'minitest/autorun'
require 'minitest/pride'
require 'pricer/calculator'

class PricerCalculatorTest < Minitest::Test
  ## Example 1:

      # Input:  $1,299.99, 3 people, food
      # Output: $1,591.58

  def test_example_1
    price = Pricer::Calculator.run(price: 1_299.99, people: 3, material: :food)
    assert_equal 1_591.58, price
  end
  ## Example 2:

      # Input:  $5,432.00, 1 person, drugs
      # Output: $6,199.81
  def test_example_2
    price = Pricer::Calculator.run(price: 5_432.00, people: 1, material: :drugs)
    assert_equal 6_199.81, price
  end
  ## Example 3:

      # Input:  $12,456.95, 4 people, books
      # Output: $13,707.63
  def test_example_3
    price = Pricer::Calculator.run(price: 12_456.95, people: 4, material: :books)
    assert_equal 13_707.63, price
  end

  ## Example 4:

      # Input:  $12,456.95, 0 people, books
      # Output: raise error
  def test_example_4_bad_input
    begin
      Pricer::Calculator.run(price: 12_456.95, people: 0, material: :books)
      assert false
    rescue Pricer::Errors::BadInput
      assert true
    end
  end
end