/**酒店数据*/
// var hotelList=get_json('/api/intro',{},true);
/*娱乐项目数据*/
var happyList = get_json('/api/get_yule', {}, true);


/*酒店初始化*/
// if(hotelList.length!=0){
// 	hotelDataWriter(0)
// 	// hotelList.forEach(function(item,index){
// 	// 	if(index==0){
// 	// 		$('.navs').append('<div index='+index+' class="navitem navitem_active"><div class="cn_name">'+item.cname+'</div><div class="en_name">'+item.ename+'</div></div>')
// 	// 	}else{
// 	// 		$('.navs').append('<div index='+index+' class="navitem"><div class="cn_name">'+item.cname+'</div><div class="en_name">'+item.ename+'</div></div>')
// 	// 	}
// 	// 	
// 	// })
// 	$('.navitem').on('click',function(){
// 		$(this).addClass('navitem_active').siblings().removeClass('navitem_active')
// 		let index=$(this).attr('index')
// 		hotelDataWriter(index)
// 	})
// }
/*娱乐项目初始化*/
if(happyList.length != 0) {
	happyList.forEach(function(item, index) {
		$('.happy_wrapper').append('<div class="swiper-slide happy_slide" id=' + item.id + ' index=' + index + '><img src=' + item.path + ' /></div>')
		$('.right_tip_more').attr('id', item.id)
	})
	happyItemReWrite(1)
} else {
	$('.happy_wrapper').append('<div class="swiper-slide happy_slide">请上传娱乐项目</div>')
}
/*获取锚点链接*/
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

/*美食hover事件*/
$('.food_item').hover(function() {
	$(this).find('.graytip').addClass('graytip_active')
}, function() {
	$(this).find('.graytip').removeClass('graytip_active')
})

/*特产轮播图*/
var timeline = new Swiper('.timeline', {
  // freeMode: true,
  scrollContainer: true,
})
var spFoodSwiper = new Swiper('.youzai .swiper-container', {
	loop: true,
	paginationClickable: true,
  pagination:'.youzai .pagination',
	slidesPerView: navigator.userAgent.match(/.*Mobile.*/) ? 1 : 2 == 1 ? 1 : 3,
  spaceBetween: 30,
	loop: true
})
var zhuzai = new Swiper('.zhuzai .swiper-container', {
	loop: true,
	paginationClickable: true,
  pagination:'.zhuzai .pagination',
	slidesPerView: navigator.userAgent.match(/.*Mobile.*/) ? 1 : 2 == 1 ? 1 : 3,
  spaceBetween: 30,
	loop: true
})
var gouzai = new Swiper('.gouzai .swiper-container', {
	loop: true,
	paginationClickable: true,
	slidesPerView: navigator.userAgent.match(/.*Mobile.*/) ? 1 : 2 == 1 ? 1 : 4,
  spaceBetween: 30,
	loop: true
})
/*特产hover事件*/
$('.spfoodimg').hover(function() {
	$(this).find('.spfood_moretip').addClass('spfood_moretip_active')
	spFoodSwiper.stopAutoplay()
}, function() {
	$(this).find('.spfood_moretip').removeClass('spfood_moretip_active')
	spFoodSwiper.startAutoplay()
})
/*箭头点击事件*/
$('.timeline .leftarrow').click(function() {
	timeline.swipePrev()
})
$('.timeline .rightarrow').click(function() {
	timeline.swipeNext()
})
$('.youzai .leftarrow').click(function() {
	spFoodSwiper.swipePrev()
})
$('.youzai .rightarrow').click(function() {
	spFoodSwiper.swipeNext()
})
$('.zhuzai .leftarrow').click(function() {
	zhuzai.swipePrev()
})
$('.zhuzai .rightarrow').click(function() {
	zhuzai.swipeNext()
})
$('.gouzai .leftarrow').click(function() {
	gouzai.swipePrev()
})
$('.gouzai .rightarrow').click(function() {
	gouzai.swipeNext()
})

/*娱乐项目轮播图*/
var happySwiper = new Swiper('.happy_swiper', {
	loop: true,
	initialSlide: 1,
	paginationClickable: true,
	slidesPerView: 1,
	loop: true
})
$('.leftbtn').click(function() {
	happySwiper.swipePrev()
	let index = $(happySwiper.activeSlide()).attr('index')
	let id = $(happySwiper.activeSlide()).attr('id')
	$('.right_tip_more').attr('id', id)
	happyItemReWrite(index)
})
$('.rightbtn').click(function() {

	happySwiper.swipeNext()
	let index = $(happySwiper.activeSlide()).attr('index')
	let id = $(happySwiper.activeSlide()).attr('id')
	$('.right_tip_more').attr('id', id)
	happyItemReWrite(index)
})

/*回到顶部*/
$(window).scroll(function() {
	if($(document).scrollTop() > $('#service_4').offset().top) {
		$('.gotop').css({
			'opacity': '1'
		})
	} else {
		$('.gotop').css({
			'opacity': '0'
		})
	}
})
/*峡江美食点击*/
$('.food_item').click(function(){
	$('.popupCxt').empty()
	let id=$(this).attr('id')
	$.ajax({
		type: "GET",
		contentType: "application/json;charset=UTF-8",
		url: "/api/nodes/" + id,
		success: function(result) {
			console.log(result);
			$('.popupCxt').html(result.summary)
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
/*三峡特产点击*/
$('.spfood_slide').click(function(){
	$('.popupCxt').empty()
	let id=$(this).attr('id')
	$.ajax({
		type: "GET",
		contentType: "application/json;charset=UTF-8",
		url: "/api/nodes/" + id,
		success: function(result) {
			console.log(result);
			$('.popupCxt').html(result.summary)
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

/*娱乐休闲点击*/
$('.right_tip_more').click(function() {
	$('.popupCxt').empty()
	let id = $(this).attr('id')
	$.ajax({
		type: "GET",
		contentType: "application/json;charset=UTF-8",
		url: "/service/get_yule_details",
		data: {
			id: id
		},
		success: function(result) {
			console.log(result);
			$('.popupCxt').html(result.subtitle)
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
/*定制项目点击事件*/
$('.booking-slide').click(function() {
	let id = $(this).attr('id')
	$.ajax({
		type: "GET",
		//请求的媒体类型
		contentType: "application/json;charset=UTF-8",
		//请求地址
		url: "/service/get_details",
		//数据，json字符串
		data: {
			id: id
		},
		//请求成功
		success: function(result) {
			console.log(result);
			$('.popupCxt').empty()
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

/*所需函数*/
function happyItemReWrite(index) {
	$('.right_tip>.name').html(happyList[index].name)
	$('.right_tip>.shuoming').html(happyList[index].desc.substring(0, 65) + '...')
}

function hotelDataWriter(index){
	// $('.left_wrapper').empty()
	// $('.cxt').empty()
	// hotelList[index].pics.forEach(function(item,index){
	// 	$('.left_wrapper').append('<div class="left_item swiper-slide" index='+index+'><img src='+item+' /></div>')
	// })
	// $('.cxt').html(hotelList[index].desc)
	/*酒店轮播*/
	var hotelSwiper = new Swiper('.hotelleft', {
		paginationClickable: true,
		pagination:'.pagination',
		autoplay:4000,
		loop:true,
		initialSlide: 0,
		slidesPerView: 1,
	})
	$('.hotelleftarrow').click(function(){
		hotelSwiper.swipePrev()
	})
	$('.hotelrightarrow').click(function(){
		hotelSwiper.swipeNext()
	})
	/**酒店hover事件*/
	$('.left_item').hover(function(){
		hotelSwiper.stopAutoplay()
	},function(){
		hotelSwiper.startAutoplay()
	})
}
$('.popupClose').click(function() {
	$('.popupCxt').empty()
	$('html,body').css({
		'overflow': 'visible'
	})
	$('.popupWindow').toggle()
})
$('.videoClose').click(function() {
	$('.videoCxt').empty()
	$('html,body').css({
		'overflow': 'visible'
	})
	$('.videoWindow').toggle()
})





