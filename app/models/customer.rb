class Customer
  include Mongoid::Document
  #include Tire::Model::Search
  #include Tire::Model::Callbacks
  
  field :name, type: String
  field :email, type: String
  mount_uploader :csv_file, CsvUploader 
  
  has_many :orders

  def self.search(params) 
    tire.search do
      query { string params[:query] } if params[:query].present? 
    end
  end
end
