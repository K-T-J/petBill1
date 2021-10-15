<%@page import="pet.hos.model.HosDTO"%>
<%@page import="pet.hos.model.HosDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>hosDeleteForm</title>
<link href="style.css" rel="stylesheet" type="text/css"/>
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
	request.setCharacterEncoding("UTF-8"); 
%>
	<!-- 비로그인시 접근불가 -->
<%	
	// 세션id값 없으면 로그인페이지로 이동 
	String hosId = (String)session.getAttribute("hosId");
	if(session.getAttribute("hosId") == null && session.getAttribute("userId") == null){ %>
		<script>
			alert("로그인이 필요합니다.");
			history.go(-1);
		</script>
<% 	}else{ 	
		HosDAO dao = HosDAO.getInstance();
		//회원정보 꺼내오기
		HosDTO hosDto = dao.getHosMember(hosId);
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
	
<!-- ======================================상단메뉴 구분선========================================= -->
	
	<div style="display: flex; height: 600px;">
		<div style="height: 100%; width: 30%;">
			<div>
				<table style="padding: 80px; margin-left: 26px;">
					<tr bgcolor="lightgray">
						<td>
							<button style="width: 190px; height: 95px;" onclick="window.location='/petBill/hospital/hosMypage.jsp'"><h1>병원<br/>회원정보</h1></button>
						</td>
					</tr>
					<tr>
						<td>
							<button style="width: 190px; height: 95px;" onclick="window.location='/petBill/search/error.jsp'"><h1>1:1문의</h1></button>
						</td>
					</tr>
					<tr>
						<td>
							<button style="width: 190px; height: 95px;" onclick="window.location='/petBill/search/error.jsp'"><h1>병원<br/>공지사항</h1></button>
						</td>
					</tr>
					<tr>
						<td>
							<button style="width: 190px; height: 95px;" onclick="window.location='/petBill/search/error.jsp'"><h1>병원<br/>이벤트</h1></button>
						</td>
					</tr>
					<tr>
						<td>
							<button style="width: 190px; height: 95px;" onclick="window.location='/petBill/hospital/hosDeleteForm.jsp'"><h1>회원탈퇴</h1></button>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div style="height: 100%; width: 50%;">
			<h1 style=" margin-left: 195px;">회원탈퇴</h1>
			<div class="right">
				<form action="hosDeletePro.jsp" method="post">
					<!-- 고유번호 보내기 -->
					<input type="hidden" name="hosNo" value="<%= hosDto.getHosNo()%>"/>
					<table style="margin-left: 195px;">
						<tr>
							<td>아이디<br/>
								<b><%= hosDto.getHosId()%></b>
							</td>
						</tr>
						<tr>
							<td>병원명<br/>
								<b><%= hosDto.getHosName() %></b>
							</td>
						</tr>
						<tr>
							<td>비밀번호 확인<br/>
							<input type="password" name="hosPw"/></td>
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
	</div>
<%}//else %>
</body>
</html>