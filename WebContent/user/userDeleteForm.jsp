<%@page import="pet.user.model.UserDTO"%>
<%@page import="pet.user.model.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<link href="style.css" rel = "stylesheet" type = "text/css">
</head>
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
<body>
	
<% 
	request.setCharacterEncoding("UTF-8"); 
	if(session.getAttribute("userId") == null && session.getAttribute("hosId")==null && session.getAttribute("admin")==null){%>
	<script>
			alert("로그인 해주세요");
			window.location = "/petBill/user/loginForm.jsp";
	</script>


	<%}else{
		//회원 정보 뿌려주기
		String id = (String)session.getAttribute("userId");
		UserDAO dao = UserDAO.getInstance();
		UserDTO dto = dao.getUser(id);
	%>
	
</head>
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
	
	<div style="display: flex; height: 600px;">
		<div style="height: 100%; width: 30%;">
			<div>
				<table style="padding: 80px; margin-left: 26px;">
					<tr bgcolor="lightgray">
						<td>
							<button onclick="window.location='/petBill/user/userMypage.jsp'"><h1>회원정보</h1></button>
						</td>
					</tr>
					<tr>
						<td>
							<button onclick="window.location='/petBill/user/userReviewList.jsp'"><h1>후기관리</h1></button>
						</td>
					</tr>
					<tr>
						<td>
							<button onclick="window.location='/petBill/search/error2.jsp'"><h1>QnA</h1></button>
						</td>
					</tr>
					<tr>
						<td>
							<button onclick="window.location='/petBill/user/userDeleteForm.jsp'"><h1>회원탈퇴</h1></button>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div style="height: 100%; width: 50%;">
			<h1 style=" margin-left: 195px;">회원탈퇴</h1>
			<form action="userDeletePro.jsp" method="post">
				<table style="margin-left: 195px;">
					<tr>
						<td>아이디<br/>
							<%= dto.getUserId()%>
						</td>
					</tr>
					<tr>
						<td><br/>비밀번호<br/>
							<%= dto.getUserPw() %>
						</td>
					</tr>
					<tr>
						<td><br/>이름<br/>
							<%= dto.getUserName() %>
						</td>
					</tr>
					<tr>
						<td><br/>휴대폰<br/>
							<%=dto.getUserMobile()%>
						</td>
					</tr>
					<tr>
						<td><br/>닉네임<br/>
							<%=dto.getUserNick() %>
						</td>
					</tr>
					<tr>
						<td><br/>주소<br/>
								<%=dto.getUserSiAddress()%>
					</tr>
					<tr>
						<td>
							<%=dto.getUserSelectAddress() %>
						</td>
					</tr>
					<tr>
						<td>
							<%=dto.getUserDetailAddress() %>
						</td>
					</tr>
					<tr>
						<td>비밀번호<br/>
						<input type="password" name="userPw"/></td>
					</tr>
					
					<tr>	
						<td><br/>
							<input style="height: 40px; width: 220px;" class="back" type="submit" value = "탈퇴하기"/>
						</td>
					</tr>
				</table>
			</form>	
		</div>
	</div>
	
<footer style="height: 240px;">
</footer>
	
</body>
<%} %>
</html>