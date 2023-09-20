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
		<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerfooter.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/codiboard.css">
		
	
	</head>
	<body>
		<div id="wrap">
		    <!--header-->
		    <c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
		    
		    <!-- 성별 분류별 상단 text -->
		   <c:if test="${gender == ''}">
	      	 <div class="location"  data-gender="${gender}">STYLE MATCH > 전체</div>
	       </c:if>
	       <c:if test="${gender == 'male'}">
	       	 <div class="location"  data-gender="${gender}">STYLE MATCH > 남성</div>
	       </c:if>
	       <c:if test="${gender == 'female'}">
	       	<div class="location"  data-gender="${gender}">STYLE MATCH > 여성</div>
	       </c:if>
	       <c:if test="${gender == 'unisex'}">
	       	<div class="location"  data-gender="${gender}">STYLE MATCH > 유니섹스</div>
	       </c:if>
			<!-- <div class="location">Style Match > 전체</div> -->
			
			<div id="contents" >
				<!--검색 , 글쓰기버튼  -->
				<form class="top_box">
					<select name="searchCate">
	         			<option value="none" selected>카테고리 선택</option>
	         			<option value="title">글제목</option>
	         			<option value="nickName">별명</option>
	         		</select>
					<input type="search" placeholder=" 검색어를 입력해주세요" name="keyword" value="">
					<button class="gray_btn blue_btn" id="btnSearch">검색</button>
					<button class="blue_btn write_btn" type="button" onclick="location.href='${pageContext.request.contextPath}/styleMatch/codiWrite?userNo=${sessionScope.authMember.userNo}'">
					<i class="fa fa-pencil-square-o" aria-hidden="true"></i> 글쓰기</button>
				</form>
			
				<div id="codi_box">
				
					<ul class="codi_line">
						
						<!-- 오늘날짜 -->
						<c:set var="today" value="<%=new java.util.Date()%>"/>
						<!-- formatDate : 날짜 타입을 해당 패턴으로 변환한다.  -->
						<fmt:formatDate var="now" type="date" value="${today}" pattern="yy.MM.dd"/>
						
						<!-- 이미지 반복 영역 -->
						<c:forEach items="${mList}" var="vo">
							<li>
								<div class="codi_row">
									<div class="row01">
										<a class="row01_nick" href="${pageContext.request.contextPath}/mycloset/${vo.userId}/main">${vo.nickName}</a> 
										
										<!-- 로그인시에만 팔로우 가능 , 본인도 팔로우 못함-->
										<c:if test="${sessionScope.authMember != null && sessionScope.authMember.userNo != vo.userNo }">
											<!-- 이미 팔로잉 되어잇는지 확인 -->
											<c:choose>
			                                    <c:when test="${vo.follower == authMember.userNo}">
			                                       <a href="${pageContext.request.contextPath}/followerfollowing/cancelFollow?following=${vo.userNo}" class="follow_btn">팔로잉</a> 
			                                    </c:when>
			                                    <c:otherwise>
			                                       <a href="${pageContext.request.contextPath}/followerfollowing/checkFollow?following=${vo.userNo}" class="follow_btn follow_box" style="color:#fff;" >팔로우</a> 
			                                    </c:otherwise>
			                                 </c:choose>

										</c:if>
										
									</div>
									<div class="row02_back gray_boader_box" onclick="location.href='${pageContext.request.contextPath}/styleMatch/${vo.boardNo}/codiRead?adopt=${vo.adopt} '">
										
										<c:if test="${sessionScope.authMember.userNo == vo.userNo}">
										<img class="delBtn" data-boardno="${vo.boardNo}" src="${pageContext.request.contextPath}/assets/images/delete02.png">
										</c:if>
										
										<p>${vo.title}</p>
									</div>
									<img class="row02" src="${pageContext.request.contextPath}/upload/${vo.boardImg}">
									<div class="row03">
										<!-- 채택이 아직 안됫을시  -->
										<c:if test="${vo.adopt eq  null}">
											<c:choose>
												<c:when test="${vo.deadline > now}">
													<i class="fa fa-calendar" aria-hidden="true"> ~ ${vo.deadline}</i>
												</c:when>
												<c:otherwise>
													<i class="fa fa-calendar" aria-hidden="true"> 기한만료</i>
												</c:otherwise>
											</c:choose>
										</c:if>
										
										<!-- 채택완료  -->
										<c:if test="${vo.adopt == 1}">
											<i class="fa fa-check" aria-hidden="true"> 채택완료</i>								
										</c:if>
									
										<i class="fa fa-comment-o" aria-hidden="true"> ${vo.reCount}</i>
									</div>
								</div>
							</li>
						</c:forEach>
						
					</ul>
					
				
				</div><!--//codi_box -->
				
				<div class="clear"></div>

			</div>
			<!--//contents -->
			
			<!--paging-->
			<div class="clear"></div>
      <!--paging-->
		<div style="text-align: center;">
			<nav id="paging">
				<ul class="pagination pagination-lg">
					<c:if test="${gender == 'male'}">
						<c:if test="${pMap.prev == true }">
							<li><a href="${pageContext.request.contextPath}/styleMatch/codi?crtPage=${pMap.startPageNo-1}&gender=male" aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a></li>
						</c:if>
						<c:forEach begin="${pMap.startPageNo}" end="${pMap.endPageNo}" step="1" var="page">
							<li><a href="${pageContext.request.contextPath}/styleMatch/codi?crtPage=${page}&gender=male">${page}</a></li>
						</c:forEach>
						<c:if test="${pMap.next == true }">
							<li><a href="${pageContext.request.contextPath}/styleMatch/codi?crtPage=${pMap.endPageNo+1}&gender=male" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
						</c:if>
					</c:if>
					<c:if test="${gender == 'female'}">
						<c:if test="${pMap.prev == true }">
							<li><a href="${pageContext.request.contextPath}/styleMatch/codi?crtPage=${pMap.startPageNo-1}&gender=female" aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a></li>
						</c:if>
						<c:forEach begin="${pMap.startPageNo}" end="${pMap.endPageNo}" step="1" var="page">
							<li><a href="${pageContext.request.contextPath}/styleMatch/codi?crtPage=${page}&gender=female">${page}</a></li>
						</c:forEach>
						<c:if test="${pMap.next == true }">
							<li><a href="${pageContext.request.contextPath}/styleMatch/codi?crtPage=${pMap.endPageNo+1}&gender=female" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
						</c:if>
					</c:if>
					<c:if test="${gender == 'unisex'}">
						<c:if test="${pMap.prev == true }">
							<li><a href="${pageContext.request.contextPath}/styleMatch/codi?crtPage=${pMap.startPageNo-1}&gender=unisex" aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a></li>
						</c:if>
						<c:forEach begin="${pMap.startPageNo}" end="${pMap.endPageNo}" step="1" var="page">
							<li><a href="${pageContext.request.contextPath}/styleMatch/codi?crtPage=${page}&gender=unisex">${page}</a></li>
						</c:forEach>
						<c:if test="${pMap.next == true }">
							<li><a href="${pageContext.request.contextPath}/styleMatch/codi?crtPage=${pMap.endPageNo+1}&gender=unisex" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
						</c:if>
					</c:if>
					<c:if test="${gender == ''}">
						<c:if test="${pMap.prev == true }">
							<li><a href="${pageContext.request.contextPath}/styleMatch/codi?crtPage=${pMap.startPageNo-1}" aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a></li>
						</c:if>
						<c:forEach begin="${pMap.startPageNo}" end="${pMap.endPageNo}" step="1" var="page">
							<li><a href="${pageContext.request.contextPath}/styleMatch/codi?crtPage=${page}">${page}</a></li>
						</c:forEach>
						<c:if test="${pMap.next == true }">
							<li><a href="${pageContext.request.contextPath}/styleMatch/codi?crtPage=${pMap.endPageNo+1}" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
						</c:if>
					</c:if>
				</ul>
			</nav>
		</div>

		
		    <!--footer-->
		    <c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
		
		</div> 
		
		<c:import url="/WEB-INF/views/includes/deleteMessage.jsp"></c:import>
		
	</body>
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/includes/common.js"></script>
	
	
	<script type="text/javascript">
	
	
	//삭제기능('N'을 'Y'로 업데이트)
	$(".delBtn").on("click",function(e){
		$("#delModal").modal();
		e.stopPropagation();
		
		var delBoardNo = $(this).data("boardno");
		$("#modalDelBtn").on("click",function(){
			location.href = "${pageContext.request.contextPath}/styleMatch/codiDelete?boardNo="+delBoardNo;
		})
	});
	
	
	//글쓰기 버튼  - 로그인 하지 않았을 경우
	$(".top_box").on("click" , ".write_btn" , function(){
		
		console.log("글쓰기 버튼 클릭");
		
		if("${authMember}" == ""){
			alert("로그인 후 글쓰기가 가능합니다. 로그인해주세요.");		
			window.location.href = "${pageContext.request.contextPath}/styleMatch/codi";
			//return false
		}
		
		
	})
	
		
	</script>

</html>

