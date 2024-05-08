$(function() {
  /*
	$.ajax({
		type: "GET",
		contentType: "application/json;charset=UTF-8",
		url: "/music/get_mp3list",
		success: function(result){
			var musics=JSON.parse(result).data
			$('#musicicon').hover(function(){
				if(musics.length!=0){
					$('.qrcode').html('<div class="musiclist"></div>')
					var musicStr=''
					if($.cookie('playinfo')!=null){
						var playindex=$.cookie('playinfo').split(',')[0]
					}else{
						var playindex=-1
					}
					musics.forEach(function(item,index){
						if(playindex==index){
							musicStr+='<div class="music_item"><img class="play_status" index='+index+' status="1" src="/static/index/images/icons/index_pause_icon.png" /><div index='+index+' status="1" class="musicname musicname_active">'+item.name+'</div></div>'
						}else{
							musicStr+='<div class="music_item"><img class="play_status" index='+index+' status="0" src="/static/index/images/icons/index_play_icon.png" /><div index='+index+' status="0" class="musicname">'+item.name+'</div></div>'
						}
						$('.musiclist').html(musicStr)
					})
					//音乐点击播放事件
					$('.play_status').on('click',function(){
						let status=$(this).attr('status')
						let index=$(this).attr('index')
						
						if(status==0){
							mp3.src=musics[index].src
							mp3.preload='auto'
							mp3.play()
							$(this).attr({'status':'1','src':'/static/index/images/icons/index_pause_icon.png'})
							$.cookie('playinfo',index+','+1)
							$(this).parent().find('.musicname').addClass('musicname_active')
							$(this).parent().siblings().find('.play_status').attr({'status':'0','src':'/static/index/images/icons/index_play_icon.png'})
							$(this).parent().siblings().find('.musicname').removeClass('musicname_active')
						}else{
							mp3.pause()
							$(this).attr({'status':'0','src':'/static/index/images/icons/index_play_icon.png'})
							$.cookie('playinfo',null)
							$(this).parent().find('.musicname').removeClass('musicname_active')
						}
					})
					
					//显示音乐列表时禁止网页跟随鼠标滚轮滚动
					$('.musiclist').hover(function(){
						$.fn.fullpage.setAllowScrolling(false, 'up, down')
					},function(){
						$.fn.fullpage.setAllowScrolling(true, 'up, down')
					})
				}
			})
		}
	})
  */

	var mp3=new Audio()
	
	//监听页面刷新事件
	window.onbeforeunload = function(){
		$.cookie('playinfo',null)
	}

	//初始弹窗隐藏
	$('.popupWindow,.videoWindow').hide()
	
	//请求获取二维码数据
  /*
	$.ajax({
		type: "GET",
		contentType: "application/json;charset=UTF-8",
		url: "/index/get_code",
		success: function(result) {
			$('#wxicon').hover(function(){
				$('.qrcode').empty()
				$('.qrcode').append('<img src='+result.wxdingyuecode+' />')
				$('.qrcode').append('<img src='+result.wxservicecode+' />')
				
			},function(){
				$('.qrcode').empty()
			})
			
			
			$('#sinaicon').hover(function(){
				$('.qrcode').empty()
				
			},function(){
				$('.qrcode').empty()
			})
			
			
			$('#dyicon').hover(function(){
				$('.qrcode').empty()
				
				$('.qrcode').append('<img src='+result.dycode+' />')
			},function(){
				$('.qrcode').empty()
			})
			
			$('.qrcode').hover(function(){},function(){
				$(this).empty()
			})
			
		},
		error: function(e) {
			console.log(e.status);
			console.log(e.responseText);
		}
	})
  */
	$('.dropdown').hover(function(){
		$(this).find('.dropdown_menu').addClass('dropdown_menu_active')
	},function(){
		$(this).find('.dropdown_menu').removeClass('dropdown_menu_active')
	})
})
//移动端展开nav
$('#navToggle').on('click', function() {
	$('.m_nav').addClass('open');
})
//关闭nav
$('.m_nav .top .closed').on('click', function() {
	$('.m_nav').removeClass('open');
})

//二级导航  移动端
$(".m_nav .ul li").click(function() {
	$(this).children("div.dropdown_menu").slideToggle('slow')
	$(this).siblings('li').children('.dropdown_menu').slideUp('slow')
	//$('.m_nav').removeClass('open');
});
/*菜单点击事件*/
var isMobile = navigator.userAgent.match(/.*Mobile.*/) ? 1 : 2
$('.navbar_nav>li').click(function() {
	if($(this).find("#indexli").length == 1) {
		window.location.href = "/"
	}
	if(isMobile!=1){
		if($(this).attr('classname')=='导览'){
			window.location.href = "/zoujin?target=daolan_1"
		}else if($(this).attr('classname')=='景区介绍'){
			window.location.href = "/leyou?target=jingqu_2"
		}else if($(this).attr('classname')=='智慧旅游'){
			window.location.href = "/zhihuilvyou/index?target=zhihuilvyou_1"
		}else if($(this).attr('classname')=='新闻资讯'){
			window.location.href = "/news?cid=50"
		}else if($(this).attr('classname')=='景区服务'){
			window.location.href = "/youji?target=service_1"
		}else if($(this).attr('classname')=='魅力三峡'){
			window.location.href = "#"
		}
	}
	
})
$('#sinaicon').click(function(){
	if(navigator.userAgent.match(/.*Mobile.*/) ? 1 : 2 == 1){
		window.open("http://weibo.cn/sxrjcom")
	}else{
		window.open("http://weibo.com/sxrjcom")
	}
	
})



$('.headerlogo').click(function() {
	window.location.href = '/'
})
$('.gotop').click(function() {
	$('html,body').animate({
		scrollTop: 0
	}, 1300)
})
//底部导航菜单点击事件
$('.fullguide,.closeimg').click(function(){
	$('.fullGuide').fadeToggle()
})

$('.aboutus').click(function() {
	unableScroll($(this).attr('id'))
	$.ajax({
		type: "GET",
		//请求的媒体类型
		contentType: "application/json;charset=UTF-8",
		//请求地址
		url: "/index/get_about",
		//请求成功
		success: function(result) {
			console.log(result);
			$('.popupCxt').html(result)
			$('.popupWindow').toggle()
		},
		error: function(e) {
			console.log(e.status);
			console.log(e.responseText);
		}
	})
})
$('.contactus').click(function() {
	unableScroll($(this).attr('id'))
	$.ajax({
		type: "GET",
		//请求的媒体类型
		contentType: "application/json;charset=UTF-8",
		//请求地址
		url: "/index/get_addr",
		//请求成功
		success: function(result) {
			console.log(result);
			$('.popupCxt').html(result)
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
$('.copyright').click(function() {
	unableScroll($(this).attr('id'))
	$.ajax({
		type: "GET",
		//请求的媒体类型
		contentType: "application/json;charset=UTF-8",
		//请求地址
		url: "/index/get_banquan",
		//请求成功
		success: function(result) {
			console.log(result);
			$('.popupCxt').html(result)
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

/*弹窗禁止网页跟随鼠标滚动*/
function unableScroll(id) {
	if(id == 'index') {
		$.fn.fullpage.setAllowScrolling(false, 'up, down');
	} else {
		$('html,body').css({
			'overflow': 'hidden'
		})
	}
}
