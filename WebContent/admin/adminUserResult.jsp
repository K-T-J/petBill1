<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="pet.user.model.UserDAO"%>
<%@ page import="pet.user.model.UserDTO"%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 회원 정보</title>
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




<%
	request.setCharacterEncoding("UTF-8");
	
	//세션 처리해주기. 
	String userId = (String)session.getAttribute("userId");
	String hosId = (String)session.getAttribute("hosId");
	String admin = (String)session.getAttribute("admin");
	
	// 파라미터 꺼내기 
	String adminUserId = request.getParameter("userId");
	System.out.println("jsp adminUserId : " + adminUserId);
	
	UserDAO dao = UserDAO.getInstance();
	UserDTO adUserDto = dao.getAdminUser(adminUserId);
%>		
</head>
<body>
		
<%
	if (userId == null && hosId == null && admin == null) { // session check 'admin != true'
%>
		<script>
			alert("잘못된 페이지 요청입니다.");
			window.location = "/petBill/search/main.jsp";
		</script>
	
<%	
	} else { // sesion check 'admin == true'
%>
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
							<button onclick="window.location='/petBill/admin/adminUserList.jsp'"><h1>회원정보</h1></button>
						</td>
					</tr>
					<tr>
						<td>
							<button onclick="window.location='/petBill/admin/adminHosList.jsp'"><h1>병원정보</h1></button>
						</td>
					</tr>
					<tr>
						<td>
							<button onclick="window.location='/petBill/admin/adminDisModify.jsp'"><h1>질병정보</h1></button>
						</td>
					</tr>
				</table>
			</div>
		</div>
		
		<div style="height: 100%; width: 50%;">
			<div>
			<h1 style=" margin-left: 195px;">회원 정보</h1>
				<table style="margin-left: 195px;">
					<tr>
						<td>아이디<br/>
							<%=adUserDto.getUserId()%>
						</td>
					</tr>
					<tr>
						<td><br/>비밀번호<br/>
							<%= adUserDto.getUserPw() %>
						</td>
					</tr>
					<tr>
						<td><br/>이름<br/>
							<%= adUserDto.getUserName() %>
						</td>
					</tr>
					<tr>
						<td><br/>휴대폰<br/>
							<%=adUserDto.getUserMobile()%>
						</td>
					</tr>
					<tr>
						<td><br/>닉네임<br/>
							<%=adUserDto.getUserNick() %>
						</td>
					</tr>
					<tr>
						<td><br/>주소<br/>
								<%=adUserDto.getUserSiAddress()%>
					</tr>
					<tr>
						<td>
							<%=adUserDto.getUserSelectAddress() %>
						</td>
					</tr>
					<tr>
						<td>
							<%=adUserDto.getUserDetailAddress() %>
						</td>
					</tr>
					<tr>
						<td><br/>가입날짜<br/>
							<%=adUserDto.getUserReg() %>
						</td>
					</tr>
					
					<tr>	
						<td>
							<br/>
							<button onclick="window.location ='adminUserList.jsp'">리스트</button>
						</td>
					</tr>
				</table>
			</div>
		</div>	
	</div>			
</body>
<%}%>		
</html>