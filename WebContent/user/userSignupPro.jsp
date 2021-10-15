<%@page import="pet.user.model.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<% 
	request.setCharacterEncoding("UTF-8");
	if(session.getAttribute("userId") != null || session.getAttribute("hosId") != null || session.getAttribute("admin") != null){%>
	<script>
		alert("잘못된 경로입니다.");
		window.location = "/petBill/search/main.jsp";
	</script>
<%}else{%>
<jsp:useBean id="dto" class="pet.user.model.UserDTO"/>
<jsp:setProperty property="*" name="dto"/>

<%

	UserDAO dao = UserDAO.getInstance();
	dao.userSignup(dto);
%>


<body>
	<script>
		alert("회원가입 되었습니다.");
		window.location = "/petBill/search/main.jsp";
	</script>
</body>
<%} %>
</html>