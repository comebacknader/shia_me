// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
	$(".msgs_inbox_bar").hover(
		function() {
		$(".users_msgs_bar").css("display", "block");
		$(".admin_mmsgs_bar").css("display", "block");									
	},
		function() {
		$(".users_msgs_bar").css("display", "none");
		$(".admin_mmsgs_bar").css("display", "none");			
		}
	)
});