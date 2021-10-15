<%@page import="pet.hos.model.HosDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
</head>
<% 
	request.setCharacterEncoding("UTF-8");
%>	

<jsp:useBean id="hosDto" class = "pet.hos.model.HosDTO"/>

<%
	
	String hosName = request.getParameter("hosName");
	String hosTel = request.getParameter("hosTel");
	
	
	HosDAO dao = HosDAO.getInstance();
	String dbid = dao.hosFindId(hosName,hosTel);

	
	if(dbid != null){%>
		<script>
			alert("아이디는 <%=dbid%> 입니다");
			window.location = "../user/loginForm.jsp";
		</script>
	<%}else{%>
		<script>
			alert("아이디/전화번호가 다릅니다");
			history.go(-1);
		</script>
	<%}

%>

<body>

</body>
</html>