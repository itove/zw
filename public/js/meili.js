// var zuopinList = get_json("/api/get_sheyinzuopin", {}, true);
// console.log(zuopinList);
// // var poemList = get_json("/meili/get_poem", {}, true);
// /*作品轮播初始化*/
// if(zuopinList.length != 0) {
// 	if(zuopinList.length < 3) {
// 		$('.imgbox_wrapper').append('<div style="font-size:20px" class="swiper-slide img_slide">为保证最佳效果,请至少上传3张作品</div>')
// 	} else {
// 		for(let i = 0; i < zuopinList.length; i++) {
// 			$('.imgbox_wrapper').append('<div class="swiper-slide img_slide" index=' + i + '><img src=' + zuopinList[i].path + ' /></div>')
// 		}
// 		infoWriter(1)
// 	}
// } else {
// 	// $('.imgbox_wrapper').append('<div style="font-size:20px" class="swiper-slide img_slide">请上传作品吧</div>')
// }
// for(let i = 0; i < poemList.length; i++) {
// 	$('.poemlist_wrapper').append('<div class="swiper-slide poemlist_slide" id=' + poemList[i].id + '><div class="name"><div>' + poemList[i].name + '</div></div><div class="content">' + poemList[i].content + '</div></div>')
// }

/*魅力三峡作品轮播*/
var zpSwiper = new Swiper('.imgbox_swiper', {
	loop: false,
	centeredSlides: true,
	initialSlide: 1,
	slidesPerView: navigator.userAgent.match(/.*Mobile.*/) ? 1 : 2 == 1 ? 1 : 3,
})
var cultureSwiper = new Swiper('.culture .act_swiper', {
	loop: true,
	initialSlide: 2,
	slidesPerView: navigator.userAgent.match(/.*Mobile.*/) ? 1 : 2 == 1 ? 1 : 3,
})
var histSwiper = new Swiper('.history .act_swiper', {
	loop: true,
	initialSlide: 2,
	slidesPerView: navigator.userAgent.match(/.*Mobile.*/) ? 1 : 2 == 1 ? 1 : 3,
})
/*诗词轮播*/
var poemSwiper = new Swiper('.poemlist_swiper', {
	loop: true,
	initialSlide: 2,
	slidesPerView: navigator.userAgent.match(/.*Mobile.*/) ? 1 : 2 == 1 ? 1 : 4,
})
var honorSwiper = new Swiper('.honor', {
	loop: true,
	initialSlide: 1,
	slidesPerView: navigator.userAgent.match(/.*Mobile.*/) ? 1 : 4 == 1 ? 1 : 4,
})

/*slide的hover事件*/
$('.act_slide').hover(function() {
	$(this).addClass('swiper_slide_active')
	$(this).find('.slide_info').addClass('slide_info_active')
}, function() {
	$(this).removeClass('swiper_slide_active')
	$(this).find('.slide_info').removeClass('slide_info_active')
})

$('.poemlist_slide').hover(function() {
	$(this).find('.name').addClass('poemlist_slide_active')
}, function() {
	$(this).find('.name').removeClass('poemlist_slide_active')
})

$('.arts_slide').hover(function() {
	$(this).find('.art_info').addClass('art_info_active')
}, function() {
	$(this).find('.art_info').removeClass('art_info_active')
})

$('.zp_left').click(function() {
	zpSwiper.swipePrev()
	let index = $(zpSwiper.activeSlide()).attr('index')
	infoWriter(index)
})
$('.zp_right').click(function() {
	zpSwiper.swipeNext()
	let index = $(zpSwiper.activeSlide()).attr('index')
	infoWriter(index)
})
$('.culture .leftarrow').click(function() {
	cultureSwiper.swipePrev()
})
$('.culture .rightarrow').click(function() {
	cultureSwiper.swipeNext()
})
$('.history .leftarrow').click(function() {
	histSwiper.swipePrev()
})
$('.history .rightarrow').click(function() {
	histSwiper.swipeNext()
})
$('.greenleft').click(function() {
	poemSwiper.swipePrev()
})
$('.greenright').click(function() {
	poemSwiper.swipeNext()
})
$('.activity_greenleft').click(function() {
	activitySwiper.swipePrev()
})
$('.activity_greenright').click(function() {
	activitySwiper.swipeNext()
})

/*民俗表演点击弹窗*/
$('.info_more').click(function() {
	$('.popupCxt').empty()
	let id = $(this).attr('id')
	$.ajax({
		type: "GET",
		contentType: "application/json;charset=UTF-8",
		url: "/api/nodes/" + id,
		success: function(result) {
			console.log(result);
			$('.popupCxt').html(result.content)
			$('html,body').css({
				'overflow': 'hidden'
			})
			$('.popupWindow').toggle()
		},
		error: function(e) {
			console.log(e.status);
			console.log(e.responseText);
		}
	})

})
/*诗词作品点击弹窗*/
$('.poemlist_slide').click(function() {
	$('.popupCxt').empty()
	let id = $(this).attr('id')
	$.ajax({
		type: "GET",
		contentType: "application/json;charset=UTF-8",
		url: "/meili/get_poem_details",
		data: {
			id: id
		},
		success: function(result) {
			console.log(result);
			$('.popupCxt').html(result.content)
			$('html,body').css({
				'overflow': 'hidden'
			})
			$('.popupWindow').toggle()
		},
		error: function(e) {
			console.log(e.status);
			console.log(e.responseText);
		}
	})
})

/*艺术作品点击弹窗*/
$('.arts_slide').click(function() {
	$('.popupCxt').empty()
	let id = $(this).attr('id')
	$.ajax({
		type: "GET",
		contentType: "application/json;charset=UTF-8",
		url: "/meili/get_huaji_details",
		data: {
			id: id
		},
		success: function(result) {
			let img = "<img style='width:auto;height:100%;'  src=" + result.picurlm + "></img><img class='pictureClose' src='/static/index/images/icons/pictureClose.png'/>"
			$('html,body').css({
				'overflow': 'hidden'
			})
			$('.gotop').css({
				'opacity': '0'
			})
			$('.picturebox').html(img)
			$('.pictureWindow').toggle()
		},
		error: function(e) {
			console.log(e.status);
			console.log(e.responseText);
		}
	})
})

/*活动点击弹窗*/
$('.activity_slide').click(function() {
	$('.popupCxt').empty()
	let id = $(this).attr('id')
	$.ajax({
		type: "GET",
		contentType: "application/json;charset=UTF-8",
		url: "/api/nodes/" + id,
		success: function(result) {
			console.log(result);
			$('.popupCxt').html(result.content)
			$('html,body').css({
				'overflow': 'hidden'
			})
			$('.popupWindow').toggle()
		},
		error: function(e) {
			console.log(e.status);
			console.log(e.responseText);
		}
	})
})

/*获取跳转锚点*/
// $(function() {
// 	target = getParam('target')
// 	$('html,body').animate({
// 		scrollTop: $('#' + target).offset().top
// 	}, 100);
// })

function getParam(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)")
	var r = window.location.search.substr(1).match(reg)
	if(r != null) {
		return decodeURI(r[2])
	} else {
		return null
	}
}
/*所需函数*/
// function infoWriter(index) {
// 	$('.zuopin_info').empty()
// 	$('.zuopin_info').append('<div class="info_item"><span style="color:#999">作品：</span>' + zuopinList[index].info.name + '</div>')
// 	$('.zuopin_info').append('<div class="info_item"><span style="color:#999">作者：</span>' + zuopinList[index].info.author + '</div>')
// 	$('.zuopin_info').append('<div class="info_item"><span style="color:#999">地点：</span>' + zuopinList[index].info.address + '</div>')
// 	$('.zuopin_info').append('<div class="info_item"><span style="color:#999">时间：</span>' + zuopinList[index].info.time + '</div>')
// }

// $('.popupClose').click(function() {
// 	$('.popupCxt').empty()
// 	$('html,body').css({
// 		'overflow': 'visible'
// 	})
// 	$('.popupWindow').toggle()
// })
$('.pictureWindow').click(function(){
	$('.picturebox').empty()
	$('html,body').css({
		'overflow': 'visible'
	})
	$('.gotop').css({
		'opacity': '1'
	})
	$('.pictureWindow').toggle()
})
