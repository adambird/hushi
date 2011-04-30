class Pokemon < ActiveRecord::Base
  validates_presence_of :name, :hit_points
  
end
