class User < ActiveRecord::Base
  attr_accessible :bio, :location, :name
end
