class Pantry
  attr_reader :stock, :shopping_list, :cookbook

  def initialize
    @stock = {}
    @shopping_list = {}
    @cookbook = {}
  end

  def stock_check(item)
    if stock.has_key?(item)
      stock[item]
    else
      0
    end
  end

  def restock(item, quantity)
    if stock.has_key?(item)
      @stock[item] += quantity
    else
      @stock.store(item, quantity)
    end
  end

  def add_to_shopping_list(recipe)
    @shopping_list.merge!(recipe.ingredients) { |k, v1, v2| v1 + v2 }
  end

  def print_shopping_list
     shopping_list.each do |key, value|
      print "* #{key}: #{value}"
    end
  end

  def add_to_cookbook(recipe)
    @cookbook.store(recipe.name, recipe.ingredients)
  end

  def what_can_i_make
      #work in progress, still trying to figure out implementation before refactoring.
      #method works but have had to hardcode recipes.
      #would build up previous methods to add new recipes
      @can_make = []
    if stock_check("Cheese") >= 20 && stock_check("Flour")
      @can_make << "Cheese Pizza"
    elsif stock_check("Brine") >= 10 && stock_check("Cucumbers") >=30
      @can_make << "Pickles"
    elsif stock_check("Raw nuts") >= 10 && stock_check("Salt") >=10
      @can_make << "Peanuts"
    end
    @can_make
  end

  def how_many_can_i_make
    if what_can_i_make != []
      recipe_1 = @can_make[0]
       cookbook[recipe_1].each { |k, v| v % 10}
    end
  end

end
