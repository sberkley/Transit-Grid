class Route < ActiveRecord::Base
  belongs_to :landmark
  belongs_to :location
  
 
  def duration
    if @duration.nil?
      @duration = calculate_duration(@landmark_id, @location_id)
    end
    @duration
  end
  
  def calculate_duration landmark_id, location_id
    99
  end
end
