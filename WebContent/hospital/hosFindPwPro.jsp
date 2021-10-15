<%@page import="pet.hos.model.HosDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="dto" class="pet.user.model.UserDTO"/>

<%
	String hosId = request.getParameter("hosId");
	String hosUserName = request.getParameter("hosUserName");
	String hosMobile = request.getParameter("hosMobile");
%>
<%
	HosDAO dao = HosDAO.getInstance();
	String dbpw = dao.hosFindPw(hosId,hosUserName,hosMobile);
	
	if(dbpw != null){%>
	<script>
		alert("비밀번호는 <%=dbpw%> 입니다");
		window.location = "../user/loginForm.jsp";
	</script>
		<%--response.sendRedirect("loginForm.jsp");--%>
<%}else{%>
	<script>
		alert("아이디/비밀번호가 틀립니다");
		history.go(-1);
	</script>
<%}
%>

<body>

</body>
</html>