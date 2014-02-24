class Venue
  include Mongoid::Document
  belongs_to :user
  field :user_id
  field :name,:type => String
  field :description,:type => String
  field :location,:type => String
  field :location_type,:type => String
  field :latitude,:type => String
  field :longitude,:type => String
  validates :name,:location,:presence => true
end
