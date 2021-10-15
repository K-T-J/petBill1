<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>subMain</title>
<link href="style.css" rel = "stylesheet" type = "text/css">
	</head>
	
	<%
		// (41) subMain -> searchResult 클릭시 구 평균 뿌려줄 초기값인 '강남구' 뿌려주기 위한 페이징 처리 해주기
		String guSel = request.getParameter("guSel");
		if (guSel == null) {
			guSel = "notSelect";
		}
	%>
	<%
		String userId = (String)session.getAttribute("userId");
		System.out.println("서브 유저 아이디 : " + userId);
		String hosId = (String)session.getAttribute("hosId");
		System.out.println("서브 병원 : " + hosId);
		String admin = (String)session.getAttribute("admin");
		System.out.println("서브 관리자: " + admin);
	%>
	
	
	
<body>
<header>
	<div style="width: 30%">
		<a href = "/petBill/search/main.jsp"><img src="/petBill/save/로고화면.png" style="height: 100%;margin-left: 100px;"></a>
	</div>
	
	<div style="width: 50%">
		<div>
			<button onclick ="window.location='/petBill/search/searchResult.jsp'" style = "margin-top: 75px; margin-right: 25px; margin-left: 103px; height: 70px; width: 150px; border-radius: 10px;"><h3>진료비 검색</h3></button>
			<button onclick ="window.location='/petBill/disease/disLargeCate.jsp'" style ="margin-top: 75px; margin-right: 25px; height: 70px; width: 150px; border-radius: 10px;" ><h3>질병정보</h3></button>
			<button onclick ="window.location='/petBill/search/error.jsp'" style="margin-top: 75px; height: 70px; width: 150px; border-radius: 10px;" ><h3>공지사항</h3></button>
		</div>	
	</div>		
	
	<div style="width: 20%">
			<% if(session.getAttribute("hosId")!= null){%>
			<button onclick = "window.location = '/petBill/user/logoutPro.jsp'" style="margin-left: 80px; margin-right: 10px; height: 30%; width: 130px; border-radius: 10px; "><h3>로그아웃</h3></button>
			<button onclick = "window.location = '/petBill/hospital/hosMypage.jsp'"style="height: 30%; width: 138px;" ><h3>마이페이지</h3></button>
			<%}else if(session.getAttribute("userId")!= null){ %>
			<button onclick = "window.location = '/petBill/user/logoutPro.jsp'" style="margin-left: 80px; margin-right: 10px; height: 30%; width: 130px; border-radius: 10px;"><h3>로그아웃</h3></button>
			<button onclick = "window.location = '/petBill/user/userMypage.jsp'" style="height: 30%; width: 138px; border-radius: 10px;"><h3>마이페이지</h3></button>
			<%}else if(session.getAttribute("admin") != null){%> 
			<button onclick = "window.location = '/petBill/user/logoutPro.jsp'" style="margin-left: 80px; margin-right: 10px; height: 30%; width: 130px; border-radius: 10px;"><h3>로그아웃</h3></button> 
			<button onclick = "window.location = '/petBill/admin/adminUserList.jsp'"style="height: 30%; width: 138px; border-radius: 10px;"><h3>마이페이지</h3></button> 
			<%}else{ %>
			<button onclick = "window.location = '/petBill/user/loginForm.jsp'" style="margin-left: 80px; margin-right: 10px; height: 30%; width: 130px; border-radius: 10px;"><h3>로그인</h3></button>
			<button onclick = "window.location = '/petBill/user/signupMain.jsp'" style="height: 30%; width: 138px; border-radius: 10px;" ><h3>회원가입</h3></button>
			<%} %>
	</div>
</header>
	<div style="height: 500px; display: flex; margin: 100px">	
		<div style="display: flex; align-items: center; flex-direction: row; justify-content: center; width: 940px;">
			<div>
				<button style="width: 400px; height: 400px;" onclick="window.location='/petBill/search/searchResult.jsp?guSel=<%=guSel%>'"><h1>병원 진료비 정보</h1></button>
			</div>
		</div>
		<div style="width: 940px; display: flex; align-items: center; flex-direction: row; justify-content: center;">
			<div>
				<button style="width: 400px; height: 400px;" onclick="window.location='/petBill/disease/disLargeCate.jsp'"><h1>질병 정보</h1></button>
			</div>
		</div>	
		<div style="width: 940px; display: flex; align-items: center; flex-direction: row; justify-content: center;">
			<div>
				<button style="width: 400px; height: 400px;" onclick="window.location='/petBill/search/error.jsp'"><h1>사이트 공지사항</h1></button>
			</div>
		</div>	
	</div>
		
	</body>
</html>