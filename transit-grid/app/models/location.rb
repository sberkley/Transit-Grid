class Location < ActiveRecord::Base
  has_many :routes
  has_many :landmarks, :through => :routes
end
