<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>ALLIGHT - 다이어트 관리 홈페이지</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/animate.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/owl.carousel.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/owl.theme.default.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/magnific-popup.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/shopping.css">

<decorator:head />
</head>

<body>

	<!-------------------- header -------------------->
	<!-- login/join -->
	<div class="header-top">
		<div class="container">
			<div class="ht-right">
				<c:if test="${empty sessionScope.MID}">
					<a href="${pageContext.request.contextPath}/login.com"
						class="login-panel"><i class="fa fa-user"></i>Login</a>
					<a href="#" class="join-panel">join</a>
				</c:if>
				<c:if test="${!empty sessionScope.MID}">
					<a href="#" class="logined-panel">로그아웃</a>
					<a href="#" class="logined-panel">장바구니()</a>
					<a href="#" class="logined-panel">주문/배송조회</a>
					<a href="#" class="logined-panel">마이페이지</a>
					<a href="#" class="logined-nick-panel">${sessionScope.MNICK} 님</a>
				</c:if>
			</div>
		</div>
	</div>

	<!-- logo -->
	<div class="container">
		<a href="${pageContext.request.contextPath}/main.com">
			<img
			src="${pageContext.request.contextPath}/resources/img/allight_logo.jpg"
			class="logo" onclick="">
		</a>
	</div>

	<!-- navigation bar -->
	<nav
		class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light"
		id="ftco-navbar">
		<div class="container-fluid">
			<div class="collapse navbar-collapse" id="ftco-nav">
				<ul class="navbar-nav m-auto">
					<li class="nav-item active"></li>
					<li class="nav-item"><a href="#" class="nav-link">다이어리</a></li>
					<li class="nav-item"><a href="#" class="nav-link">칼로리 사전</a></li>
					<li class="nav-item"><a href="#" class="nav-link">칼로리 처방</a></li>
					<li class="nav-item"><a href="#" class="nav-link">커뮤니티</a></li>
					<li class="nav-item"><a href="#" class="nav-link">쇼핑</a>
						<ul class="dropdown">
							<li><a href="#">식단</a></li>
							<li><a href="#">간식</a></li>
							<li><a href="#">운동기구</a></li>
							<li><a href="#">운동복</a></li>
							<li><a href="#">브랜드관</a></li>
						</ul></li>
					<!-- 회원 로그인시  -->
					<c:if test="${sessionScope.MTYPE eq 0 }"></c:if>
					<li class="nav-item"><a href="#" class="nav-link">마이페이지</a>
						<ul class="dropdown">
							<li><a href="#">주문/배송조회</a></li>
							<li><a href="#">취소/반품조회</a></li>
							<li><a href="#">장바구니</a></li>
							<li><a href="#">배송지 관리</a></li>
							<li><a href="#">상품 문의</a></li>
							<li><a href="#">내 정보</a></li>
						</ul></li>

					<!-- 기업 로그인시   -->
					<c:if test="${sessionScope.MTYPE eq 1 }"></c:if>
					<li class="nav-item"><a href="#" class="nav-link">기업</a>
						<ul class="dropdown">
							<li><a href="#">주문 관리</a></li>
							<li><a href="#">상품 관리</a></li>
							<li><a href="#">상품리뷰/문의</a></li>
							<li><a href="#">기업 정보 관리</a></li>
							<li><a href="#">문의사항</a></li>
						</ul></li>

					<!-- 관리자 로그인시   -->
					<c:if test="${sessionScope.MTYPE eq null}"></c:if>
					<li class="nav-item"><a href="#" class="nav-link">관리자</a>
						<ul class="dropdown">
							<li><a href="#">기업/회원 관리</a></li>
							<li><a href="#">기업 문의 관리</a></li>
							<li><a href="#">커뮤니티 관리</a></li>
							<li><a href="#">칼로리 사전 관리</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
	</nav>
	<hr>

	<!-------------------- body -------------------->
	<div id="wrap">
		<div class="wrap-left">
			<div class="left_menu">
				<p class="left_tit">
					<a href="">기업</a>
				</p>
				<ul class="left_menu_box">
					<li class="left_menu_m1">주문관리</li>
					<li class="on"><a href="#">주문/배송관리</a></li>
					<li><a href="#">취소/반품관리</a></li>
				</ul>

				<ul class="left_menu_box">
					<li class="left_menu_m1">상품관리</li>
					<li><a href="#">상품 등록/수정/삭제</a></li>
					<li><a href="#">재고 관리</a></li>
				</ul>

				<ul class="left_menu_box">
					<li class="left_menu_m1">문의/리뷰관리</li>
					<li><a href="#">상품 문의 관리</a></li>
					<li><a href="#">상품 리뷰 관리</a></li>
				</ul>

				<ul class="left_menu_box">
					<li class="left_menu_m1">관리자에게</li>
					<li><a href="#">문의사항</a></li>
				</ul>

				<ul class="left_menu_box last">
					<li class="left_menu_m1">기업정보관리</li>
					<li><a href="#">기업정보 확인/수정</a></li>
				</ul>
			</div>
		</div>

		<div class="wrap-right">
			<decorator:body />
		</div>

	</div>

	<!-------------------- footer -------------------->
	<div
		style="text-align: center; padding: 30px; background-color: #f5f5f5;">
		footer<br /> ~~<br /> ~~<br /> ~~
	</div>
</body>

</html>