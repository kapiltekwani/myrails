class ReportsController < ApplicationController
  def create
    @report = Report.new(params[:report])
    if @report.save
      redirect_to object_states_path
    else
    
    end
  end
  
  def index 
  end
end
