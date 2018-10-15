require_relative 'cookbook'
require_relative 'view'
require 'nokogiri'
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
    index = @view.ask_user_for_index
    @cookbook.remove_recipe(index - 1)
  end

  def import_recipe
    keyword = @view.ask_user_for_keyword
    url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{keyword}"
    doc = Nokogiri::HTML(open(url), nil, 'm_contenu_resultat')

    search_recipes = []

    doc.search('.m_contenu_resultat').each do |element|
      name = element.search('.m_titre_resultat a')
      description = element.search('.m_texte_resultat')
      name = name.text.strip
      description = description.text.strip
      recipe = Recipe.new(name, description)
      search_recipes << recipe
    end

    search_recipes = search_recipes[(0..4)]

    @view.display_search_results(search_recipes)

    index = @view.which_index_keep.to_i

    @cookbook.add_recipe(search_recipes[(index - 1)])

    puts "Your recipe has been imported"
  end
end
