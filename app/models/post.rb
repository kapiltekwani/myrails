class Post
  include Mongoid::Document
  field :views, type: Integer
  field :content, type: String
  field :author, type: String
end
