<%@page import="pet.user.model.UserDTO"%>
<%@page import="pet.user.model.UserDAO"%>
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
	if(session.getAttribute("userId") != null || session.getAttribute("hosId")!=null || session.getAttribute("admin")!=null){%>
	<script>
			alert("잘못된 경로입니다");
			window.location = "/petBill/search/main.jsp";
	</script>
<%}else{ %>

<jsp:useBean id="dto" class = "pet.user.model.UserDTO"/>
<jsp:setProperty property="*" name="dto"/>

<%
	
	String userName = request.getParameter("userName");
	String userMobile = request.getParameter("userMobile");
	
	
	
	
	UserDAO dao = UserDAO.getInstance();
	String dbid = dao.findid(userName,userMobile);

	
	if(dbid != null){%>
		<script>
			alert("아이디는 <%=dbid%> 입니다");
			window.location = "loginForm.jsp";
		</script>
			<%--response.sendRedirect("loginForm.jsp");--%>
	<%}else{%>
		<script>
			alert("일치하지 않습니다 다시 확인해주세요");
			history.go(-1);
		</script>
	<%}

%>

<body>

</body>
<%} %>
</html>