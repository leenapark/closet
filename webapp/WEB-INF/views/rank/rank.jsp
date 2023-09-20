<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Closetory</title>

<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.js"></script>

<link href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
<!--리셋css-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/closet.css">
<!--리셋css-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/rank.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerfooter.css"> <!--헤더 푸터css-->


</head>
<body>
	<div id="wrap">
		<!--header-->
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
		<!--header-->
		
		<!-- nav -->
		<nav class="rank-nav">
			<span class="nav-title">RANKING</span>
		</nav>
		<!-- nav -->


		<div id="container">
			<div class="content clearfix">
				<div class="best-rank blinkcssp">
					<div class="title">
						<span class="navy">POINT</span> RANK
					</div>
					<table class="simple-table">
						<colgroup>
							<col style="width: 30%;">
							<col style="width: 35%;">
							<col style="width: 35%;">
						</colgroup>
					
						<thead>
							<tr class="head">
								<th>순위</th>
								<th>회원정보</th>
								<th>포인트</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${pointList }" var="pointVo">
								<tr>
									<td>
										${pointVo.rank }
									</td>
									<td>
										<span>
											<a href="${pageContext.request.contextPath}/mycloset/${pointVo.id }/main">
												<img class="rankProfile" src="${pageContext.request.contextPath}/profile/${pointVo.profileImg}">
												${pointVo.nickName }님
											</a>
										</span>
									</td>
									<td>
										<span>${pointVo.point }</span>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					
					
					
				</div>
				
				<div class="point-rank blinkcssg">
					<div class="title">
						<span class="red">GOOD</span> RANK
					</div>
					<table class="simple-table">
											
						<colgroup>
							<col style="width: 15%;">
							<col style="width: 30%;">
							<col style="width: 40%;">
							<col style="width: 15%;">
						</colgroup>
						
						<thead>
							<tr>
								<th>순위</th>
								<th>회원정보</th>
								<th>글제목</th>
								<th>좋아요 수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${goodList }" var="goodVo">
								<tr>
									<td>
										${goodVo.rank }
									</td>
									<td>
										<span>
											<a href="${pageContext.request.contextPath}/mycloset/${goodVo.id }/main">
												<img class="rankProfile" src="${pageContext.request.contextPath}/profile/${goodVo.profileImg}">
												${goodVo.nickName }님
											</a>
										</span>
									</td>
									<td>
										<a href="${pageContext.request.contextPath}/trendSetter/readTrendSetter/?boardNo=${goodVo.boardNo}">${goodVo.title }</a>
									</td>

									<td>
										<span>${goodVo.gcount }</span>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				
			</div>
		</div>

		<!--footer-->
		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
	</div>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/includes/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/includes/sideMenu.jsp"></script>

<script type="text/javascript">
	
		
		
</script>

</html>