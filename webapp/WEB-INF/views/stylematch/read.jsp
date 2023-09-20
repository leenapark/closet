<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerfooter.css">
<!--리셋css-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/codiboard.css">

</head>
<body>
	<div id="wrap">
		<!--header-->
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
		
		<!-- 오늘날짜 -->
		<c:set var="today" value="<%=new java.util.Date()%>"/>
		<!-- formatDate : 날짜 타입을 해당 패턴으로 변환한다.  -->
		<fmt:formatDate var="now" type="date" value="${today}" pattern="yy.MM.dd"/>
		
		<div class="location">STYLE MATCH > 글읽기</div>

		<div id="codi_readBox">
			<!-- 제목, 요청기한 -->
			<div class="title_name gray_boader_box">제목</div>
			<div class="title gray_boader_box2"> ${boardOne.title}</div>
			<div class="date_limit gray_boader_box">작성자</div>
			<div class="editor gray_boader_box2"><a href="${pageContext.request.contextPath}/mycloset/${boardOne.userId}/main">${boardOne.nickName}</a></div>

			<div class="codi_drag gray_boader_box">
				<img class="radius10" src="${pageContext.request.contextPath}/upload/${boardOne.boardImg}">
			</div>
			<div class="closet_drag gray_boader_box">${boardOne.content}</div>

		</div>
		


		<div id="codi_box">
			<div class="coment_box">
			
			<button class="return"  type="button" onclick="location.href='${pageContext.request.contextPath}/styleMatch/codi'" style="board:1px solid #ccc; color:#333;">목록</button>
			<!-- 본인글에서는 답글을 달 수 없음 , 비로그인시에도 답글 달 수 없음 , 답글에 채택된 글이 있을때도 답글 달 수 없음, 데드라인이 넘어도 답글 달수 없음  -->
			<c:if test="${sessionScope.authMember.userNo != boardOne.userNo && sessionScope.authMember ne null && adopt == 0 && boardOne.deadline >= now}">
				<button class="codi_coment_btn"  type="button" onclick="location.href='${pageContext.request.contextPath}/styleMatch/reCodiWrite?boardUserNo=${boardOne.userNo}&boardNo=${boardOne.boardNo}&boardImg=${boardOne.boardImg}'">답글달기</button>
			</c:if>

				<!--
				<p>
					<span>최신순</span> 좋아요순 
				</p>
				-->
				<!-- 슨서 정렬 -->
				 	<div role="tabpanel" >
						<div id="tabArea" class="clearfix" role="tabpanel">
						<!-- Nav tabs -->
						<ul class="nav nav-tabs blue_order" role="tablist"  style="border:none;">
							<li role="presentation" class="active">
								<a href="#recency" aria-controls="recency_order" role="tab" data-toggle="tab" data-order="recency" >최신순</a>
							</li>
							<li role="presentation">
								<a href="#like_order" aria-controls="like_oreder" role="tab" data-toggle="tab"  data-order="like"  >좋아요순</a>
							</li>
						</ul>

						<!-- Tab panes -->
						<div class="tab-content">

							<!-- 반복영역 -->
							<div role="tabpanel" class="tab-pane active p00" id="recency">
								<ul class="codi_line">
					
									<!-- 이미지 반복 영역 -->
									<c:forEach items="${reBoardList}" var="vo">
										<li>
											<div class="codi_row row_m45">
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
							                                       <a href="${pageContext.request.contextPath}/followerfollowing/checkFollow?following=${vo.userNo}" class="follow_btn follow_box" style="color:#fff;">팔로우</a> 
							                                    </c:otherwise>
							                                 </c:choose>				
														</c:if>
													<i class="fa fa-bookmark-o btnWishlist" data-matchimg="${vo.matchImg}" data-matchno="${vo.matchNo}" aria-hidden="true"></i>
												</div>
												<div class="row02_back gray_boader_box showModal" data-good="${vo.good}"data-matchno="${vo.matchNo}" data-content="${vo.content}" data-matchimg="${vo.matchImg}" data-title="${vo.title}" data-userno="${vo.userNo}"  data-boardno="${vo.boardNo }" data-adopt="${vo.adopt}">
													<c:if test="${vo.userNo == sessionScope.authMember.userNo}">
														<img src="${pageContext.request.contextPath}/assets/images/delete02.png" onclick="location.href='${pageContext.request.contextPath}/styleMatch/deleteReply?matchNo=${vo.matchNo}&boardNo=${vo.boardNo}'">
													</c:if>
													<p>${vo.title}</p>
												</div>
												<img class="row02" src="${pageContext.request.contextPath}/upload/${vo.matchImg}">
												<div class="re_row03">
													<i class="fa fa-heart-o" aria-hidden="true"> ${vo.good}</i>
													<i class="fa fa-frown-o" aria-hidden="true"> ${vo.hate}</i> 
													<i class="fa fa-comment-o" aria-hidden="true"> ${vo.reCount}</i>
												</div>
												
													<c:if test="${vo.adopt == 'Y'}">
														<div class="row04">
															<i class="fa fa-check" aria-hidden="true">채택완료</i>		
														</div>						
													</c:if>
											</div>
										</li>
									</c:forEach>
									
								</ul>
								<div class="clear"></div>
								
								<!--paging-->
								<div style="text-align: center;">
									<nav id="paging">
										<ul class="pagination pagination-lg">
												<c:if test="${pMap.prev == true }">
													<li><a href="${pageContext.request.contextPath}/styleMatch/${boardNo}/codiRead?adopt=${pMap.adopt}&crtPage=${pMap.startPageNo-1}" aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a></li>
												</c:if>
												<c:forEach begin="${pMap.startPageNo}" end="${pMap.endPageNo}" step="1" var="page">
													<li><a href="${pageContext.request.contextPath}/styleMatch/${boardNo}/codiRead?adopt=${pMap.adopt}&crtPage=${page}">${page}</a></li>
												</c:forEach>
												<c:if test="${pMap.next == true }">
													<li><a href="${pageContext.request.contextPath}/styleMatch/${boardNo}/codiRead?adopt=${pMap.adopt}&crtPage=${pMap.endPageNo+1}&gender=male" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
												</c:if>
										</ul>
									</nav>
								</div>
							</div>
							
							
							
							<div role="tabpanel" class="tab-pane p00" id="like_order">
								<ul class="codi_line">
					
									<!-- 이미지 반복 영역 -->
									<c:forEach items="${reBoardList}" var="vo">
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
							                                       <a href="${pageContext.request.contextPath}/followerfollowing/checkFollow?following=${vo.userNo}" class="follow_btn">팔로우</a> 
							                                    </c:otherwise>
							                                 </c:choose>				
														</c:if>
													<i class="fa fa-bookmark-o btnWishlist" aria-hidden="true"></i>
												</div>
												<div class="row02_back gray_boader_box showModal" data-matchno="${vo.matchNo}"data-content="${vo.content}" data-matchimg="${vo.matchImg}" data-title="${vo.title}" data-userno="${vo.userNo}"  data-boardno="${vo.boardNo }" data-adopt="${vo.adopt}">
													<c:if test="${vo.userNo == sessionScope.authMember.userNo}">
														<img src="${pageContext.request.contextPath}/assets/images/delete02.png" class="delBtn" onclick="location.href='${pageContext.request.contextPath}/styleMatch/deleteReply?matchNo=${vo.matchNo}&boardNo=${vo.boardNo}'">
													</c:if>
													<p>${vo.title}</p>
												</div>
												<img class="row02" src="${pageContext.request.contextPath}/upload/${vo.matchImg}">
												<div class="re_row03">
													<i class="fa fa-heart-o" aria-hidden="true"> ${vo.good}</i>
													<i class="fa fa-frown-o" aria-hidden="true"> ${vo.hate}</i> 
													<i class="fa fa-comment-o" aria-hidden="true"> ${vo.reCount}</i>
												</div>
												
													<c:if test="${vo.adopt == 'Y'}">
														<div class="row04">
															<i class="fa fa-check" aria-hidden="true">채택완료</i>		
														</div>						
													</c:if>
											</div>
										</li>
									</c:forEach>
									
								</ul>
								
								<div class="clear"></div>
								
								<!--paging-->
								<div style="text-align: center;">
									<nav id="paging">
										<ul class="pagination pagination-lg">
												<c:if test="${pMap.prev == true }">
													<li><a href="${pageContext.request.contextPath}/styleMatch/${boardNo}/codiRead?adopt=${pMap.adopt}&crtPage=${pMap.startPageNo-1}" aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a></li>
												</c:if>
												<c:forEach begin="${pMap.startPageNo}" end="${pMap.endPageNo}" step="1" var="page">
													<li><a href="${pageContext.request.contextPath}/styleMatch/${boardNo}/codiRead?adopt=${pMap.adopt}&crtPage=${page}">${page}</a></li>
												</c:forEach>
												<c:if test="${pMap.next == true }">
													<li><a href="${pageContext.request.contextPath}/styleMatch/${boardNo}/codiRead?adopt=${pMap.adopt}&crtPage=${pMap.endPageNo+1}&gender=male" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
												</c:if>
										</ul>
									</nav>
								</div>
								
							</div>

						</div>
					</div>
				
				
			</div>


		</div>
		<div class="clear"></div>

		<!--footer-->
		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>

	</div>
	</div>
	<!-- 이미지보기 팝업(모달)창 -->
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel"></h4>
				</div>
				<div class="modal-body">
					<img class="row02 gray_boader_box" id="modalImg" src="" style="height: 400px;">	
					
					<div class="text_box">
						<div class="text_top" id="modalContent"></div>
						<div class="re_text" style="overflow: auto;">
							<ul id="modal_re_div">
								
							</ul>
							
						</div>
						<!--
						<div class="icon_box">
							<i class="fa fa-heart-o" aria-hidden="true"> 10</i>
							<i class="fa fa-frown-o" aria-hidden="true"> 3</i>
							<i class="fa fa-bookmark-o" aria-hidden="true"></i>
						</div>
						  -->
						<c:choose>
							<c:when test="${sessionScope.authMember != null}">
								<input type="text" id="reReComment"><button class="white_box" id="reReBtn">등록</button><button data-matchcomno class="white_box" id="modiReReBtn">수정</button>
							</c:when>
							<c:otherwise>
								<p style="margin-top: 10px; font-size: 18px;">로그인을 해야 댓글을 작성하실 수 있습니다.</p>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="modal-footer" id="">
				
						<div class="icon_box float-l">
							<span class="black" id="modalGoodCount"></span>
							<span class="black" id="modalHateCount"></span>
							<!-- 
							<button  type="button" class="bookmark_btn gray_boader_box btn">
								 <i class="fa fa-bookmark-o btnWishlist" aria-hidden="true"> 위시리스트 저장  </i>  
							</button>
							-->
						</div>			
					
					<!-- 답글 작성자만 삭제할수 있음  -->
					<span id="modalDelSpan"></span>
						
					<!-- 부모글 작성자만 채택가능 , 채택완료시 더 채택할수 없음 -->
					<c:if test="${adopt == 0}">
						<span id="adopt_btn"></span>
					</c:if>
					<button type="button" class="btn btn-default gray_boader_box" data-dismiss="modal">닫기</button>				
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- 위시리스트 추가 모달 -->
	<div class="modal fade" id="wishlistModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">위시리스트</h4>
				</div>
				<div class="modal-body">
					<div>
						<img id="wishListModalImg" src="${pageContext.request.contextPath}/assets/images/testimg.jpg">
					</div>
					
					<div class="wish_comment_label">
					    <label class="gray_boader_box">코멘트</label>
					    <textarea id="wishComment" class="wish_comment gray_boader_box" rows="4"></textarea>
				  </div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="wishBtn">저장</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	
	<c:import url="/WEB-INF/views/includes/deleteMessage.jsp"></c:import>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/includes/common.js"></script>

<script type="text/javascript">

	var matchNo
	//답글 읽기 모달창 불러오기
	$('.showModal').on('click', function() {
		$("#myModal").modal();
		//대댓창 이전꺼 삭제
		$("#reReComment").val("");
		//수정 버튼 가리기
		$("#modiReReBtn").hide();
		//등록 버튼 보이기
		$("#reReBtn").show();
		
		
		$("#modalContent").text($(this).data("content"));
		$("#myModalLabel").text($(this).data("title"));
		
		//이미지 사이즈 안맞아서 강제로 크기 정했어요 style height:400px
		$("#modalImg").attr("src","${pageContext.request.contextPath}/upload/"+$(this).data("matchimg"));
		if("${sessionScope.authMember.userNo}"==$(this).data("userno")){
			$("#modalDelSpan").html('<button id="modalDelBtn" type="button" class="red_btn btn btn-primary" onclick="location.href='+"'"+"${pageContext.request.contextPath}"+'/styleMatch/deleteReply?matchNo='+$(this).data("matchno")+'&boardNo='+"${boardOne.boardNo}"+"'"+'">삭제</button>');
		}
		
		
		//채택 , 답글쓴 사람의 userNo를 전달해줘야함
		matchNo = $(this).data("matchno");
		console.log(matchNo);
		
		var userNo = $(this).data("userno");
		console.log(userNo);
		
		var boardNo = $(this).data("boardno");
		console.log(boardNo);
		
		goodSelect(matchNo);
		hateSelect(matchNo);
		
		$.ajax({
			url : "${pageContext.request.contextPath}/styleMatch/reReCommentList",
			type : "post",
			data : {
				matchNo : matchNo
			},
			dataType : "json",
			success : function(reReCommentList) {
				$("#modal_re_div").children().remove();
				for(i=0;i<reReCommentList.length;i++){
					reReCommentRender(reReCommentList[i]);
				}
			},
			//성공도 실패도 아닌 에러
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
		
		
		// 스타일 매칭 글쓴이만 채택할 수 있음 
		if("${sessionScope.authMember.userNo}" == "${boardOne.userNo}" && "${adopt}" == 0 ){
			
			$("#adopt_btn").html('<button type="button" id="clickAdoptBtn" class="btn btn-primary radius_btn">채택</button>');
			
			$("#clickAdoptBtn").on("click",function(){
				$.ajax({
					url : "${pageContext.request.contextPath}/styleMatch/reMatchAdopt",
					type : "post",
					data : {
						matchNo : matchNo,
						userNo : userNo,
						boardNo : boardNo
					},
					success : function(result) {
						window.location.href = result;
					},
					//성공도 실패도 아닌 에러
					error : function(XHR, status, error) {
						console.error(status + " : " + error);
					}
				});
			});
		}
				
		$('#myInput').focus();
		
	});
	
	function goodSelect(matchNo) {
		
		//ajax
		$.ajax({	
			url : "${pageContext.request.contextPath}/styleMatch/selectFeeling?emotion=1",		
			type : "post",
			//contentType : "application/json",
			data : {matchNo : matchNo},
					
			dataType : "json",
			success : function(goodMap){
				$("#spanLike").remove();
				$("#modalGoodCount").text(goodMap.good);
				renderGood(goodMap,matchNo);
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});	
		
	}
	
	function hateSelect(matchNo) {
		
		//ajax
		$.ajax({	
			url : "${pageContext.request.contextPath}/styleMatch/selectFeeling?emotion=2",		
			type : "post",
			data : {matchNo : matchNo},
					
			dataType : "json",
			success : function(hateMap){
				$("#spanHate").remove();
				$("#modalHateCount").text(hateMap.hateCount);
				renderHate(hateMap,matchNo);
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});	
		
	}
	function renderHate(hateMap, matchNo) {
		var hate = hateMap.hate;
		
		var str = '';
		
		if (hate == "hate") {
			str += '<span id="spanHate" data-feelingNo="'+hateMap.feelingNo+'" data-like="' + hate + '">';
			str += '		<i class="fa fa-frown-o red" aria-hidden="true">';
			str += '		</i>';
			str += '</span>';
		} else if (hate = "nohate") {
			str += '<span id="spanHate" data-like="' + hate + '">';
			str += '		<i class="fa fa-frown-o" aria-hidden="true"></i>';
			str += '</span>';
		}

		$("#modalHateCount").before(str);
		
		$("#spanHate").on("click",function(){
			like = $(this).data("like");
			if (like == "hate") {
				$.ajax({	
					url : "${pageContext.request.contextPath}/styleMatch/deleteFeeling?emotion=2",		
					type : "post",
					data : {feelingNo : hateMap.feelingNo},
							
					dataType : "json",
					success : function(result){
						hateSelect(matchNo);
					},
					error : function(XHR, status, error) {
						console.error(status + " : " + error);
					}
				});	
			} else if (like = "nohate") {
				$.ajax({	
					url : "${pageContext.request.contextPath}/styleMatch/insertFeeling?emotion=2",		
					type : "post",
					//contentType : "application/json",
					data : {matchNo : matchNo},
							
					dataType : "json",
					success : function(result){
						hateSelect(matchNo);
					},
					error : function(XHR, status, error) {
						console.error(status + " : " + error);
					}
				});
			}
		});
	}

	function renderGood(goodMap, matchNo) {
		var like = goodMap.like;
		
		var str = '';
		
		if (like == "like") {
			str += '<span id="spanLike" data-feelingNo="'+goodMap.feelingNo+'" data-like="' + like + '">';
			str += '		<i class="fa fa-heart red">';
			str += '		</i>';
			str += '</span>';
		} else if (like = "unlike") {
			str += '<span id="spanLike" data-like="' + like + '">';
			str += '		<i class="fa fa-heart-o red"></i>';
			str += '</span>';
		}

		$("#modalGoodCount").before(str);
		
		$("#spanLike").on("click",function(){
			like = $(this).data("like");
			if (like == "like") {
				$.ajax({	
					url : "${pageContext.request.contextPath}/styleMatch/deleteFeeling?emotion=1",		
					type : "post",
					//contentType : "application/json",
					data : {feelingNo : goodMap.feelingNo},
							
					dataType : "json",
					success : function(result){
						goodSelect(matchNo);
					},
					error : function(XHR, status, error) {
						console.error(status + " : " + error);
					}
				});	
			} else if (like = "unlike") {
				$.ajax({	
					url : "${pageContext.request.contextPath}/styleMatch/insertFeeling?emotion=1",		
					type : "post",
					//contentType : "application/json",
					data : {matchNo : matchNo},
							
					dataType : "json",
					success : function(result){
						goodSelect(matchNo);
					},
					error : function(XHR, status, error) {
						console.error(status + " : " + error);
					}
				});
			}
		});
	}
	//스타일 매칭 답글 위시리스트 아이콘 클릭시 위시리스트창 모달 띄우기
	$("#codi_box").on("click", ".btnWishlist", function(){
			
		if("${sessionScope.authMember}" == ""){
			alert("로그인을 해주십시오.");
		}else{
			matchNo = $(this).data("matchno");
			$("#wishlistModal").modal();
			$("#wishListModalImg").attr("src","${pageContext.request.contextPath}/upload/"+$(this).data("matchimg"));
		}
	});
	
	$("#wishBtn").on("click",function(){
		
		var content = $("#wishComment").val();
		
		if($("#wishComment").val().length<1){
			alert("코멘트를 입력해주세요!");
			return false;
		}
		
		$.ajax({
			url : "${pageContext.request.contextPath}/styleMatch/insertWishList",
			type : "post",
			data : {
				userNo : "${sessionScope.authMember.userNo}",
				matchNo : matchNo,
				content : content
			},
			success : function(result) {
				$("#wishComment").val("");
				$("#wishlistModal").modal("hide");
			},
			//성공도 실패도 아닌 에러
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
	});
	
	//대댓 달기
	$("#reReBtn").on("click",function(){
		
		var content = $("#reReComment").val();
		
		$.ajax({
			url : "${pageContext.request.contextPath}/styleMatch/insertReReComment",
			type : "post",
			data : {
				matchNo : matchNo,
				content : content,
				userNo : "${sessionScope.authMember.userNo}"
			},
			dataType : "json",
			success : function(reReCommentList) {
				$("#modal_re_div").children().remove();
				for(i=0;i<reReCommentList.length;i++){
					reReCommentRender(reReCommentList[i]);
				}
				$("#reReComment").val("");
			},
			//성공도 실패도 아닌 에러
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
	});
	
	function reReCommentRender(commentVo){
		
		var str='';
		str+='<li class="reReCommentLi" id="reReComment'+commentVo.matchComNo+'" data-matchcomno='+commentVo.matchComNo+'>'+'<div class="reRecommentDiv">'+commentVo.content+'</div>';
		str+='<div><div class="reReCommentWriter">작성자:'+commentVo.nickName+'</div>';
		if("${sessionScope.authMember.userNo}"==commentVo.userNo){
			str+='<div class="modiReReComments" id="modiReReComment'+commentVo.matchComNo+'">수정</div><div class="delReReComments" id="delReReComment'+commentVo.matchComNo+'">삭제</div>';
		}
		str+='</div>';
		str+='</li>';
		$("#modal_re_div").append(str);
		//대댓글 삭제
		$("#delReReComment"+commentVo.matchComNo).on("click",function(){
			$("#reReComment"+commentVo.matchComNo).remove();
			
			$.ajax({
				url : "${pageContext.request.contextPath}/styleMatch/deleteReReComment",
				type : "post",
				data : {
					matchComNo : commentVo.matchComNo
				},
				success : function() {
					
				},
				//성공도 실패도 아닌 에러
				error : function(XHR, status, error) {
					console.error(status + " : " + error);
				}
			});
		});
		
		//대대글 수정
		$("#modiReReComment"+commentVo.matchComNo).on("click",function(){
			$("#modiReReBtn").show();
			$("#reReBtn").hide();
			$("#reReComment").val(commentVo.content);
			
			$("#modiReReBtn").data("matchcomno",commentVo.matchComNo);
		});
	}
	
	$("#modiReReBtn").on("click",function(){

		$.ajax({
			url : "${pageContext.request.contextPath}/styleMatch/modiReReComment",
			type : "post",
			data : {
				matchComNo : $(this).data("matchcomno"),
				content : $("#reReComment").val(),
				matchNo: matchNo
			},
			dataType : "json",
			success : function(reReCommentList) {
				$("#modal_re_div").children().remove();
				for(i=0;i<reReCommentList.length;i++){
					reReCommentRender(reReCommentList[i]);
				}
				$("#reReComment").val("");
				$("#modiReReBtn").hide();
				$("#reReBtn").show();
			},
			//성공도 실패도 아닌 에러
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
	});
	
</script>

</html>
