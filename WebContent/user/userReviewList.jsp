<%@page import="pet.rev.model.RevDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="pet.user.model.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> 
<title>회원 리뷰 리스트</title>
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
	if(session.getAttribute("userId") == null && session.getAttribute("hosId")==null && session.getAttribute("admin")==null){%>
		<script>
				alert("로그인 해주세요");
				window.location = "/petBill/user/loginForm.jsp";
		</script>

</head>
	<%}else{ request.setCharacterEncoding("UTF-8");
	
	String userId = (String)session.getAttribute("userId");

int pageSize = 5; //보여줄 게시글 수

//현재 페이지 번호
String pageNum = request.getParameter("pageNum"); //사용자 요청 페이지 번호
if(pageNum == null){//사용자가 요청하지 않았을때 (기본 시작페이지)
	pageNum = "1"; //기본 1페이지를 보여준다.
}

//시작번호와 끝번호 세팅
int currentPage = Integer.parseInt(pageNum); // 형변환
System.out.println("currentPage : " + currentPage);
int startRow = (currentPage -1)* pageSize +1; //시작번호 세팅
System.out.println("startRow : " + startRow);
int endRow = currentPage * pageSize;//페이지 끝번호
System.out.println("endRow : " + endRow);

//게시판 글 가져오기
UserDAO dao = UserDAO.getInstance(); //리뷰 dao 객체 생성
int count = 0;
int number = 0;
List articleList = null;

count = dao.getUserArticleCount(userId); 
System.out.println("게시글 전체수 count : " + count);
if(count > 0){//글이 하나라도 있다면
	articleList = dao.getArticles(startRow,endRow,userId);
}

//게시판 목록에 뿌려줄 가상의 글번호
number = count - (currentPage-1)*pageSize;
System.out.println("number : " + number);

//날짜 출력 형태 패턴생성 
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
	<div style="display: flex; height: 600px;">
		<div style="height: 100%; width: 30%;">
			<div>
				<table style="padding: 80px; margin-left: 26px;">
					<tr bgcolor="lightgray">
						<td>
							<button onclick="window.location='/petBill/user/userMypage.jsp'"><h1>회원정보</h1></button>
						</td>
					</tr>
					<tr>
						<td>
							<button onclick="window.location='/petBill/user/userReviewList.jsp'"><h1>후기관리</h1></button>
						</td>
					</tr>
					<tr>
						<td>
							<button onclick="window.location='/petBill/search/error2.jsp'"><h1>QnA</h1></button>
						</td>
					</tr>
					<tr>
						<td>
							<button onclick="window.location='/petBill/user/userDeleteForm.jsp'"><h1>회원탈퇴</h1></button>
						</td>
					</tr>
				</table>
			</div>
		</div>
			<div style="width: 800px; padding: 92px;">
				<%if(count == 0){//게시글이 없으면%>
					<table>
						<tr>
					 	   <td><h1>게시글이 없습니다.</h1></td>
					    </tr>
				    </table>
					<%}else{//게시글이 있으면%>
						<table>
							<tr>
				         		<td>No.</td>
				        		<td>병원명</td>
				        		<td>등록날짜</td>
				       		  	<td>제목</td>
				      			<td>평가</td>
			     			</tr>
			     		<%
			     			for(int i = 0; i < articleList.size(); i++){
			     				RevDTO article = (RevDTO)articleList.get(i);
			     		%>
			 
			     			<tr>    
			     				<td><%= number-- %></td>
						      	<td><%=article.getReviewHosName()%>병원명</td><%--병원명 --%>
						        <td><%= sdf.format(article.getReviewDate()) %></td> <%-- 리뷰 등록날짜 무조건 만들어야 함 --%>
			     				<td><a href="/petBill/review/reviewContent.jsp?reviewNo=<%=article.getReviewNo()%>&reviewHosNo=<%=article.getReviewHosNo()%>&reviewId=<%=article.getReviewId()%>&pageNum=<%=pageNum%>"> <%=article.getReviewSubject() %><%-- 리뷰 --%> </a></td>
			     				<%-- article.getReviewArticle() --> article.getReviewSubject() 로 수정하기 --%>																							
					 	        <td><%= article.getReviewJudge() %></td>
			     			</tr>   
			     			<%} %>
			            </table>
			        <%}%>
			        <div style="text-align: center; width: 571px;">
			     		<%--페이지 번호 --%>
			     		<%if(count > 0){
			     		//페이지 번호를 몇개까지 보여줄것인지
			     		int pageBlock = 2;
			     		
			     		//총 몇페이지가 나오는지 계산
			     		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			     		//			???	ex)	3 / 5 + (3 % 5 == 0 ? 0 : 1);		
			     		//현재 페이지에서 보여줄 첫번째 페이지번호
			     		int startPage = (int)((currentPage-1)/pageBlock)* pageBlock + 1;
			     		
			     		//현재 페이지에서 보여줄 마지막 페이지번호 (~10,~20,~30....)
			     		int endPage = startPage + pageBlock -1;
			     		// 마지막에 보여줄 페이지번호는, 전체 페이지 수에 따라 달라질 수 있다. 
			    		// 전체 페이지수(pageCount)가 위에서 계산한 endPage(10단위씩)보다 작으면 
			    		// 전체 페이지수가 endPage가 된다. 
						     		
			     		if(endPage > pageCount) {endPage = pageCount;}
			     		
			     		// 왼쪽 꺽쇄 : startPage 가 pageBlock(10)보다 크면 
			    		if(startPage > pageBlock) { %>
			    			<a href="/petBill/user/userReviewList.jsp?pageNum=<%=startPage-pageBlock %>" class="pageNums"> &lt; &nbsp;</a>
			    		<%}
			    		
			    		// 페이지 번호 뿌리기 
			    		for(int i = startPage; i <= endPage; i++){ %>
			    			<a href="/petBill/user/userReviewList.jsp?pageNum=<%=i%>" class="pageNums"> &nbsp; <%= i %> &nbsp; </a>
			    		<%}
			    		
			    		// 오른쪽 꺽쇄 : 전체 페이지 개수(pageCount)가 endPage(현재보는페이지에서의 마지막번호) 보다 크면 
			    		if(endPage < pageCount) { %>
			    			&nbsp; <a href="/petBill/user/userReviewList.jsp?pageNum=<%=startPage+pageBlock%>" class="pageNums"> &gt; </a>
			    		<%}
			    		}%>
			</div>
		</div>	
	</div>	 	  
</body>
<%} %>
</html>