<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "DTD/xhtml1-strict.dtd">
<html xmlns=" http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-cache"/>
<meta name="MobileOptimized" content="240"/>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- jsp文件头和头部 -->
	<%@ include file="../system/admin/top.jsp"%>   
	<title>乐停</title> 
</head>
<style>
.center {
	margin-left: auto;
	margin-right: auto;
	width: 100%;
 	background-color: #b0e0e6;
}
</style>
<body >
	<div class="center" style="text-align:center;width:340px;height:340px">
		<img src="static/images/logo/logo.png" alt="乐停" style="margin-top:30px;background-repeat: repeat-y;background-position: center;"/>
		<h2 class="center" style="margin-top:15px;padding:0px;">乐停云停车</h2>
		<table class="center" style="margin:0px;padding:0px;">
			<tr style="width:100%;">
				<td>
					<input type="text" name="plateNumber" id="plateNumber" value="" style="text-align:center;" placeholder="请输入您的车牌号" />
					<img src="static/images/logo/jt.png" alt="确定" onclick="save();" style="margin:0px;padding:0px;height:30px"/>
				</td>
			</tr>
		</table>
		<h class="center" style="margin-top:50px;margin-bottom:25px;padding:0px;color:#999999;font:14px ">©leting360.cn</h>
	</div>
		
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
		<script type="text/javascript">

		function chosePlateFlag(){
			var oldPlateFlag = $("#plateFlag").val();
			$("#position div").find('tr:not(:first)').remove();
			var html = '';
			var positions = new Array('京','沪','津','渝','黑','吉','辽','蒙','冀','新','甘','青','陕','宁','豫','鲁','晋','皖','鄂','湘','苏','川','黔','滇','桂','藏','浙','赣','粤','闽','台','琼','港','澳');
			for(var i = 0;i < positions.length; i++) {
				if(i%7==0){
					html+='<tr><td onclick="chosePlate(\''+positions[i]+'\')">'+positions[i]+'</td>';
				}else if(i%7==6){
					html+='<td onclick="chosePlate(\''+positions[i]+'\')">'+positions[i]+'</td></tr>';
				}else{
					html+='<td onclick="chosePlate(\''+positions[i]+'\')">'+positions[i]+'</td>';
				}
			}
			html+='<td onclick="chosePlate(\''+oldPlateFlag+'\')">取消</td></tr>';
            $("#position div").html(html);
		}
		
			function chosePlate(newPlateFlag){
				$("#position div").find('tr').remove();
				if(newPlateFlag !== null && newPlateFlag !==''){
					$("#plateFlag").val(newPlateFlag);
				}
			}
			
		 	function save(){
				var plateNumber = $("#plateNumber").val();
				var openId = "";
				var postData = {"plateNumber":plateNumber,"openId":openId};
	            $.ajax({
	                url: "weixin/addWeiXinPlateNumbers",
	                type:"post",
	                data:JSON.stringify(postData),
	                dataType:"json",
	                contentType:"application/json",
	                success:function(data){
	                	if(data.code==200){
	                		window.location.href="<%=request.getContextPath() %>/weixin/getPlateNumberPage";
	                	}else{
	                		alert(data.msg);
	                	}
	                },error:function(data){
	                }
	            });
			}
		
		</script>
	</body>
</html>

