class Question < ActiveRecord::Base
  attr_accessible :education, :hijab, :job, :prayer, :syed, :user_id, 
  				  :ethnicity, :firsthobby, :secondhobby, :thirdhobby, :islamtoyou
  
  belongs_to :user
  
end