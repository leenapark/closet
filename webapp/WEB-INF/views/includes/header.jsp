<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<div id="header">
		<c:choose>
			<c:when test="${sessionScope.authMember == null}">
		        <ul id="top_menu">
		            <li><a href="${pageContext.request.contextPath}/user/loginform">로그인</a></li>
		            <li><a href="${pageContext.request.contextPath}/user/joinform">회원가입</a></li>
		        </ul>
        	</c:when>
        	<c:otherwise>
        		<ul id="top_menu">
		            <li><a href="${pageContext.request.contextPath}/user/logout">로그아웃</a></li>
		            <li><a href="${pageContext.request.contextPath}/user/modifyform">회원정보수정</a></li>
		        </ul>
        	</c:otherwise>	
        </c:choose>
      	<div id="logo"><a href="${pageContext.request.contextPath}"><img src="${pageContext.request.contextPath}/assets/images/logo.png"></a></div>
    </div>
    
    <div id="nav">
        <nav>
            <ul id="main-menu">
            <c:choose>
				<c:when test="${sessionScope.authMember == null}">
					<li><a href="${pageContext.request.contextPath}/user/loginform">MY CLOSET</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="${pageContext.request.contextPath}/mycloset/${sessionScope.authMember.id}/main">MY CLOSET</a></li>
				</c:otherwise>
			</c:choose>
              <li id="best"><a href="${pageContext.request.contextPath}/trendSetter/trendSetterList">TREND SETTER</a>
                <ul class="sub-menu" id="best_sub">
                  <li><a href="${pageContext.request.contextPath}/trendSetter/trendSetterList">전체</a></li>
                  <li><a href="${pageContext.request.contextPath}/trendSetter/trendSetterList?gender=male">남성</a></li>
                  <li><a href="${pageContext.request.contextPath}/trendSetter/trendSetterList?gender=female">여성</a></li>
                  <li><a href="${pageContext.request.contextPath}/trendSetter/trendSetterList?gender=unisex">유니섹스</a></li>
                </ul>
              </li>
              <li id="codi"><a href="${pageContext.request.contextPath}/styleMatch/codi">STYLE MATCH</a>
                <ul class="sub-menu" id="codi_sub">
                  <li><a href="${pageContext.request.contextPath}/styleMatch/codi">전체</a></li>
                  <li><a href="${pageContext.request.contextPath}/styleMatch/codi?gender=male">남성</a></li>
                  <li><a href="${pageContext.request.contextPath}/styleMatch/codi?gender=female">여성</a></li>
                  <li><a href="${pageContext.request.contextPath}/styleMatch/codi?gender=unisex">유니섹스</a></li>
                </ul>
              </li>
              <li><a href="${pageContext.request.contextPath}/rank">RANKING</a></li>
            </ul>
          </nav>
    </div>
   <div id="main_visual"><img src="${pageContext.request.contextPath}/assets/images/main_visual.jpg"></div>
    