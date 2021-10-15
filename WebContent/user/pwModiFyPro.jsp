<%@page import="pet.hos.model.HosDAO"%>
<%@page import="pet.user.model.UserDAO"%>
<%@page import="pet.user.model.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> 
<title>비밀번호 찾기</title>
<%
	request.setCharacterEncoding("UTF-8");
	if(session.getAttribute("userId") == null && session.getAttribute("hosId")==null && session.getAttribute("admin")==null){%>
	<script>
		alert("로그인 해주세요");
		window.location = "/petBill/user/loginForm.jsp";
	</script>

<%}else{
	String userId = (String)session.getAttribute("userId");
	String hosId = (String)session.getAttribute("hosId");
	
	
	
	int result1 = 0;
	int result2 = 0; 
	if(userId != null){
	String userPw = request.getParameter("userPw");
	String userPwModify = request.getParameter("userPwModify");
	String userPwch = request.getParameter("userPwModifych");
	
	UserDAO dao = UserDAO.getInstance();
	result1 = dao.pwupdateUser(userId, userPw, userPwModify);
	
	}else if(hosId != null){
	String hosPw = request.getParameter("userPw");
	String hosPwModify = request.getParameter("userPwModify");
	String hosPwch = request.getParameter("userPwModifych");
	
	HosDAO dao = HosDAO.getInstance();
	result2 = dao.pwupdateHos(hosId, hosPw, hosPwModify);
	
	}else{%>
		<script>
			history.go(-1);
		</script>
	<%}
	
	if(result1 == 1 || result2 == 1){%>
		<script>
			alert("성공");
			<%
				session.invalidate();//세션삭제
			
				Cookie[] coos = request.getCookies();//쿠키삭제
				if(coos != null){
					for(Cookie c : coos){
						if(c.getName().equals("autoId") || c.getName().equals("autoPw") || c.getName().equals("autoAuto") || c.getName().equals("autologin")){
							c.setDomain("localhost");
							c.setPath("/petBill");
							c.setMaxAge(0);
							response.addCookie(c);
						}
					}
				}
			
			
			
			%>
			window.location="/petBill/search/main.jsp";
		</script>
	<%}else{%>
		<script>
			alert("비밀번호가 틀렸습니다.");
			history.go(-1);
		</script>
	<%}%> 
</head>
<body>
<%} %>

</body>
</html>