<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Closetory</title>


<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-ui-1.12.1/jquery-ui.min.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
<!--리셋css-->

</head>

<body>
	<div id="wrap">
		
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
		
		<div id="container">

			<div id="home-img-contain">
				<div class="home-img1">
					<img class="img" src="${pageContext.request.contextPath}/assets/images/1.jpg">
				</div>
				<div class="home-img2">
					<img class="img" src="${pageContext.request.contextPath}/assets/images/6.jpg">
				</div>
				<div class="home-img4">
					<img class="img" src="${pageContext.request.contextPath}/assets/images/3.jpg">
				</div>
				<div class="home-img1">
					<img class="img" src="${pageContext.request.contextPath}/assets/images/1.jpg">
				</div>
				<div class="home-img3">
					<img class="img" src="${pageContext.request.contextPath}/assets/images/3.jpg">
				</div>
				<div class="home-img1">
					<img class="img" src="${pageContext.request.contextPath}/assets/images/1.jpg">
				</div>
				<div class="home-img2">
					<img class="img" src="${pageContext.request.contextPath}/assets/images/6.jpg">
				</div>
				<div class="home-img3">
					<img class="img" src="${pageContext.request.contextPath}/assets/images/5.jpg">
				</div>
				<div class="home-img1">
					<img class="img" src="${pageContext.request.contextPath}/assets/images/1.jpg">
				</div>
				<div class="home-img2">
					<img class="img" src="${pageContext.request.contextPath}/assets/images/3.jpg">
				</div>
				<div class="home-img4">
					<img class="img" src="${pageContext.request.contextPath}/assets/images/5.jpg">
				</div>
			</div>
		</div>

	</div>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/includes/common.js"></script>

<script type="text/javascript">
	
	$("#main_visual").remove();

	$(document).ready(function() {

		var i = 0;
		setInterval(function() {
			//$("#home-img-contain").children().eq(i).effect('slide',{direction:"down"},2800);
			//$("#home-img-contain").children().eq(i).css({"display":"block"});
			/*
			$("#home-img-contain").children().eq(i).fadeIn().css({
				bottom:0,
				height:"0%",
				position:"absolute"
			}).animate({height:"100%"},2000,function(){
				
			});*/
			$("#home-img-contain").children().eq(i).fadeIn().css({
				bottom : "0",
				position : "absolute"
			}).animate({
				top : "0"
			},1900);
			//$("#home-img-contain").children().eq(i).slideDown(2800);
			//$("#home-img-contain").children().attr(".ui-effects-placeholder").remove();
			$("#home-img-contain").children().eq(i - 1).hide();
			i = i + 1;
			if (i == 11) {
				i = 0;
			}
		}, 2500);
	});
</script>
</html>