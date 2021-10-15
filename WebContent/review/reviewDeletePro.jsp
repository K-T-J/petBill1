<%@page import="pet.rev.model.RevDTO"%>
<%@page import="pet.rev.model.RevDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<jsp:useBean id="dto" class = "pet.rev.model.RevDTO"/>


 
<%
	request.setCharacterEncoding("UTF-8");
	String admin = (String)session.getAttribute("admin");
	System.out.println("admin pro : " + admin);
	String userId = (String)session.getAttribute("userId");
	System.out.println("userId pro : " + userId);
	String hosId = (String)session.getAttribute("hosId");
	System.out.println("hosId pro : " + hosId);
	String userPw = request.getParameter("userPw");
	 System.out.println("userPw pro : " + userPw);
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	 System.out.println("reviewno pro : " + reviewNo);
	
	RevDAO dao = RevDAO.getInstance();
	// 리뷰 삭제 비밀번호 확인 후
	if(userId != null){
	int result = dao.deleteReview(userId, userPw, reviewNo);
	System.out.println("결과값 : "+ result);
	if(result == 1){ %>
		<script>
			alert("삭제완료"); 
			history.go(-4);
		</script>
	<%}else{%>
		<script>
			alert("실패");
			history.go(-1);
		</script>
	<%} %>
	<%}else if(admin != null){
	int result = dao.AdminDelete(reviewNo); 
	System.out.println("결과값2 : "+ result);
	if(result == 1){ %>
		<script>
			alert("삭제완료"); 
			history.go(-4);
		</script>
	<%}else{%>
		<script>
			alert("실패");
			history.go(-1);
		</script>
	<%}
	
	}%>
<body>

</body>
</html>