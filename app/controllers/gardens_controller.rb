class GardensController < ApplicationController

  def show
    @garden = Garden.find(params[:id])
    @unique = @garden.unique_plants
  end

end