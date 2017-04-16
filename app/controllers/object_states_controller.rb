class ObjectStatesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @report = Report.new
    @object_states = ObjectState.all
  end

  def search
    @report = Report.new
    @object_states = ObjectState.where(:object_id => params[:object_id], :object_type => params[:object_type], :timestamp.lte => DateTime.strptime(params[:timestamp],'%s')).order_by(:timestamp => "desc")
    render "index"
  end
end
