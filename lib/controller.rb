require_relative 'cookbook'
require_relative 'view'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = CookbookView.new
  end

  def list
    recipes = @cookbook.all
    @view.display(recipes)
  end

  def create
    name = @view.ask_user_for_recipe_name
    description = @view.ask_user_for_recipe_description
    recipe = Recipe.new(name, description)
    @cookbook.add_recipe(recipe)
  end

  def destroy
    index = @view.ask_user_for_index
    @cookbook.remove_recipe(index - 1)
  end
end