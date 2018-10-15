require 'csv'
require_relative 'recipe'

class Cookbook
  attr_reader :recipes, :description

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []

    CSV.foreach(@csv_file_path) do |row|
      boolean = row[4].to_s == "true"
      @recipes << Recipe.new(row[0], row[1], row[2], row[3], boolean)
    end
  end

  def all
    return @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe

    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |element|
        csv << [element.name, element.description, element.prep_time, element.difficulty, element.done]
      end
    end
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)

    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.difficulty, recipe.done]
      end
    end
  end

  def find(index)
    @recipes[index - 1]
  end

  def save
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.difficulty, recipe.done]
      end
    end
  end
end



