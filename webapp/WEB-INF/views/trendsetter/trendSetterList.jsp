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

   <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
   <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css"> <!--리셋css-->
   <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/trendSetter.css">
   <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerfooter.css"> <!--헤더 푸터css-->
   
</head>
<body>
   <div id="wrap">
      <!--header-->
      <c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
      <c:if test="${gender == ''}">
      	<div class="location" data-gender="${gender}">TREND SETTER > 전체</div>
      </c:if>
      <c:if test="${gender == 'male'}">
      	<div class="location" data-gender="${gender}">TREND SETTER > 남성</div>
      </c:if>
      <c:if test="${gender == 'female'}">
      	<div class="location" data-gender="${gender}">TREND SETTER > 여성</div>
      </c:if>
      <c:if test="${gender == 'unisex'}">
      	<div class="location" data-gender="${gender}">TREND SETTER > 유니섹스</div>
      </c:if>
      <div id="contents" >
         <!--검색 , 글쓰기버튼  -->
         <div class="top_box">
	         <div id="search_box">
	         	<form action="${pageContext.request.contextPath}/trendSetter/trendSetterList" method="get">
	         		<select name="searchCate">
	         			<option value="none" selected>카테고리 선택</option>
	         			<option value="title">글제목</option>
	         			<option value="nickName">별명</option>
	         		</select>
		            <input type="search" placeholder="  검색어를 입력해주세요" name = "keyword" value="">
		            <button type="submit" id="btnSearch">검색</button>
				</form>
			</div>
			<div id = "tagSearch_box">
				<button id="btnTagSearch">태그검색</button>
		        <button type="button" id="btnResetTag" onclick="location.href='${pageContext.request.contextPath}/trendSetter/trendSetterList'">태그초기화</button>
         	</div>
         </div>
               
         <form id="tagList_box">
            <div class="tag_box">
               <ul class="clearfix">
                  <!-- 선택된 태그리스트 뿌리는 곳 -->
                  <!-- <li class="tag">눈오는날</li>  -->
               </ul>
            </div>
         </form>
         <!-- //tagList_box -->      
         <div id="codi_box">
            <ul class="codi_line">
               <!-- 이미지 반복 영역 -->
               <c:forEach items="${trendSetterList}" var="trendSetterVo">
                  <li>
                     <div class="codi_row">
                        <div class="row01">
                           <div class="nickName"><a href="${pageContext.request.contextPath}/mycloset/${trendSetterVo.id}/main">${trendSetterVo.nickName}</a></div>
                           <c:if test="${sessionScope.authMember != null && authMember.userNo != trendSetterVo.userNo}">
                                 <c:choose>
                                    <c:when test="${trendSetterVo.follower == authMember.userNo}">
                                       <div class="btnFollow following"><a href="${pageContext.request.contextPath}/followerfollowing/cancelFollow?following=${trendSetterVo.userNo}" class="follow_btn">팔로잉</a></div> 
                                    </c:when>
                                    <c:otherwise>
                                       <div class="btnFollow follow"><a href="${pageContext.request.contextPath}/followerfollowing/checkFollow?following=${trendSetterVo.userNo}" class="follow_btn">팔로우</a></div> 
                                    </c:otherwise>
                                 </c:choose>
                              <div class="btnWishlist" data-boardno="${trendSetterVo.boardNo}"><i class="fa fa-bookmark-o" aria-hidden="true"></i></div>
                           </c:if>
                        </div>
                        <!-- //row01 -->
                        <div class="row02_back" onclick="location.href='${pageContext.request.contextPath}/trendSetter/readTrendSetter?boardNo=${trendSetterVo.boardNo}'">
                           <p>${trendSetterVo.title}</p>
                        </div>
                        <!-- //row02-back -->
                        <img src="${pageContext.request.contextPath}/upload/${trendSetterVo.boardImg}">
                        <div class="row03">
                           <div class="likes"><i class="fa fa-heart-o" aria-hidden="true" ></i> ${trendSetterVo.goodCnt}개</div>
                           <div class="comments"><i class="fa fa-comment-o" aria-hidden="true"></i> ${trendSetterVo.commentCnt}개</div>
                        </div>   
                     <!-- //row03 -->               
                     </div>
                     <!-- //codi_row -->
                  </li>
               </c:forEach>
            </ul>
            
         </div>
         <!-- //codi_box -->
         
      </div>
      <!-- //contents -->
		
	  <div class="clear"></div>
      <!--paging-->
		<div style="text-align: center;" id="paging">
			<nav>
				<ul class="pagination pagination-lg">
					<c:if test="${gender == 'male'}">
						<c:if test="${pMap.prev == true }">
							<li><a href="${pageContext.request.contextPath}/trendSetter/trendSetterList?crtPage=${pMap.startPageNo-1}&gender=male" aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a></li>
						</c:if>
						<c:forEach begin="${pMap.startPageNo}" end="${pMap.endPageNo}" step="1" var="page">
							<li><a href="${pageContext.request.contextPath}/trendSetter/trendSetterList?crtPage=${page}&gender=male">${page}</a></li>
						</c:forEach>
						<c:if test="${pMap.next == true }">
							<li><a href="${pageContext.request.contextPath}/trendSetter/trendSetterList?crtPage=${pMap.endPageNo+1}&gender=male" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
						</c:if>
					</c:if>
					<c:if test="${gender == 'female'}">
						<c:if test="${pMap.prev == true }">
							<li><a href="${pageContext.request.contextPath}/trendSetter/trendSetterList?crtPage=${pMap.startPageNo-1}&gender=female" aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a></li>
						</c:if>
						<c:forEach begin="${pMap.startPageNo}" end="${pMap.endPageNo}" step="1" var="page">
							<li><a href="${pageContext.request.contextPath}/trendSetter/trendSetterList?crtPage=${page}&gender=female">${page}</a></li>
						</c:forEach>
						<c:if test="${pMap.next == true }">
							<li><a href="${pageContext.request.contextPath}/trendSetter/trendSetterList?crtPage=${pMap.endPageNo+1}&gender=female" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
						</c:if>
					</c:if>
					<c:if test="${gender == 'unisex'}">
						<c:if test="${pMap.prev == true }">
							<li><a href="${pageContext.request.contextPath}/trendSetter/trendSetterList?crtPage=${pMap.startPageNo-1}&gender=unisex" aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a></li>
						</c:if>
						<c:forEach begin="${pMap.startPageNo}" end="${pMap.endPageNo}" step="1" var="page">
							<li><a href="${pageContext.request.contextPath}/trendSetter/trendSetterList?crtPage=${page}&gender=unisex">${page}</a></li>
						</c:forEach>
						<c:if test="${pMap.next == true }">
							<li><a href="${pageContext.request.contextPath}/trendSetter/trendSetterList?crtPage=${pMap.endPageNo+1}&gender=unisex" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
						</c:if>
					</c:if>
					<c:if test="${gender == ''}">
						<c:if test="${pMap.prev == true }">
							<li><a href="${pageContext.request.contextPath}/trendSetter/trendSetterList?crtPage=${pMap.startPageNo-1}" aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a></li>
						</c:if>
						<c:forEach begin="${pMap.startPageNo}" end="${pMap.endPageNo}" step="1" var="page">
							<li><a href="${pageContext.request.contextPath}/trendSetter/trendSetterList?crtPage=${page}">${page}</a></li>
						</c:forEach>
						<c:if test="${pMap.next == true }">
							<li><a href="${pageContext.request.contextPath}/trendSetter/trendSetterList?crtPage=${pMap.endPageNo+1}" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
						</c:if>
					</c:if>
				</ul>
			</nav>
		</div>

		<!--footer-->
      <c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
   </div> 
   <!-- //wrap -->

   <!-- 모달창 영역 -->
   <!-- 태그검색 모달 -->
   <div class="modal fade" id="tagSearchModal">
      <div class="modal-dialog">
         <div class="modal-content">
            <div class="modal-header">
               <button type="button" class="close" id="tagCloseBtn"data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
               <h4 class="modal-title">태그 검색</h4>
            </div>
            <div class="modal-body"><!-- style="overflow-y:scroll; height:500px" -->
               <c:forEach items="${tagCateList}" var="tagCateList">
                  <div class="tagCate">${tagCateList.tagStatus}</div>
                  <div class="tag_items">               
                     <ul id="tagDivNo${tagCateList.tagDivNo}">
                        <!-- 태그리스트 반복되는 부분.. -->
                        <!-- <li class="tag">눈</li> -->   
                     </ul>
                  </div>
   
               <br>
               </c:forEach>
            </div>   
            <!-- /modal-body -->
            <div class="modal-footer">
               <button type="button" class="btn btn-default" id="tagCancelBtn" data-dismiss="modal">취소</button>
               <button type="button" class="btn btn-primary" id="selectTags">태그선택</button>
            </div>
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
   
   <script type="text/javascript">
      //선택한 태그 리스트를 담을 배열 선언
      var searchTagList = [];
      var resultListArr = [];
      //========================================================
      
      //베스트드레서 이미지 클릭시 위시리스트창 모달 띄우기
      $("#codi_box").on("click", ".btnWishlist", function(){
         console.log("위시리스트 모달창 호출");
         
         var boardNo = $(this).data("boardno");
         console.log("보드넘버: " + boardNo);
         
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

   
      //태그검색 버튼 눌렀을때 모달창 띄우기
      $("#btnTagSearch").on("click", function(){
         //console.log("태그검색 모달창 호출");
         
         $("#tagSearchModal").modal('show');
         
         $(".modal-body .tag_items ul li").remove();
         $("#tagList_box .tag_box ul li").remove();

         //태그리스트 초기화
         for(var i=searchTagList.length; i>0; i--) {
            searchTagList.pop();
         }
         
         //태그리스트 초기화
         for(var i=resultListArr.length; i>0; i--) {
            resultListArr.pop();
         }

         //태그리스트 뿌리기
         tagList();
      
      });

      //태그 선택/선택취소 할때
      $(".modal-body").on("click", "li", function(){

         var tagNo = $(this).data("tagno");
         
         //와 이거 찾느라 죽는줄..
         var check =  $(this).data("check");
         
         //태그 선택이 안된 상태에서 선택할때
         if (check == "notcheck") {
        	 
            searchTagList.push(tagNo);
            
            $(this).css({
               "background-color":"#3bb1e5",
               "color":"#ffffff"
            });
            //와 이거 찾느라 죽는줄..
            //기존 data-check가 notcheck로 되어있는 것을 checked 속성으로 바꾸어줌
            $(this).data("check","checked");
   
         } else if (check == "checked") {      //태그선택이 된걸 취소할때
            //빠질 태그를 찾기 위해 변수 만듬
            var minusTag;
         
            while((minusTag = searchTagList.indexOf(tagNo)) !== -1) {
               searchTagList.splice(minusTag, 1);   //searchTagList에서 minustTag를 뺀다
            }

            $(this).css({
               "background-color":"#ffffff",
               "color":"#000000"
            });
            //data-check가 checked로 되어있는 것을 다시 notcheck 속성으로 바꾸어줌
            $(this).data("check","notcheck");

         }
         
      });
      
      //태그선택 클릭시
      $("#selectTags").on("click",function() {
         $("#tagSearchModal").modal("hide");

         for(var i = 0; i < searchTagList.length ; i++) {
            console.log("선택결과 : " + searchTagList[i]);
            //선택된 태그번호로 태그 리스트 조회
         }
         
         $("#paging nav ul").html("");
       	 
         //선택된 태그번호로 태그 리스트 조회
         resultTagList(searchTagList);
         
      });
      
      //선택된 태그번호로 태그 리스트 조회
      function resultTagList(tagNoList) {
         //ajax
         $.ajax({
                  
            url : "${pageContext.request.contextPath}/trendSetter/selectTagList",      
            type : "post",
            //contentType : "application/json",
            data : {tagNoList : tagNoList},

            dataType : "json",
            success : function(hashTagVoList){
               //성공시 처리해야될 코드 작성      
             
               selectTag(hashTagVoList);
            },
            error : function(XHR, status, error) {
               console.error(status + " : " + error);
            }
         });   

      }
      
      //전체 태그 리스트 뿌리기
      function tagList() {
         
         for(var tagDivNo = 1; tagDivNo <= 3; tagDivNo++) {
            
            (function(tagDivNo){
               //ajax
               $.ajax({
                  
                  url : "${pageContext.request.contextPath}/trendSetter/hashTagList",      
                  type : "post",
                  //contentType : "application/json",
                  data : {tagDivNo : tagDivNo},

                  dataType : "json",
                  success : function(hashTagList){
                     //성공시 처리해야될 코드 작성                  
                     for(var i = 0; i < hashTagList.length; i++) {
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
      
      //선택된 태그가 포함된 게시글 리스트 뿌리기
      function selectTag(selectTagVo) {

         $("#codi_box .codi_line li").remove();
         $(".modal-body .tag_items ul li").remove();
         
         for(var i = 0; i < selectTagVo.length; i++) {
            $("#tagList_box .tag_box ul").append('<li class="tag" data-tagno = ' + selectTagVo[i].tagNo + ' data-check="checked">#' + selectTagVo[i].tagName + '</li>');

            resultListArr.push(selectTagVo[i].tagNo);
         }
         
        inputSelectTagList(resultListArr);
      }
      
      $("#tagList_box .tag_box ul").on("click", "li", function(){

    	  var tagNo = $(this).data("tagno");

          var check =  $(this).data("check");
          
          //태그 선택이 안된 상태에서 선택할때
          if (check == "notcheck") {

             resultListArr.push(tagNo);
             
             $(this).css({
                "background-color":"#3bb1e5",
                "color":"#ffffff"
             });

             //기존 data-check가 notcheck로 되어있는 것을 checked 속성으로 바꾸어줌
             $(this).data("check","checked");
    
          } else if (check == "checked") {      //태그선택이 된걸 취소할때
             //빠질 태그를 찾기 위해 변수 만듬
             var minusTag;
          
             while((minusTag = resultListArr.indexOf(tagNo)) !== -1) {
   
                resultListArr.splice(minusTag, 1);   //searchTagList에서 minustTag를 뺀다
             }

             $(this).css({
                "background-color":"#ffffff",
                "color":"#000000",
                "border": "1px solid #ccc"
             });
             //data-check가 checked로 되어있는 것을 다시 notcheck 속성으로 바꾸어줌
             $(this).data("check","notcheck");
		
          }
          $("#codi_box .codi_line li").remove();
         
          inputSelectTagList(resultListArr);
         
      });
      
      $("#paging nav ul").on("click", "li", function() {
	  		//페이징 정보 클릭시 리스트 재출력
	  		var prevPage = $(this).data("prevpage");
	  		var page = $(this).data("page");
	  		var nextPage = $(this).data("nextpage");
	
	  		console.log(prevPage);
	  		console.log(page);
	  		console.log(nextPage);
	  	
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
	  		inputSelectTagList(resultListArr, crtPage);
	  	});

      function inputSelectTagList(resultListArr, crtPage) {
  
    	 var gender = $("#wrap .location").data("gender");
    	 var crtPage = crtPage;
    	 
    	 //console.log("crtPage : " + crtPage);
    	 
         //ajax
         $.ajax({
                  
            url : "${pageContext.request.contextPath}/trendSetter/trendTagResultList",      
            type : "post",
            //contentType : "application/json",
            data : {resultListArr : resultListArr,
            		gender : gender,
            		crtPage : crtPage},

            dataType : "json",
            success : function(tagpMap){
               
               //성공시 처리해야될 코드 작성     
			   var startPostNo = tagpMap.startPostNo;
               //console.log("첫번쨰 : " + startPostNo);
			   var endPostNo = tagpMap.endPostNo;
			   //console.log("두번째 : " + endPostNo);
               //console.log("성별 : " + gender);
               
               $("#codi_box .codi_line li").remove();
               
               //포함된 태그 리스트뿌리기
               for(var i = 0; i < tagpMap.trendSetterList.length; i++) {

   				  if (tagpMap.trendSetterList[i] != null) {

   					  var tagPageList = tagpMap.trendSetterList[i];
   					  
   					  selectIncludeTagList(tagPageList);
   				  }

               }
               //페이징
               renderPaging(tagpMap);
            },
            error : function(XHR, status, error) {
               console.error(status + " : " + error);
            }
         });   

      }
      
      
      //태그 리스트 뿌리기
      function render(hashTagVo) {
         
         if (hashTagVo.tagDivNo == 1) {
            $(".modal-body .tag_items #tagDivNo1").append('<li class="tag" data-tagno = ' + hashTagVo.tagNo + ' data-check = "notcheck">#' + hashTagVo.tagName + '</li>');
         } else if (hashTagVo.tagDivNo == 2) {
            $(".modal-body .tag_items #tagDivNo2").append('<li class="tag" data-tagno = ' + hashTagVo.tagNo + ' data-check = "notcheck">#' + hashTagVo.tagName + '</li>');
         } else if (hashTagVo.tagDivNo == 3) {
            $(".modal-body .tag_items #tagDivNo3").append('<li class="tag" data-tagno = ' + hashTagVo.tagNo + ' data-check = "notcheck">#' + hashTagVo.tagName + '</li>');
         }
         
      }
      
      //선택한 태그가 포함된 리스트 출력
      function selectIncludeTagList(tagPageList, startPostNo, endPostNo, gender) {
  
    	  var urlLink = '${pageContext.request.contextPath}/trendSetter/readTrendSetter?boardNo=' + tagPageList.boardNo;
	      var sessionNo = "${authMember.userNo}";
	      var session = "${authMember}";
	
	      var str = '';
	         
	      str += '<li>';
	      str += '   <div class="codi_row">';
	      str += '      <div class="row01">';
	      str += '         <div class="nickName"><a href="${pageContext.request.contextPath}/mycloset/' + tagPageList.id + '/main">' + tagPageList.nickName + '</a></div>';
	      str += '         <c:if test="${authMember != null && ' + sessionNo + '!=' + tagPageList.userNo + '}">';
	         
	      if ((session != null) && (sessionNo != tagPageList.userNo)) {
		      if (tagPageList.follower == sessionNo) {
		     	 str += '            			<div class="btnFollow"><a href="${pageContext.request.contextPath}/followerfollowing/cancelFollow?following=' + tagPageList.userNo + '" class="follow_btn"> · 팔로잉</a></div> ';
		      } else {
		     	 str += '						<div class="btnFollow"><a href="${pageContext.request.contextPath}/followerfollowing/checkFollow?following=' + tagPageList.userNo + '" class="follow_btn"> · 팔로우</a></div> ';
		      }
	      }
	      
	      str += '            <div class="btnWishlist"><i class="fa fa-bookmark-o" aria-hidden="true"></i></div>';
	      str += '         </c:if>';
	      str += '      </div>';
	      str += '      <div class="row02_back" onclick="location.href=\'' + urlLink + '\'">';
	      str += '         <p>' + tagPageList.title + '</p>';
	      str += '      </div>';
	      str += '      <img src="${pageContext.request.contextPath}/upload/' + tagPageList.boardImg + '">';
	      str += '      <div class="row03"  onclick="location.href=' + '">';
	      str += '         <div class="likes"><i class="fa fa-heart-o" aria-hidden="true"></i>' + tagPageList.goodCnt + '개</div>';
	      str += '         <div class="comments"><i class="fa fa-comment-o" aria-hidden="true"></i> ' + tagPageList.commentCnt + '개</div>';
	      str += '      </div>';
	      str += '   </div>';
	      str += '</li>';
    	  
    	  $("#codi_box .codi_line").append(str);
    
      }
      
      //태그리스트 페이징
      function renderPaging(tagpMap) {
    	  
    	  $("#paging nav ul").html("");
    	  
    	  var str = '';

	      if (tagpMap.prev) {
	    	  str = '	<li data-prevpage="' + tagpMap.startPageNo + '">';
			  str += '	<a><span aria-hidden="true">&laquo;</span></a>';
			  str += '</li>';
	      }
	      for (var i = tagpMap.startPageNo; i <= tagpMap.endPageNo; i++) {
	    	  str = '<li data-page="' + i + '"> <a>'
					 + i + '</a></li>';
			  $("#paging nav ul").append(str);
	      }
	      
	      if (tagpMap.next) {
				str = '	<li data-nextpage="' +tagpMap.endPageNo+ '">';
				str += '	<a><span aria-hidden="true">&raquo;</span></a>';
				str += '</li>';

				$("#paging nav ul").append(str);

		  }

      }

   </script>

</html>
