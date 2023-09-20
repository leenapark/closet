<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Closetory - 로그인</title>

<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.js"></script>

<link href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
<!--리셋css-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user.css" type="text/css">
<!--user css-->


</head>
<body>
	<div id="wrap">
		<h1 class="n-hidden">회원가입 완료 화면</h1>

		<div class="form-area">
			<!-- header -->
			<header class="join-header">
				<div class="logo">
					<a href="${pageContext.request.contextPath}">
						<img src="${pageContext.request.contextPath}/assets/images/logo.png">
					</a>
				</div>
			</header>
			<!-- header -->

			<!-- loginbox -->
			<div class="joincomplete">

				<img src="${pageContext.request.contextPath}/assets/images/confetti.png">


				<div class="complete">
					<p>
						회원 가입을 축하합니다!
						<br>
						<a href="${pageContext.request.contextPath}/user/loginform">[로그인하기]</a>
					</p>
				</div>
			</div>

		</div>

	</div>
</body>
</html>