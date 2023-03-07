class Garden < ApplicationRecord
  has_many :plots
  has_many :plants, through: :plots

  # def unique_plants OLD model FOR US 3- left this here for the record. new model is below
  #   require 'pry'; binding.pry
  #   self.plants.where('days_to_harvest < ?', 100).distinct
  # end

  #new method for extension- read online about using the Arel.sql to write direct SQL code in new versions of rails, still prevents against injection attacks
  def unique_plants 
    self.plants.where('days_to_harvest < ?', 100)
      .group(:id)
      .order(Arel.sql('COUNT(*) DESC'))
  end

end


