<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<div style="display: inline-block;">
		<div id="side_profile">
			<div>
				<span id="today">Today: ${sessionScope.myRoomVo.todayVisit}</span> <span id="total">Total: ${sessionScope.myRoomVo.totalVisit}</span>
			</div>
			<img id="profileImg" src="${pageContext.request.contextPath}/profile/${sessionScope.myRoomVo.profileImg}">
				
			
		
			<div id="nickFollDiv">
				<span id="nickName">${sessionScope.myRoomVo.nickName}(${sessionScope.myRoomVo.id})님</span> 
				<c:if test="${sessionScope.myRoomVo.id != sessionScope.authMember.id && sessionScope.authMember!=null}">
					<c:choose>
						<c:when test="${sessionScope.follow.isFollow == true}">
							<span id="unfollow">팔로잉</span>
						</c:when>
						<c:otherwise>
							<span id="tofollow">팔로우</span>
						</c:otherwise>
					</c:choose>
				</c:if>
			</div>
			<div>
				<span style="display: inline-block; margin-right: 4px;">Point: </span><span>${sessionScope.myRoomVo.point}</span>
			</div>
			<div>
				<span id="follow"><a href="${pageContext.request.contextPath}/followerfollowing/followers">팔로워</a>: ${sessionScope.follow.followerCount}</span> <span id="following"><a href="${pageContext.request.contextPath}/followerfollowing/following">팔로잉</a>: ${sessionScope.follow.followingCount}</span>
			</div>
		</div>
	
		<div id="side_menu">
			<ul id="">
				<li>
					<div class="side_top" id="closet">옷장</div>
					<ul class="side_sub" id="closet_sub">
						<li><a href="${pageContext.request.contextPath}/mycloset/${sessionScope.myRoomVo.id}/closet?clothCategory=0">전체</a></li>
						<li><a href="${pageContext.request.contextPath}/mycloset/${sessionScope.myRoomVo.id}/closet?clothCategory=1">상의</a></li>
						<li><a href="${pageContext.request.contextPath}/mycloset/${sessionScope.myRoomVo.id}/closet?clothCategory=2">하의</a></li>
						<li><a href="${pageContext.request.contextPath}/mycloset/${sessionScope.myRoomVo.id}/closet?clothCategory=3">신발</a></li>
						<li><a href="${pageContext.request.contextPath}/mycloset/${sessionScope.myRoomVo.id}/closet?clothCategory=4">아우터</a></li>
						<li><a href="${pageContext.request.contextPath}/mycloset/${sessionScope.myRoomVo.id}/closet?clothCategory=5">악세서리</a></li>
					</ul>
				</li>
				<li>
					<div class="side_top">
						<a href="${pageContext.request.contextPath}/mycloset/${myRoomVo.id}/doCodi">코디하기</a>
					</div>
					
				</li>
				
				<%-- <li>
					<div class="side_top" id="styleZip">스타일.zip</div>
					<ul class="side_sub" id="styleZip_sub">
						<li><a href="${pageContext.request.contextPath}/myroom/styzipList">코디구함 작성글</a></li>
						<li><a href="${pageContext.request.contextPath}/myroom/wishList">위시리스트</a></li>
					</ul>
				</li> 
				단일 메뉴화
				--%>
				<li>
					<div class="side_top">
						<a href="${pageContext.request.contextPath}/mycloset/${sessionScope.myRoomVo.id}/styzipList">코디구함 작성글</a>
					</div>
					
				</li>
				
				<li>
					<div class="side_top">
						<a href="${pageContext.request.contextPath}/mycloset/${sessionScope.myRoomVo.id}/wishList">위시리스트</a>
					</div>
					
				</li>
			
				<c:if test="${sessionScope.myRoomVo.id == sessionScope.authMember.id}">
					<li>
						<div class="side_top"><a href="${pageContext.request.contextPath}/user/modifyform">회원정보수정</a></div>
					</li>
				</c:if>
			</ul>
		</div>
	</div>	