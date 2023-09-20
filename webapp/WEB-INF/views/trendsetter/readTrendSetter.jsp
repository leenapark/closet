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
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerfooter.css"> <!--헤더 푸터css-->

</head>

<body>
	<div id="wrap">
		<!--header-->
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>

		<div id="container">

			<div id="main" class="clearfix">
				<div id="main-topline">
					<span id="closet-menu-title">TREND SETTER ></span> <span id="closet-category">글읽기</span>
				</div>

				<div class="clear"></div>

				<div id="main-middle" class="clearfix">
					<c:if test="${sessionScope.authMember != null && authMember.userNo != tsMap.trendSetterVo.userNo}">
						<button id="writeBestdresser" class="btn float-r">위시리스트 저장</button>
					</c:if>
						<input type="hidden" id="codiBoardNo" data-boardno="${tsMap.trendSetterVo.boardNo}">
						<div id="like" class="float-r" data-like="${tsMap.heart}">
							<div id="goodCnt">${tsMap.goodCnt}</div>
						</div>


					<div class="clear"></div>

					<div class="form-group">
						<label for="bestDresserTitle" class="formTitle">제목</label> <input type="text"
							id="bestDresserTitle" value="${tsMap.trendSetterVo.title}" placeholder="" readonly>
						<div id="writerLabel">작성자</div>
						<div id="bestDresserWriter" class="float-r">${tsMap.trendSetterVo.nickName}</div>
					</div>

					<div id="imgArea" class="float-l borderCodi">
						<img src="${pageContext.request.contextPath}/upload/${tsMap.trendSetterVo.boardImg}">
					</div>

					<div id="codiContent" class="float-r borderCodi">
						<div class="clear"></div>
						<p>${tsMap.trendSetterVo.content}</p>

					</div>

					<div class="clear"></div>

					<div id="tagArea" class="float-l">
						<ul>
							<c:forEach items="${tsMap.tagList}" var="tagList">
								<li>${tagList.tagName}</li>
							</c:forEach>
						</ul>
					</div>
					
					<div id="buttonArea" class="float-r">
						<c:if test="${sessionScope.authMember.nickName eq tsMap.trendSetterVo.nickName}">
							<button id="bestDresserDel" class="myDel btn-danger float-l">삭제</button>
						</c:if>
							<button id="bestDresserList" class="return btn-default float-l" onclick="location.href='${pageContext.request.contextPath}/trendSetter/trendSetterList'">목록</button>
					</div>
				</div>
				
				<div id="main-foot" class="clearfix">
					<!-- 답글 입력부분 -->
					<c:choose>
						<c:when test="${empty authMember}">
							<div id="replyWriteForm-unlogin">
								<div class="replyWriter">비회원</div>
								<div id="replyInput">댓글을 작성하려면 <a href="${pageContext.request.contextPath}/user/loginform">로그인</a> 해주세요.<br> &nbsp; </div>
								<div class="clear"></div>				
							</div>
						</c:when>
						
						<c:otherwise>
							<div id="replyWriteForm-login">
								<div class="replyWriter">${authMember.nickName}</div>
								<textarea id="replyInput" rows="3" placeholder="원하는 내용을 입력해 주세요."></textarea>
								<button class="insert float-r">등록</button>	
								<div class="clear"></div>				
							</div>
						</c:otherwise>
						
					</c:choose>
					
					<div id="replyList">
						<ul>
							<!-- 답글 리스트 영역 -->
						</ul>					
					</div>
					
					<div class="clear"></div>
					
					<!-- 댓글 더보기 위치 -->
					
				</div>

			</div>


		</div>

		<!--footer-->
		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
	</div>
	
	<!-- 삭제버튼 클릭시 모달창 -->
	<div class="modal fade" id="boardDelModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">경고 메세지</h4>
				</div>
				<form action="${pageContext.request.contextPath}/trendSetter/deleteTrendSetter?boardNo=${tsMap.trendSetterVo.boardNo}" method="post">
					<div class="modal-body">
						<h4>한 번 삭제한 게시글을 되돌릴 수 없습니다. 정말 삭제하시겠습니까?</h4>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-primary">삭제</button>
					</div>
				</form>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	
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
                  <div id="imgDiv">
                     <img id="wishListImg" src="">
                  </div>
                  
                  <div class="form-group">
                      <label>코멘트</label>
                      <textarea class="commentForm" rows="4"></textarea>
                    </div>
                    
                    <input type="hidden" id="wishListBoardNo" value="">
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                  <button type="button" class="btn btn-primary" id="wishListAdd">저장</button>
               </div>
            </div>
            <!-- /.modal-content -->
      </div>
      <!-- /.modal-dialog -->
   </div>
   <!-- /.modal -->
</body>


<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/includes/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/includes/sideMenu.js"></script>

<script type="text/javascript">
	
	var getCmtCnt = 5; //출력할 댓글 수 = 5 
	
	$("document").ready(function() {
	
		var boardNo = $("#codiBoardNo").data("boardno");
		
		var cmtPrintCnt = 0;//출력된 댓글  수
			
		console.log("도큐먼트 boardNo : " + boardNo);

		commentTS(boardNo, getCmtCnt, cmtPrintCnt);
		
		goodSelect(boardNo);
		
	});
	
	$("#writeBestdresser").on("click", function(){
		console.log("위시리스트 모달창 호출");
		
		var boardNo = $("#codiBoardNo").data("boardno");
		console.log("보드넘버 : " + boardNo);
		
		$(".commentForm").val("");
		
		//위시리스트 버튼을 클릭한 게시글의 정보를 가져오려고
        //ajax
        $.ajax({
           
           url : "${pageContext.request.contextPath}/trendSetter/selectBoardImg",      
           type : "post",
           //contentType : "application/json",
           data : {boardNo : boardNo},

           dataType : "json",
           success : function(selectBoardVo){
              //성공시 처리해야될 코드 작성                  
              //console.log("잘가져오나 : " + selectBoardVo.boardImg);
              //해당게시글의 이미지데이터를 넣어줌
              $("#wishListImg").attr("src", "${pageContext.request.contextPath}/upload/" + selectBoardVo.boardImg);
              $("#wishListBoardNo").val(selectBoardVo.boardNo);
           },
           error : function(XHR, status, error) {
              console.error(status + " : " + error);
           }
        });   
        
        $("#wishlistModal").modal();
	});
	
	//위시리스트 추가 버튼 클릭시 
    $("#wishlistModal").on("click", "#wishListAdd", function(){
       console.log("위시리스트 추가");

       var boardNo = $("#wishListBoardNo").val();
       var userNo = "${authMember.userNo}";
       var content = $(".commentForm").val();
       
       //위시리스트 추가
       //ajax
       $.ajax({
          
          url : "${pageContext.request.contextPath}/trendSetter/addWishList",      
          type : "post",
          //contentType : "application/json",
          data : {boardNo : boardNo,
                userNo : userNo,
                content : content},

          //dataType : "json",
          success : function(){
             
          },
          error : function(XHR, status, error) {
             console.error(status + " : " + error);
          }
       });   
       
       $("#wishlistModal").modal("hide");
    });

	
	$("#like").on("click", "#likeBtn", function() {
		console.log("하트클릭");
		
		var like = $(this).data("like");
		var boardNo = $("#codiBoardNo").data("boardno");
		//console.log("like 값은 : " + like);
		//console.log("board 값은 : " + boardNo);
		
		//작성자 nickName
		var best = $("#bestDresserWriter").text();

		//로그인하지 않을 경우
		if ( "${authMember}" == "") {
			alert("좋아요 버튼은 로그인 후 사용하실 수 있습니다.");
		} else if( best == "${authMember.nickName}") {	//작성자와 로그인한 사람이 같을경우
			alert("자신의 글에는 좋아요를 누를 수 없습니다.");
		} else {
			if(like=="like"){
				
				$("#likeBtn i").removeClass("fa-heart");
				$("#likeBtn i").addClass("fa-heart-o");
				
				deleteFeeling(boardNo);
				
				$(this).data("like", "unlike");
				
			} else if(like=="unlike") {
				
				$("#likeBtn i").removeClass("fa-heart-o");
				$("#likeBtn i").addClass("fa-heart");
				
				insertFeeling(boardNo);
				
				$(this).data("like", "like");
				
			}
		}
	})

	//삭제버튼 클릭시 모달 띄우기
	$("#bestDresserDel").on("click", function(){
		console.log("삭제모달 띄우자");
		$("#boardDelModal").modal();
	});
	
	$("#tagArea ul li").prepend("#");

	//댓글 등록
	$("#replyWriteForm-login").on("click", "button", function(){
			console.log("댓글 등록 버튼 클릭");
			
			var content = $("#replyWriteForm-login textarea").val();
			var boardNo = ${tsMap.trendSetterVo.boardNo};
			
			$.ajax({	
				url : "${pageContext.request.contextPath}/trendSetter/writeCmt",		
				type : "post",
				//contentType : "application/json",
				data : {content : content,
						matchNo : boardNo},
						
				dataType : "json",
				success : function(result){
					//성공시 처리해야될 코드 작성		
					console.log("댓글 등록 완료");
					console.log(result);
					
					commentTS(boardNo, getCmtCnt, 0);
					$("#replyWriteForm-login textarea").val("");
				},
				error : function(XHR, status, error) {
					console.error(status + " : " + error);
				}
			});	
			
	});
	
	//댓글 더보기 클릭
	$("#main-foot").on("click", "#cmtReadMore", function(){
		console.log("댓글 더보기 클릭");
		
		cmtPrintCnt = $(this).data("cmtprintcnt");
		boardNo = ${tsMap.trendSetterVo.boardNo};
		
		commentTS(boardNo, getCmtCnt, cmtPrintCnt);
	});
	
	//댓글 삭제 클릭
	$("#replyList ul").on("click", "li .del", function(){
		console.log("댓글 삭제 클릭");
		comNo = $(this).data("comno");
		
		$.ajax({	
			url : "${pageContext.request.contextPath}/trendSetter/removeCmt",		
			type : "post",
			//contentType : "application/json",
			data : {comNo : comNo},
					
			dataType : "json",
			success : function(result){
				//성공시 처리해야될 코드 작성		
				console.log("댓글 삭제 완료");
				console.log(result);
				console.log("comNo: "+comNo);

				$("#cmt"+comNo).remove();
				
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});	
		
	});

	//댓글 수정 클릭 -> 수정 폼으로 변경
	$("#replyList ul").on("click", "li .modi", function(){
		console.log("댓글 수정 클릭 : 수정폼 이동");

		var comNo = $(this).data("comno");
		var content = $("#cmt"+comNo+ " .replyContent p").html();
		
		$("#cmt"+comNo+ " button").remove();
		
		str = '';
		str += '<textarea id="replyInput" rows="3" placeholder="">' +content+ '</textarea>';
		str += '<button id="modiBtn" class="formTitle float-r" data-comno="' +comNo+ '">수정</button>';
		
		$("#cmt"+comNo+ " .replyContent").html(str);
		
	});
	
	//댓글 수정폼 수정 클릭 -> DB
	$("#replyList ul").on("click", "li #modiBtn", function(){
		console.log("댓글 수정 클릭");
		console.log($(this).data("comno"));
		var comNo = $(this).data("comno");
		
		console.log($("#cmt"+comNo+ " textarea").val());
		var content = $("#cmt"+comNo+ " textarea").val();
		
		$.ajax({	
			url : "${pageContext.request.contextPath}/trendSetter/modifyCmt",		
			type : "post",
			//contentType : "application/json",
			data : {matchComNo : comNo,
					content : content},
					
			dataType : "json",
			success : function(result){
				//성공시 처리해야될 코드 작성		
				console.log("댓글 수정 완료");
				console.log(result);
				
				str = '<p>' +content+ '</p>';
				$("#cmt"+comNo+ " .replyContent").html(str);
				
				str = '';
				str += '<button class="formTitle modi" data-comno="' +comNo+ '">수정</button> ';
				str += '<button class="myDel del" data-comno="' +comNo+ '">삭제</button>';
				
				$("#cmt"+comNo+ " .float-r").html(str);
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});	
		
		
		
		
	});
	
	//좋아요 취소를 누를때 - feeling 테이블에서 삭제
	function deleteFeeling(boardNo) {

		var boardNo = boardNo;
		
		//ajax
		$.ajax({	
			url : "${pageContext.request.contextPath}/trendSetter/deleteGood",		
			type : "post",
			//contentType : "application/json",
			data : {boardNo : boardNo},
					
			//dataType : "json",
			success : function(like){
				//성공시 처리해야될 코드 작성		
				console.log("삭제완료");
				
				//goodCnt(boardNo);
				$("#likeBtn").remove();
				
				goodCnt(boardNo);
				
				render(like);
			
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});	
		
	}
	
	//좋아요 빈하트 상태를 누를때 - feeling 테이블에 insert
	function insertFeeling(boardNo) {

		var boardNo = boardNo;
		console.log("boardNo 값이요 : " + boardNo);
		
		//ajax
		$.ajax({	
			url : "${pageContext.request.contextPath}/trendSetter/insertGood",		
			type : "post",
			//contentType : "application/json",
			data : {boardNo : boardNo},
					
			//dataType : "json",
			success : function(like){
				//성공시 처리해야될 코드 작성		
				console.log("insert완료");
				
				//goodCnt(boardNo);
				$("#likeBtn").remove();
				
				goodCnt(boardNo);
				
				render(like);
			
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});	
		
	}
	
	//그 게시글의 좋아요 갯수 조회
	function goodCnt(boardNo) {
		var boardNo = boardNo;
		//ajax
		$.ajax({	
			url : "${pageContext.request.contextPath}/trendSetter/goodCnt",		
			type : "post",
			//contentType : "application/json",
			data : {boardNo : boardNo},
					
			dataType : "json",
			success : function(goodCnt){
				//성공시 처리해야될 코드 작성		
				console.log("결과 : " + goodCnt);
				$("#goodCnt").text(goodCnt);
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});	
	}
	
	//feeling 테이블에 좋아요데이터가 있는지 조회
	function goodSelect(boardNo) {
		var boardNo = boardNo

		//ajax
		$.ajax({	
			url : "${pageContext.request.contextPath}/trendSetter/selectFeeling",		
			type : "post",
			//contentType : "application/json",
			data : {boardNo : boardNo},
					
			dataType : "json",
			success : function(like){
				//성공시 처리해야될 코드 작성		
				console.log("결과 : " + like);
				
				render(like);
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});	
		
	}

	function render(like) {
		var like = like;
		
		console.log("모야대체 : " + like);
		
		var str = '';
		
		if (like == "like") {
			str += '<div>';
			str += '	<button id="likeBtn" data-like="' + like + '">';
			str += '		<i class="fa fa-heart"></i>';
			str += '	</button>';
			str += '</div>';
		} else if (like = "unlike") {
			str += '<div>';
			str += '	<button id="likeBtn" data-like="' + like + '">';
			str += '		<i class="fa fa-heart-o"></i>';
			str += '	</button>';
			str += '</div>';
		}

		$("#goodCnt").before(str);
	}
	
	//댓글 가져오기
	function commentTS(boardNo, getCmtCnt, cmtPrintCnt){
		var startCmtNo = cmtPrintCnt + 1;				//가져올 댓글 리스트의 시작번호
		var endCmtNo = startCmtNo + getCmtCnt-1;		//가져올 댓글 리스트의 끝번호
		
		if(cmtPrintCnt == 0){
			$("#replyList ul li").remove();	
		}
		
		$.ajax({	
			url : "${pageContext.request.contextPath}/trendSetter/getCmt",		
			type : "post",
			//contentType : "application/json",
			data : {boardNo : boardNo,
					startCmtNo : startCmtNo,
					endCmtNo : endCmtNo},
					
			dataType : "json",
			success : function(result){
				//성공시 처리해야될 코드 작성		
				console.log("[댓글 결과]");
				console.log(result);
				randerCmt(result, cmtPrintCnt);
				
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});	
	}
	
	//댓글 랜더
	function randerCmt(cmtMap, cmtPrintCnt){
		var newCmtPrintCnt;
		
		//댓글 더보기 지우기
		$("#cmtReadMore").remove();
		
		//댓글 랜더링(현재페이지에 추가)
		for(newCmtPrintCnt=0; newCmtPrintCnt < cmtMap.cmtList.length; newCmtPrintCnt++){
			str = '';
			str += '<li id="cmt' +cmtMap.cmtList[newCmtPrintCnt].matchComNo+ '" class="bottomLine">';
			if(cmtMap.cmtList[newCmtPrintCnt].userNo == "${tsMap.trendSetterVo.userNo}"){
				str += '	<div class="replyWriter">' +cmtMap.cmtList[newCmtPrintCnt].nickName+ ' (글쓴이)</div>';
			}else{
				str += '	<div class="replyWriter"><a href="${pageContext.request.contextPath}/mycloset/' +cmtMap.cmtList[newCmtPrintCnt].id+ '/main">' +cmtMap.cmtList[newCmtPrintCnt].nickName+ '</a></div>';
			}
			str += '	<div class="replyContent"><p>' +cmtMap.cmtList[newCmtPrintCnt].content+ '</p></div>';
			str += '	<div class="writeDate">' +cmtMap.cmtList[newCmtPrintCnt].regDate+ '</div>';
			
			if(cmtMap.cmtList[newCmtPrintCnt].userNo == cmtMap.authUserNo){
				str += '	<div class="float-r">';
				str += '		<button class="update modi" data-comno="' +cmtMap.cmtList[newCmtPrintCnt].matchComNo+ '">수정</button>';
				str += '		<button class="myDel del" data-comno="' +cmtMap.cmtList[newCmtPrintCnt].matchComNo+ '">삭제</button>';
				str += '	</div>';
				str += '	<div class="clear"></div>';
			}

			str += '</li>'
			
			$("#replyList ul").append(str);
		}
		
		cmtPrintCnt += newCmtPrintCnt;
		
		//댓글 더보기가 true면 출력
		if(cmtMap.readMore){
			str = '<div class="clear"></div>';
			str += '<div id="cmtReadMore" class="clear float-r" data-cmtprintcnt="' +cmtPrintCnt+ '">댓글 더보기</div>';
			$("#main-foot").append(str);
		}
		
		//등록버튼 재설정 - 현재입력글 수, 마지막입력된 li의 id를 보유
		$("#replyWriteForm-login button").remove();
		$("#replyWriteForm-login .clear").remove();
		str = '';
		
		str += '<button class="insert float-l">등록</button>';
		str += '<div class="clear"></div>';
		
		
		$("#replyWriteForm-login").append(str);
		
	}
</script>
</html>

