require 'rails_helper'

RSpec.describe 'Plots Index feature spec' do
before(:each) do 
 @g1 = Garden.create!(name: "Nursery", organic: true)
 @g2 = Garden.create!(name: "Spirit", organic: false)

 @plot1 = @g1.plots.create!(number: 23, size: "Large", direction: "West")
 @plot2 = @g1.plots.create!(number: 45, size: "Small", direction: "North")
 @plot3 = @g2.plots.create!(number: 85, size: "Medium", direction: "Northeast")

 @plant1 = Plant.create!(name: "Sunflower", description: "yellow", days_to_harvest: 80)
 @plant2 = Plant.create!(name: "Peach", description: "orange", days_to_harvest: 120)
 @plant3 = Plant.create!(name: "Rose", description: "red", days_to_harvest: 90)
 @plant4 = Plant.create!(name: "Blueberry", description: "blue", days_to_harvest: 100)

 @plantplot1 = PlotPlant.create!(plant_id: @plant1.id, plot_id: @plot1.id)
 @plantplot1 = PlotPlant.create!(plant_id: @plant2.id, plot_id: @plot1.id)
 @plantplot1 = PlotPlant.create!(plant_id: @plant4.id, plot_id: @plot2.id)

 
end 

 describe "as a visitor" do
  describe "visit plots index page" do 
    it "See a list of all plot numbers" do
    visit "/plots"

    within("div#plot_#{@plot1.id}") do
      expect(page).to have_content(@plot1.number)
      expect(page).to have_content(@plant1.name)
      expect(page).to have_content(@plant2.name)
      expect(page).to_not have_content(@plant3.name)
      expect(page).to_not have_content(@plant4.name)

    end 

    within("div#plot_#{@plot2.id}") do
      expect(page).to have_content(@plot2.number)
      expect(page).to have_content(@plant4.name)
      expect(page).to_not have_content(@plant1.name)
      expect(page).to_not have_content(@plant2.name)
      expect(page).to_not have_content(@plant3.name)


    end 

    within("div#plot_#{@plot3.id}") do
      expect(page).to have_content(@plot3.number)
      expect(page).to_not have_content(@plant1.name)
      expect(page).to_not have_content(@plant2.name)
      expect(page).to_not have_content(@plant3.name)
      expect(page).to_not have_content(@plant3.name)

    end 

  end 
end 
end 
end 