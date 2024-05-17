$(window).scroll(function() {
  if($(document).scrollTop() > $('.path').offset().top) {
    $('.gotop').css({
      'opacity': '1'
    })
  } else {
    $('.gotop').css({
      'opacity': '0'
    })
  }
})

/* pop video */
$('#musicicon').click(function() {
	$('html,body').css({
		'overflow': 'hidden'
	})
	$('.videoWindow').toggle()
})
$('.video_item').click(function() {
	let vpath = $(this).attr('vpath')
	$('.videoCxt').html("<video style='width:100%;height:100%'  poster='' src='" + vpath + "' preload=\"auto\" controls=\"controls\" autoplay=\"autoplay\"></video>")
	$('html,body').css({
		'overflow': 'hidden'
	})
	$('.videoWindow').toggle()
})

$('.videoClose').click(function() {
	// $('.videoCxt').empty()
	$('html,body').css({
		'overflow': 'visible'
	})
	$('.videoWindow').toggle()
})

wx = document.querySelector('#wxicon');
wx.addEventListener('mouseover', function(){
  img = document.querySelector('#wxqr');
  img.classList.add('d-block');
});
wx.addEventListener('mouseleave', function(){
  img = document.querySelector('#wxqr');
  img.classList.remove('d-block');
});
minp = document.querySelector('#minpicon');
minp.addEventListener('mouseover', function(){
  img = document.querySelector('#mpqr');
  img.classList.add('d-block');
});
minp.addEventListener('mouseleave', function(){
  img = document.querySelector('#mpqr');
  img.classList.remove('d-block');
});
