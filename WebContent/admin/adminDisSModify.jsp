<%@page import="pet.cat.model.CatSDTO"%>
<%@page import="java.util.List"%>
<%@page import="pet.cat.model.CatDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

if(session.getAttribute("admin") != null){ // admin 관리자 세션이 있을때 (관리자가 로그인했을때 보여질 페이지.)

	String userId = (String)session.getAttribute("userId");
	String hosId = (String)session.getAttribute("hosId");
	String admin = (String)session.getAttribute("admin");
	
	//게시글 수 
	int pageSize = 10;
	
	// 현재 페이지 번호
	String pageNum = request.getParameter("pageNum"); // pageNum이 넘어오면 담기
	if(pageNum == null){ // pageNum이 안넘어오면 1
		pageNum = "1";
	}
	
	// 게시글 시작과 끝
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	
	
	// DB에서 대분류 정보 다 가져와서 밑에 화면에 뿌려주기 
	CatDAO dao = new CatDAO(); 
	List catSmall = dao.getCatSmall(startRow, endRow);  
	System.out.println("catSmall : "+catSmall);
	
	// 소분류 테이블의 총 갯수 가져올 메서드 
	int count = dao.getDisSModifycount(); 
	System.out.println("count몇 뜨냐? :" + count);
	int number = count-(currentPage-1)*pageSize;
	System.out.println("number몇 뜨냐? :" + number);
	
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
	
	
	<div align="center">
	<h1 align="center">  질병 수정(소분류) </h1>
	<table>
		<tr>
			<td>NO</td>
			<td>대분류</td>
			<td>소분류</td>
			
		</tr>
		<% 
			CatSDTO dto = null;
			for(int i = 0; i < catSmall.size(); i++){ 
	 		dto = (CatSDTO)catSmall.get(i); 
		%>
		<tr>
			<td><%=number-- %></td>
				<form action="adminDisSModiForm.jsp?subLptNo=<%=dto.getSubLptNo() %>" method="post" >
					<input type="hidden" name="subNo" value= "<%=dto.getSubNo()%>"/>
						<td><%=dto.getLptName() %></td>				
						<td><%=dto.getSubName() %></td>
						<td><input class="back" type="submit" value="수정"  /></td>
						<td><input class="back" type="button" value="삭제" onclick="window.location='adminDisSDelPro.jsp?subNo=<%=dto.getSubNo()%>'"/></td>
					
				</form>
		</tr>
		<%} // close of the 'for(int i = 0; i < catSmall.size(); i++)' %>
	
		<%--페이지 번호 --%>
			<br/><br/>
     		<div>
     		<%
     		//페이지 번호를 몇개까지 보여줄것인지
     		int pageBlock = 5;
     		
     		//총 몇페이지가 나오는지 계산
     		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
     		//현재 페이지에서 보여줄 첫번째 페이지번호
     		int startPage = (int)((currentPage-1)/pageBlock)* pageBlock + 1;
     		
     		//현재 페이지에서 보여줄 마지막 페이지번호 (~10,~20,~30....)
     		int endPage = startPage + pageBlock -1;
     		// 마지막에 보여줄 페이지번호는, 전체 페이지 수에 따라 달라질 수 있다. 
    		// 전체 페이지수(pageCount)가 위에서 계산한 endPage(10단위씩)보다 작으면 
    		// 전체 페이지수가 endPage가 된다. 
			     		
     		if(endPage > pageCount) {endPage = pageCount;}
     		
     		if(count > 0){
     			// 왼쪽 꺽쇄 : startPage 가 pageBlock(10)보다 크면 
        		if(startPage > pageBlock) { %>
        			<a href="/petBill/admin/adminDisSModify.jsp?pageNum=<%=startPage-pageBlock %>" > &lt; &nbsp;</a>
        		<%}
        		
        		// 페이지 번호 뿌리기 
        		for(int i = startPage; i <= endPage; i++){ %>
        			<a href="/petBill/admin/adminDisSModify.jsp?pageNum=<%=i%>" > &nbsp; <%= i %> &nbsp; </a>
        		<%}
        		
        		// 오른쪽 꺽쇄 : 전체 페이지 개수(pageCount)가 endPage(현재보는페이지에서의 마지막번호) 보다 크면 
        		if(endPage < pageCount) { %>
        			&nbsp; <a href="/petBill/admin/adminDisSModify.jsp?pageNum=<%=startPage+pageBlock%>" > &gt; </a>
        		<%}%>
     		<%}else{	// close of the 'if(count > 0)'
     			// 왼쪽 꺽쇄 : startPage 가 pageBlock(10)보다 크면 
        		if(startPage > pageBlock) { %>
        			<a href="/petBill/admin/adminDisSModify.jsp?pageNum=<%=startPage-pageBlock %>" > &lt; &nbsp;</a>
        		<%}
        		
        		// 페이지 번호 뿌리기 
        		for(int i = startPage; i <= endPage; i++){ %>
        			<a href="/petBill/admin/adminDisSModify.jsp?pageNum=<%=i%>" > &nbsp; <%= i %> &nbsp; </a>
        		<%}
        		
        		// 오른쪽 꺽쇄 : 전체 페이지 개수(pageCount)가 endPage(현재보는페이지에서의 마지막번호) 보다 크면 
        		if(endPage < pageCount) { %>
        			&nbsp; <a href="/petBill/admin/adminDisSModify.jsp?pageNum=<%=startPage+pageBlock%>" > &gt; </a>
        		<%}
        		
        		} // close of the 'else' %>
     	
   		  </div>
	
		<tr>
			<td><input class="back" type="button" value="등록" onclick="window.location='adminDisSAddForm.jsp'"/></td>
			<td><input class="back" style="width: 100px;" type="button" onclick = "window.location='adminDisModify.jsp'" value="뒤로가기">
		</tr>
	</table>
	</div>
</body>
<%}else{ // 유효성 검사 if  %>
		<script>
	  	 alert("잘못된 경로입니다."); 
	  	 window.location = "/petBill/search/main.jsp"; 
		</script>
<%} %>
</html>