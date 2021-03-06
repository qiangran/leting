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
	</head>
<body>
<div class="container-fluid" id="main-container">
<div id="page-content" class="clearfix">
	<div class="row-fluid" id="page">
		<div id="p"></div>
	</div>
 
</div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->
	
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
		<script type="text/javascript">
		window.plateNumber ;
		function chosePlateNumber(value){
			plateNumber = value;
		}
			$(window).load(function(){
				var postData = {openId:"", pageSize:"15", pageIndex:"1"};
	            $.ajax({
	                url: "weixin/getparkingRecords",
	                type:"post",
	                data:JSON.stringify(postData),
	                dataType:"json",
	                contentType:"application/json",
	                success:function(data){
	                	$("#page div").find('tr:not(:first)').remove();
	        			var html = "";
	        			$.each(data.data.list,function(index,comm){
	        			html+='<div id="p" class="easyui-panel" title="" onclick="chosePlateNumber("'+comm['PlateNumber']+'")" style="width:200px;height:150px;padding:10px;background:#fafafa;"'
	        			+ 'iconCls="icon-save"  closable="true" collapsible="true" minimizable="true" maximizable=true>'
	        			+'<p>'+ comm['PlateNumber'] +'&nbsp&nbsp&nbsp'
	        			+ comm['entryTime'] +'</p>'
	        			+'停车'+ comm['Duration'] +'小时&nbsp&nbsp&nbsp'
	        			+ comm['orderAmount'] +'元&nbsp&nbsp&nbsp已缴费</p>'
	    				+ '</div><p></p>';
	        			});
	        			$("#page div").html(html);
	                },error:function(data){
	                }
	            });
			});
		
		</script>
		
	</body>
</html>

