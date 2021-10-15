<%@page import="pet.user.model.UserDTO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.List"%>
<%@page import="pet.rev.model.RevDTO"%>
<%@page import="pet.rev.model.RevDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title> 
<link href="style.css" rel="stylesheet" type="text/css">

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
String admin = (String)session.getAttribute("admin");
System.out.println("admin : " + admin); 
String reviewId = request.getParameter("reviewId");
System.out.println("reviewId : " + reviewId);
String userId = (String)session.getAttribute("userId");
System.out.println("userId : " + userId);
String hosId = (String)session.getAttribute("hosId");
System.out.println("hosId : " + hosId);
int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
System.out.println("reviewNo : " + reviewNo);
String reviewHosNo = (request.getParameter("reviewHosNo"));
System.out.println("reviewHosNo : " + reviewHosNo);
  
// 기존 리뷰 데이터 출력 메서드
RevDAO dao = RevDAO.getInstance();//싱글턴 
RevDTO dto = dao.getReview(reviewNo, reviewHosNo);





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

   
   
    <form action = "reviewDeletePro.jsp?reviewNo=<%=dto.getReviewNo() %>" method = "post">
      <table align="center">
         <tr>
            <td>
            	제목&nbsp;:&nbsp;<%=dto.getReviewSubject()%>
            </td>
         </tr>
         <tr>
            <td>
            	품종&nbsp;:&nbsp;<%=dto.getReviewPetKind()%>
            </td>
         </tr>
         <tr>
            <td>
            	성별&nbsp;:&nbsp;<%=dto.getReviewGender()%>
            </td>
         </tr>
         <tr>
            <td>
            	나이&nbsp;:&nbsp;<%=dto.getReviewAge()%>
            </td>
         </tr>
         <tr>
            <td>
            	몸무게(kg)&nbsp;:&nbsp;<%=dto.getReviewWeight()%>kg
            </td>
         </tr>
         <tr>
            <td>
            	강아지/고양이&nbsp;:&nbsp;<%=dto.getReviewPetType()%>
            </td>
         </tr>
         <tr>
               <%if(dto.getReviewPhoto() != null){ // 사진 저장된게 있을 경우%>
				<td> 영수증 사진 <br/>	
				<img src="/petBill/photo/<%=dto.getReviewPhoto()%>" width="150" />
               <%}else{ %>
               	<td> 영수증 사진 <br/>
				<img src="/petBill/review/imgs/default.png" width="150" />
               <%} %>
               <%if(hosId != null || admin != null){%>
               <%}else if(userId.equals(reviewId)) {%> 
               	<br/>
               	<input type="file" name="reviewPhoto" />
				<input type="hidden" name="exreviewPhoto" value="<%=dto.getReviewPhoto()%>"/>    
               <%} %>
         </tr>
         <tr>
            <td>
            	진료항목&nbsp;:&nbsp;
            <%if(dto.getReviewArticle().equals("hosBasicVaccin")){ %>
            <td align="center">기초접종</td> 
            <%}else if(dto.getReviewArticle().equals("hosNeuteringMan")){ %>
            <td align="center">중성화(남)</td> 
            <%}else if(dto.getReviewArticle().equals("hosNeuteringWoman")){ %>
            <td align="center">중성화 (여)</td> 
            <%}else if(dto.getReviewArticle().equals("hosHeartWorm")){ %>
            <td align="center">심장사상충</td> 
            <%} %>
         </tr> 
         <tr>
            <td>
            	병원비 정보&nbsp;:&nbsp;<%=dto.getReviewPrice()%>
            </td>
         </tr>
         <tr>
            <td>
            	후기&nbsp;:&nbsp;<%=dto.getReviewContent()%>
            </td>
         </tr>
         <tr>
            <td>
            	평가&nbsp;:&nbsp;<%=dto.getReviewJudge()%>
            </td>
         </tr>
         <tr>      
         <%if(userId != null){ %>
      <tr>
         <td>
         	비밀번호 확인 &nbsp;:&nbsp;
            <input type = "password" name = "userPw"/><br/>
         </td>
      </tr>
</table>
<table align="center">
	<tr>
		<td>        
            <button type="submit">삭제</button>
         </td>
      </tr>
</table>      
      <%}else if(admin != null){ %>
<table align="center">      
      <tr>
         <td align="center">
            <button type="submit">삭제</button>
         </td>
      </tr>
</table>
      <%} %>
   </form>

</body> 
</html>

</body>
</html>