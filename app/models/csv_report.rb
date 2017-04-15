class CsvReport < ActiveRecord::Base
  include Mongoid::Document

  field :file, type: string 	  
  
end
