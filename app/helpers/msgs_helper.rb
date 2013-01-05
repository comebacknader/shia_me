module MsgsHelper


	def retrieve_newmsg
	 @user = current_user
	 @newmsg = Msg.where(:user_id => @user.id, :seen => nil).all
	end

	def admin_not_seen_msg
	 if current_admin.present? 	
	  @admin = current_admin	
	  @unseen = Msg.where(:admin_id => @admin.id, :admin_seen => nil).all
	  @unseen_admin = Mmsg.where(:receiver_id => @admin.id, :receiver_seen => nil).all
	 end
	end

end