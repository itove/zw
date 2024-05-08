$(function() {
	var target

	/*轮播图*/
	var mySwiper = new Swiper('.swiper-container', {
		// autoplay: 4000,
		loop: true,
		paginationClickable: true,
		slidesPerView: 3,
		loop: true
	})
	/*slide的hover事件*/
	$('.swiper-slide').hover(function() {
		$(this).addClass('swiper_slide_active')
		$(this).find('.slide_info').addClass('slide_info_active')
	}, function() {
		$(this).removeClass('swiper_slide_active')
		$(this).find('.slide_info').removeClass('slide_info_active')
	})
	$('.leftarrow').click(function() {
		mySwiper.swipePrev()
	})
	$('.rightarrow').click(function() {
		mySwiper.swipeNext()
	})
	/*获取跳转锚点*/
	$(function() {
		target = getParam('target')
		$('html,body').animate({
			scrollTop: $('#' + target).offset().top
		}, 100);
	})

	function getParam(name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)")
		var r = window.location.search.substr(1).match(reg)
		if(r != null) {
			return decodeURI(r[2])
		} else {
			return null
		}
	}

	/*回到顶部*/
	$(window).scroll(function() {
		if($(document).scrollTop() > $('#daolan_6').offset().top) {
			$('.gotop').css({
				'opacity': '1'
			})
		} else {
			$('.gotop').css({
				'opacity': '0'
			})
		}
	})

	/*点击攻略文章弹窗*/
	$('.right>.item').click(function() {
		$('.popupCxt').empty()
		let id = $(this).attr('id')
		$.ajax({
			type: "GET",
			contentType: "application/json;charset=UTF-8",
			url: "/daolan/get_details",
			data: {
				id: id
			},
			success: function(result) {
				console.log(result);
				$('.popupCxt').html(result.content)
				$('html,body').css({'overflow':'hidden'})
				$('.popupWindow').toggle()
				//弹窗成功后调用接口改变浏览数
				$.ajax({
					type:'GET',
					contentType: "application/json;charset=UTF-8",
					url:'/news/add_viewnum',
					data:{
						id:id
					},
					success:function(res){
						$('.viewnum'+id).html(parseInt($('.viewnum'+id).text())+1)
					}
				})
			},
			error: function(e) {
				console.log(e.status);
				console.log(e.responseText);
			}
		})
	})

	$('.popupClose').click(function() {
		$('.popupCxt').empty()
		$('html,body').css({'overflow':'visible'})
		$('.popupWindow').toggle()
	})
	$('.videoClose').click(function() {
		$('.videoCxt').empty()
		$('html,body').css({'overflow':'visible'})
		$('.videoWindow').toggle()
	})

})