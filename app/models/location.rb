class Location
  include Mongoid::Document
  field :location,:type => string
  field :tag ,:type => string
end
