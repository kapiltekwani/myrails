class Report
  include Mongoid::Document

  mount_uploader :file, FileUploader

  after_save :process_file

  def process_file
  end 
 
 def self.import(file_path)
    CSV.parse(File.read(file_path).gsub(/\\"/,'""'), :headers => true).each do |row|

      previous_object_state = ObjectState.where(object_id: row["object_id"], object_type: row["object_type"]).order_by(:timestamp => 'desc').first

      row["object_changes"] = (JSON.parse(previous_object_state.object_changes).merge(JSON.parse(row["object_changes"]))).to_json if previous_object_state
      
      current_object_state = ObjectState.create(object_id: row["object_id"], object_type: row["object_type"], timestamp: DateTime.strptime(row["timestamp"],'%s'), object_changes: row["object_changes"])
    end
  end 
end
