class ObjectStatesController < ApplicationController
  def index
    @object_states = ObjectState.all
  end

end
