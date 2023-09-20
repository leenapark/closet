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
						<span id="closet-menu-title">옷장 ></span>
						<span id="closet-category">
							<c:if test="${clothCategory==0}">
								전체
							</c:if>
							<c:if test="${clothCategory==1}">
								상의
							</c:if>
							<c:if test="${clothCategory==2}">
								하의
							</c:if>
							<c:if test="${clothCategory==3}">
								신발
							</c:if>
							<c:if test="${clothCategory==4}">
								아우터
							</c:if>
							<c:if test="${clothCategory==5}">
								악세서리
							</c:if>
							
						</span>
						<c:if test="${sessionScope.myRoomVo.id == sessionScope.authMember.id}">
							<button id="btn-fill-closet">옷장 채우기</button>
						</c:if>
					</div>
					<div id="main-middle" class="clearfix">
						<ul>							
							<c:forEach items="${pMap.clothesList}" var="vo">
								<li class="imgBox thumbnail" data-placement="top" data-toggle="popover" title="${vo.clothName}" data-content="${vo.clothInfo}">
									<c:if test="${sessionScope.myRoomVo.id == sessionScope.authMember.id}">
										<img class="delBtn" data-clothNo="${vo.clothNo}" src="${pageContext.request.contextPath}/assets/images/delete.jpg">
									</c:if>
									<div class="clear"></div>
									<img class="clothesImg" src="${pageContext.request.contextPath}/upload/${vo.clothImg}">			
								</li>
							</c:forEach>
						</ul>
						
					</div>
					
					<div style="text-align: center;">
						<nav>
							<ul class="pagination pagination-lg">
								<c:if test="${pMap.prev == true }">
									<li>
										<a href="${pageContext.request.contextPath}/mycloset/${sessionScope.myRoomVo.id}/closet?clothCategory=${requestScope.clothCategory}&crtPage=${pMap.startPageBtnNo-1}" aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a>
									</li>
								</c:if>
								<c:forEach begin="${pMap.startPageBtnNo}" end = "${pMap.endPageBtnNo}" step="1" var="page">
									<li><a href="${pageContext.request.contextPath}/mycloset/${sessionScope.myRoomVo.id}/closet?clothCategory=${requestScope.clothCategory}&crtPage=${page}">${page}</a></li>
								</c:forEach>
								<c:if test="${pMap.next == true }">
									<li>
										<a href="${pageContext.request.contextPath}/mycloset/${sessionScope.myRoomVo.id}/closet?clothCategory=${requestScope.clothCategory}&crtPage=${pMap.endPageBtnNo+1}" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a>
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
		
		<!-- 모달 옷장 채우기 -->
		<div class="modal fade" id="isertClothModal">
		  <div class="modal-dialog" style="top:120px; left:150px;">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        
		      </div>
		      <div class="modal-body">
		        <input id="clothName"type="text" class="form-control" style="display:inline-block; width: 70%;" placeholder="옷의 이름을 입력하세요">
		        <select class="form-control" style="display:inline-block; width: 20%;" name="cloth-position">
		        	<option value="1">상의</option>
		        	<option value="2">하의</option>
		        	<option value="3">신발</option>
		        	<option value="4">아우터</option>
		        	<option value="5">악세서리</option>
		        </select>
		        <div id="img-input-box" style="width: 100%; height:300px; border: 1px dashed black; margin: 10px 0px; text-align: center; ">
		        	<p id="img-input-box-text" style="text-align: center; font-size: 23px; color: #CDCDCD; line-height:290px;">이미지를 드래그하거나 첨부하기 버튼을 눌러주세요.</p>
		        	<img id="img-box-img">
		        </div>
		        <div class="clearfix">
			        <label for="ex_file" id="fileInputLabel">첨부 파일</label> 
			        <input type="file" id="ex_file" onChange="attachment(event);">
		        </div>
		        <p style="font-size: 18px; font-weight: bold;">옷 정보</p>
		        <input id="clothInfo" type="text" class="form-control" style="display:inline-block; width: 95%;" placeholder="브랜드/사이즈 /상품명 등 정보를 자유롭게 입력하세요.">
		      </div>
		      <div class="modal-footer" style="text-align: center;">
		        <button type="button" class="btn btn-primary" id="insert-clothes">저장</button>
		        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
		      </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->

		<c:import url="/WEB-INF/views/includes/deleteMessage.jsp"></c:import>

	</body>
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/includes/common.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/includes/sideMenu.jsp"></script>
	
	<script type="text/javascript">
	
	$(".delBtn").on("click",function(){
		$("#delModal").modal();
		var delClothNo = $(this).data("clothno");
		$("#modalDelBtn").on("click",function(){
			location.href = "${pageContext.request.contextPath}/mycloset/${sessionScope.authMember.id}/closet/deleteClothes?clothNo="+delClothNo;
		})
	});
	
	//리스트 위에 팝업
	$(".imgBox").hover(function(){
		$(this).popover("show");
	},function(){
		$(this).popover("hide");
	});
	
	//버튼 누르면 옷 넣는 모달 창 띄움
	$("#btn-fill-closet").on("click",function(){
		$("#isertClothModal").modal();
		$("#img-input-box-text").show();
		$("#img-box-img").removeAttr("src");
		$("#img-box-img").removeAttr("style");
		$("#clothInfo").val("");
		$("#clothName").val("");
		$("[name = 'cloth-position']").val("1");
	});
	
	//드래그 드롭으로 이미지 넣기(외부에서)
	var obj = $("#img-input-box");
	//var files;
	var file;
	//드래그 들어갈때
	obj.on("dragenter",function(e){
		e.stopPropagation();
		e.preventDefault();
	});
	//드래그가 올라가 있을때
	obj.on("dragover",function(e){
		e.stopPropagation();
		e.preventDefault();
		obj.css({
			"background-color": "gray"
		});
		$("#img-input-box-text").css("color","white");
	});
	//드래그 떠날때
	obj.on("dragleave",function(e){
		obj.css({
			"background-color": "white"
		});
		$("#img-input-box-text").css("color","#CDCDCD");
	});
	//드래그 해서 놓을때
	obj.on("drop",function(e){
		e.stopPropagation();
		e.preventDefault();
		obj.css({
			"background-color": "white"
		});
		$("#img-input-box-text").css("color","#CDCDCD");
		
		var files = e.originalEvent.dataTransfer.files;
		file = files[0];
		$("#img-input-box-text").hide();
		
		//이미지 바로 적용
		for(var i=0;i<1;i++){
			
			var reader = new FileReader();
			reader.onload=function(e){
				$("#img-box-img").attr("src",e.target.result);
				$("#img-box-img").css({position:"relative",width:"auto",height:"80%",top:"10%"});
			}
			reader.readAsDataURL(files[i]);
		}
	});
	//이미지 저장
	$("#insert-clothes").on("click",function(){
		$("#isertClothModal").modal("hide");
		if(file==undefined){
			alert("옷 사진을 넣어주세요");
			return false;
		}
		if($("#clothName").val().length<1){
			alert("옷 이름을 입력해주세요");
			return false;
		}
		if($("#clothInfo").val().length<1){
			alert("옷 정보를 입력해 주세요");
			return false;
		}
		pushImg(file,obj);
	});
	
	function attachment(e){
		file= $("#ex_file")[0].files[0];
		$("#img-input-box-text").hide();
		//이미지 바로 적용
		var reader = new FileReader();
		reader.onload=function(e){
			$("#img-box-img").attr("src",e.target.result);
			$("#img-box-img").css({position:"relative",width:"270px",height:"270px",top:"4%",left:"0%"});
		}
		reader.readAsDataURL(e.target.files[0]);
		
	}
	
	//이미지 서버로 보내기
	function pushImg(file,obj){
		
		//서버로 보내기
		//var file = files[0];
		var formData = new FormData();
		
		var data = JSON.stringify({
			clothInfo: $("#clothInfo").val(),
			clothName: $("#clothName").val(),
			clothCateNo: $("[name = 'cloth-position']").val(),
			userNo: "${sessionScope.authMember.userNo}"
		});
		
		formData.append("file",file);
		formData.append("data",data);
		
		$.ajax({
			url: "${pageContext.request.contextPath}/mycloset/${sessionScope.myRoomVo.id}/insertClothes",
			type : "post",
			data : formData,
			processData: false,
			contentType: false,
			cache: false,
			enctype: 'multipart/form-data',
			success : function(result){
				//페이지 넘기기
				window.location.href = result;
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
	}
	
	$(".imgBox").hover(function(){
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

