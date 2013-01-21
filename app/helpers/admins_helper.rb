module AdminsHelper


	def matched_users 
	    @male_users = User.where(:admin_id => current_admin.id, :gender => "MALE")
	    @female_users = User.where(:admin_id => current_admin.id, :gender => "FEMALE")    
	    @users = []
	    @matched_users = []
	    @male_users.each do |user|
	      unless user.matches.present?
	       @users << user
	      else
	       @matched_users << user
	      end
	    end
	    @female_users.each do |user|
	      unless user.wmatches.present? 
	        @users << user
	      else
	        @matched_users << user
	      end
	    end
	end

end
