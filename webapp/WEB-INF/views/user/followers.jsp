<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Closetory - follow</title>

<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.js"></script>

<link href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
<!--리셋css-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/closet.css">
<!--리셋css-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/follow.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/myClosetSide.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerfooter.css"> <!--헤더 푸터css-->


</head>
<body>
	<div id="wrap">
		<!--header-->
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
		
		<div id="container">

			<!-- side profile&menu -->
			<c:import url="/WEB-INF/views/includes/sideProfileMenu.jsp"></c:import>
			
			<div id="follow-main">
				<div id="follow-menu" class="clearfix">
					<ul>
						<li class="page-follow"><a target="_self" href="${pageContext.request.contextPath}/followerfollowing/following">팔로잉</a></li>
						<li class="page-follow followers-active"><a target="_self" href="${pageContext.request.contextPath}/followerfollowing/followers">팔로워</a></li>
					</ul>
				</div>

				<div id="follow-content" class="clearfix">
					<div class="user">
						<c:forEach items="${followersList }" var="followersVo">
							<div class="users">
								<a href="${pageContext.request.contextPath}/mycloset/${followersVo.id }/main">
									&nbsp;&nbsp;&nbsp;&nbsp;
									<img class="profile" src="${pageContext.request.contextPath}/profile/${followersVo.profileImg}">
									${followersVo.nickName }(${followersVo.id })님
								</a>
							</div>
						</c:forEach>
					</div>
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