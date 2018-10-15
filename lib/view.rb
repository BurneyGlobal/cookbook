require_relative 'cookbook'
require_relative 'cookbook'
require_relative 'controller'
require_relative 'router'

class CookbookView
  def display(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1}. #{recipe.name}\nDescription: #{recipe.description}"
    end
  end

  def ask_user_for_recipe_name
    puts "What recipe name would you like to add?"
    return gets.chomp
  end

  def ask_user_for_recipe_description
    puts "Please enter a recipe description"
    return gets.chomp
  end

  def ask_user_for_index
    puts "Please enter a recipe index you would like to delete"
    return gets.chomp.to_i
  end

  def ask_user_for_keyword
    puts "Please choose a ingredient you'd like to search"
    gets.chomp
  end

  def display_search_results(search_recipes)
    search_recipes.each_with_index do |recipe, index|
      puts "#{index + 1}. #{recipe.name}\n"
    end
  end

  def which_index_keep
    puts "Select recipe to import"
    gets.chomp
  end

end
