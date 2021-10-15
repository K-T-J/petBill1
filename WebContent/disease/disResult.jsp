<%@page import="pet.cat.model.CatDAO"%>
<%@page import="pet.cat.model.CatSDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel = "stylesheet" type = "text/css"> 

<%
	int subNo = Integer.parseInt(request.getParameter("subNo"));
	System.out.println("subNo :" + subNo);
	
	CatDAO dao = new CatDAO();
	CatSDTO dto = dao.Sptdata(subNo);  
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
				<button onclick ="window.location='/petBill/search/error.jsp'" style ="margin-top: 75px; margin-right: 25px; height: 70px; width: 150px; border-radius: 10px;" ><h3>질병정보</h3></button>
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
	
	
	<div align="center" style="height: 760px;">	
		<img style="margin-top: 120px;width: 1000px;" src="/petBill/photo/<%=dto.getSubImg()%>" />
	</div>
	
	<div>  	
	<div>	  
	   	<br />	  
	   	<br />	  
	   	<br />	  
	   	<br />	  
	   	<table align = "center">
			<tr>
				<td>
					<button style="width: 400px;" onclick = "history.go(-1);">뒤로가기</button>
				</td>
			</tr>
		</table>
	</div>
</div>
	
	
	
</body>
</html>