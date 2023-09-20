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

<script type="text/javascript" src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.js"></script>
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>


<link href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
<!--리셋css-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerfooter.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/codiboard.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">


</head>
<body>
	<div id="wrap">
		<!--header-->
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
		<div class="location">STYLE MATCH > 글쓰기</div>

		<div id="codi_writeBox">
			<form action="">
				<!-- 오늘날짜 -->
				<c:set var="today" value="<%=new java.util.Date()%>"/>
				<!-- formatDate : 날짜 타입을 해당 패턴으로 변환한다.  -->
				<fmt:formatDate var="now" type="date" value="${today}" pattern="yyyy-MM-dd"/>
				
				<!-- 제목, 요청기한 -->
				<div class="title_name gray_boader_box text-center">제목</div>
				<input class="title blue_boader_box" type="text" name="title">
				<div class="date_limit gray_boader_box text-center">요청기한</div>
				<input class="date blue_boader_box" type="date" name="deadline" min="${now}"> <input type="hidden" name="userNo"
					value="${sessionScope.authMember.userNo}">

				<!-- 캡쳐할 영역 -->
				<div class="codi_drag gray_boader_box drag-css" style="overflow:auto;">
					<div id="screenshot" style="width: 100%; height: 100%;" ondrop="drop(event)" ondragover="allowDrop(event)">
					
					</div>
				</div>
				<div class="closet_drag gray_boader_box">

					<!-- 부위별 옷 탭 -->
					<div role="tabpanel">
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
									<ul>	</ul>
								</div>

								<div role="tabpanel" class="tab-pane" id="top">
									<ul>	</ul>
								</div>
								
								<div role="tabpanel" class="tab-pane" id="pants">
									<ul>	</ul>
								</div>
								
								<div role="tabpanel" class="tab-pane" id="shoes">
									<ul>	</ul>
								</div>
								
								<div role="tabpanel" class="tab-pane" id="outer">
									<ul>	</ul>
								</div>
								
								<div role="tabpanel" class="tab-pane" id="aeccesory">
									<ul>	</ul>
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

				</div>
				<div class="check_box  text-center">
					<label for="male">남</label><input id="male" type="radio" name="gender" value="male" checked="checked"> 
					<label for="female">여</label><input id="female" type="radio" name="gender"  value="female" > 
					<label for="unisex">유니섹스</label><input id="unisex" type="radio" name="gender" value="unisex">
				</div>

				<textarea class="codi_text text-left" name="content" placeholder="내용을 입력해 주세요"></textarea>
				<div class="but_box text-center">
					<!-- 등록버튼을 스샷버튼으로 -->
					<button type="button" id="save" class="white_box">등록</button>
					<button class="white_box">취소</button>
				</div>
			</form>
		</div> <!--  -->

		<!--footer-->
		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
		
	</div> <!-- wrap -->
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/includes/common.js"></script>

<script type="text/javascript">
	
	$("#document").ready(function(){
		//최초 전체 리스트의 1번 페이지 가져오기
		getClothList(0, 1);
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
	
	$("#paging nav ul").on("click", "li", function(){
		//페이징 정보 클릭시 리스트 재출력
		var prevPage = $(this).data("prevpage");
		var page = $(this).data("page");
		var nextPage= $(this).data("nextpage");
		
		var clothCategory = $(this).data("clothcategory");
		
		var crtPage;
		
		if(prevPage != undefined){
			//만약 이전 버튼데이터가 있으면
			console.log("prevPage 버튼 클릭");
			
			prevPage -= 1;
			console.log("prevPage-1 : " +prevPage);
			
			crtPage = prevPage;
		}else if(nextPage != undefined){
			//그렇지 않고 다음 버튼 데이터가 있으면
			console.log("nextPage 버튼 클릭");
			
			nextPage += 1;
			console.log("nextPage+1 : " +nextPage);
			
			crtPage = nextPage;
		}else{
			//둘다 아니면 페이지
			console.log("page 버튼 클릭");
			
			crtPage = page;
		}		
		getClothList(clothCategory, crtPage);
	});
	function getClothList(clothCategory, crtPage){
		//DB에서 리스트 및 페이징 정보 불러오기
		$.ajax({
			
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
		
		for (var i = 0; i<pMap.clothesList.length; i++) {
			str = '<li class="float-l">';
			str += '	<div class="thumbnail clothImg">';
			str += '		<img id="cloth' +pMap.clothesList[i].clothNo+ '" src="${pageContext.request.contextPath}/upload/' +pMap.clothesList[i].clothImg+ '"data-clothno='+pMap.clothesList[i].clothNo+' draggable="true" ondragstart="drag(event)">';
			str += '	</div>';
			str += '</li>';
			console.log(i);
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
			console.log("prev : " + str);
		}
	
		for (var page = pMap.startPageBtnNo; page <= pMap.endPageBtnNo; page++) {
			console.log("for1 : " + str);
			str = '<li data-page="' +page+ '" data-clothcategory="' +pMap.clothCategory+ '"> <a>' + page + '</a></li>';
			$("#paging nav ul").append(str);
			console.log("for2 : " + str);
		}
	
		if (pMap.next) {
			console.log("next-start : " + str);
			str = '	<li data-nextpage="' +pMap.endPageBtnNo+ '" data-clothcategory="' +pMap.clothCategory+ '">';
			str += '	<a><span aria-hidden="true">&raquo;</span></a>';
			str += '</li>';
	
			$("#paging nav ul").append(str);
			console.log("next-end : " + str);
		}
	
	}

	//드래그앤드롭
	function allowDrop(ev) {ev.preventDefault();}
		
	function drag(ev) {ev.dataTransfer.setData("Text", ev.target.id);}
		
	function drop(ev) {
		ev.preventDefault();
		var data = ev.dataTransfer.getData("Text");
		
		//이미지를 복사해서 넣어줘야함 .clone()
		var dropImg = $("#"+data).clone();
		
		dropImg.removeAttr("ondragstart");
		
		$("#screenshot").append(dropImg);
		
		dropImg.bind("dblclick",function(event){
			dropImg.remove();
		});
		
		//캡쳐될 이미지 영역에 이미지 추가시 append
	
		dropImg.resizable({
			minWidth: 80,
			maxWidth: 190,
			aspectRatio: true
		});
		dropImg.parent().css("width","140px");
		dropImg.parent().css("height","auto");
		dropImg.css("width","100%");
		dropImg.css("height","100%");
		
		dropImg.parent().draggable({
			containment: '#screenshot'
		});
		
	}
	
	//div 영역 캡쳐 및 데이터 넘기기 
	$(function(){
		$("#save").click(function(){
			
		    if($("[name = 'title']").val().length<1){
		    	alert("제목을 입력해주세요");
		    	return false;
		    }
		    if($("[name = 'deadline']").val().length<1){
		    	alert("요청기한을 작성해주세요");
		    	return false;
		    }
		    
			var clothList = new Array();
			var scCount = $("#screenshot").children().length;
			for(i=0;i<scCount;i++){
				var data = new Object();
				data.clothNo = $('#screenshot').children('.ui-wrapper:eq('+i+')').children().data('clothno');
				data.imgWidth = $('#screenshot').children('.ui-wrapper:eq('+i+')').width(); 
				data.imgHeight = $('#screenshot').children('.ui-wrapper:eq('+i+')').height();
				data.x = $('#screenshot').children('.ui-wrapper:eq('+i+')').css("left").replace(/[^-\d\.]/g, '');
				data.y = $('#screenshot').children('.ui-wrapper:eq('+i+')').css("top").replace(/[^-\d\.]/g, '');
				clothList.push(data);
			}
			
			window.scroll(0,0);
	    	html2canvas(document.getElementById("screenshot")).then(function(canvas){
	    		var file = canvas.toDataURL("image/png");
	    		var formData = new FormData();
	    		var clothImgData = JSON.stringify(clothList);
	    		var data = JSON.stringify({
	    			title: $("[name = 'title']").val(),
	    			content: $("[name = 'content']").val(),
	    			deadline: $("[name = 'deadline']").val(),
	    			gender: $("[name = 'gender']").val(),
	    			userNo: "${sessionScope.authMember.userNo}"
	    		});
	    		/*
	    		canvas.toBlob(function(blob){
	    			formData.append("file",blob,'aa.png');
	    		});*/
	    		
	    		formData.append("file",file);
	    		formData.append("data",data);
	    		formData.append("clothImgData",clothImgData);
	    		
	    		$.ajax({
	    			url: "${pageContext.request.contextPath}/styleMatch/styleMatchInsert",
	    			type : "post",
	    			data : formData,
	    			processData: false,
	    			contentType: false,
	    			cache: false,
	    			enctype: 'multipart/form-data',
	    			success : function(result){
	    				//페이지 넘기기
	    				window.location.href = "${pageContext.request.contextPath}/styleMatch/codi";
	    			},
	    			error : function(XHR, status, error) {
	    				console.error(status + " : " + error);
	    			}
	    		});
	        });
	    });
	});

</script>

</html>

