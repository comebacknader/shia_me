// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
	$(".admin_menu").hover(
		function() {
		$(".admin_all_men_drop").css("display", "block");
		$(".admin_all_women_drop").css("display", "block");
		$(".admin_all_matches_drop").css("display", "block");
		$(".admin_delete_users_drop").css("display", "block");
		$(".admin_code_drop").css("display", "block");										
	},
		function() {
		$(".admin_all_men_drop").css("display", "none");
		$(".admin_all_women_drop").css("display", "none");
		$(".admin_all_matches_drop").css("display", "none");
		$(".admin_delete_users_drop").css("display", "none");
		$(".admin_code_drop").css("display", "none");				
		}
	)
});