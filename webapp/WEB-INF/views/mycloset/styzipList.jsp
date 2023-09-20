<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko"><!--한국어 문서만 검색 음성지원할때-->
	<head>
	    <meta charset="UTF-8"> <!--브라우저가 문서를 해설할때 필요한 정보-->
	    <title>Closetory</title>
	    
	    
	    <script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.js"></script>
	    
	    <link href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css"> <!--리셋css-->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/closet.css"> <!--옷장css-->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerfooter.css"> <!--헤더 푸터css-->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/myClosetSide.css"> <!--사이드css-->		
		<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/codiboard.css"> <!--코디보드css-->
	</head>
	
	<body>
		<div id="wrap">
		    <!--header-->
		    <c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
	
			<div id="container" class="clearfix">	
				<!-- side profile -->
				<c:import url="/WEB-INF/views/includes/sideProfileMenu.jsp"></c:import>
				
				<div id="main">
					<div id="main-top">
						<span id="closet-menu-title">코디구함 작성 글</span>
					</div>
					<div id="codiGuhamCateDiv">
						<select id="codiGuhamCate" class="selet_box" name="codiGuhamCategory">
							<option value="0">전체</option>
							<option value="1">기한만료</option>
							<option value="2">진행중</option>
							<option value="3">채택완료</option>
						</select>
					</div>
					
					<div id="main-middle" class="clearfix">
						<div id="codi_box" style="width: 100%">
							<ul class="codi_line">
								
								<!-- 오늘날짜 -->
								<c:set var="today" value="<%=new java.util.Date()%>"/>
								<!-- formatDate : 날짜 타입을 해당 패턴으로 변환한다.  -->
								<fmt:formatDate var="now" type="date" value="${today}" pattern="yy.MM.dd"/>
							
								<!-- 이미지 반복 영역 -->
								<c:forEach items="${pMap.codiBoardList}" var="vo">
								<li>
									<div class="codi_row" style="margin: 10px 5px;">
										<div class="row02_back gray_boader_box" onclick="location.href='${pageContext.request.contextPath}/styleMatch/${vo.boardNo}/codiRead'">
											<img class="delBtn" data-boardno="${vo.boardNo}" src="${pageContext.request.contextPath}/assets/images/delete02.png">
											<p>${vo.title}</p>
										</div>
										<img class="row02" src="${pageContext.request.contextPath}/upload/${vo.boardImg}">
										<div class="row03">
											<c:choose>
												<c:when test="${vo.adopt eq  null}">
													<c:choose>
														<c:when test="${vo.deadline > now}">
															<i class="fa fa-calendar" aria-hidden="true"> ~ ${vo.deadline}</i>
														</c:when>
														<c:otherwise>
															<i class="fa fa-calendar" aria-hidden="true"> 기한만료</i>
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<i class="fa fa-check" aria-hidden="true"> 채택완료</i>
												</c:otherwise>
											</c:choose>
											
											<i class="fa fa-comment-o" aria-hidden="true"> ${vo.reCount}</i>
										</div>
									</div>
								</li>
								</c:forEach>
							</ul>
						</div>
					</div>
					<div style="text-align: center;">
						<nav>
							<ul class="pagination pagination-lg">
								<c:if test="${pMap.prev == true }">
									<li>
										<a href="${pageContext.request.contextPath}/mycloset/${sessionScope.myRoomVo.id}/styzipList?categoryNo=${requestScope.categoryNo}&crtPage=${pMap.startPageBtnNo-1}" aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a>
									</li>
								</c:if>
									<c:forEach begin="${pMap.startPageBtnNo}" end = "${pMap.endPageBtnNo}" step="1" var="page">
										<li><a href="${pageContext.request.contextPath}/mycloset/${sessionScope.myRoomVo.id}/styzipList?categoryNo=${requestScope.categoryNo}&crtPage=${page}">${page}</a></li>
									</c:forEach>
								<c:if test="${pMap.next == true }">
									<li>
										<a href="${pageContext.request.contextPath}/mycloset/${sessionScope.myRoomVo.id}/styzipList?categoryNo=${requestScope.categoryNo}&crtPage=${pMap.endPageBtnNo+1}" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a>
									</li>
								</c:if>
							</ul>
						</nav>
					</div>
				</div>
		    </div>
		    <!--footer-->
		     <c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
		</div>
		
		<c:import url="/WEB-INF/views/includes/deleteMessage.jsp"></c:import>
		
	</body>
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/includes/common.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/includes/sideMenu.jsp"></script>
	
	<script type="text/javascript">
	$(".delBtn").on("click",function(e){
		$("#delModal").modal();
		e.stopPropagation();
		var delBoardNo = $(this).data("boardno");
		$("#modalDelBtn").on("click",function(){
			location.href = "${pageContext.request.contextPath}/mycloset/${sessionScope.authMember.id}/styzipList/deletestyzipList?boardNo="+delBoardNo;
		})
	});
	
		$(document).ready(function(){
			var cate = "${requestScope.categoryNo}"
			if(cate == 0){
				$("#codiGuhamCate").val(0).prop("selected",true);
			}else if(cate == 1){
				$("#codiGuhamCate").val(1).prop("selected",true);
			}else if(cate == 2){
				$("#codiGuhamCate").val(2).prop("selected",true);
			}else if(cate == 3){
				$("#codiGuhamCate").val(3).prop("selected",true);
			}	
		});
		
		
		$("#codiGuhamCate").on("change",function(){
			location.href="${pageContext.request.contextPath}/mycloset/${sessionScope.myRoomVo.id}/styzipList?categoryNo="+$(this).val();
		})
	</script>

</html>

