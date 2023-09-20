<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	var cloFlag=0;
	var styFlag=0;
		
	$("#closet").on("click",function(){
		if(cloFlag == 0){
			$("#closet_sub").slideDown(400);
			cloFlag=1;
			if(styFlag == 1){
				$("#styleZip_sub").slideUp(400);
				styFlag=0;
			}
		}
		else if(cloFlag==1){
			$("#closet_sub").slideUp(400);
			cloFlag=0;
		}
	});
	
	$("#tofollow").on("click",function(){
		location.href = "${pageContext.request.contextPath}/followerfollowing/toFollow?following=${sessionScope.myRoomVo.userNo}";
	});
	
	$("#unfollow").on("click",function(){
		location.href = "${pageContext.request.contextPath}/followerfollowing/unFollow?following=${sessionScope.myRoomVo.userNo}";
	});