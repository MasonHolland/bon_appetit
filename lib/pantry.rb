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
    if cook
  end

end
