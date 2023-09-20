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

</head>

<body>
	<div id="wrap">
		<!--header-->
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>

		<div id="container">

			<div id="main" class="clearfix">
				<div id="main-topline">
					<span id="closet-menu-title">코디하기 ></span> <span id="closet-category">글쓰기</span>
				</div>

				<div class="clear"></div>

				<form class="clearfix">
					<div class="form-group">
						<label for="doCodiTitle" class="formTitle">제목</label> <input type="text" id="doCodiTitle"
							placeholder="" value="${bMap.codiBoardVo.title}">
					</div>
					<div id="canvasContainer" class="float-l borderCodi" ondrop="drop(event)" ondragover="allowDrop(event)">
						<canvas id="imgArea">
	
						</canvas>
					</div>

					<div id="closetList" class="float-r borderCodi">

						<div id="tabArea" class="clearfix" role="tabpanel">

							<!-- Nav tabs -->
							<ul class="nav nav-tabs" role="tablist">
								<li role="presentation" class="active"><a href="#all" aria-controls="all" role="tab"
									data-toggle="tab">전체</a></li>
								<li role="presentation"><a href="#top" aria-controls="top" role="tab" data-toggle="tab">상의</a></li>
								<li role="presentation"><a href="#pants" aria-controls="pants" role="tab"
									data-toggle="tab">하의</a></li>
								<li role="presentation"><a href="#shoes" aria-controls="shoes" role="tab"
									data-toggle="tab">신발</a></li>
								<li role="presentation"><a href="#outer" aria-controls="outer" role="tab"
									data-toggle="tab">외투</a></li>
								<li role="presentation"><a href="#aeccesory" aria-controls="aeccesory" role="tab"
									data-toggle="tab">악세서리</a></li>
							</ul>

							<!-- Tab panes -->
							<div class="tab-content">
								<div role="tabpanel" class="tab-pane active" id="all">
									<ul>
									</ul>
								</div>

								<div role="tabpanel" class="tab-pane" id="top">
									<ul>
									</ul>
								</div>

								<div role="tabpanel" class="tab-pane" id="pants">
									<ul>
									</ul>
								</div>

								<div role="tabpanel" class="tab-pane" id="shoes">
									<ul>
									</ul>
								</div>

								<div role="tabpanel" class="tab-pane" id="outer">
									<ul>
									</ul>
								</div>

								<div role="tabpanel" class="tab-pane" id="aeccesory">
									<ul>
									</ul>
								</div>
							</div>

							<div class="clear"></div>

							<div id="paging">
								<nav>
									<ul class="pagination pagination-lg">

									</ul>
								</nav>
							</div>

						</div>

					</div>

					<div class="clear"></div>

					<div id="content" class="form-group">
						<textarea id="doCodiContent" rows="10" placeholder="내용을 입력해 주세요">${bMap.codiBoardVo.content}</textarea>
					</div>

					<div id="btnArea">
						<c:choose>
							<c:when test="${empty bMap.codiBoardVo}">
								<button id="submitBtn" type="button" class="btn-default insert">등록</button>	
							</c:when>
							<c:otherwise>
								<button id="submitBtn" type="button" class="btn-default update">수정</button>
							</c:otherwise>
						</c:choose>
						
						<button type="button" class="btn-default return" onclick="location.href='./doCodi'" style="float:none;">취소</button>
					</div>
				</form>


			</div>


		</div>

		<!--footer-->
		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
	</div>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/includes/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/fabric/fabric.js"></script>

<script type="text/javascript">

	//fabric 캔버스 설정
	var canvas = new fabric.Canvas('imgArea'), canvasOriginalWidth = 353, canvasOriginalHeight = 518, canvasWidth = 353, canvasHeight = 518;

	//캔버스 크기 지정
	canvas.setWidth(canvasWidth);
	canvas.setHeight(canvasHeight);
	
	//옷(객체) 더블클릭 시 삭제
	canvas.on('mouse:dblclick', function (e) {
		canvas.remove(e.target);
	});

	$("#document").ready(function() {
		//최초 전체 리스트의 1번 페이지 가져오기
		getClothList(0, 1);
		
		//캔버스에 객체 채우기
		var canvasJson = '${bMap.canvasJson}';
		console.log(canvasJson);
		
		canvas.loadFromJSON(canvasJson, function() {
			canvas.renderAll();
		});
	});
	
	//글 등록
	$("#submitBtn").on("click", function() {
		var clothInCanvas = JSON.stringify(canvas.toJSON());
		var canvasImg = canvas.toDataURL("image/png", 1.0);

		var title = $("#doCodiTitle").val();
		var content = $("#doCodiContent").val();
		
		var boardNo = "${bMap.codiBoardVo.boardNo+0}";

		$.ajax({

			url : "${pageContext.request.contextPath}/mycloset/${authMember.userNo}/writeCodi",
			type : "post",
			//contentType : "application/json",
			data : {
				clothInCanvas : clothInCanvas,
				canvasImg : canvasImg,
				title : title,
				content : content,
				boardNo : boardNo
			},
			/*여기까지 보낼때 */

			/*여기부터 받을 때*/
			dataType : "text",
			success : function(result) {
				/*성공시 처리해야될 코드 작성*/
				console.log(result);
				window.location.href = "./doCodi";
			},
			//성공도 실패도 아닌 에러
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});

	});

	$("#tabArea ul li a").on("click", function() {
		//탭 클릭시에 카테고리에 맞는 1번 페이지 가져오기
		var clothCategory = ($(this).attr("href")).replace("#", "");
		console.log(clothCategory);

		switch (clothCategory) {
		case "all":
			clothCategory = 0;
			break;
		case "top":
			clothCategory = 1;
			break;
		case "pants":
			clothCategory = 2;
			break;
		case "shoes":
			clothCategory = 3;
			break;
		case "outer":
			clothCategory = 4;
			break;
		case "aeccesory":
			clothCategory = 5;
			break;
		}

		console.log(clothCategory);

		getClothList(clothCategory, 1);

	});

	$("#paging nav ul").on("click", "li", function() {
		//페이징 정보 클릭시 리스트 재출력
		var prevPage = $(this).data("prevpage");
		var page = $(this).data("page");
		var nextPage = $(this).data("nextpage");

		console.log(prevPage);
		console.log(page);
		console.log(nextPage);
		var clothCategory = $(this).data("clothcategory");

		var crtPage;

		if (prevPage != undefined) {
			//만약 이전 버튼데이터가 있으면
			console.log("prevPage 버튼 클릭");

			prevPage -= 1;
			console.log("prevPage-1 : " + prevPage);

			crtPage = prevPage;
		} else if (nextPage != undefined) {
			//그렇지 않고 다음 버튼 데이터가 있으면
			console.log("nextPage 버튼 클릭");

			nextPage += 1;
			console.log("nextPage+1 : " + nextPage);

			crtPage = nextPage;
		} else {
			//둘다 아니면 페이지
			console.log("page 버튼 클릭");

			crtPage = page;
		}
		getClothList(clothCategory, crtPage);
	});

	function getClothList(clothCategory, crtPage) {
		//DB에서 리스트 및 페이징 정보 불러오기
		$
				.ajax({

					url : "${pageContext.request.contextPath}/mycloset/${authMember.userNo}/getCloset",
					type : "post",
					//contentType : "application/json",
					data : {
						clothCategory : clothCategory,
						crtPage : crtPage
					},
					/*여기까지 보낼때 */

					/*여기부터 받을 때*/
					dataType : "json",
					success : function(result) {
						/*성공시 처리해야될 코드 작성*/
						console.log(result);
						randerList(result);
						randerPaging(result);
					},
					//성공도 실패도 아닌 에러
					error : function(XHR, status, error) {
						console.error(status + " : " + error);
					}
				});
	}

	function randerList(pMap) {
		//카테고리별 옷장 리스트 출력
		var str = '';
		var clothCategory;

		switch (pMap.clothCategory) {

		case 0:
			clothCategory = "all";
			break;
		case 1:
			clothCategory = "top";
			break;
		case 2:
			clothCategory = "pants";
			break;
		case 3:
			clothCategory = "shoes";
			break;
		case 4:
			clothCategory = "outer";
			break;
		case 5:
			clothCategory = "aeccesory";
			break;
		}
		$("#" + clothCategory + " ul").html("");

		console.log("[randerList] clothCategory : " + clothCategory);

		for (var i = 0; i < pMap.clothesList.length; i++) {
			str = '<li>';
			str += '	<div class="thumbnail clothImg">';
			str += '		<img id="cloth'
					+ pMap.clothesList[i].clothNo
					+ '" src="${pageContext.request.contextPath}/upload/'
					+ pMap.clothesList[i].clothImg
					+ '" draggable="true" draggable="true" ondragstart="drag(event)">';
			str += '	</div>';
			str += '</li>';

			$("#" + clothCategory + " ul").prepend(str);
		}

	}

	function randerPaging(pMap) {
		//옷장 페이징 출력
		$("#paging nav ul").html("");

		var str = '';

		if (pMap.prev) {
			str = '	<li data-prevpage="' +pMap.startPageBtnNo+ '" data-clothcategory="' +pMap.clothCategory+ '">';
			str += '	<a><span aria-hidden="true">&laquo;</span></a>';
			str += '</li>';

			$("#paging nav ul").append(str);
		}

		for (var page = pMap.startPageBtnNo; page <= pMap.endPageBtnNo; page++) {
			str = '<li data-page="' +page+ '" data-clothcategory="' +pMap.clothCategory+ '"> <a>'
					+ page + '</a></li>';
			$("#paging nav ul").append(str);
		}

		if (pMap.next) {
			str = '	<li data-nextpage="' +pMap.endPageBtnNo+ '" data-clothcategory="' +pMap.clothCategory+ '">';
			str += '	<a><span aria-hidden="true">&raquo;</span></a>';
			str += '</li>';

			$("#paging nav ul").append(str);

		}

	}

	//드래그 앤 드랍 설정
	function allowDrop(ev) {
		ev.preventDefault();
	}

	function drag(ev) {
		ev.dataTransfer.setData("text", ev.target.id);
		console.log(ev.target.id);
	}

	function drop(ev) {
		ev.preventDefault();
		var data = ev.dataTransfer.getData("text");
		var imgElement = document.getElementById(data);
		console.log(imgElement);

		//드랍된 데이터를 페브릭이미지로 설정
		var imgInstance = new fabric.Image(imgElement, {
			left : 5,
			top : 5,
			angle : 0,
			opacity : 1,

			scaleX : 100 / imgElement.naturalWidth,
			scaleY : 100 / imgElement.naturalWidth
		});

		//이미지를 캔버스에 추가
		canvas.add(imgInstance);
		
		
	}
	//드래그 앤 드랍 설정 끝
	
</script>

</html>

