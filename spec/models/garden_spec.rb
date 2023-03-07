require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it {should have_many(:plants).through(:plots)}

  end

  describe "instance methods" do 
    it "returns a unique plants that take less than 100 days to harvest" do #test for US 3 without sorting

      @g1 = Garden.create!(name: "Nursery", organic: true)
      @g2 = Garden.create!(name: "Spirit", organic: false)
     
      @plot3 = @g2.plots.create!(number: 85, size: "Medium", direction: "Northeast")
      @plot1 = @g1.plots.create!(number: 23, size: "Large", direction: "West")
      @plot2 = @g1.plots.create!(number: 45, size: "Small", direction: "North")

      @plant2 = Plant.create!(name: "Peach", description: "orange", days_to_harvest: 60)
      @plant3 = Plant.create!(name: "Rose", description: "red", days_to_harvest: 90)
      @plant4 = Plant.create!(name: "Blueberry", description: "blue", days_to_harvest: 100)
      @plant5 = Plant.create!(name: "Greenberry", description: "green", days_to_harvest: 150)
      @plant1 = Plant.create!(name: "Sunflower", description: "yellow", days_to_harvest: 80)
   
      @PlotPlant2 = PlotPlant.create!(plant_id: @plant2.id, plot_id: @plot1.id)
      @PlotPlant3 = PlotPlant.create!(plant_id: @plant4.id, plot_id: @plot2.id)
      @PlotPlant4 = PlotPlant.create!(plant_id: @plant1.id, plot_id: @plot2.id)
      @PlotPlant5 = PlotPlant.create!(plant_id: @plant5.id, plot_id: @plot2.id)
      @PlotPlant1 = PlotPlant.create!(plant_id: @plant1.id, plot_id: @plot1.id)

      expect(@g1.unique_plants).to eq([@plant1, @plant2])
    end

    it "orders those plants by the number of times they appear in the garden's plots" do #test for extension when sorted makes a difference. I did it within the same method in the garden.rb and commented out the old one-- did this to show my work. 
      @g3 = Garden.create!(name: "Spirit", organic: false)

      @plot4 = @g3.plots.create!(number: 1, size: "Large", direction: "East")
      @plot5 = @g3.plots.create!(number: 2, size: "Small", direction: "South")

      @plant6 = Plant.create!(name: "Apple", description: "blue", days_to_harvest: 12)
      @plant7 = Plant.create!(name: "Pear", description: "green", days_to_harvest: 15)

      @PlotPlant6 = PlotPlant.create!(plant_id: @plant7.id, plot_id: @plot5.id)
      @PlotPlant7 = PlotPlant.create!(plant_id: @plant6.id, plot_id: @plot4.id)
      @PlotPlant8 = PlotPlant.create!(plant_id: @plant7.id, plot_id: @plot4.id)

      expect(@g3.unique_plants).to eq([@plant7, @plant6])
    end



  end
end
