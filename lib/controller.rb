require_relative 'cookbook'
require_relative 'view'
require_relative 'scrape_lets_cook_french_service'
require 'nokogiri'
require 'pry-byebug'
require 'open-uri'

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
    list
    index = @view.ask_user_for_index
    @cookbook.remove_recipe(index - 1)
  end

  def import_recipe
    keyword = @view.ask_user_for_keyword

    scraping = ScrapeLetsCookFrenchService.new(keyword)

    search_recipes = scraping.call

    @view.display_search_results(search_recipes)

    index = @view.which_index_keep.to_i

    @cookbook.add_recipe(search_recipes[(index - 1)])

    puts "Your recipe has been imported"
  end

  def mark_as_done
    list

    index = @view.ask_user_for_index

    recipe = @cookbook.find(index)

    recipe.mark_as_done

    @cookbook.save
  end
end
