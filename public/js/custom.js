document.addEventListener('DOMContentLoaded', function () {
	const imageFieldsList = document.getElementById('image-fields-list');
	const addImageButton = document.getElementById('add-image');

	// Ajouter un champ d'image
	addImageButton.addEventListener('click', function () {
		const prototype = imageFieldsList.dataset.prototype;
		const index = imageFieldsList.children.length;
		const newForm = prototype.replace(/__name__/g, index);
		imageFieldsList.insertAdjacentHTML('beforeend', newForm);
	});

	// Supprimer un champ d'image
	document.addEventListener('click', function (e) {
		if (e.target.classList.contains('delete-image')) {
			const imageField = e.target.closest('.container');
			imageField.remove();
		}
	});
});
// Add + delete video
document.addEventListener('DOMContentLoaded', function () {

	const videoFieldsList = document.getElementById('video-fields-list');
	const addVideoButton = document.getElementById('add-video');
	const newVideoIndex = videoFieldsList.children.length;

	addVideoButton.addEventListener('click', function () {
		const prototype = videoFieldsList.dataset.prototype;
		const newForm = prototype.replace(/__name__/g, newVideoIndex);
		videoFieldsList.insertAdjacentHTML('beforeend', newForm);
		videoFieldsList.children[newVideoIndex].querySelector('.delete-video').addEventListener('click', function () {
			this.closest('li').remove();
		});
	});

	document.querySelectorAll('.delete-video').forEach(button => {
		button.addEventListener('click', function () {
			this.closest('div').remove();
		});
	});
});

document.addEventListener('DOMContentLoaded', function () {
	const profilePicture = document.getElementById('profilePicture');
	const deleteProfilePictureButton = document.getElementById('deleteProfilePicture');

	// Delete Profile Picture
	deleteProfilePictureButton.addEventListener('click', function () {
		if (confirm('Are you sure you want to delete your profile picture?')) {
			// Send an AJAX request to delete the profile picture
			// You can use fetch or another AJAX method to send the request
			fetch(delete_profile_picture, {
				method: 'POST', // Use the appropriate HTTP method
			})
		.then(response => {
				if (response.ok) {
					// Profile picture deleted successfully
					profilePicture.style.display = 'none'; // Hide the profile picture
					alert('Profile picture deleted successfully.');
				} else {
					// Handle errors here
					alert('An error occurred while deleting the profile picture.');
				}
			})
				.catch(error => {
					// Handle network or other errors
					console.error(error);
				});
		}
	});
});


$(document).ready(function(){
	$('.filter-btn').click(function(){
		var category = $(this).data('category');
		if(category === 'all') {
			$('.figure-item').show();
			$('#no-figures-message').hide(); // Cache le message si le filtre est réinitialisé
		} else {
			$('.figure-item').hide();
			var filteredItems = $('.figure-item[data-category="' + category + '"]');
			if(filteredItems.length > 0) {
				filteredItems.show();
				$('#no-figures-message').hide(); // Cache le message s'il y a des éléments à afficher
			} else {
				$('#no-figures-message').show(); // Affiche le message s'il n'y a pas d'éléments à afficher
			}
		}
	});
});



(function ($) {

	"use strict";

	// Page loading animation
	$(window).on('load', function() {

		$('#js-preloader').addClass('loaded');

	});

	// WOW JS
	$(window).on ('load', function (){
		if ($(".wow").length) {
			var wow = new WOW ({
				boxClass:     'wow',      // Animated element css class (default is wow)
				animateClass: 'animated', // Animation css class (default is animated)
				offset:       20,         // Distance to the element when triggering the animation (default is 0)
				mobile:       true,       // Trigger animations on mobile devices (default is true)
				live:         true,       // Act on asynchronously loaded content (default is true)
			});
			wow.init();
		}
	});

	$(window).scroll(function() {
		var scroll = $(window).scrollTop();
		var box = $('.header-text').height();
		var header = $('header').height();

		if (scroll >= box - header) {
			$("header").addClass("background-header");
		} else {
			$("header").removeClass("background-header");
		}
	});

	$('.filters ul li').click(function(){
		$('.filters ul li').removeClass('active');
		$(this).addClass('active');

		var data = $(this).attr('data-filter');
		$grid.isotope({
			filter: data
		})
	});

	var $grid = $(".grid").isotope({
		itemSelector: ".all",
		percentPosition: true,
		masonry: {
			columnWidth: ".all"
		}
	})

	var width = $(window).width();
	$(window).resize(function() {
		if (width > 992 && $(window).width() < 992) {
			location.reload();
		}
		else if (width < 992 && $(window).width() > 992) {
			location.reload();
		}
	})



	$(document).on("click", ".naccs .menu div", function() {
		var numberIndex = $(this).index();

		if (!$(this).is("active")) {
			$(".naccs .menu div").removeClass("active");
			$(".naccs ul li").removeClass("active");

			$(this).addClass("active");
			$(".naccs ul").find("li:eq(" + numberIndex + ")").addClass("active");

			var listItemHeight = $(".naccs ul")
				.find("li:eq(" + numberIndex + ")")
				.innerHeight();
			$(".naccs ul").height(listItemHeight + "px");
		}
	});

	$('.owl-features').owlCarousel({
		items:3,
		loop:true,
		dots: false,
		nav: true,
		autoplay: true,
		margin:30,
		responsive:{
			0:{
				items:1
			},
			600:{
				items:2
			},
			1200:{
				items:3
			},
			1800:{
				items:3
			}
		}
	})

	$('.owl-collection').owlCarousel({
		items:3,
		loop:true,
		dots: false,
		nav: true,
		autoplay: true,
		margin:30,
		responsive:{
			0:{
				items:1
			},
			800:{
				items:2
			},
			1000:{
				items:3
			}
		}
	})

	$('.owl-banner').owlCarousel({
		items:1,
		loop:true,
		dots: false,
		nav: true,
		autoplay: true,
		margin:30,
		responsive:{
			0:{
				items:1
			},
			600:{
				items:1
			},
			1000:{
				items:1
			}
		}
	})

	// Menu Dropdown Toggle
	if($('.menu-trigger').length){
		$(".menu-trigger").on('click', function() {
			$(this).toggleClass('active');
			$('.header-area .nav').slideToggle(200);
		});
	}


	// Menu elevator animation
	$('.scroll-to-section a[href*=\\#]:not([href=\\#])').on('click', function() {
		if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
			var target = $(this.hash);
			target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
			if (target.length) {
				var width = $(window).width();
				if(width < 991) {
					$('.menu-trigger').removeClass('active');
					$('.header-area .nav').slideUp(200);
				}
				$('html,body').animate({
					scrollTop: (target.offset().top) - 80
				}, 700);
				return false;
			}
		}
	});

	$(document).ready(function () {
		$(document).on("scroll", onScroll);

		//smoothscroll
		$('.scroll-to-section a[href^="#"]').on('click', function (e) {
			e.preventDefault();
			$(document).off("scroll");

			$('.scroll-to-section a').each(function () {
				$(this).removeClass('active');
			})
			$(this).addClass('active');

			var target = this.hash,
				menu = target;
			var target = $(this.hash);
			$('html, body').stop().animate({
				scrollTop: (target.offset().top) - 79
			}, 500, 'swing', function () {
				window.location.hash = target;
				$(document).on("scroll", onScroll);
			});
		});
	});

	function onScroll(event){
		var scrollPos = $(document).scrollTop();
		$('.nav a').each(function () {
			var currLink = $(this);
			var refElement = $(currLink.attr("href"));
			if (refElement.position().top <= scrollPos && refElement.position().top + refElement.height() > scrollPos) {
				$('.nav ul li a').removeClass("active");
				currLink.addClass("active");
			}
			else{
				currLink.removeClass("active");
			}
		});
	}


	// Page loading animation
	$(window).on('load', function() {
		if($('.cover').length){
			$('.cover').parallax({
				imageSrc: $('.cover').data('image'),
				zIndex: '1'
			});
		}

		$("#preloader").animate({
			'opacity': '0'
		}, 600, function(){
			setTimeout(function(){
				$("#preloader").css("visibility", "hidden").fadeOut();
			}, 300);
		});
	});

	const dropdownOpener = $('.main-nav ul.nav .has-sub > a');

	// Open/Close Submenus
	if (dropdownOpener.length) {
		dropdownOpener.each(function () {
			var _this = $(this);

			_this.on('tap click', function (e) {
				var thisItemParent = _this.parent('li'),
					thisItemParentSiblingsWithDrop = thisItemParent.siblings('.has-sub');

				if (thisItemParent.hasClass('has-sub')) {
					var submenu = thisItemParent.find('> ul.sub-menu');

					if (submenu.is(':visible')) {
						submenu.slideUp(450, 'easeInOutQuad');
						thisItemParent.removeClass('is-open-sub');
					} else {
						thisItemParent.addClass('is-open-sub');

						if (thisItemParentSiblingsWithDrop.length === 0) {
							thisItemParent.find('.sub-menu').slideUp(400, 'easeInOutQuad', function () {
								submenu.slideDown(250, 'easeInOutQuad');
							});
						} else {
							thisItemParent.siblings().removeClass('is-open-sub').find('.sub-menu').slideUp(250, 'easeInOutQuad', function () {
								submenu.slideDown(250, 'easeInOutQuad');
							});
						}
					}
				}

				e.preventDefault();
			});
		});
	}
})(window.jQuery);
let items = document.querySelectorAll('.carousel .carousel-item')

items.forEach((el) => {
	const minPerSlide = 4
	let next = el.nextElementSibling
	for (var i=1; i<minPerSlide; i++) {
		if (!next) {
			// wrap carousel by using first child
			next = items[0]
		}
		let cloneChild = next.cloneNode(true)
		el.appendChild(cloneChild.children[0])
		next = next.nextElementSibling
	}
})

// Quand l'utilisateur scroll vers le bas de 20px depuis le haut du document, on monte le bouton vers le haut
window.onscroll = function() {scrollFunction()};

function scrollFunction() {
	if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 1000) {
		document.getElementById("scrollToTopBtn").style.display = "block";
	} else {
		document.getElementById("scrollToTopBtn").style.display = "none";
	}
}

// Quand l'utilisateur clique sur le bouton, scroll vers le haut
function topFunction() {
	document.body.scrollTop = 0; // Pour Safari
	document.documentElement.scrollTop = 0;
}

document.getElementById("scrollToTopBtn").onclick = function() {topFunction()};


// Permet de supprimer le message d'alerte dans 3 secondes
window.setTimeout(function() {
	$(".alert").fadeTo(500, 0).slideUp(500, function(){
		$(this).remove();
	});
}, 3000);

$(document).ready(function(){
	$(".owl-carousel").owlCarousel({
		margin: 10,
		nav: true,
		navText: ["<img src='/images/chevron-gauche.png'>","<img src='/images/chevron-droit.png'>"],
		responsive:{
			0:{
				items:1
			},
			600:{
				items:3
			},
			1000:{
				items:4
			}
		}
	});

	$('[data-fancybox="gallery"]').fancybox({
		// options pour fancybox
	});
});
function toggleCarousel() {
	var carousel = document.getElementById('carouselContent');
	carousel.classList.toggle('d-none');
}

// Ajout d'un écouteur d'événement au bouton
document.getElementById('toggleCarousel').addEventListener('click', toggleCarousel);
