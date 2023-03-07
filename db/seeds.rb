# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@g1 = Garden.create!(name: "Nursery", organic: true)
@g2 = Garden.create!(name: "Spirit", organic: false)

@plot1 = @g1.plots.create!(number: 23, size: "Large", direction: "West")
@plot2 = @g1.plots.create!(number: 45, size: "Small", direction: "North")
@plot3 = @g2.plots.create!(number: 85, size: "Medium", direction: "Northeast")

@plant1 = Plant.create!(name: "Sunflower", description: "yellow", days_to_harvest: 80)
@plant2 = Plant.create!(name: "Peach", description: "orange", days_to_harvest: 120)
@plant3 = Plant.create!(name: "Rose", description: "red", days_to_harvest: 90)
@plant4 = Plant.create!(name: "Blueberry", description: "blue", days_to_harvest: 100)

@PlotPlant1 = PlotPlant.create!(plant_id: @plant1.id, plot_id: @plot1.id)
@PlotPlant2 = PlotPlant.create!(plant_id: @plant2.id, plot_id: @plot1.id)
@PlotPlant3 = PlotPlant.create!(plant_id: @plant4.id, plot_id: @plot2.id)
@PlotPlant4 = PlotPlant.create!(plant_id: @plant1.id, plot_id: @plot2.id)
