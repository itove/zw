$(function(){
	var id=getParam('id')
	var cid=getParam('cid')

	/**初始化獲取當前要展示的文章*/
	getDetail(id)
	
	/**獲取當前分類下所有的文章列表*/
	getList(id,cid)
	
	
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
	
	function getDetail(id){
		$.ajax({
			type:'GET',
			contentType: "application/json;charset=UTF-8",
			url: "/news/get_details",
			data: {
				id:id
			},
			success:function(res){
				$('.detailbox').empty()
				$('.detailbox').html(res.content)
			}
		})
	}
	
	function getList(currentid,cid){
		$.ajax({
			type:'GET',
			contentType: "application/json;charset=UTF-8",
			async:false,
			url: "/news/get_chapter_list",
			data: {
				classid:cid
			},
			success:function(res){
				console.log(res)
				var index=res.findIndex((item,index)=>{
					return item.id==currentid
				})
				if(index==0){
					$('.up').attr('href','javascript:void(0)').html('上一篇：沒有啦')
					$('.down').attr('href','/newsdetail/index?id='+res[1].id+'&cid='+cid).html('下一篇：'+res[1].title)
				}else if(index+1==res.length){
					$('.up').attr('href','/newsdetail/index?id='+res[index-1].id+'&cid='+cid).html('上一篇：'+res[index-1].title)
					$('.down').attr('href','javascript:void(0)').html('下一篇：沒有啦')
				}else{
					$('.up').attr('href','/newsdetail/index?id='+res[index-1].id+'&cid='+cid).html('上一篇：'+res[index-1].title)
					$('.down').attr('href','/newsdetail/index?id='+res[index+1].id+'&cid='+cid).html('下一篇：'+res[index+1].title)
				}
			}
		})
	}
	$('.popupClose').click(function() {
		$('.popupCxt').empty()
		$('.popupWindow').toggle()
	})
	
	/*回到顶部*/
	$('.gotop').css({
		'opacity': '1'
	})
})
