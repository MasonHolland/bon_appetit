require './lib/pantry'
require './lib/recipe'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class PantryTest < Minitest::Test

  def test_it_exists
    pantry = Pantry.new

    assert_instance_of Pantry, pantry
  end

  def test_pantry_has_stock
    pantry = Pantry.new

    assert_equal pantry.stock, {}
  end

  def test_stock_can_be_checked
    pantry = Pantry.new

    assert_equal 0, pantry.stock_check("Cheese")
  end

  def test_can_stock_items_and_retrieve_correct_count
    pantry = Pantry.new
    pantry.restock("Cheese", 10)

    assert_equal 10, pantry.stock_check("Cheese")
  end

  def test_can_stock_items_twice_and_retrieve_correct_count
    pantry = Pantry.new
    pantry.restock("Cheese", 10)
    pantry.restock("Cheese", 20)

    assert_equal 30, pantry.stock_check("Cheese")
  end

  def test_recipe_can_exist
    pantry = Pantry.new
    r = Recipe.new("Cheese Pizza")

    assert_instance_of Recipe, r
  end

  def test_can_call_ingredients
    pantry = Pantry.new
    r = Recipe.new("Cheese Pizza")

    assert_equal r.ingredients, {}
  end

  def test_can_add_ingredients
    pantry = Pantry.new
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)

    assert_equal r.ingredients, {"Cheese" => 20, "Flour" => 20}
  end

  def test_can_add_to_shopping_list_and_call_it
    pantry = Pantry.new
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(r)

    assert_equal pantry.shopping_list, {"Cheese" => 20, "Flour" => 20}
  end

  def test_can_add_another_recipe
    pantry = Pantry.new
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(r)
    r = Recipe.new("Spaghetti")
    r.add_ingredient("Noodles", 10)
    r.add_ingredient("Sauce", 10)
    r.add_ingredient("Cheese", 5)
    pantry.add_to_shopping_list(r)

    assert_equal pantry.shopping_list, {"Cheese" => 25, "Flour" => 20, "Noodles" => 10, "Sauce" => 10}
  end

  def test_can_print_shopping_list
    pantry = Pantry.new
    r = Recipe.new("Spaghetti Bog")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    r.add_ingredient("Spaghetti Noodles", 10)
    r.add_ingredient("Marinara Sauce", 10)
    pantry.add_to_shopping_list(r)

    assert_equal pantry.print_shopping_list, "* Cheese: 20\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10"
  end
end
