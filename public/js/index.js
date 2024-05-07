$(function() {
	//banner
	$('.index_banner').slick({
		autoplay: true,
		arrows: false,
		dots: false,
		infinite: true,
		speed: 3000,
		autoplaySpeed: 5000,
		pauseOnHover: false,
		fade: true,
		responsive: [{
			breakpoint: 992,
			settings: {
				dots: true
			}
		}]
	});

	$('.index_banner').init(function(slick) {
		$('.index_banner .item.slick-current').addClass('active').siblings().removeClass('active')
	})
	$('.index_banner').on('afterChange', function(slick, currentSlide) {
		$('.index_banner .item.slick-current').addClass('active').siblings().removeClass('active');
		var _index = $('.index_banner').slick('slickCurrentSlide')
		$('.section1 .number span').eq(_index).addClass('active').siblings().removeClass('active')
	})
	$('.section1 .number span').click(function() {
		var _index = $(this).index();
		$('.index_banner').slick('slickGoTo', _index);
		$(this).addClass("active").siblings().removeClass("active")
	});
	$('.section1 .prev').click(function() {
		$('.index_banner').slick('slickPrev')
	})
	$('.section1 .next').click(function() {
		$('.index_banner').slick('slickNext');
	});
	/*首页出行方式点击事件*/
	$('.way').click(function() {
		window.location.href = '/daolan/index?target=daolan_4'
	})
	$('.sitem').click(function(e) {
		if($(this).attr('goto') == 'service_6') {
			window.location.href = "/zhihuilvyou/index?target=zhihuilvyou_1"
		} else {
			window.location.href = "/service/index?target=" + $(this).attr('goto')
		}
	})
	//导航
	//超过一定高度导航添加类名
	var nav = $("header"); //得到导航对象  
	var win = $(window); //得到窗口对象  
	var sc = $(document); //得到document文档对象。  
	win.scroll(function() {
		if(sc.scrollTop() >= 100) {
			nav.addClass("on");
		} else {
			nav.removeClass("on");
		}
	})

	//全屏滚动
	$('#index_main').fullpage({
		'navigation': true,
		slidesNavigation: true,
		controlArrows: false,
		continuousHorizontal: true,
		scrollingSpeed: 1000,
		showActiveTooltip: true,
		anchors: ['one', 'two', 'three', 'four', 'five', 'six'],
		loopHorizontal: true,
		loopBottom: false, //滚动到底部后是否继续滚动到顶部
		afterLoad: function(anchorLink, index) {
			if(index == 1) {
				$('#fp-nav ul li a span, .fp-slidesNav ul li a span').removeClass('fullpage_dot_active')
			}
			if(index == 2) {
				$('.gonglue').addClass('animated tada').css('animation-delay', '.1s')
				$('#fp-nav ul li a span, .fp-slidesNav ul li a span').removeClass('fullpage_dot_active')
			}
			if(index == 3) {
				$('.section3 h3').addClass('animated fadeInUp').css('animation-delay', '.1s');
				$('#fp-nav ul li a span, .fp-slidesNav ul li a span').addClass('fullpage_dot_active')
			}
			if(index == 4) {
				$('.section4 h3').addClass('animated fadeInUp').css('animation-delay', '.1s');
				$('#fp-nav ul li a span, .fp-slidesNav ul li a span').removeClass('fullpage_dot_active')
			}
			if(index == 5) {
				$('#fp-nav ul li a span, .fp-slidesNav ul li a span').removeClass('fullpage_dot_active')
			}
			if(index == 6) {
				$('#fp-nav ul li a span, .fp-slidesNav ul li a span').addClass('fullpage_dot_active')
			}
		},
		onLeave: function(index, direction) {}
	})

	/*鼠标放置到景区上弹出蒙版*/
	$('.views>.top').hover(function() {
		$(this).find('.hovertip').addClass('hover_active')
	}, function() {
		$(this).find('.hovertip').removeClass('hover_active')
	})

	$('.sitem').hover(function() {
		$(this).addClass('sitem_active')
	}, function() {
		$(this).removeClass('sitem_active')
	})

	$('.cxt').hover(function() {
		$(this).find('.cxt_t').addClass('cxt_active')
		$(this).find('.cxt_shuoming').addClass('cxt_active')
	}, function() {
		$(this).find('.cxt_t').removeClass('cxt_active')
		$(this).find('.cxt_shuoming').removeClass('cxt_active')
	})

	$('.rtop,.rbleft,.rbright').hover(function() {
		$(this).find('.hoverbox').addClass('hoverbox_active')
	}, function() {
		$(this).find('.hoverbox').removeClass('hoverbox_active')
	})

	/*点击弹出文章详情弹窗*/
	$('.sec5item_articlebox,.sec5item_articleimgbox').click(function() {
		$('.popupCxt').empty()
		//获取文章ID 通过ajax请求数据然后注入到弹窗并显示
		let id = $(this).attr('id')
		$.ajax({
			type: "GET",
			//请求的媒体类型
			contentType: "application/json;charset=UTF-8",
			//请求地址
			url: "/news/get_details",
			//数据，json字符串
			data: {
				id: id
			},
			//请求成功
			success: function(result) {
				console.log(result);
				$('.popupCxt').html(result.content)
				$.fn.fullpage.setAllowScrolling(false, 'up, down');
				$('.popupWindow').toggle()
			},
			error: function(e) {
				console.log(e.status);
				console.log(e.responseText);
			}
		})
	})
	/*点击弹出高德地图*/
	$('.canclickmap').click(function() {
		$('.videoCxt').empty()
		let maphtml = '<iframe style="width:100%;height:100%;border:none" src="https://www.amap.com/search?query=%E4%B8%89%E5%B3%A1%E4%BA%BA%E5%AE%B6%E9%A3%8E%E6%99%AF%E5%8C%BA&city=430000&geoobj=106.484873%7C24.069801%7C122.305204%7C31.422355&zoom=7"></iframe>'
		$('.videoCxt').html(maphtml)
		$.fn.fullpage.setAllowScrolling(false, 'up, down');
		$('.videoWindow').toggle()
	})
	/*点击更多跳转*/
	$('.sec5item_title>.more').click(function() {
		window.location.href = "/news/index?cid=" + $(this).attr('cid')
	})

	$('.hoverbox').click(function() {
		window.location.href = "/meili/index?target=meili_1"
	})

	$('.popupClose').click(function() {
		$('.popupCxt').empty()
		$.fn.fullpage.setAllowScrolling(true, 'up, down');
		$('.popupWindow').toggle()
	})
	$('.videoClose').click(function() {
		$('.videoCxt').empty()
		$.fn.fullpage.setAllowScrolling(true, 'up, down');
		$('.videoWindow').toggle()
	})

	/*PC版鼠标放置事件*/
	if(navigator.userAgent.match(/.*Mobile.*/) ? 1 : 2 != 1){
		$('.hoverfather').hover(function(){
			$(this).find('.hovertip').css({'bottom':'0'})
		},function(){
			$(this).find('.hovertip').css({'bottom':'-35px'})
		})
	}
	/*诗画模块点击*/
	$('.hoverfather').click(function(){
		let goto=$(this).attr('goto')
		window.location.href='/meili/index?target='+goto
	})
	

})