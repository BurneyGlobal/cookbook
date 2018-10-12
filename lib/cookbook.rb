require 'csv'
require_relative 'recipe'

class Cookbook
  attr_reader :recipes, :description
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []

    CSV.foreach(@csv_file_path) do |row|
      @recipes << Recipe.new(row[0], row[1])
    end
  end

  def all
    return @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe

    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |element|
        csv << [element.name, element.description]
      end
    end
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)

    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description]
      end
    end
  end
end



