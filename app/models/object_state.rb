class ObjectState
  include Mongoid::Document	
  require 'csv'
  #Add uniqinuess constraint on combination of object_id, object_type & timestamp
  field :object_id, type: Integer
  field :object_type, type: String
  field :object_changes, type: String
  field :timestamp, type: DateTime  

  validates :object_id,:object_type, :timestamp, :object_changes, presence: true

  attr_accessible :object_id,:object_type, :timestamp, :object_changes

  def self.import(file_path)
    CSV.parse(File.read(file_path).gsub(/\\"/,'""'), :headers => true).each do |row|

      previous_object_state = ObjectState.where(object_id: row["object_id"], object_type: row["object_type"]).order_by(:timestamp => 'desc').first

      row["object_changes"] = JSON.parse(previous_object_state.object_changes).merge(JSON.parse(row["object_changes"])) if previous_object_state
      
      current_object_state = ObjectState.create(object_id: row["object_id"], object_type: row["object_type"], timestamp: DateTime.strptime(row["timestamp"],'%s'), object_changes: row["object_changes"])
    end
  end
end
