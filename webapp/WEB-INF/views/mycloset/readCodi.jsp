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
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerfooter.css">
<!--헤더 푸터css-->

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- 아이콘 -->


</head>

<body>
	<div id="wrap">
		<!--header-->
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>

		<div id="container">

			<div id="main" class="clearfix">
				<div id="main-topline">
					<span id="closet-menu-title">코디하기 ></span> <span id="closet-category">글읽기</span>
				</div>

				<div class="clear"></div>

				<div id="main-middle" class="clearfix">

					<div class="form-group">

						<c:choose>
							<c:when test="${codiPost.trendSetterNo != 0}">
								<button id="readTS" class="btn float-r"
									onclick="location.href='${pageContext.request.contextPath}/trendSetter/readTrendSetter?boardNo=${codiPost.trendSetterNo}'">
									<i class="fa fa-star" aria-hidden="true"></i>  TrendSetter 확인					
								</button>
							</c:when>

							<c:when test="${codiPost.trendSetterNo == 0 && authMember.userNo == codiPost.userNo}">
								<button id="writeTS" class="btn float-r">
									<i class="fa fa-star" aria-hidden="true"></i>  TrendSetter 등록
								</button>
							</c:when>

						</c:choose>
						<div class="clear"></div>
						<label for="doCodiTitle" class="formTitle">제목</label> <input type="text" id="codiTitle"
							placeholder="" readonly>
					</div>

					<div id="imgArea" class="float-l borderCodi">
						<img src="${pageContext.request.contextPath }/upload/${codiPost.boardImg}">
					</div>

					<div id="codiContent" class="float-r borderBF">
						<div class="clear"></div>
						<p>${codiPost.content}</p>

					</div>

					<div class="clear"></div>

					<div id="buttonArea" class="float-r">
						<c:if test="${authMember.userNo == codiPost.userNo }">
							<button id="codiMdify" class="update btn-default float-l" onclick="location.href='${pageContext.request.contextPath}/mycloset/${myRoomVo.id}/codiWriteForm?no=${codiPost.boardNo}'">수정</button>
							<button id="codiDel" class="myDel btn-danger float-l" data-no="${codiPost.boardNo}" data-tsno="${codiPost.trendSetterNo}">삭제</button>
						</c:if>
						<button id="codiList" class="return btn-default float-l" onclick="location.href='./doCodi'">목록</button>
					</div>
				</div>

			</div>


		</div>

		<!--footer-->
		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
	</div>


	<!-- trend setter 등록 폼 모달 창 -->
	<div id="writeTSModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button id="tagCloseBtn" type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">TREND SETTER 등록하기</h4>
				</div>
				<div class="modal-body clearfix">
					<div id="madalImgArea" class="float-l borderCodi">
						<img src="${pageContext.request.contextPath }/upload/${codiPost.boardImg}">
					</div>

					<div id="modal-content" class="form-group float-r">
						<label for="titleTS" class="formTitle">제목</label> <input type="text" id="titleTS"
							placeholder=""> <label for="contentTS" class="formTitle">내용</label>
						<textarea id="contentTS"></textarea>
					</div>

					<div class="check_box text-center float-l">
						<label>남</label><input type="radio" name="gender" value="male" checked="checked"> <label>여</label><input
							type="radio" name="gender" value="female"> <label>유니섹스</label><input type="radio" name="gender" value="unisex">
					</div>

					<div class="clear"></div>

					<div class="tagArea clearfix">
						<div class="formTitle float-l">태그</div>

						<div class="clear"></div>
						
						<div id="selectTagArea">
							<ul>
							</ul>
						</div>
					
						<div class="clear"></div>

						<c:forEach items="${tagCateList}" var="tagCateList">
							<div class="tagCate">${tagCateList.tagStatus}</div>
							<div class="tag_items clearfix">
								<ul id="tagDivNo${tagCateList.tagDivNo}">
									<!-- 태그리스트 반복되는 부분.. -->
									<!-- <li class="tag">눈</li> -->
								</ul>
							</div>
							<br>
						</c:forEach>

					</div>

				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-primary">등록</button>
					<div class="alert alert-danger">TREND SETTER에 등록된 글은 수정이 안되오니 신중하게 등록하시기 바랍니다.</div>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->

	
	<!-- trend setter 저장 모달 창 -->
	<div id="saveTSModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">TREND SETTER 등록 안내</h4>
				</div>
				<div class="modal-body">
					<h5>TREND SETTER에 글이 등록되었습니다.<br>확인하시겠습니까?</h5>
				</div>
				<div class="modal-footer">
					<!-- 버튼 영역 -->
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	
	<!-- trend setter 저장 모달 창 -->
	<div id="delModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">삭제 안내</h4>
				</div>
				<div class="modal-body">
					<!-- 안내문구 영역-->
				</div>
				<div class="modal-footer">
					<!-- 버튼 영역 -->
					
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->


</body>


<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/includes/common.js"></script>

<script type="text/javascript">
	//선택한 태그 리스트를 담을 배열 선언
	var selectTagList = [];
	
	//글 삭제
	$("#codiDel").on("click", function(){
		var boardNo = $(this).data("no");
		var trendSetterNo = $(this).data("tsno");
		var delRepeatStr;
		var buttonStr;
		var delLink = "'${pageContext.request.contextPath}/mycloset/${authMember.id}/removeCodi?boardNo=${codiPost.boardNo}";
		var delBothLink = delLink + "&trendSetterNo=${codiPost.trendSetterNo}'";
		delLink += "'";

		if(trendSetterNo == 0){
			//트렌드 세터에 등록되지 않은 경우
			delRepeatStr = '<h5>삭제하시겠습니까?</h5>';
			
			//버튼 생성
			buttonStr = '<button type="button" class="btn btn-primary" onClick="location.href=' +delLink+ '">예</button>';
			buttonStr += '<button type="button" class="btn btn-default" data-dismiss="modal">아니요</button>';

		}else{
			//트렌드 세터에 등록된 경우
			delRepeatStr = '<h5>Trend Setter에도 등록된 글입니다.<br> 같이 삭제하시겠습니까?</h5>';
			
			//버튼 생성
			buttonStr = '<button type="button" class="btn btn-primary" onClick="location.href=' +delBothLink+ '">예</button>';
			buttonStr += '<button type="button" class="btn btn-default" onClick="location.href=' +delLink+ '">아니요</button>';
		}
		
		$("#delModal .modal-dialog .modal-content .modal-body").html(delRepeatStr);
		$("#delModal .modal-dialog .modal-content .modal-footer").html(buttonStr);
		
		$("#delModal").modal();
	});
	
	//타이틀 정보 입력
	$("#codiTitle").val(" ${codiPost.title}")

	//트랜드세터 등록 버튼 클릭 -> 입력 모달창 띄움
	$("#writeTS").on("click", function() {

		tagList();

		$("#writeTSModal").modal();
	});
	
	//선택된 태그를 클릭했을 때, 지워지고, 태그 리스트의 해당 태그 체크해제
	$("#selectTagArea ul").on("click", "li", function(){
		var tagNo = $(this).data("tagno");
		
		$("#tag"+tagNo).css({
			"background-color" : "#ffffff",
			"color" : "#000000"
		});
		
		$("#tag"+tagNo).data("check", "notcheck");
		
		$(this).remove();
	});
	
	//트렌드세터 등록 모달의 등록버튼 클릭
	$("#writeTSModal .modal-dialog .modal-content .modal-footer button").on("click", function(){
		console.log("등록버튼 클릭");
		var title = $("#titleTS").val();
		var content =  $("#contentTS").val();
		var boardImg = "${codiPost.boardImg}";
		var gender = $("#writeTSModal .modal-dialog .check_box input[name = 'gender']:checked").val(); 
		var boardNo = "${codiPost.boardNo}";	
		
		console.log("젠더 확인 : " +gender);
		
		$.ajax({

			url : "${pageContext.request.contextPath}/trendSetter/writeTrendSetter",
			type : "post",
			//contentType : "application/json",
			data : {
				title : title,
				content : content,
				boardImg : boardImg,
				gender : gender,
				boardNo : boardNo,
				selectTagList : selectTagList
			},

			dataType : "json",
			success : function(result) {
				//성공시 처리해야될 코드 작성  
				console.log("트렌드세터 글번호 :" +result);
				
				$("#writeTSModal").modal("hide");
				
				$("#saveTSModal .modal-dialog .modal-content .modal-footer").html("");
				
				var trendsetterLink = "'${pageContext.request.contextPath}/trendSetter/readTrendSetter?boardNo=" +result+ "'";
				var doCodiLink = "'${pageContext.request.contextPath}/mycloset/${authMember.id}/readCodi?no=${codiPost.boardNo}'";
				var str = '';
				str += '<button type="button" class="btn btn-primary" onClick="location.href=' +trendsetterLink+ '">예</button>';
				str += '<button type="button" class="btn btn-default" onClick="location.href=' +doCodiLink+ '">아니요</button>';
				
				onClick="location.href="
				$("#saveTSModal .modal-dialog .modal-content .modal-footer").html(str);
				
				$("#saveTSModal").modal();
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});

	});
	
	//전체 태그 리스트 뿌리기
	function tagList() {

		//선택 태그 리스트 초기화
		$("#selectTagArea ul li").remove();

		//태그 리스트 초기화
		$(".modal-body .tag_items ul li").remove();

		for (var tagDivNo = 1; tagDivNo <= 3; tagDivNo++) {

			(function(tagDivNo) {
				//ajax
				$.ajax({
					url : "${pageContext.request.contextPath}/trendSetter/hashTagList",
					type : "post",
					//contentType : "application/json",
					data : {
						tagDivNo : tagDivNo
					},

					dataType : "json",
					success : function(hashTagList) {
						//성공시 처리해야될 코드 작성

						for (var i = 0; i < hashTagList.length; i++) {
							//태그 리스트 뿌리기
							render(hashTagList[i]);
						}
					},
					error : function(XHR, status, error) {
						console.error(status + " : " + error);
					}
				});
			})(tagDivNo);
		}
	}

	//태그 리스트 뿌리기
	function render(hashTagVo) {

		if (hashTagVo.tagDivNo == 1) {
			$(".modal-body .tag_items #tagDivNo1")
					.append(
							'<li id="tag' + hashTagVo.tagNo + '" class="tag" data-tagno = ' + hashTagVo.tagNo + ' data-check = "notcheck" data-name="' +hashTagVo.tagName+ '">#'
									+ hashTagVo.tagName + '</li>');
		} else if (hashTagVo.tagDivNo == 2) {
			$(".modal-body .tag_items #tagDivNo2")
					.append(
							'<li id="tag' + hashTagVo.tagNo + '" class="tag" data-tagno = ' + hashTagVo.tagNo + ' data-check = "notcheck" data-name="' +hashTagVo.tagName+ '">#'
									+ hashTagVo.tagName + '</li>');
		} else if (hashTagVo.tagDivNo == 3) {
			$(".modal-body .tag_items #tagDivNo3")
					.append(
							'<li id="tag' + hashTagVo.tagNo + '" class="tag" data-tagno = ' + hashTagVo.tagNo + ' data-check = "notcheck" data-name="' +hashTagVo.tagName+ '">#'
									+ hashTagVo.tagName + '</li>');
		}

	}

	//태그 선택/선택취소 할때
	$(".modal-body .tag_items ul").on(
			"click",
			"li",
			function() {

				var tagNo = $(this).data("tagno");

				var check = $(this).data("check");

				var name = $(this).data("name");

				//태그 선택이 안된 상태에서 선택할때
				if (check == "notcheck") {

					selectTagList.push(tagNo);

					$(this).css({
						"background-color" : "#3bb1e5",
						"color" : "#ffffff"
					});

					//기존 data-check가 notcheck로 되어있는 것을 checked 속성으로 바꾸어줌
					$(this).data("check", "checked");

					//상단에 뿌림
					$("#selectTagArea ul").append(
							'<li id="selectTag' + tagNo + '" class="tag" data-tagno = "' + tagNo + '">#'
									+ name + '</li>');

				} else if (check == "checked") { //태그선택이 된걸 취소할때
					//console.log("해제된 번호 : " + tagNo);
					//빠질 태그를 찾기 위해 변수 만듬
					var minusTag;

					while ((minusTag = selectTagList.indexOf(tagNo)) !== -1) {
						selectTagList.splice(minusTag, 1); //searchTagList에서 minustTag를 뺀다
					}

					$(this).css({
						"background-color" : "#ffffff",
						"color" : "#000000"
					});
					//data-check가 checked로 되어있는 것을 다시 notcheck 속성으로 바꾸어줌
					$(this).data("check", "notcheck");

					//상단에 지움
					$("#selectTag" + tagNo).remove();
				}

			});
</script>

</html>

