class Question < ActiveRecord::Base
  attr_accessible :education, :hijab, :job, :prayer, :syed, :user_id, 
  				  :ethnicity, :firsthobby, :secondhobby, :thirdhobby, :islamtoyou, :race
  
  belongs_to :user

  before_save { |question| question.race = race.downcase }  
end
