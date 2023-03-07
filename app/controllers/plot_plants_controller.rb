class PlotPlantsController < ApplicationController

  def destroy
    PlotPlant.find_by(plot_id: params[:plot_id], plant_id: params[:plant_id]).destroy
    redirect_to '/plots'
  end
end