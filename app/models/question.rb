class Question < ActiveRecord::Base
  attr_accessible :education, :hijab, :job, :prayer, :syed, :user_id, :ethnicity
  
  belongs_to :user
  
end
