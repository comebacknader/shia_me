module MsgsHelper


	def retrieve_newmsg
	 @user = current_user
	 @newmsg = Msg.where(:user_id => @user.id, :seen => nil).all
	end


end