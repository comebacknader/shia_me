module MsgsHelper


	def retrieve_newmsg
	 @newmsg = Msg.where(:seen => nil).all
	end


end