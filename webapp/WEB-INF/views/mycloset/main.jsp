<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<!--한국어 문서만 검색 음성지원할때-->
<head>
<meta charset="UTF-8">
<!--브라우저가 문서를 해설할때 필요한 정보-->
<title>Closetory</title>


<script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.js"></script>

<link href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.css" rel="stylesheet"
	type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
<!--리셋css-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/doCodi.css">
<!--리셋css-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerfooter.css"> <!--헤더 푸터css-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/myClosetSide.css"> <!--사이드css-->		


</head>

<body>
	<div id="wrap">
		<!--header-->
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>

		<div id="container">

			<!-- side profile&menu -->
			<c:import url="/WEB-INF/views/includes/sideProfileMenu.jsp"></c:import>

			<div id="myRoomMain" class="clearfix">
				<div id="main-top">
					<span id="closet-menu-title">MY CLOSET</span>
				</div>

				<div id="main-middle">
					<table style="width: 100%; height: 100%">
						<colgroup>
							<col style="width: 30%;">
							<col style="width: 11%;">
							<col style="width: 19%;">
							<col style="width: 12%;">
							<col style="width: 28%;">
						</colgroup>

						<tr height="20%">
							<td>1</td>
							<td>2</td>
							<td>3</td>
							<td>4</td>
							<td>5</td>
						</tr>

						<tr>
							<td>6</td>
							<td id="closetLink" class="mouseOver" rowspan="2" colspan="2">7</td>
							<!-- <td>8</td> -->
							<td id="wishLink" class="mouseOver">9</td>
							<td>10</td>
						</tr>

						<tr height="8%">
							<td>11</td>
							<!-- <td>12</td>
								<td>13</td> -->
							<td>14</td>
							<td>15</td>
						</tr>

						<tr height="21.5%">
							<td>16</td>
							<td id="codiBoardLink" class="mouseOver">17</td>
							<td id="codiLink" class="mouseOver" rowspan="2">18</td>
							<td>19</td>
							<td>20</td>
						</tr>
						
						<tr height="6.5%">
							<td>21</td>
							<td>22</td>
							<!-- <td>23</td> -->
							<td>24</td>
							<td>25</td>
						</tr>

						<tr height="5%">
							<td>26</td>
							<td>27</td>
							<td>28</td>
							<td>29</td>
							<td>30</td>
						</tr>
					</table>

				</div>

			</div>

			<div class="clear"></div>

		</div>

		<!--footer-->
		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
	</div>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/includes/common.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/js/includes/sideMenu.jsp"></script>

<script type="text/javascript">
	$(document).ready(function() {

		$("#main-middle td").html("");

		$("#closetLink").html("옷장");
		$("#wishLink").html("위시리스트");
		$("#codiBoardLink").html("코디구함<br> 작성글");
		$("#codiLink").html("코디하기");
		
		var id = "${myRoomVo.id}";
		
		$("#closetLink").hover(function() {
			$(this).removeClass("mouseOver");
			$(this).html("");
		}, function() {
			$(this).addClass("mouseOver");
			$(this).html("옷장");
		});

		$("#wishLink").hover(function() {
			$(this).removeClass("mouseOver");
			$(this).html("");
		}, function() {
			$(this).addClass("mouseOver");
			$(this).html("위시리스트");
		});

		$("#codiBoardLink").hover(function() {
			$(this).removeClass("mouseOver");
			$(this).html("");
		}, function() {
			$(this).addClass("mouseOver");
			$(this).html("코디구함<br> 작성글");
		});
		
		$("#codiLink").hover(function() {
			$(this).removeClass("mouseOver");
			$(this).html("");
		}, function() {
			$(this).addClass("mouseOver");
			$(this).html("코디하기");
		});

		$("#closetLink").on("click", function() {
			console.log("옷장");
			location.href = "${pageContext.request.contextPath}/mycloset/" +id+ "/closet";
		});

		$("#wishLink").on("click", function() {
			console.log("위시리스트");
			location.href = "${pageContext.request.contextPath}/mycloset/" +id+ "/wishList";
		});
		
		$("#codiBoardLink").on("click", function() {
			console.log("코디구함 작성글");
			location.href = "${pageContext.request.contextPath}/mycloset/" +id+ "/styzipList";
		});

		$("#codiLink").on("click", function() {
			console.log("코디");
			location.href = "${pageContext.request.contextPath}/mycloset/" +id+ "/doCodi";
		});
	});
</script>

</html>

