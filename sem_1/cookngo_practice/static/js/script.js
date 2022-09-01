$('section.awSlider .carousel').carousel({
	pause: "hover",
  interval: 4000
});

$('section.awSlider .carousel').on('slid.bs.carousel', function () {
	var bscn = $(this).find('.item.active > img').attr('src');
	$('section.awSlider > img').attr('src',bscn);
});


$(".s1 a").on('click', function () {
	$(".s1 ul").slideToggle('medium');
});

$(".s0 a").on('click', function () {
	$(".s0 ul").slideToggle('medium');
	$(".s0 a").toggleClass("white-bg");
});

$(".s2 a").on('click', function () {
	$(".s2 ul").slideToggle('medium');
	$(".s2 a").toggleClass("white-bg");
});

$(".2n ul").hide();

$(".1n").hover(function () {
	$(".1n ul").slideToggle('medium');
}, function () {
	$(".1n ul").slideToggle("medium", function () {
		$(".1n ul").hide();
	});
});

$(".2n").hover(function () {
	$(".2n ul").slideToggle('medium');
}, function () {
	$(".2n ul").slideToggle("medium", function () {
		$(".2n ul").hide();
	});
});

$(".3n").hover(function () {
	$(".3n ul").slideToggle('medium');
}, function () {
	$(".3n ul").slideToggle("medium", function () {
		$(".3n ul").hide();
	});
});

//
// $(".recipe_block").hover(function () {
// 	$(".recipe_block p").addClass("active1");
// 	$(".active1").slideToggle('medium');
// });

document.addEventListener("DOMContentLoaded", function() {
	//The first argument are the elements to which the plugin shall be initialized
	//The second argument has to be at least a empty object or a object with your desired options
	OverlayScrollbars(document.querySelectorAll("body"), { });
});
