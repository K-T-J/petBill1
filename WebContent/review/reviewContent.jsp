<%@page import="java.text.DecimalFormat"%>
<%@page import="pet.hos.model.HosDTO"%>
<%@page import="pet.hos.model.HosDAO"%>
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
	if(session.getAttribute("userId") == null && session.getAttribute("hosId") == null && session.getAttribute("admin") == null){%>
	<script>
		alert("로그인 해주세요"); 
		window.location = "/petBill/user/loginForm.jsp"; 
	</script>
	<%}else{ %>
	<%
	request.setCharacterEncoding("UTF-8");
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
	
	
	String admin = (String)session.getAttribute("admin"); 
	System.out.println("admin : " + admin);
	
	
	int hosNo = Integer.parseInt(request.getParameter("reviewHosNo"));
	System.out.println("hosNo : " + hosNo); 


	 
 	// 리뷰 가져오는 메서드
	RevDAO dao = RevDAO.getInstance();//싱글턴 
	RevDTO dto = dao.getReview(reviewNo, reviewHosNo);
	
	//병원정보 가져오는 메서드
	HosDAO hos = HosDAO.getInstance();
	HosDTO article = hos.getHosArticle(hosNo);
	
	String hosIdPro = article.getHosId();
	System.out.println("hosIdPro : " + hosIdPro);
  
  
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
<%------------------------------------------------------------------------------------------------------------------------ --%>

	<div>
	<div style="height: 100px">	
		<h1 align="center" style="margin: 0%; padding: 23px"> <%=article.getHosName() %> </h1>
	</div>
	
	<div style="display: flex;">	
		<div style="width: 738px; text-align: center;">
		
			<%if(article.getHosProfile() == null || article.getHosProfile().equals("none")){%>
				<img src="/petBill/review/imgs/default.png" width="400px"/><br/>
			<%}else{%>
				<img src="/petBill/photo/<%=article.getHosProfile()%>" width="400px"/><br/>
		  	<%}%>
		  	 대표자 사진 <br />
		 </div>
		<div style="width: 630px;">
			<table border="1">
				<tr>
					<td>
						<div> 	
							병원장 약력 <br />
						  <% //비어있는 상태면 보기좋게 내용 띄워주기 'none'출력방지
							if(article.getHosBio() == null || article.getHosBio().equals("none")) {%>
								(등록된 정보가 없습니다.)
						  <%}else{ %> 
							<b><%=article.getHosBio() %> </b>
					      <%}%>
						</div>
					</td>
				</tr>
			      
			    <tr>
			    	<td>
						<div>	
							 병원주소 <br />
							지역 :<b> <%=article.getHosSiAddress() %> <%=article.getHosGuAddress() %> <br />
								<%=article.getHosNewAddress() %>	</b>
						</div>
					</td>
				</tr>
				
				<tr>
					<td>
						<div>
							 전화번호 <br />
							<b><%=article.getHosTel()  %> </b> 
						</div>
					</td>
				</tr>
				
				<tr>
					<td>
						<div>
							 영업시간 
						  <% //비어있는 상태면 보기좋게 내용 띄워주기 'none'출력방지
							if(article.getHosTime() == null || article.getHosTime().equals("none")) {%>
								(등록된 정보가 없습니다.)
						  <%}else{ %> 
								<b><%=article.getHosTime() %> </b> 		
						  <%}%>	
						 </div> 
					 </td>
				</tr>	 
			</table>
		</div> 
		<div>
			<h1 align="center">진료비 평균 </h1>
			<table>
					<tr>
						<td>기초접종</td>
						<td>중성화 (남)</td>
						<td>중성화 (여)</td>
						<td>심장사상충</td>
					</tr>
					<tr>
						<td>
					  <%//**String메서드 replace(".0", ""); 문자열에서 .0 지우기 
					  	//int로 변환후 천단위로 ',; 표시 
					  	DecimalFormat df = new DecimalFormat("###,###,###");
					  	
					  	//비어있는 상태면 보기좋게 내용 띄워주기 'none'출력방지
						if(article.getHosBasicVaccin().equals("none")) { //비교는 날것으로 하고%>
							(등록된 정보가 없습니다.)
					  <%}else{ //숫자변환상태 + 천단위','추가해서 출력
					  		int Vaccin = Integer.parseInt(article.getHosBasicVaccin().replace(".0", ""));%>
						<p><%=df.format(Vaccin)%> 원</p>
					  <%}%>	
						</td>
						<td>
					  <%if(article.getHosNeuteringMan().equals("none")) {%>
							(등록된 정보가 없습니다.)
					  <%}else{ 
					  		int ntrMan = Integer.parseInt(article.getHosNeuteringMan().replace(".0", ""));%> 
						<p><%=df.format(ntrMan)%> 원</p>
					  <%}%>		
						 </td>
						<td>
					  <%if(article.getHosNeuteringWoman().equals("none")) {%>
							(등록된 정보가 없습니다.)
					  <%}else{ 
					  		int ntrWoman = Integer.parseInt(article.getHosNeuteringWoman().replace(".0", ""));%> 
						<p><%=df.format(ntrWoman)%> 원</p>
					  <%}%>		
						 </td>
						<td>
					  <%if(article.getHosHeartWorm().equals("none")) {%>
							(등록된 정보가 없습니다.)
					  <%}else{ 
					  		int heart = Integer.parseInt(article.getHosHeartWorm().replace(".0", ""));%> 
						<p> <%=df.format(heart)%> 원</p>
					  <%}%>			
					     </td>
					</tr>
			</table>
		</div>
	</div>	
	
<%--------------------------------------------------------------------- 리뷰 정보 ------------------------------------------------------------------------%>
<!-- 본인이쓴 리뷰일때 -->
<div>
	<div>
		<%if(reviewId.equals(userId)){ %>
	    <form action="reviewModifyPro.jsp?reviewNo=<%=dto.getReviewNo() %>&reviewHosNo=<%=dto.getReviewHosNo()%>&reviewId=<%=dto.getReviewId() %>" method="post" enctype="multipart/form-data"> 
			<table align="center">   
				
				
				<tr>
					<td>
						<input type="hidden" name = "reviewNo" value = "<%=dto.getReviewNo()%>"/>
						제목 &nbsp;<input type="text" name="reviewSubject" value="<%=dto.getReviewSubject()%>" size="13"/>
					</td> 
				</tr>
				<tr>
					<td>
						품종  &nbsp;<input type="text" name="reviewPetKind" value="<%= dto.getReviewPetKind() %>" size="13"/>
					</td>
				</tr>
				<tr>
					<td>
						성별	&nbsp;<input type="text" name="reviewGender" value="<%= dto.getReviewGender() %>" size="13"/>
					</td>
				</tr>
				<tr>
					<td>
						나이 &nbsp;<input type="number" name="reviewAge" value="<%= dto.getReviewAge() %>" size="13"/> 살
					</td>
				</tr>
				<tr>
					<td>
						몸무게 &nbsp;<input type="number" name="reviewWeight" value="<%= dto.getReviewWeight() %>" size="13"/> kg
					</td>
				</tr>
				<tr>
					<td>
						강아지/고양이
						<input type="radio" name="reviewPetType" value="dog" /> 강아지
						<input type="radio" name="reviewPetType" value="cat" checked="checked"/> 고양이
					</td>	
				</tr>
				<tr>
						<%if(dto.getReviewPhoto() != null){ // 사진 저장된게 있을 경우%>
							<td> 영수증 사진 <br/>
							<img src="/petBill/photo/<%=dto.getReviewPhoto()%>" width="150" />
						<%}else{  // 사진 저장된게 없을 경우%>
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
					<td>진료항목&nbsp;
						<select name="reviewArticle">		
							<option value="hosBasicVaccin"<%=dto.getReviewArticle().equals("hosBasicVaccin")?" selected":""%>>기초접종</option>
							<option value="hosNeuteringMan"<%=dto.getReviewArticle().equals("hosNeuteringMan")?" selected":""%>>중성화 수술(남)</option>
							<option value="hosNeuteringWoman"<%=dto.getReviewArticle().equals("hosNeuteringWoman")?" selected":""%>>중성화 수술(여)</option>
							<option value="hosHeartWorm"<%=dto.getReviewArticle().equals("hosHeartWorm")?" selected":""%>>심장사상충</option>
							<option value="others"<%=dto.getReviewArticle().equals("others")?" selected":""%>>기타</option>
						</select> 
					</td>
				</tr>
				<tr>
					<td>
						금액 &nbsp;<input type="number" name="reviewPrice" value="<%= dto.getReviewPrice() %>" size="13"/> 원 
					</td>
				</tr>
				<tr>
					<td align="center">
						<textarea rows="20" cols="40" name="reviewContent"><%= dto.getReviewContent() %></textarea><br/>
						후기
					</td>
				</tr>
				<tr>
					<td>
						평가&nbsp;
						<input type="radio" name="reviewJudge" value="좋아요" <% if("좋아요".equals(dto.getReviewJudge())){%>checked<%}%>/> 좋아요
						<input type="radio" name="reviewJudge" value="보통이에요" <% if("보통이에요".equals(dto.getReviewJudge())){%>checked<%}%>/> 보통이에요
						<input type="radio" name="reviewJudge" value="나빠요" <% if("나빠요".equals(dto.getReviewJudge())){%>checked<%}%>/> 나빠요
					</td>
				</tr>
			</table>
			<table align="center">	
				<tr>		
					<td>
						<%if(admin != null){ %>  
							<button type ="button" onclick="window.location='reviewDeleteForm.jsp?reviewNo=<%=dto.getReviewNo()%>&reviewHosNo=<%=dto.getReviewHosNo()%>'">삭제</button>
						<%}else if(hosId != null){%>
						<%}else if(userId.equals(reviewId)){%>
							<button type="submit">수정</button> 
							<button type="reset">재작성</button>
							<button type ="button" onclick="window.location='reviewDeleteForm.jsp?reviewNo=<%=dto.getReviewNo()%>&reviewHosNo=<%=dto.getReviewHosNo()%>'">삭제</button>
						<%} %>
					</td>
				</tr> 
			</table> 
		</form>
	</div>	
	
	
	
	<div>
		<form action = "reviewHosPro.jsp?reviewNo=<%=dto.getReviewNo()%>">
			<table align="center">
				<tr>
					<td align="center">병원 답변</td>
					<td align="center">
					<%if(hosId == null){ %>
						<%if(dto.getReviewRef() == null){ %>
							<td>답변이 없습니다.</td>
						<%}else{ %>
							<td><%=dto.getReviewRef()%></td>
						<%}%>
					<%}else{ %>
						<%if(dto.getReviewRef() == null){ %>
							<textarea rows="20"cols="40" name = "reviewRef" >답변이 없습니다.</textarea>
						<%}else{ %>
							<textarea rows="20"cols="40" name = "reviewRef"><%=dto.getReviewRef()%></textarea>
						<%}%>
					<%} %>
					</td>
				</tr> 
			</table>	
						<%if(hosIdPro.equals(hosId)){ 
						System.out.println("same");					
						%>
			<table align="center">
				<tr>
					<td>
						<button type="submit">답변등록</button>
						<button type ="button" onclick="history.go(-2);">뒤로가기</button>
					</td>
				</tr>
			</table>		
						<%}else{ %>
			<table align="center">			
				<tr>			
					<td>
						<button type ="button" onclick="history.go(-2);">뒤로가기</button>
					</td>	
				</tr>
			</table>
						<%} %>
		</form>
	</div>
</div>
	
<% }else{%>
<!-- 다른사람이 쓴 리뷰 볼때 -->	

<div>	
	<div>
		<form>
			<table align="center">
				<tr>
					<td>제목</td>
					<td align="center"><%=dto.getReviewSubject()%></td>
				</tr>
				<tr>
					<td>품종</td>
					<td align="center"><%=dto.getReviewPetKind()%></td>
				</tr>
				<tr>
					<td>성별</td>
					<td align="center"><%=dto.getReviewGender()%></td>
				</tr>
				<tr>
					<td>나이</td>
					<td align="center"><%=dto.getReviewAge()%></td>
				</tr>
				<tr>
					<td>몸무게(kg)</td>
					<td align="center"><%=dto.getReviewWeight()%>kg</td>
				</tr>
				<tr>
					<td>강아지/고양이</td>
					<td align="center"><%=dto.getReviewPetType()%></td>
				</tr>
				<tr>
					<td>영수증 사진</td>
					<td align="center">
						<%if(dto.getReviewPhoto() != null){ // 사진 저장된게 있을 경우%>
							<img src="/petBill/photo/<%=dto.getReviewPhoto()%>" width="150" />
						<%}else{ %>
							<img src="/petBill/review/imgs/default.png" width="150" />
						<%} %>
						<%if(hosId != null || admin != null){%>
						<%}else if(userId.equals(reviewId)) {%> 
							<input type="file" name="reviewPhoto" />
							<input type="hidden" name="exreviewPhoto" value="<%=dto.getReviewPhoto()%>"/> 	
						<%} %>
					</td>
				</tr>
				<tr>
					<td>진료항목</td>
					<%if(dto.getReviewArticle().equals("hosBasicVaccin")){ %>
					<td align="center">기초접종</td> 
					<%}else if(dto.getReviewArticle().equals("hosNeuteringMan")){ %>
					<td align="center">중성화(남)</td> 
					<%}else if(dto.getReviewArticle().equals("hosNeuteringWoman")){ %>
					<td align="center">중성화 (여)</td> 
					<%}else if(dto.getReviewArticle().equals("hosHeartWorm")){ %>
					<td align="center">심장사상충</td> 
					<%}else if(dto.getReviewArticle().equals("others")){ %>
	           		<td align="center">기타</td> 
	           		<%} %>
					
				</tr> 
				<tr>
					<td>병원비</td>
					<td align="center"><%=dto.getReviewPrice()%></td>
				</tr>
				<tr>
					<td>후기</td>
					<td align="center"><%=dto.getReviewContent()%></td>
				</tr>
				<tr>
					<td>평가</td>
					<td align="center"><%=dto.getReviewJudge()%></td>
				</tr>
				<tr>		
						<%if(admin != null){ %>  
							<td align="center"><button type ="button" onclick="window.location='reviewDeleteForm.jsp?reviewNo=<%=dto.getReviewNo()%>&reviewHosNo=<%=dto.getReviewHosNo()%>'" >삭제</button></td>
						<%}else if(hosId != null){%>
							 
						<%}else if(userId.equals(reviewId)){%>
							<td align="center"><input type="submit" value="수정"/>
							<button type="reset" value="재작성" />
							<button type ="button" value="삭제" onclick="window.location='reviewDeleteForm.jsp?reviewNo=<%=dto.getReviewNo()%>&reviewHosNo=<%=dto.getReviewHosNo()%>'" /></td>
						<%} %>
				</tr>
			</table>
		</form>
	</div>
	
	<div>
		<form action = "reviewHosPro.jsp?reviewNo=<%=dto.getReviewNo()%>&hosId=<%=hosId%>"> 
			<table align="center">
				<tr>
					<td>병원 답변</td>
					<td align="center">
						<%if(hosId == null || admin != null){ %>
							<%if(dto.getReviewRef() == null){ %>
								답변이 없습니다.</td>
							<%}else{ %>
								<td><%=dto.getReviewRef()%></td>
							<%}%>
						<%}else{ %>
							<%if(dto.getReviewRef() == null){ %>
								<textarea rows="20"cols="40" name = "reviewRef" >답변이 없습니다.</textarea>
							<%}else{ %>
								<textarea rows="20"cols="40" name = "reviewRef"><%=dto.getReviewRef()%></textarea>
							<%}%>
						<%} %>
					</td>
				</tr>
			</table >	
						<%if(hosIdPro.equals(hosId)){ 
							System.out.println("same");					
						%>
			<table align="center">
				<tr>
					<td>			
							<button type="submit">답글달기</button>
							<button type ="button" onclick="history.go(-1);">뒤로가기</button>
					</td>
				</tr>
			</table>				
						<%}else{ %>
			<table align="center">
				<tr>
					<td>			
							<button type ="button" onclick="history.go(-1);">뒤로가기</button>
					</td>
				</tr>
			</table>				
						<%} %> 
		</form>	
	</div>	
</div>	
<%} }%>	
</body>
</html>