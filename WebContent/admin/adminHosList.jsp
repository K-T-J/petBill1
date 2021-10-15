<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="pet.hos.model.HosDTO"%>
<%@ page import="pet.hos.model.HosDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 병원 리스트</title>
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
	
	// 병원 전체 리스트 불러오는 메서드
	String pageNum = request.getParameter("pageNum");	
	if (pageNum == null) {								
		pageNum = "1";									
	}
	// 병원 가입 대기 목록 뿌려줄 페이징 변수 
	int hosWaitingPageSize = 5;
	int hosWaitingCurrentPage = Integer.parseInt(pageNum);
	int waitingStartRow = (hosWaitingCurrentPage - 1) * hosWaitingPageSize + 1;
	int waitingEndRow = hosWaitingCurrentPage * hosWaitingPageSize;
	
	// 병원 전체 가입 목록 뿌려줄 페이징 변수 
	int pageSize = 10;
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize; 

	HosDAO dao = HosDAO.getInstance();
	
	String adminHosSearch = request.getParameter("adminHosSearch");
	
	// 가입 대기 병원 
	List hosJoinNumberList = null;	// 병원 가입대기 List 
	int waitingCount = 0;			// 병원 가입 대기 수 
	int waitNumber = 0;				// 병원 가입 대기 수 화면에 뿌려질 가상의 번호 
	
	// 총 병원 
	List adminHosList = null;		// DB에 저장된 병원 총 List 
	int count = 0;					// DB에 저장되어있는 총 병원의 수 
	int number = 0;					// 화면에 뿌려질 가상의 번호 (총 병원)
	
	if (adminHosSearch != null) { 	// admin 병원정보 페이지에서 검색했을시.
		// 병원 가입 대기 List 
		waitingCount = dao.getHosSearchJoinWaitingCount(adminHosSearch);
		System.out.println("[검색O] 병원 가입대기 수 : " + waitingCount);
		if (waitingCount > 0) { 
			hosJoinNumberList = dao.getHosSearchJoinWaitingList(waitingStartRow, waitingEndRow, adminHosSearch);
		}
		System.out.println("hosJoinNumberList : "  +hosJoinNumberList);
		
		// DB에 병원 총 List  
		count = dao.getHosSearchArticleCount(adminHosSearch);
		System.out.println("[검색O] 병원 전체 수 : " + count);
		if (count > 0) { 
			adminHosList = dao.getHosSearchArticlesList(startRow, endRow, adminHosSearch);
		}
		System.out.println("[adminHosList] adminHosList : " + adminHosList);
		
	} else {	// admin 병원정보 페이지에서 검색 안했을때 또는 첫 페이지시.
		// 검색 안했을시 대기 목록 List 
		waitingCount = dao.getHosJoinWaitingCount();
		System.out.println("[검색X] waitingCount : " + waitingCount);
		if (waitingCount > 0) {
			hosJoinNumberList = dao.getHosJoinWaitingList(waitingStartRow, waitingEndRow);
		}
		// 검색 안했을시 DB 총 목록 List
		count = dao.getHosArticleCount();
		System.out.println("[검색X] count : " + count);
		if (count > 0) {
			adminHosList = dao.getAdminHosArticles(startRow, endRow);
		}
		System.out.println("[검색X] 병원 전체 리스트 : " + count);
	}
	waitNumber = waitingCount - (hosWaitingCurrentPage - 1) * hosWaitingPageSize;
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
	} else { // session check 'admin == true'
%>
	    <div align="center">
	    	<section>
	        	<form action="adminHosList.jsp" method="post">
	            	<input type="text" name="adminHosSearch" placeholder="병원명 검색" style="width: 550px; height: 75px; margin-top: 40px; border-radius: 10px;"/>
	            	<input class="input" type="submit" value="검색" /> 
	            </form>
	      	</section>
	   	</div>
<main>	   		      
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
		
			
		<%
			if (waitingCount == 0) {
		%>
			<div>
				<table>
					<tr>
						<td><h2>병원가입 대기 목록</h2></td>
					</tr>	
					<tr>
						<td colspan="3">가입대기 중인 병원회원이 없습니다.</td>
					</tr>
				</table>
			</div>
		<%} else {%>		
				<h2>병원가입 대기 목록</h2>
				<table>
					<tr>
						<td>No.</td>
						<td>병원명</td>
						<td>시 주소</td>
						<td>구 주소</td>
						<td>가입날짜</td>
						<td>활동상태</td>
					</tr>
				<%
					for (int i = 0; i < hosJoinNumberList.size(); i++) {
						HosDTO hosDto = (HosDTO)hosJoinNumberList.get(i);
				%>
					<tr>
						<td><%=waitNumber--%></td>
						<td><a href="adminHosResult.jsp?hosNo=<%=hosDto.getHosNo()%>"><%=hosDto.getHosName()%></a></td>
						<td><%=hosDto.getHosSiAddress()%></td>
						<td><%=hosDto.getHosGuAddress()%></td>
						<td><%=sdf.format(hosDto.getHosReg())%></td>
						<td><%=hosDto.getHosActiveNum()%></td>
					</tr>
				<%}%>
				</table>
				<%-- 하단에 번호 만들기 --%>
			<div style="text-align: center; width: 571px;">	
			<%
				if (waitingCount > 0) {
					int waitPageBlock = 3;
					int waitPageCount = waitingCount / hosWaitingPageSize + (waitingCount % hosWaitingPageSize == 0 ? 0 : 1);
					int waitStartPage = (int)((hosWaitingCurrentPage - 1) / waitPageBlock) * waitPageBlock + 1;
					int waitEndPage = waitStartPage + waitPageBlock - 1; 
					if (waitEndPage > waitPageCount) {
						waitEndPage = waitPageCount;
					}
					
					// 검색시 페이지 번호 처리
					if (adminHosSearch != null) {
						if (waitStartPage > waitPageBlock) {
				%>
							<a href="adminHosList.jsp?pageNum=<%=waitStartPage-waitPageBlock%>&adminHosSearch=<%=adminHosSearch%>">&lt; &nbsp;</a>
				<%			
						}
						for (int i = waitStartPage; i <= waitEndPage; i++) {
				%>			
							<a href="adminHosList.jsp?pageNum=<%= i %>&adminHosSearch=<%=adminHosSearch%>"> &nbsp; <%= i %> &nbsp; </a>			
				<%			
						}
						if (waitEndPage < waitPageCount) {
				%>
							&nbsp; <a href="adminHosList.jsp?pageNum=<%=waitStartPage+waitPageBlock %>&adminHosSearch=<%=adminHosSearch%>"> &gt; </a>
				<%
						}
					} else {	// 검색안했을때 
						// 왼쪽 꺽쇄 
						if (waitStartPage > waitPageBlock) {
				%>
							<a href="adminHosList.jsp?pageNum=<%=waitStartPage-waitPageBlock %>"> &lt; &nbsp;</a>
				<%
						}
						// 페이지 번호 뿌리기 
						for (int i = waitStartPage; i <= waitEndPage; i++) {
				%>
							<a href="adminHosList.jsp?pageNum=<%=i%>"> &nbsp; <%= i %> &nbsp; </a>
				<%
						}
						// 오른쪽 꺽쇄 
						if (waitEndPage < waitPageCount) {
				%>
							&nbsp; <a href="adminHosList.jsp?pageNum=<%=waitStartPage+waitPageBlock%>"> &gt; </a>
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
</main>

<div style="display: flex;justify-content: center;">
	<div style="width: 690px; padding: 92px;">
		<%if (count == 0) {%>
			<h2>병원가입 전체 목록</h2>
				<table>
					<tr>
						<td><h1>가입한 병원회원이 없습니다.</h1></td>
					</tr>	
				</table>
			<%} else {%>
			<h2>병원가입 전체 목록</h2>
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
					for (int i = 0; i < adminHosList.size(); i++) {
						HosDTO hosArticle = (HosDTO)adminHosList.get(i);
				%>
					<tr>
						<td><%=number--%></td>
						<td><%=hosArticle.getHosName()%></td>
						<td><%=hosArticle.getHosSiAddress()%></td>
						<td><%=hosArticle.getHosGuAddress()%></td>
						<td><%=hosArticle.getHosTel()%></td>
						<td><%=hosArticle.getHosActiveNum()%></td>
					</tr>
				<%}%>
				</table>
		<%}%>
		<div>
			<table align="center">
				<tr>
					<td><button onclick="window.location='adminHosTotalList.jsp'">더보기</button></td>
				</tr>
			</table>
		</div>		
	</div>
</div>



</body>
<%}%>
</html>