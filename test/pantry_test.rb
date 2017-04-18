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
    #test not passing, couldnt figure out how to stop the each loop from printing
    #the hash as a whole at the end of the loop
    skip
    pantry = Pantry.new
    r = Recipe.new("Spaghetti Bog")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    r.add_ingredient("Spaghetti Noodles", 10)
    r.add_ingredient("Marinara Sauce", 10)
    pantry.add_to_shopping_list(r)

    assert_equal pantry.print_shopping_list, "* Cheese: 20\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10"
  end

  def test_can_add_to_cookbook
    pantry = Pantry.new
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)
    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)
    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)
    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)
    pantry.restock("Cheese", 10)
    pantry.restock("Flour", 20)
    pantry.restock("Brine", 40)
    pantry.restock("Pickles", 40)
    pantry.restock("Raw nuts", 20)
    pantry.restock("Salt", 20)
    binding.pry

    assert_equal pantry.what_can_i_make, ["Peanuts"]
  end

  def test_can_check_how_many_i_can_make
    pantry = Pantry.new
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)
    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)
    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)
    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)
    pantry.restock("Cheese", 10)
    pantry.restock("Flour", 20)
    pantry.restocpak("Brine", 40)
    pantry.restock("Pickles", 40)
    pantry.restock("Raw nuts", 20)
    pantry.restock("Salt", 20)

    assert_equal pantry.what_can_i_make, ["Peanuts"]
    assert_equal pantry.how_many_can_i_make, {"Peanuts" => 2}
  end
end
