//通用延时跳转函数
function Goto(msg,time,url){
    if(msg!=""){
        layer.msg(msg);
    }
    setTimeout(function(){
        if(url=='' || url=='reload' ){
            window.location.reload();
		}else if(url=='back'){
			window.history.go(-1);
        }else{
            window.location.href=url;
        }
    },time);
}
//通用form表单提交函数-带回调跳转
function Form_Post(frm,url,gourl){
     var options={
        url:url,
        type:'post',
        dataType:'json',
        data:$(frm).serialize(),
        success:function(data){ 
            if(data.status==0){
				if(gourl==""){
					layer.msg(data.msg);
            	}else{
            		Goto(data.msg,1000,gourl);
            	}
            }else{
                layer.msg(data.msg);
            }
        }
      }
      $.ajax(options);
      return false;
}
//通用form表单提交函数-不带回调跳转
function Form_Post_Return(frm,url){
	 var result='';
	  $.ajaxSettings.async = false;
     var options={
        url:url,
        type:'post',
        dataType:'json',
        data:$(frm).serialize(),
        success:function(data){
        	result=data;
        }
      }
      $.ajax(options);
      return result;
}
//通用表单清空函数
function Form_Reset(frm){
	$(frm)[0].reset();
	$(frm).find('div[data-type=upload]').each(function(){
		var classname=$(this).attr('class');
		var inputname=$(this).attr('attr-inputname');
		$(this).attr('attr-value','');
		File_Upload("."+classname,'image',inputname);
	});
	$(frm).find('input[type=hidden]').val('');
	var sipt=$(frm).find('select');
	sipt.find('option').attr('selected',false);	
}
//通用getJSON提交函数
function get_json(url,data,result){
    var d="";
    //关闭异步请求
    $.ajaxSettings.async = false; 
    $.getJSON(url,data,function(json){
        if(result==false){
            if(json.status==0){
                Goto(json.msg,1000,"");
            }else{
                layer.msg(json.msg);
            }
        }else{
            d=json;
        }
    });
    return d;
}
//通用getJSON提交函数
function get_json_nomsg(url,data){
    var d="";
    //关闭异步请求
    $.ajaxSettings.async = false;
    $.getJSON(url,data,function(json){
        d=json;
    });
    return d;
}
//通用确认弹窗
var Confirm=function(title,ok,cencel){
    layer.confirm(title, {
      btn: ['确认','取消'] //按钮
    }, function(){
       ok();
    },function(){
       cencel();
    });
}
//unix时间戳转换成普通日期时间
function MyDate(time){
	var d=new Date(time*1000);
	var Y=d.getFullYear();
	var M=d.getMonth()+1;
	var D=d.getDate();
	var H=d.getHours();
	var Mi=d.getMinutes();
	var S=d.getSeconds();
	return Y+'-'+M+'-'+D+' '+H+':'+Mi+':'+S;
}
//unix时间戳转换成普通日期
function MyDateMin(time){
	var d=new Date(time*1000);
	var Y=d.getFullYear();
	var M=d.getMonth()+1;
	var D=d.getDate();
	var H=d.getHours();
	var Mi=d.getMinutes();
	var S=d.getSeconds();
	return Y+'/'+M+'/'+D;
}
//获得当前日期
function getNowDate(){
    var d=new Date();
    return d.getFullYear()+'-'+(d.getMonth()+1)+'-'+d.getDate(); 
}
//判断两个日期相差多少天：sDate1和sDate2是2006-12-18格式  
function datedifference(sDate1, sDate2){
    var dateSpan, tempDate, iDays;
    sDate1 = Date.parse(sDate1);
    sDate2 = Date.parse(sDate2);
    dateSpan = sDate2 - sDate1;
    dateSpan = dateSpan;
    iDays = Math.floor(dateSpan / (24 * 3600 * 1000));
    return iDays
}
//比较两个日期大小 第一个大返回真，
function compareDate(date1,date2){
    var oDate1 = new Date(date1);
    var oDate2 = new Date(date2);
    if(oDate1.getTime() > oDate2.getTime()){
        return true;
    } else {
        return false;
    }
}
//指定日期加一天
function addDate(date, days) {
    if (days == undefined || days == '') {
        days = 1;
    }
    var date = new Date(date);
    date.setDate(date.getDate() + days);
    var month = date.getMonth() + 1;
    var day = date.getDate();
    return date.getFullYear() + '-' + getFormatDate(month) + '-' + getFormatDate(day);
}
//日期月份/天的显示，如果是1位数，则在前面加上'0'
function getFormatDate(arg) {
    if (arg == undefined || arg == '') {
        return '';
    }
    var re = arg + '';
    if (re.length < 2) {
        re = '0' + re;
    }
    return re;
}
//获得随机数
function GetRandom(max){
	return Math.floor(Math.random()*max);
}
//通用表单验证方法
function FormCheck(form_id){
	/*
	 	input属性支持选项：
	 		在每个被检查的input的class上绑定 ipt_check
	 		data-type="string"  选择检查类型
	 		data-len="5-20"	       选择检查长度 浮点数为点前位数和点后位数
	 		nullmsg				为空时提示信息
	 		errormsg			验证失败提示信息
	 		repeated			绑定重复验证的input 的name名（用于密码重复验证）
	 		repeated-msg		重复验证失败提示信息
	 		
	 	检查类型:
	 		string:任何字符
			name:下划线/任何字符/数字/中文
			zhname:中文文字
			enname:英文文字
	 		integer:整型
	 		float:浮点，货币型
	 		mobile:手机号码
	 		phone:固定电话
	 		email:邮箱类型
	 		url:网址类型
	 		password:密码类型(绑定到指定的repassword),来确定两次输入是否一致 
	 		以及密码健壮测试(1,2,3)
	 		postcode:邮政编码类型
	 		ip:IP地址	
	 		upload:ajax上传文件类型	
	 */
	/*
	     判断字符类型(密码健壮测试)
	*/
	function CharMode(iN) {
	    if (iN >= 48 && iN <= 57) //数字  
	        return 1;
	    if (iN >= 65 && iN <= 90) //大写字母  
	        return 2;
	    if (iN >= 97 && iN <= 122) //小写  
	        return 4;
	    else
	        return 8; //特殊字符  
	}
	/*
	    统计字符类型(密码健壮测试)
	*/
	function bitTotal(num) {
	    modes = 0;
	    for (i = 0; i < 4; i++) {
	        if (num & 1) modes++;
	        num >>>= 1;
	    }
	    return modes;
	}

	var inpt=$(form_id).find('.ipt_check');
	var frm=$(form_id);
	var result=true;
	
	if(inpt.length>=1){

		inpt.each(function(){
			var ipt=$(this);
			var type=ipt.attr('data-type');
			var len=ipt.attr('data-len');
			var nullmsg=ipt.attr('nullmsg');
			var errormsg=ipt.attr('errormsg');
			var value=ipt.val();
			var repeated=ipt.attr('repeated'); //判断是否需要重复测试
			var repeatedmsg=ipt.attr('repeated-msg'); //判断是否需要重复测试
			var inputname=ipt.attr('attr-inputname'); //检查上传文件的input
			
			var types=new Array('string','integer','float','mobile','phone','email','url','ip','name','enname','zhname');
			
			if($.inArray(type,types)>=0)
			{
				
				var reg_lst=new Array;
				var len_arr=len.split('-');
				//匹配任何字符
				reg_lst['string']="^(.*){"+len_arr[0]+","+len_arr[1]+"}$";
				//匹配下划线的任何单词字符和数字和中文
				reg_lst['name']="^(\\w|[\\u4E00-\\u9FA5\\uF900-\\uFA2D]|[\\uFF00-\\uFFEF]){"+len_arr[0]+","+len_arr[1]+"}$";
				//匹配中文字
				reg_lst['zhname']="^([\\u4E00-\\u9FA5\\uF900-\\uFA2D]|[\\uFF00-\\uFFEF]){"+len_arr[0]+","+len_arr[1]+"}$";
				//匹配英文文字
				reg_lst['enname']="^([A-Za-z0-9]){"+len_arr[0]+","+len_arr[1]+"}$";				
				//匹配整型数字
				reg_lst['integer']="^(\\d){"+len_arr[0]+","+len_arr[1]+"}$";
				
				reg_lst['float']="^([0-9]{1,"+len_arr[0]+"}\.{0,1}[0-9]{0,"+len_arr[1]+"})$";
				reg_lst['mobile']="^(0|86|17951)?(17[0-9]|16[0-9]|13[0-9]|15[012356789]|18[0-9]|14[57])[0-9]{8}$";
				reg_lst['phone']="^([0-9]{3,4}-)?[0-9]{7,8}$";
				reg_lst['email']="^\\w+((-\\w+)|(\.\\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$";
				reg_lst['url']="^((https|http|ftp|rtsp|mms)?://)"
						        + "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?"
						        + "(([0-9]{1,3}\.){3}[0-9]{1,3}"
						        + "|"
						        + "([0-9a-z_!~*'()-]+\.)*"
						        + "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\."
						        + "[a-z]{2,6})"
						        + "(:[0-9]{1,4})?"
						        + "((/?)|"
						        + "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$";
						        
				reg_lst['ip']="^([0-9]|[1-9]\\d|1\\d\\d|2[0-4]\\d|25[0-5])\."+
							 +"([0-9]|[1-9]\\d|1\\d\\d|2[0-4]\\d|25[0-5])\."+
							 +"([0-9]|[1-9]\\d|1\\d\\d|2[0-4]\\d|25[0-5])\."+
							 +"([0-9]|[1-9]\\d|1\\d\\d|2[0-4]\\d|25[0-5])$";
				
				var valid=new RegExp(reg_lst[type],"gim").test(value);
				
				//验证是否为空
				if($.trim(value)==""){
					layer.msg(nullmsg);
					ipt.focus();
					result=false;
					return false;
				}
				//正则验证是否通过
				if(!valid){
					ipt.val('');
					layer.msg(errormsg);
					ipt.focus();
					result=false;
					return false;
				}
				//是否需要重复验证
				if(repeated!=""){
					var repeated=frm.find("input[name='"+repeated+"']");
					if(repeated.length>=1){
						if(repeated.val()!=value){
							layer.msg(repeatedmsg);
							result=false;		
							return false;
						}
					}
				}
			}else if(type=='password'){
				var isStrong=ipt.attr('passwordStrong');	
				var StrongMsg=ipt.attr('StrongMsg');	
				//判断是否需要密码健壮测试
				var len_arr	=len.split('-');
				var valid	=new RegExp("^(\\S){"+len_arr[0]+","+len_arr[1]+"}$","gim").test(value);
				//正则验证是否通过
				if(!valid){
					ipt.val('');
					layer.msg(errormsg);
					ipt.focus();
					result=false;
					return false;
				}
				//密码健壮测试
				if(isStrong>=1){
		            Modes = 0;
		            for (i = 0; i < value.length; i++) {
		                //测试每一个字符的类别并统计一共有多少种模式.  
		                Modes |= CharMode(value.charCodeAt(i));
		            }
		            if(bitTotal(Modes)<isStrong){
		            	layer.msg(StrongMsg);
						result=false;
						return false;
		            }
				}
				//是否需要重复验证
				if(repeated!=""){
					var repeated=frm.find("input[name='"+repeated+"']");
					if(repeated.length>=1){
						if(repeated.val()!=value){
							layer.msg(repeatedmsg);
							result=false;
							return false;
						}
					}
				}
			}else if(type=='upload'){
				if(inputname!=""){
					var inputname=$("input[type='text'][name='"+inputname+"']");
					if(inputname.length<1){
						layer.msg(nullmsg);
						result=false;
					}else{
						if(inputname.val()==''){
							layer.msg(nullmsg);
							result=false;
							return false;
						}
					}
				}
			}else if(type=='select'){
				var len_arr=len.split('-');
				var min= parseFloat(len_arr[0]);
				var max= parseFloat(len_arr[1]);
				if(value<min || value>max ){
					layer.msg(nullmsg);
					result=false;
					return false;
				}
			}else if(type=='checkbox'){
				var check_ele=ipt.find('input[type=checkbox]:checked');
				if(check_ele.length<len){
					layer.msg(nullmsg);
					result=false;
					return false;
				}
			}
		});
	}
	return result;
}
//调用文件上传组件
function File_Upload(ele,type,ipt_name,isMulti){
	var picurl=$(ele);
	var Aroot = $("body").attr('bind-root');
    if(picurl.length>=1){
        picurl.upload({
			uploadPath: Aroot+'admin/file_upload/type/'+type,
            isMulti: isMulti,
            type: type,
            fileInputName: ipt_name,
            callback: function (msg){}
        });
    }
}
//数据装载方法
function Data_loader(edit_frm,type,name,value,ele){
	if(type=='input'){
		edit_frm.find('input[name='+name+']').val(value);
	}else if(type=='select'){
		edit_frm.find('select[name='+name+']').val(value);
	}else if(type=='textarea'){
		edit_frm.find('textarea[name='+name+']').val(value);
	}else if(type=='radio'){
		edit_frm.find('input[name='+name+'][value=\''+value+'\']').prop('checked',true);
   }else if(type=='checkbox'){
    	var lst=value.split(',');
		$.each(lst, function(i,n) {
			ele=edit_frm.find('input[name='+name+'\\[\\]][value=\''+n+'\']');
			ele.prop('checked',true);
		});
	}else if(type=='file'){
		edit_frm.find(ele).attr('attr-value',value);
		isMulti=edit_frm.find(ele).attr('isMulti');
		if(isMulti=='true'){
			isMulti=true;
		}else{
			isMulti=false;
		}
		File_Upload(ele,'file',name,isMulti);	
	}else if(type=='image'){
		edit_frm.find(ele).attr('attr-value',value);
		isMulti=edit_frm.find(ele).attr('isMulti');
		if(isMulti=='true'){
			isMulti=true;
		}else{
			isMulti=false;
		}
		File_Upload(ele,'image',name,isMulti);
	}else if(type=='text'){	
		edit_frm.find(name).text(value);
	}else if(type=='select_mult'){
		var lst=value.split(',');
		var sipt=edit_frm.find('select[name='+name+'\\[\\]]');
		sipt.find('option').attr('selected',false);
		$.each(lst, function(i,n) {
			sipt.find('option[value='+n+']').attr('selected',true);
		});
	}
}
//获得选中的checkbox值
function Get_Checkbox_Vals(cls_name){
	var ids=new Array();
	var checks=$(cls_name);
	var index=0;
	$.each(checks, function() {
		var obj=$(this);
		if(obj.prop('checked')){
			ids[index]=obj.val();
			index++;
		}
	});
	return ids;
}
//显示百度地图,default_address:默认地址  bind:绑定的地址表单
function Show_BaiduMap(bind,default_address){
	//清理并生成新的地图层DOM节点
	$('body').find("#baidu_map_layer").remove();
	$("body").append('<div id="baidu_map_layer"></div>');
	$(".layui-layer-nobg").remove();
	$(".layui-layer-shade").remove();
	// 创建Map实例
	var map = new BMap.Map("baidu_map_layer");
	//创建一个百度地址解析对像
	var geoc = new BMap.Geocoder();
	//设置一个默认位置
	var point = new BMap.Point('111.3007957295','30.7080385485');
	//创建标注
	var marker = new BMap.Marker(point);
	//读取绑定的经纬度表单
	var location=$("input[name="+bind+"_location]");
	//读取绑定的地址表单
	var ipt=$("input[name="+bind+"]");
	//优先移动到表单地址,否者移动到默认地址
	if(ipt.val()!=""){
		map.centerAndZoom(ipt.val(),15);     		//初始化地图,设置中心点坐标和地图级别
	}else{
		map.centerAndZoom(default_address,15);     			//初始化地图,设置中心点坐标和地图级别
	}
	//将标注添加到地图中	
	map.addOverlay(marker);            				
	//开启标注物拖动
	marker.enableDragging();
	//设置标物监听事件
	marker.addEventListener("dragend",function(e){
	    var p = e.target;
	    var p = e.point;
		write(p);		
	});
	//在地图中创建一个导航工具
	map.addControl(new BMap.NavigationControl());
	//开启鼠标滚轮缩放
	map.enableScrollWheelZoom(true);
	//设置地图片点击监听事件
	map.addEventListener("click",function(e){
	    var p = e.point;
	    write(p);   
	    marker.setPosition(e.point);
	});
	//当前地图片完全加载完成,设置到指定位置
	map.addEventListener("tilesloaded",function(){
		if(location.val()!=""){
			l2=location.val();
			l2=l2.split(',');
			p2=new BMap.Point(l2[0],l2[1]);
			//移动地图到指定位置
			map.panTo(p2);
			//设置标注物的新位置
			marker.setPosition(p2);
		}
	});
	//把获得的地理信息写入绑定的input中
	function write(p){
		//根据经纬度获得地址信息
		geoc.getLocation(p, function(rs){
			var addComp = rs.addressComponents;
			var address =addComp.province + addComp.city +addComp.district + addComp.street + addComp.streetNumber;
			//直接写入地址和经纬度
			$("input[name="+bind+"]").val(address);
			$("input[name="+bind+"_location]").val(p.lng+','+p.lat);
		});
	}
	//打开地图层
	layer.open({
	  type: 1,
	  title: '',
	  closeBtn: 0,
	  skin: 'layui-layer-nobg', //没有背景色
      shadeClose: true,
	  area: ['750px','450px'],
	  content: $('#baidu_map_layer')
	});
}
//获得百度编辑器配置
function Get_UEditor_Config(type){
	
	var full_config=[['fullscreen', 'source', '|', 'undo', 'redo', '|','bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|','rowspacingtop', 'rowspacingbottom', 'lineheight', '|','customstyle', 'paragraph', 'fontfamily', 'fontsize', '|','directionalityltr', 'directionalityrtl', 'indent', '|',
'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'touppercase', 'tolowercase', '|','link', 'unlink', 'anchor', '|', 'imagenone', 'imageleft', 'imageright', 'imagecenter', '|','insertimage', 'emotion', 'scrawl', 'insertvideo', 'music', 'attachment', 'map','insertcode','pagebreak', 'template','|','horizontal', 'date', 'time', 'spechars', 'snapscreen', 'wordimage', '|','inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols', 'charts', '|','print', 'preview', 'searchreplace','help']];

	var single_config=[['source', '|', 'undo', 'redo', '|','bold', 'italic', 'underline', 'removeformat','pasteplain', '|', 'forecolor', 'backcolor','insertunorderedlist','cleardoc', '|','paragraph', 'fontfamily', 'fontsize','indent', 'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|','link','insertimage','map','horizontal','inserttable']];
	
	if(type=='full'){
		return full_config;
	}else{
		return single_config;
	}
}
//全选，反选，全取消
function Checkbox_Select(classname,type){
	if(type=='all'){
		if($(classname).length>=1){
			$.each($(classname), function(index,item) {
				$(item).prop('checked',true);
			});
		}
	}else if(type=='reverse'){
		var checks=$(classname);
		$.each((checks), function() {
			var obj=$(this);
			if(obj.prop('checked')){
				obj.prop('checked',false);
			}else{
				obj.prop('checked',true);
			}
		});
	}else if(type=='cancel'){
		if($(classname).length>=1){
			$.each($(classname), function(index,item) {
				$(item).prop('checked',false);
			});
		}
	}
}