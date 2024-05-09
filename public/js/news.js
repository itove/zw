$(function() {
	/*弹窗打开*/
	$('.content_item').click(function() {
		let id = $(this).attr('id')
		let cid = $(this).attr('cid')
		$.ajax({
			type: 'GET',
			contentType: "application/json;charset=UTF-8",
			url: '/news',
			data: {
				id: id
			},
			success: function(res) {
				window.location.href = "/news/" + id
			}
		})
		
	})

	/*弹窗关闭*/
	$('.closeicon').click(function() {
		$('html,body').css({
			'overflow': 'visible'
		})
		$('.new_window').hide()
	})
	$('.popupClose').click(function() {
		$('html,body').css({
			'overflow': 'visible'
		})
		$('.popupWindow').toggle()
	})

	//获取从首页第五屏跳转过来的URL携带的cid参数
	let indexcid = getParam('cid')
	$('.tabitem').each(function() {
		if($(this).attr('cid') == indexcid) {
			$(this).addClass('tabitem_active').siblings().removeClass('tabitem_active')
			//根据cid查询出对应数据写入DOM里面
		}
	})
	$('.tabitem').click(function() {
		let cid = $(this).attr('cid') //获取点击分类的ID
		$(this).addClass('tabitem_active').siblings().removeClass('tabitem_active')
		//根据cid查询出对应数据写入DOM里面
	})
	/**所需函数 获取URL携带的参数*/
	function getParam(name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)")
		var r = window.location.search.substr(1).match(reg)
		if(r != null) {
			return decodeURI(r[2])
		} else {
			return null
		}
	}

})
