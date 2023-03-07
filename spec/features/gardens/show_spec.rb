require 'rails_helper'

RSpec.describe 'Gardens Show feature spec' do
before(:each) do 
 @g1 = Garden.create!(name: "Nursery", organic: true)
 @g2 = Garden.create!(name: "Spirit", organic: false)

 @plot1 = @g1.plots.create!(number: 23, size: "Large", direction: "West")
 @plot2 = @g1.plots.create!(number: 45, size: "Small", direction: "North")
 @plot3 = @g2.plots.create!(number: 85, size: "Medium", direction: "Northeast")

 @plant1 = Plant.create!(name: "Sunflower", description: "yellow", days_to_harvest: 80)
 @plant2 = Plant.create!(name: "Peach", description: "orange", days_to_harvest: 60)
 @plant3 = Plant.create!(name: "Rose", description: "red", days_to_harvest: 90)
 @plant4 = Plant.create!(name: "Blueberry", description: "blue", days_to_harvest: 100)
 @plant5 = Plant.create!(name: "Greenberry", description: "green", days_to_harvest: 150)


 @PlotPlant1 = PlotPlant.create!(plant_id: @plant1.id, plot_id: @plot1.id)
 @PlotPlant2 = PlotPlant.create!(plant_id: @plant2.id, plot_id: @plot1.id)
 @PlotPlant3 = PlotPlant.create!(plant_id: @plant4.id, plot_id: @plot2.id)
 @PlotPlant4 = PlotPlant.create!(plant_id: @plant1.id, plot_id: @plot2.id)
 @PlotPlant5 = PlotPlant.create!(plant_id: @plant5.id, plot_id: @plot2.id)


 
end 

 describe "as a visitor" do
  describe "visit gardens show page" do
     it "shows a list of all unique plants included in the garden's plots that take less than 100 days to harvest" do 
      visit "/gardens/#{@g1.id}"
      
      expect(page).to have_selector('p', text: @plant1.name, count: 1)
      expect(page).to_not have_content(@plant3.name)
      expect(page).to_not have_content(@plant4.name)
      expect(page).to_not have_content(@plant5.name)
      expect(page).to have_selector('p', text: @plant2.name, count: 1)

     end

     it "the list of plants is sorted by the number of times that the plant appears in any of the garden's plants" do 
      
      @g3 = Garden.create!(name: "Spirit", organic: false)

      @plot4 = @g3.plots.create!(number: 1, size: "Large", direction: "East")
      @plot5 = @g3.plots.create!(number: 2, size: "Small", direction: "South")

      @plant6 = Plant.create!(name: "Apple", description: "blue", days_to_harvest: 12)
      @plant7 = Plant.create!(name: "Pear", description: "green", days_to_harvest: 15)

      @PlotPlant6 = PlotPlant.create!(plant_id: @plant7.id, plot_id: @plot5.id)
      @PlotPlant7 = PlotPlant.create!(plant_id: @plant6.id, plot_id: @plot4.id)
      @PlotPlant8 = PlotPlant.create!(plant_id: @plant7.id, plot_id: @plot4.id)

      visit "/gardens/#{@g3.id}"

      expect(@plant7.name).to appear_before(@plant6.name)

     end
    end 
  end 
end 