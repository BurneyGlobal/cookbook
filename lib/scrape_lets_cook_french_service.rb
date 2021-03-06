
class ScrapeLetsCookFrenchService

  def initialize(keyword)
    @keyword = keyword
  end

  def call
    url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{@keyword}"
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')

    search_recipes = []

    doc.search('.m_contenu_resultat').each do |element|
      name = element.search('.m_titre_resultat a')
      description = element.search('.m_texte_resultat')

      name = name.text.strip
      description = description.text.strip

      prep_time = element.search('.m_prep_time').first.parent
      prep_time = prep_time.text.strip

      difficulty = element.search('.m_detail_recette')
      difficulty = difficulty.text.strip
      difficulty = difficulty.split('-')
      difficulty = difficulty[2].strip

      recipe = Recipe.new(name, description, prep_time, difficulty)
      search_recipes << recipe
    end

    search_recipes = search_recipes[(0..4)]

    # @view.display_search_results(search_recipes)

    # index = @view.which_index_keep.to_i

    # @cookbook.add_recipe(search_recipes[(index - 1)])

    # puts "Your recipe has been imported"

    return search_recipes
  end
end
