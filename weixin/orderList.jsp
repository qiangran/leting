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
<body>
	<div id="page" class="center" style="text-align:center; width: 340px; height: 340px">
		<div id="p">
		</div>
		<a class="btn" style="margin-top:0px;color:#f39939;font:24px;"
			onclick="javascript:save();return false;">确定缴费</a>
		<br />
		<h class="center" style="color:#999999;font:14px;text-align: center; ">©leting360.cn</h>
	</div>
	
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
		<script type="text/javascript">
		window.plateNumber ;
		var appId ;
		var timeStamp ;
		var nonceStr ;
		var pg ;
		var signType ;
		var paySign ;
		var orderId ;
		function chosePlateNumber(value){
			plateNumber = value;
		}
			$(window).load(function(){
				var postData = {openId:"", pageSize:"15", pageIndex:"1"};
	            $.ajax({
	                url: "weixin/parkingOrders",
	                type:"post",
	                data:JSON.stringify(postData),
	                dataType:"json",
	                contentType:"application/json",
	                success:function(data){
	                	$("#page div").find('tr:not(:first)').remove();
	        			var html = "";
	        			$.each(data.data.list,function(index,comm){
	        			html+='<div id="p" class="easyui-panel" title="" style="width:100%;height:100%;text-align: left;color:#666666;font:16px;">'
	        			+ '<label><input type="checkbox" id="zcheckbox" onclick="chosePlateNumber(\''+comm['PlateNumber']+'\')" /><span class="lbl"></span></label>'
	        			+'<h2 class="" style="margin-top: 15px; padding: 0px;color:#f39939;font:24px;">'
						+comm['PlateNumber'] +'</h2>'
						+ '<p>入场时间：'
						+ comm['entryTime']
						+ '</p>'
						+ '<p>出场时间：'
						+ comm['exitTime']
						+ '</p>'
						+ '<p>停车时长：'
						+ comm['Duration']
						+ '小时</p>'
						+ '<p>停车费用：'
						+ comm['orderAmount']
						+ '元</p>'
	    				+ '</div><p></p>';
	        			});
	        			$("#page div").html(html);
	                },error:function(data){
	                }
	            });
			});
		
			function save(){
				var plateNumber = window.plateNumber;
				var postData = {"plateNumber":plateNumber};
	            $.ajax({
	                url: "weixin/getWeiChartPrePay",
	                type:"post",
	                data:JSON.stringify(postData),
	                dataType:"json",
	                contentType:"application/json",
	                success:function(data){
	                	
	                	var prePayData = JSON.parse(data.data.list);
	                	if(prePayData.success==1){
	                		var map = prePayData.map;
		                	appId = map.appId;
		                	timeStamp = map.timeStamp;
		                	nonceStr = map.nonceStr;
		                	pg = map.package;
		                	signType = map.signType;
		                	paySign = map.paySign;
		                	orderId = map.out_trade_no;
		                	pay();
	                	}else{
	                		alert("微信预支付订单参数出错！");
	                	}
	                },error:function(data){
	                }
	            });
			}
		 	
	  function onBridgeReady(){
		    wx.config({
		 	    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
		 	    appId: appId, // 必填，公众号的唯一标识
		 	    timestamp: timeStamp, // 必填，生成签名的时间戳
		 	    nonceStr: nonceStr, // 必填，生成签名的随机串
		 	    signature: paySign,// 必填，签名，见附录1
		 	    jsApiList: ['chooseWXPay'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
		 	});

		       wx.chooseWXPay({
			   "appId" : appId,     //公众号名称，由商户传入     
	           "timestamp": timeStamp,         //时间戳，自1970年以来的秒数     
	           "nonceStr" : nonceStr, //随机串     
	           "package" : pg,
	           "signType" : signType,         //微信签名方式:     
	           "paySign" : paySign,    //微信签名 
			    success: function (res) {
			        // 支付成功后的回调函数
					checkpay();
					window.location.href="<%=request.getContextPath() %>/weixin/getOrderListPage";
			    },error: function(){
			    }
			}); 

		}
	  
	  //主动查询微信支付结果信息
	  function checkpay(){
		var postData = {"orderId":orderId};
          $.ajax({
              url: "weixin/querywxpay",
              type:"post",
              data:JSON.stringify(postData),
              dataType:"json",
              contentType:"application/json",
              success:function(data){
              },error:function(data){
              }
          });
	  }
	  
	    function pay(){
	    	try {
				if (typeof WeixinJSBridge == "undefined"){
				   if( document.addEventListener ){
				       document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
				   }else if (document.attachEvent){
				       document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
				       document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
				   }
				}else{
				   onBridgeReady();
				}
	    	} catch (e) {
                alert(e);
            }
            window.event.returnValue = false;
            return false;
	    }
		</script>
		
	</body>
</html>

