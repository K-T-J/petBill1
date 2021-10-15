<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="style.css" rel = "stylesheet" type = "text/css">
</head>
<%
	if(session.getAttribute("userId") != null || session.getAttribute("hosId")!=null || session.getAttribute("admin")!=null){%>
	<script>
		alert("잘못된 경로 입니다.");
		window.location = "/petBill/search/main.jsp";
	</script>	

<%}else{ %>

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
		
		
	<h1 align = "center">로그인</h1>
	<div>
		<div align="center">
		<form action = "loginPro.jsp" method = "post">
			<table>
				<tr>
					<td>
						<input type="radio" name = "login" value = "0" checked="checked"/>회원 로그인
						<input type="radio" name = "login" value = "1"/>병원 로그인
					</td>
				</tr>
				<tr>
					<td> 아이디  <br/>
						<input type = "text" name = "userId"/>
					</td>
				</tr>
				<tr>
					<td><br/>비밀번호 <br/>
						<input type = "password" name = "userPw"/>
						<input type = "checkbox" name = "auto" value="1"/>자동로그인
					</td>
				</tr>
				<!-- <tr>
					<td>
					</td>
				</tr> -->
			</table>
			<table style="padding: 15px">
				<tr>
					<td>
						<input style="width: 100px;" class="back" type = "submit" value="로그인"/>
						<input style="width: 100px;" class="back" type = "button" onclick = "window.location='signupMain.jsp'" value = "회원가입">
						<input style="width: 150px;" class="back" type = "button" onclick = "window.location='findIdFormMain.jsp'" value = "아이디 / 비번찾기"> <%-- 기본 보여주는건 아이디 찾기 --%>
					</td>
				</tr>
			</table>
		</form>
		</div>
	</div>
	
</body>
<%} %>
</html>