class Landmark < ActiveRecord::Base
  has_many :routes
  has_many :locations, :through => :routes
end
