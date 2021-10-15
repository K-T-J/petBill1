<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<link href="style.css" rel = "stylesheet" type = "text/css">
<style>
table.b {
		width: 100%;
		border-top: 1px solid #444444;
		border-collapse: collapse;
		}
th, td {
		border-bottom: 1px solid #444444;
		padding: 10px;
		}
</style>




</head>
<%
	if(session.getAttribute("userId") == null && session.getAttribute("hosId")==null && session.getAttribute("admin")==null){%>
	<script>
		alert("로그인 해주세요");
		window.location = "/petBill/user/loginForm.jsp";
	</script>
<%}else{
	String userId = (String)session.getAttribute("userId");
	String hosId = (String)session.getAttribute("hosId");
	String admin = (String)session.getAttribute("admin");
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
	
	
	<br/>
	<h1 align = "center">회원 비밀번호 수정</h1>
	
	<form action = "pwModiFyPro.jsp" method = "post">
	<div align = "center">
		<table>
			<tr>
				<td>기존 비밀번호<br/>
					<input type="password" name="userPw"/>
				</td>
			</tr>
			<tr>
				<td><br/>수정 비밀번호<br/>
					<input type="password" name="userPwModify"/>
				</td>
			</tr>
			<tr>
				<td><br/>수정 비밀번호 확인<br/>
					<input type="password" name="userPwModifych"/>
				</td>
			</tr>
			<tr>	
				<td><br/>
					<input class="back" type="submit" value="수정"/>
					<input class="back" type="button" value="취소" onclick= "window.location='/petBill/search/main.jsp'"/>
				</td>
			</tr>
		</table>
	</div>
	
	</form>
</body>
<%} %>
</html>