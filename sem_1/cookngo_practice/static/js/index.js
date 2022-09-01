$('section.awSlider .carousel').carousel({
	pause: "hover",
  interval: 1000
});

$('section.awSlider .carousel').on('slid.bs.carousel', function () {
 var bscn = $(this).find('.item.active > img').attr('src');
	$('section.awSlider > img').attr('src',bscn);
});


/* 
Philips ambilight tv
Üzerine gleince duruyor slide
*/