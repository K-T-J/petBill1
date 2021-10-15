<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="pet.hos.model.HosDAO"%>
<%@ page import="pet.hos.model.HosDTO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 전체 List</title>
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
	
	// 회원 전체 리스트 불러오는 메서드
	int pageSize = 10;
	String pageNum = request.getParameter("pageNum");	
	if (pageNum == null) {								
		pageNum = "1";									
	}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	
	HosDAO dao = HosDAO.getInstance();
	
	String adminHosSearch = request.getParameter("adminHosSearch");
	
	List adminHosTotalList = null;
	int count = 0;
	int number = 0;
	
	if (adminHosSearch != null) {	// admin 마이페이지에서 회원 검색 했을시. 
		count = dao.getHosTotalSearchListCount(adminHosSearch);
		 
		if (count > 0) {
			adminHosTotalList = dao.getAdminHosSearchList(startRow, endRow, adminHosSearch);
		}
	} else { // admin 마이페이지에서 검색하지 않았거나 첫 페이지시. 
		count = dao.getAdminHosTotalCount(); 
		System.out.println("전체 유저 수 count : " + count);
		
		if (count > 0) {
			adminHosTotalList = dao.getgetAdminHosTotalList(startRow, endRow);
		} 
	}
	number = count - (currentPage - 1) * pageSize;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
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
	        	<form action="adminHosTotalList.jsp" method="post">
	            	<input type="text" name="adminHosSearch" placeholder="병원명 검색" style="width: 550px; height: 75px; margin-top: 40px; border-radius: 10px;"/>
	            	<input class="input" type="submit" value="검색" /> 
	            </form>
	      	</section>
	   	</div>
	   	
	   	
	<div style="display: flex; height: 422px;">
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
		
		<div style="width: 800px; padding: 40px;">
	<%if (count == 0) {%>
		<h2>병원가입 전체 목록</h2>
		<br />
			<table>
				<tr>
					<td><h1>가입한 병원회원이 없습니다.</h1></td>
				</tr>
			</table>
	<%} else {%>
		<h2>병원가입 전체 목록</h2>
		<br />
			<table>
				<tr>
					<td>No.</td>
					<td>병원명</td>
					<td>시 주소</td>
					<td>구 주소</td>
					<td>전화번호</td>
					<td>활동상태</td>
				</tr>
			<%
				for (int i = 0; i < adminHosTotalList.size(); i++) {
					HosDTO hosToDto = (HosDTO)adminHosTotalList.get(i);
			%>
				<tr>
					<td><%=number--%></td>
					<td><a href="adminHosResult.jsp?hosNo=<%=hosToDto.getHosNo()%>"><%=hosToDto.getHosName()%></a></td>
					<td><%=hosToDto.getHosSiAddress()%></td>
					<td><%=hosToDto.getHosGuAddress()%></td>
					<td><%=hosToDto.getHosTel()%></td>
					<td><%=hosToDto.getHosActiveNum()%></td>
				</tr>
				<%}%>
			</table>
			<%-- 하단 번호 만들기 --%>
		<div style="text-align: center; width: 571px;">
		<%
			if (count > 0) {
				int pageBlock = 5;		// '1 2 3 > ' '< 4 5 6 ' 이런 식으로 
				int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
				int startPage = (int)((currentPage - 1) / pageBlock) * pageBlock + 1;
				int endPage = startPage + pageBlock - 1; 
				if (endPage > pageCount) {
					endPage = pageCount;
				}
				// 검색시 페이지 번호 처리 
				if (adminHosSearch != null) {	// 검색했을때 
					// 왼쪽 꺽쇄 
					if (startPage > pageBlock) {
			%>
						<a href="adminHosTotalList.jsp?pageNum=<%=startPage-pageBlock%>&adminHosSearch=<%=adminHosSearch%>" >&lt; &nbsp;</a>
			<%			
					}
					// 번호 뿌리
					for (int i = startPage; i <= endPage; i++) {
			%>
						<a href="adminHosTotalList.jsp?pageNum=<%= i %>&adminHosSearch=<%=adminHosSearch%>" > &nbsp; <%= i %> &nbsp; </a>
			<%		
					}
					if (endPage < pageCount) {
			%>
						&nbsp; <a href="adminHosTotalList.jsp?pageNum=<%=startPage+pageBlock %>&adminHosSearch=<%=adminHosSearch%>"> &gt; </a>
			<%			
					}
				} else {	// 검색안했을때 
					// 왼쪽 꺽쇄 
					if (startPage > pageBlock) {
			%>
						<a href="adminHosTotalList.jsp?pageNum=<%=startPage-pageBlock %>"> &lt; &nbsp;</a>
			<%
					}
					// 페이지 번호 뿌리기 
					for (int i = startPage; i <= endPage; i++) {
			%>
						<a href="adminHosTotalList.jsp?pageNum=<%=i%>"> &nbsp; <%= i %> &nbsp; </a>
			<%			
					}
					// 오른쪽 꺽쇄 
					if (endPage < pageCount) {
			%>
						&nbsp; <a href="adminHosTotalList.jsp?pageNum=<%=startPage+pageBlock%>"> &gt; </a>
			<%
					}
				}
			}
		%>
	<%}%>
	
	</div>
</div>	



</body>
<%}%> 
</html>