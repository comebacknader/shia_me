// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


$(document).ready(function() {
	$(".topbar_signout_button").hover(
		function() {
		$(".signout_menu").css("display", "block");		
	},
		function() {
		$(".signout_menu").css("display", "none");
		}
	)
	$(".topbar_edit_button").hover(
		function() {
		$(".user_edit_menu").css("display", "block");		
	},
		function() {
		$(".user_edit_menu").css("display", "none");
		}
	)	
	$(".user_home_button").hover(
		function() {
		$(".user_home_menu").css("display", "block");		
	},
		function() {
		$(".user_home_menu").css("display", "none");
		}
	)	
});