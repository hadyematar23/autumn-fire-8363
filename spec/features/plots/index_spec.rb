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

 @PlotPlant1 = PlotPlant.create!(plant_id: @plant1.id, plot_id: @plot1.id)
 @PlotPlant2 = PlotPlant.create!(plant_id: @plant2.id, plot_id: @plot1.id)
 @PlotPlant3 = PlotPlant.create!(plant_id: @plant4.id, plot_id: @plot2.id)

 
end 

 describe "as a visitor" do
  describe "visit plots index page" do 
    it "See a list of all plot numbers and under it see names of all the plots plants" do
    visit "/plots"
      
  
    within("div#plot_#{@plot1.id}") do
      expect(page).to have_content(@plot1.number)
      expect(page).to have_content(@plant1.name)
      expect(page).to have_content(@plant2.name)
      expect("23").to appear_before(@plant2.name)
      expect("23").to appear_before(@plant1.name)
      expect(page).to_not have_content(@plant3.name)
      expect(page).to_not have_content(@plant4.name)

    end 

    within("div#plot_#{@plot2.id}") do
      expect(page).to have_content(@plot2.number)
      expect(page).to have_content(@plant4.name)
      expect("45").to appear_before(@plant4.name)
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

    it "next to each plant's name I see a link to remove that plant from the plot" do 
      @PlotPlant4 = PlotPlant.create!(plant_id: @plant1.id, plot_id: @plot2.id)


      visit "/plots"

      within("div#plot_#{@plot2.id}") do
        expect(page).to have_content(@plant1.name)
      end

      within("div#plot_#{@plot1.id}_plant_#{@plant1.id}") do 
        expect(page).to have_link("Remove #{@plant1.name} from #{@plot1.number}", href: "/plots/#{@plot1.id}/plants/#{@plant1.id}" )
      end

      within("div#plot_#{@plot1.id}_plant_#{@plant2.id}") do 
        expect(page).to have_link("Remove #{@plant2.name} from #{@plot1.number}", href: "/plots/#{@plot1.id}/plants/#{@plant2.id}" )
      end

      within("div#plot_#{@plot2.id}_plant_#{@plant4.id}") do 
        expect(page).to have_link("Remove #{@plant4.name} from #{@plot2.number}", href: "/plots/#{@plot2.id}/plants/#{@plant4.id}" )
      end

      click_link("Remove #{@plant1.name} from #{@plot1.number}")

      expect(current_path).to eq("/plots")

      within("div#plot_#{@plot2.id}") do
        expect(page).to have_content(@plant1.name)
      end

      within("div#plot_#{@plot1.id}") do
        expect(page).to_not have_content(@plant1.name)
      end

    end






end 
end 
end 