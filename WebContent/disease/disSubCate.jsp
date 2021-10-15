<%@page import="java.util.List"%>
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
</head>
<% 
	request.setCharacterEncoding("UTF-8"); 


	String userId = (String)session.getAttribute("userId");
	String hosId = (String)session.getAttribute("hosId");
	String admin = (String)session.getAttribute("admin");
	
	int lptNo = Integer.parseInt(request.getParameter("lptNo"));
	System.out.println("lptNo :" + lptNo);
	
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
	List catSmall = dao.SubCate(startRow, endRow, lptNo);
	System.out.println("catSmall123123123 : "+catSmall);
	
	
	
	// 소분류 테이블의 총 갯수 가져올 메서드 
	int count = dao.SubCatecount(lptNo); 
	int number = count-(currentPage-1)*pageSize;
	
%>


<body>
	<header style="margin-bottom: 100px;">
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
						<% 
							for(int i = 0; i < catSmall.size(); i++){ 
							CatSDTO dto = (CatSDTO)catSmall.get(i); 
						%>
						
<main>
	<div align="center" style="margin-top: 10px;">
		<div>
			<form action="disResult.jsp" method="post">
				<table>
					<tr>
						<td>
							<button onclick="window.location='disResult.jsp'">&nbsp;<%=dto.getSubName() %></button>
							<input type="hidden" name="subNo" value= "<%=dto.getSubNo()%>"/>
						</td>
					</tr>
				</table>	
			</form>
						<%}%>
		</div>
	</div>	
</main>			


	
			<%-- <div style="text-align: center; width: 571px;">
					페이지 번호
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
			        			<a href="/petBill/disease/disSubCate.jsp?pageNum=<%=startPage-pageBlock %>" > &lt; &nbsp;</a>
			        		<%}
			        		
			        		// 페이지 번호 뿌리기 
			        		for(int i = startPage; i <= endPage; i++){ %>
			        			<a href="/petBill/disease/disSubCate.jsp?pageNum=<%=i%>" > &nbsp; <%= i %> &nbsp; </a>
			        		<%}
			        		
			        		// 오른쪽 꺽쇄 : 전체 페이지 개수(pageCount)가 endPage(현재보는페이지에서의 마지막번호) 보다 크면 
			        		if(endPage < pageCount) { %>
			        			&nbsp; <a href="/petBill/disease/disSubCate.jsp?pageNum=<%=startPage+pageBlock%>" > &gt; </a>
			        		<%}%>
			     		<%}else{	// close of the 'if(count > 0)'
			     			// 왼쪽 꺽쇄 : startPage 가 pageBlock(10)보다 크면 
			        		if(startPage > pageBlock) { %>
			        			<a href="/petBill/disease/disSubCate.jsp?pageNum=<%=startPage-pageBlock %>" > &lt; &nbsp;</a>
			        		<%}
			        		
			        		// 페이지 번호 뿌리기 
			        		for(int i = startPage; i <= endPage; i++){ %>
			        			<a href="/petBill/disease/disSubCate.jsp?pageNum=<%=i%>" > &nbsp; <%= i %> &nbsp; </a>
			        		<%}
			        		
			        		// 오른쪽 꺽쇄 : 전체 페이지 개수(pageCount)가 endPage(현재보는페이지에서의 마지막번호) 보다 크면 
			        		if(endPage < pageCount) { %>
			        			&nbsp; <a href="/petBill/disease/disSubCate.jsp?pageNum=<%=startPage+pageBlock%>" > &gt; </a>
			        		<%}
			        		
			        		} // close of the 'else' %>
			       </div>
 --%>



<div>  	
	<div>	  
	   	<br />	  
	   	<br />	  
	   	<br />	  
	   	<br />	  
	   	<table align = "center">
			<tr>
				<td>
					<button style="width: 400px;" onclick = "window.location='/petBill/disease/disLargeCate.jsp'">뒤로가기</button>
				</td>
			</tr>
		</table>
	</div>
</div>



</body>
</html>