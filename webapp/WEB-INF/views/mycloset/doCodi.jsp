<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<!--한국어 문서만 검색 음성지원할때-->
<head>
<meta charset="UTF-8">
<!--브라우저가 문서를 해설할때 필요한 정보-->
<title>Closetory</title>


<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.js"></script>

<link href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
<!--리셋css-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/doCodi.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerfooter.css">
<!--헤더 푸터css-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/myClosetSide.css">
<!--사이드css-->


</head>

<body>
	<div id="wrap">
		<!--header-->
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>

		<div id="container">

			<!-- side profile&menu -->
			<c:import url="/WEB-INF/views/includes/sideProfileMenu.jsp"></c:import>

			<div id="codiMain" class="clearfix">
				<div id="main-top">
					<span id="closet-menu-title">코디하기</span>

					<c:if test="${myRoomVo.id == authMember.id}">
						<button id="btn-fill-closet" class="btn btn-info float-r writeBtn"
							onclick="location.href='${pageContext.request.contextPath}/mycloset/${myRoomVo.id}/codiWriteForm'">
								<i class="fa fa-pencil-square-o" aria-hidden="true"> 글쓰기</i> </button>
					</c:if>
				</div>

				<div id="main-middle">

					<!--셀렉트 박스  -->
					<div class="float-r">
						<select onChange="window.open(value, '_self');" class="selet_box">
							<option value="${pageContext.request.contextPath}/mycloset/${myRoomVo.id}/doCodi">전체</option>
							<option value="${pageContext.request.contextPath}/mycloset/${myRoomVo.id}/doCodi?listType=1" <c:if test="${param.listType == 1}">selected</c:if>>코디하기</option>
							<option value="${pageContext.request.contextPath}/mycloset/${myRoomVo.id}/doCodi?listType=2" <c:if test="${param.listType == 2}">selected</c:if>>트렌드세터</option>
						</select>
					</div>

					<div class="clear"></div>

					<div id="codi_box">

						<ul class="codi_line">
							<!-- 이미지 반복 영역 -->
							<c:forEach items="${pMap.codiList}" var="codiBoardVo">
								<li>
									<c:if test="${myRoomVo.id == authMember.id}">
										<c:choose>
											<c:when test="${codiBoardVo.openFlag == 'Y'}">
												<div class="float-r">
													<p id="openStat${codiBoardVo.boardNo}" class="openStat">공개</p>
													<label class="switch"> <input type="checkbox" checked="checked" data-openflag="${codiBoardVo.openFlag}" data-no="${codiBoardVo.boardNo}" data-tsno="${codiBoardVo.trendSetterNo}">
														<span class="slider round"> </span>
													</label>
												</div>
											</c:when>
											<c:otherwise>
												<div class="float-r">
													<p id="openStat${codiBoardVo.boardNo}" class="openStat">비공개</p>
													<label class="switch"> <input type="checkbox" data-openflag="${codiBoardVo.openFlag}" data-no="${codiBoardVo.boardNo}" data-tsno="${codiBoardVo.trendSetterNo}">
													<span class="slider round"> </span>
													</label>
												</div>
											</c:otherwise>
										</c:choose>
									</c:if>

									<div class="clear"></div>

									<div class="codi_row">
										<a href="${pageContext.request.contextPath}/mycloset/${myRoomVo.id}/readCodi?no=${codiBoardVo.boardNo}"> <img class="row02"
											src="${pageContext.request.contextPath}/upload/${codiBoardVo.boardImg}">
										</a>

										<c:if test="${codiBoardVo.trendSetterNo != 0}">
											<div class="row03">
												<a href="${pageContext.request.contextPath}/trendSetter/readTrendSetter?boardNo=${codiBoardVo.trendSetterNo}"> <i class="fa fa-star" aria-hidden="true" style="color:orange;"></i>
												</a> <i class="fa fa-comment-o" aria-hidden="true"> ${codiBoardVo.reCount}</i>
											</div>
										</c:if>
									</div></li>
							</c:forEach>

						</ul>

					</div>
					<!--//codi_box -->


				</div>
				<!--//main-middle -->

				<div class="clear"></div>

				<div id="main-bottom">
					<!--paging-->
					<nav>
						<ul class="pagination pagination-lg">
							<c:if test="${pMap.prev == true }">
								<li><a href="${pageContext.request.contextPath}/mycloset/${myRoomVo.id}/doCodi?listType=${param.listType}&crtPage=${pMap.startPageNo-1}"
									aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a></li>
							</c:if>
							<c:forEach begin="${pMap.startPageNo}" end="${pMap.endPageNo}" step="1" var="page">
								<li><a href="${pageContext.request.contextPath}/mycloset/${myRoomVo.id}/doCodi?listType=${param.listType}&crtPage=${page}">${page}</a></li>
							</c:forEach>
							<c:if test="${pMap.next == true }">
								<li><a href="${pageContext.request.contextPath}/mycloset/${myRoomVo.id}/doCodi?listType=${param.listType}&crtPage=${pMap.endPageNo+1}"
									aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
							</c:if>
						</ul>
					</nav>
				</div>
				<!--//main-bottom-->
			</div>

			<div class="clear"></div>

		</div>

		<!--footer-->
		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
	</div>

</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/includes/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/includes/sideMenu.jsp"></script>

<script type="text/javascript">
	var openFlag;
	$("#codi_box ul li div label input").on("click", function(e) {

		var boardNo = $(this).data("no");
		var openFlag = $(this).data("openflag");
		var trendSetterNo = $(this).data("tsno");

		if (openFlag == "Y") {
			
			if(trendSetterNo > 0){
				alert("TREND SETTER에 등록된 글이여서 비공개로 설정할 수 없습니다.");
				e.preventDefault()
				
			}else{
				
				
				$(this).data("openflag", "N");
				$("#codi_box ul li div #openStat" + boardNo).html("비공개");
				setOpenStat(boardNo, "N");	
			}
			
		} else {
			$(this).data("openflag", "Y");
			$("#codi_box ul li div #openStat" + boardNo).html("공개");
			setOpenStat(boardNo, "Y");
		}
	});

	function setOpenStat(boardNo, openStat) {

		$.ajax({
			url : "${pageContext.request.contextPath }/mycloset/${authMember.id}/setOpenStat",
			type : "post",
			//contentType : "application/json",
			data : {
				boardNo : boardNo,
				openFlag : openStat
			},
			/*여기까지 보낼때 */

			/*여기부터 받을 때*/
			dataType : "json",
			success : function(result) {
				/*성공시 처리해야될 코드 작성*/
				console.log(result);
			},
			//성공도 실패도 아닌 에러
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
	}
</script>

</html>

