class ObjectStatesController < ApplicationController
  before_filter :authenticate_user!
  def index
    @object_states = ObjectState.all
  end
end
