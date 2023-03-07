class Garden < ApplicationRecord
  has_many :plots
  has_many :plants, through: :plots

  # def unique_plants OLD TEST FOR US 3- left this here for the record
  #   require 'pry'; binding.pry
  #   self.plants.where('days_to_harvest < ?', 100).distinct
  # end

  def unique_plants #new method for extension- read online about using the Arel.sql to write direct SQL code.
    self.plants.where('days_to_harvest < ?', 100)
      .group(:id)
      .order(Arel.sql('COUNT(*) DESC'))
  end

end


