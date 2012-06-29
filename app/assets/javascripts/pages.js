// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


$(document).ready(function() {
	$(".about_image_privacy").hover(function(){
			$(".about_match").css("display", "none");
			$(".about_privacy").css("display", "block");
	},
	function() {
			$(".about_privacy").css("display", "none");
			$(".about_match").css("display", "block");
	})
	$(".about_image_join").hover(function(){
			$(".about_match").css("display", "none");
			$(".about_how_to").css("display", "block");			
	},
	function(){
			$(".about_how_to").css("display", "none");
			$(".about_match").css("display", "block");
	});		
});