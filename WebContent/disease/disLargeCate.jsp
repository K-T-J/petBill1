<%@page import="pet.cat.model.CatLDTO"%>
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
</head>
<% 
	
	// 게시글 수
	int pageSize = 30;

	// 현재 페이지 번호
	String pageNum = request.getParameter("pageNum"); // pageNum이 넘어오면 담기
	if(pageNum == null){ // pageNum이 안넘어오면 1
		pageNum = "1";
	}
	
	// 게시글 시작과 끝
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	
	int number = 1;
	
	// DB에서 대분류 정보 다 가져와서 밑에 화면에 뿌려주기 
	CatDAO dao = new CatDAO(); 
	List catLarge = dao.getCatLarge(startRow, endRow); 
	
	String userId = (String)session.getAttribute("userId");
	String hosId = (String)session.getAttribute("hosId");
	String admin = (String)session.getAttribute("admin");
	
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
							for(int i = 0; i < catLarge.size(); i++){ 
							  CatLDTO dto = (CatLDTO)catLarge.get(i);
						%>
<main >						
	<div align="center" style="margin-top: 10px;">
		<div>
			<form action="disSubCate.jsp" method="post">
				<table>
					<tr>
						<%-- <td><%=number++ %></td> --%>
						<td>
							<button onclick="window.location='disSubCate.jsp'"><%=number++ %>.&nbsp;&nbsp;<%=dto.getLptName()%></button>
							<input type="hidden" name="lptNo" value="<%=dto.getLptNo()%>" />
						</td>
					</tr>		
				</table>	
			</form>
						<%} %>
		</div>	
	</div>
</main>


<div>	
	<br />	  
   	<br />	  
   	<br />	  
   	<br />	
	<table align = "center" >
		<tr>
			<td>
				<button style="width: 400px;" onclick = "window.location='/petBill/search/subMain.jsp'">뒤로가기</button>
			</td>
		</tr>
	</table>
</div>

</body>
</html>