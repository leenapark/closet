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
		<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerfooter.css"> <!--헤더 푸터css-->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/myClosetSide.css"> <!--사이드css-->
		
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
						<span id="closet-menu-title">위시리스트</span>
					</div>
					
					<div id="main-middle" class="clearfix">
						<c:forEach items="${pMap.wishList}" var="vo">
							<div class="wishImgBox" data-id="${vo.id}" data-writer="${vo.nickName}" data-content="${vo.content}" data-imgname="${vo.boardImg}">
								<c:if test="${sessionScope.myRoomVo.id == sessionScope.authMember.id}">
									<img data-wishno="${vo.wishNo}" class="delBtn" src="${pageContext.request.contextPath}/assets/images/delete.jpg">
								</c:if>
								<img class="wishImg"src="${pageContext.request.contextPath}/upload/${vo.boardImg}">
							</div>
						</c:forEach>
						
					</div>
					
					<div style="text-align: center;">
						<nav>
							<ul class="pagination pagination-lg">
								<c:if test="${pMap.prev == true }">
									<li>
										<a href="${pageContext.request.contextPath}/mycloset/${sessionScope.myRoomVo.id}/wishList?crtPage=${pMap.startPageBtnNo-1}" aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a>
									</li>
								</c:if>
								<c:forEach begin="${pMap.startPageBtnNo}" end = "${pMap.endPageBtnNo}" step="1" var="page">
									<li><a href="${pageContext.request.contextPath}/mycloset/${sessionScope.myRoomVo.id}/wishList?crtPage=${page}">${page}</a></li>
								</c:forEach>
								<c:if test="${pMap.next == true }">
									<li>
										<a href="${pageContext.request.contextPath}/mycloset/${sessionScope.myRoomVo.id}/wishList?crtPage=${pMap.endPageBtnNo+1}" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a>
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
		
		<div class="modal fade" id="wishModal">
		  <div class="modal-dialog" style="width: 400px; top: 100px; left: 150px;">
		    <div class="modal-content">
		    	<div class="modal-body" style="">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <div id="wishImgModalDiv" style="margin: 30px auto 20px auto;">
			        	<img id="wishImgModal" class="wishImgModalFit">
			        </div>
			      	<div style="margin-bottom: 20px; position: relative; left: 30px;">
			      		<span style="font-size: 15px; padding: 10px 20px; border-radius: 6px; background-color:#BFBFBF;color: white;">작성자</span>
			      		<a id="wishWriter" style="display:inline-block; margin-left:25px; font-size: 15px; font-weight: 900;"></a>
			      	</div>
			      	
			      		
			      	<div class="clearfix" style="border: 1px solid black; border-radius: 10px; width: 300px; height: 120px; margin: 0px auto; padding: 2px; font-size: 15px;">
			      		<p style="float:left; font-size: 15px; padding: 10px 20px; border-radius: 6px; background-color:#BFBFBF;color: white; margin-right: 10px;">코멘트</p>
			  			<p id="wishContent" style="word-break:break-all;">
		      			</p>
		      		</div>			      	
		      	</div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		
		<c:import url="/WEB-INF/views/includes/deleteMessage.jsp"></c:import>
		
	</body>
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/includes/common.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/includes/sideMenu.jsp"></script>
	
	<script type="text/javascript">
	
	$(".delBtn").on("click",function(e){
		$("#delModal").modal();
		e.stopPropagation();
		var delWishNo = $(this).data("wishno");
		$("#modalDelBtn").on("click",function(){
			location.href = "${pageContext.request.contextPath}/mycloset/${sessionScope.authMember.id}/wishList/deleteWishList?wishNo="+delWishNo;
		})
	});
	
	$(".wishImgBox").on("click",function(){
		$("#wishModal").modal();
		$("#wishWriter").text($(this).data("writer"));
		$("#wishContent").text($(this).data("content"));
		$("#wishImgModal").attr("src","${pageContext.request.contextPath}/upload/"+$(this).data("imgname"));
		$("#wishWriter").attr("href","${pageContext.request.contextPath}/mycloset/"+$(this).data("id")+"/main");
	});
	
	$(".wishImgBox").hover(function(){
		$(this).children(".delBtn").stop().animate({
			opacity: 1
		},300);
	},function(){
		$(this).children(".delBtn").stop().animate({
			opacity: 0
		},300);
	});
		
	</script>

</html>

