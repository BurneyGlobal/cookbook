class Recipe
  attr_reader :name, :description, :prep_time, :difficulty

  def initialize(name, description, prep_time = "Dono brow", difficulty)
    @name = name
    @description = description
    @prep_time = prep_time
    @difficulty = difficulty
    @done = false
  end

  def done?
    @done
  end

  def mark_as_done
    @done = true
  end

end


