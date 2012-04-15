class Route < ActiveRecord::Base
  include BingApi

  belongs_to :landmark
  belongs_to :location
  
  validates :landmark_id, :location_id, :presence => true
 
  #def after_create
    #if @duration.nil? #and !@landmark_id.nil? and !@location_id.nil?
  #    @duration = 7# calculate_duration(@landmark_id, @location_id)
    #end
    #@duration
  #end
  
  def before_validation
    @duration = 1
  end

  def after_validation
    @duration = 2
  end
  
  def before_save
    @duration = 3
  end

  def before_create
    @duration = 4
  end
  
  def after_create
    @duration = 5
  end
  
  def after_save
    @duration = 6
  end
  
  def after_commit
    @duration = 7
  end
  
  def calculate_duration landmark_id, location_id
    landmark = Landmark.find_by_id! landmark_id
    location = Location.find_by_id! location_id
    new_york = ", New York, NY"
    default_time = "11:11:00AM"
    landmark_address = landmark.address + new_york
    location_address = location.address + new_york
    
    calculateTrip(location_address, landmark_address, default_time)
  end
end
