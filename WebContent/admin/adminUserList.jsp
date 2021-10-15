<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.List"%>
<%@ page import="pet.user.model.UserDAO"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="pet.user.model.UserDTO"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		
</head>
<%
	request.setCharacterEncoding("UTF-8");

	//세션 처리해주기. 
	String userId = (String)session.getAttribute("userId");
	String hosId = (String)session.getAttribute("hosId");
	String admin = (String)session.getAttribute("admin");
	
	// 회원 전체 리스트 불러오는 메서드
	int pageSize = 10;
	String pageNum = request.getParameter("pageNum");	
	if (pageNum == null) {								
		pageNum = "1";									
	}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	
	UserDAO dao = UserDAO.getInstance();
	
	String adminUserSearch = request.getParameter("adminUserSearch");
	
	List adminUserList = null;
	int count = 0;
	int number = 0;
	
	if (adminUserSearch != null) {	// admin 마이페이지에서 회원 검색 했을시. 
		count = dao.getAdminUserSearchCount(adminUserSearch);
		System.out.println("검색 유저 수 count : " + count);
		
		if (count > 0) {
			adminUserList = dao.getAdminUserSearchList(startRow, endRow, adminUserSearch);
		}
	} else { // admin 마이페이지에서 검색하지 않았거나 첫 페이지시.
		count = dao.getAdminUserCount();
		System.out.println("전체 유저 수 count : " + count);
		
		if (count > 0) {
			adminUserList = dao.getgetAdminUserList(startRow, endRow);
		}
	}
	number = count - (currentPage - 1) * pageSize;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
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
<%
	if (userId == null && hosId == null && admin == null) { // session check 'admin != true'
%>
		<script>
			alert("잘못된 페이지 요청입니다.");
			window.location = "/petBill/search/main.jsp";
		</script>
<%
	} else {	// session check 'admin == true'
%>
	    <%-- (1-1) search(검색)form 만들기. --%>
	    <div align="center">
	    	<section>
	        	<form action="adminUserList.jsp" method="post">
	            	<input type="text" name="adminUserSearch" placeholder="회원 ID 검색" style="width: 550px; height: 75px; margin-top: 40px; border-radius: 10px;"/>
	            	<input class="input" type="submit" value="검색" /> 
	            </form>
	      	</section>
	   	</div>
<div style="display: flex; height: 600px;">
		<div style="height: 100%; width: 30%;">
			<div>
				<table style="padding: 80px; margin-left: 26px;">
					<tr>
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
	   		<div style="width: 800px; padding: 92px;">
				<%if (count == 0) {%>
					<table align="center">
						<tr>
							<td><h1>가입한 회원이 없습니다.</h1></td>
						</tr>
					</table>
					<%} else {%>
					<table>
						<tr>
							<td>No.</td>
							<td>사용자 ID</td>
							<td>사용자 Nick</td>
							<td>가입날짜</td>
						</tr>
					<%
						for (int i = 0; i < adminUserList.size(); i++) {
						UserDTO userArticle = (UserDTO)adminUserList.get(i);
					%>
						<tr>
							<td><%=number--%></td>
							<td><a href="adminUserResult.jsp?userId=<%=userArticle.getUserId()%>"><%=userArticle.getUserId()%></a></td>
							<td><%=userArticle.getUserNick()%></td>
							<td><%=sdf.format(userArticle.getUserReg())%></td>
						</tr>
					<%} // close of the for%>
					</table>
				<%}%>
		
		<%-- 하단에 번호 만들기 --%>
		<div style="text-align: center; width: 571px;">
	<%
		if (count > 0) {
			int pageBlock = 5;
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			int startPage = (int)((currentPage - 1) / pageBlock) * pageBlock + 1;
			int endPage = startPage + pageBlock - 1; 
			if (endPage > pageCount) {
				endPage = pageCount;
			}
			
			// 검색시, 페이지 번호 처리 
			if (adminUserSearch != null) {
				if (startPage > pageBlock) {
	%>
					<a href="adminUserList.jsp?pageNum=<%=startPage-pageBlock%>&adminUserSearch=<%=adminUserSearch%>">&lt; &nbsp;</a>
		<%
				} // close of the 'if(startPage > pageBlock)'
				for (int i = startPage; i <= endPage; i++) {
		%>
					<a href="adminUserList.jsp?pageNum=<%=i%>&adminUserSearch=<%=adminUserSearch%>"> &nbsp; <%=i%> &nbsp; </a>
		<%
				}
				if (endPage < pageCount) {
		%>
					&nbsp; <a href="adminUserList.jsp?pageNum=<%=startPage+pageBlock %>&adminUserSearch=<%=adminUserSearch%>"> &gt; </a>
		<%
				}
			} else {	// 검색 안했을때 
				// 왼쪽 꺽쇄 
				if (startPage > pageBlock) {
		%>
					<a href="adminUserList.jsp?pageNum=<%=startPage-pageBlock %>"> &lt; &nbsp;</a>
		<%
				}
				// 페이지 번호 뿌리기.
				for (int i = startPage; i <= endPage; i++) {
		%>
					<a href="adminUserList.jsp?pageNum=<%=i%>"> &nbsp; <%= i %> &nbsp; </a>
		<%		
				}
				// 오른쪽 꺽쇄 
				if(endPage < pageCount) {
		%>
					&nbsp; <a href="adminUserList.jsp?pageNum=<%=startPage+pageBlock%>"> &gt; </a>
		<%				
				}
			}
		%>
		
	<%			
		}
	%>
		</div>

<%		
	}
%>
</div>
</div>
	</body>
</html>