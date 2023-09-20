<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko"><!--한국어 문서만 검색 음성지원할때-->
	<head>
	    <meta charset="UTF-8"> <!--브라우저가 문서를 해설할때 필요한 정보-->
	    <title>Closetory</title>
	    
	    
	    <script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.js"></script>
	    
	    <link href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css"> <!--리셋css-->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/closet.css"> <!--리셋css-->
		
		
	</head>
	
	<body>
		<div id="wrap">
		    <!--header-->
		    <c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
	
			<div id="container">
			
				<!-- side profile&menu -->
				<c:import url="/WEB-INF/views/includes/sideProfileMenu.jsp"></c:import>
						
				<div id="main">
					<div id="main-top">
						<span id="closet-menu-title">옷장 ></span>
						<span id="closet-category">전체</span>
						<button id="btn-fill-closet">옷장 채우기</button>
					</div>
					<div id="main-middle" class="clearfix">
						
						
					</div>
					<c:import url="/WEB-INF/views/includes/paging.jsp"></c:import>
				</div>
				
			
		    </div>
			
		    <!--footer-->
		    <c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
		</div> 
	</body>
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/includes/common.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/includes/sideMenu.js"></script>
	
	<script type="text/javascript">
	
		
		
	</script>

</html>

