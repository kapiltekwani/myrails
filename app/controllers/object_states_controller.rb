class ObjectStatesController < ApplicationController
  before_filter :authenticate_user!
  def index
    @report = Report.new
    @object_states = ObjectState.all
  end
end
