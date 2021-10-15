<%@page import="pet.user.model.UserDTO"%>
<%@page import="pet.rev.model.RevDAO"%>
<%@page import="pet.rev.model.RevDTO"%>
<%@page import="java.util.List"%>
<%@page import="pet.user.model.UserDAO"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="pet.hos.model.HosDTO"%>
<%@page import="pet.hos.model.HosDAO"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
		<title>hosContent</title>
		<link href="style.css" rel="stylesheet" type="text/css"/>
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

	String userId = (String)session.getAttribute("userId");
	String hosId = (String)session.getAttribute("hosId");
	String admin = (String)session.getAttribute("admin");
	
	// 세션값 없으면 로그인페이지로 이동 
if(userId == null && hosId == null && admin == null){ %>
		<script>
			alert("로그인이 필요합니다.");
			history.go(-1);
		</script>	

<%	// 세션 hosId값 있을경우 보이기 
}else{		

	System.out.println("userId = " + userId + "/ hosId = " + hosId + "/ admin = " + admin);

	int pageSize = 5; //보여줄 게시글 수

	//현재 페이지 번호
	int pageNum = Integer.parseInt(request.getParameter("pageNum")); //사용자 요청 페이지 번호
	if (pageNum == 0) { //없으면 1로 세팅해주고 		
		pageNum = 1;									
	}
	System.out.println("pageNum = "+ pageNum);

	//시작번호와 끝번호 세팅
	int currentPage = pageNum; // pageNum을 int로 형변환
	System.out.println("currentPage : " + currentPage);
	int startRow = (currentPage -1)* pageSize +1; //시작번호 세팅
	System.out.println("startRow : " + startRow);
	int endRow = currentPage * pageSize;//페이지 끝번호
	System.out.println("endRow : " + endRow);

	//병원고유번호 꺼냄
	int hosNo = Integer.parseInt(request.getParameter("hosNo"));//int로 형변환
	System.out.println("hosNo = "+ hosNo);
	//병원고유번호 주고 해당 병원정보 DB에서 가져오기 
	HosDAO dao = HosDAO.getInstance();
	HosDTO article = dao.getHosArticle(hosNo);

	//써먹고나서 다시 review테이블에서 써먹기위해 스트링타입인 reviewHosNo로 형변환 
	String reviewHosNo = request.getParameter("hosNo");
	System.out.println("hosNo를 reviewHosNo로 변환(문자로) = " + reviewHosNo);

	//리뷰 테이블에서 사용자 진료비 평균꺼내오기
	RevDAO revDao = RevDAO.getInstance();
	List revList = revDao.getAvg(reviewHosNo);//** 메서드의 타입(List), 리턴명(revList)와 동일해야함!!!**
	System.out.println("revList = " + revList);
	
	//리뷰테이블 글 가져오기
	UserDAO userdao = UserDAO.getInstance(); 
	int count = 0;
	int number = 0;
	int avgNumber = 0;
	
	List articleList = null;
	count = revDao.getReviewArticleCount(reviewHosNo); 
	System.out.println("후기 게시글 전체수 count : " + count);
	if(count > 0){ //글이 하나라도 있다면
		articleList = revDao.getArticlesAll(startRow,endRow,reviewHosNo);
	}

	//게시판 목록에 뿌려줄 가상의 글번호
	number = count - (currentPage-1) * pageSize;
	avgNumber = count - (currentPage-1) * pageSize;
	
	//날짜 출력 형태 패턴생성 
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
	
	//review에서 해당병원 리뷰글 가져오기 
	RevDTO revDto = revDao.getContactReview(reviewHosNo);

%>

<body>
      <header>
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
	
<!-- ======================================상단메뉴 구분선========================================= -->
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
</div>
<div align="center">
	ⓒ 2019. Seoul Metropolitan Government Some Rights Reserved.(CC BY)
</div>			  
<!-- ======================================사용자진료비 목록========================================= -->	
<div style="text-align: center;">
	<div style="height: 128px;">
	<% if(revList == null){ // 담긴게 없으면 %>
		<h1>회원 진료비 평균 </h1>
		<br />
		<table align="center">
			<tr>
				<td>기초접종</td>
				<td>중성화 (남)</td>
				<td>중성화 (여)</td>
				<td>심장사상충</td>
			</tr>
			<tr>
		 	  	<td>(등록된 가격이 없습니다.)</td>
		 	  	<td>(등록된 가격이 없습니다.)</td>
		 	  	<td>(등록된 가격이 없습니다.)</td>
		 	  	<td>(등록된 가격이 없습니다.)</td>
		    </tr>
		  </table>
	</div>
	<%	}else{ %>
	<div style="height: 128px;">		
			<h1>회원 진료비 평균 </h1>
			<br />
			<table align="center">
				<tr>
					<td>
			<%for(int i = 0; i < revList.size(); i++){
				RevDTO revAvgDto = (RevDTO)revList.get(i); 
				avgNumber++;
				
				if(revAvgDto.getReviewArticle() != null) { // 값이 들어있다. %>
				<% 	if(revAvgDto.getReviewArticle().equals("hosBasicVaccin")){ // 1. 기초접종이면%>	
					  <b>기초접종</b>
					  <% int avg = Integer.parseInt(revAvgDto.getReviewPrice());%>
					  <%=df.format(avg)%>&nbsp;원 &nbsp;&nbsp;
				<% 	}else if(revAvgDto.getReviewArticle().equals("hosNeuteringMan")){//2. 중성화 남이면%> 
					  <b>중성화(남)</b>
					  <% int avg = Integer.parseInt(revAvgDto.getReviewPrice());%>
					  <%=df.format(avg)%>&nbsp;원 &nbsp;&nbsp;
				<% 	}else if(revAvgDto.getReviewArticle().equals("hosNeuteringWoman")){//2. 중성화 여이면%>
					  <b>중성화(여)</b>
					  <% int avg = Integer.parseInt(revAvgDto.getReviewPrice());%>
					  <%=df.format(avg)%>&nbsp;원 &nbsp;&nbsp;
				<% 	}else if(revAvgDto.getReviewArticle().equals("hosHeartWorm")){//2. 심장사상충이면 %>
					  <b>심장사상충</b>
					  <% int avg = Integer.parseInt(revAvgDto.getReviewPrice());%>
					  <%=df.format(avg)%>&nbsp;원 &nbsp;&nbsp;
					<% }//else if %>
	  				<%}//외부if %>
 		 		<%}//for문 %>
 			<%}//외부 else %>
 					</td>
 				</tr>
 			</table>
	</div>				 	
</div>
<!-- ====================================== 후기 목록 ========================================= -->
<div style="height: 100px;">
	<div>	
		<%  RevDTO revArticle = null;
			if(revDto == null || count == 0){ %>
		<div style="display: flex; justify-content: center;">	
			<h1 style="margin-top: 83px;"> 후기목록 </h1>
		</div>
		<div style="display: flex; justify-content: center;">	
			<br />
			 	   <h1>게시글이 없습니다.</h1>
			<br />
		</div>	
	</div>		
		<%	}else if(count > 0){//게시글이 있으면
			if(revDto != null){
				String reviewId = revDto.getReviewId();
				//reviewId로 user테이블의 닉네임 가져오기
				UserDAO userDao = UserDAO.getInstance();
		%>
	<div>
		<div>
			<h1 style="margin-top: 37px;"> 후기목록 </h1>
		</div>	
		<div style="display: flex; justify-content: center;">
				<table>
					<tr>
			         	<td>No.</td> 
			        	<td>등록날짜</td>
			       		<td>제목</td>
			       		<td>닉네임</td>
			      		<td>평가</td>
		     		</tr>
		     		
		     <%
		     		for(int i = 0; i < articleList.size(); i++){
			     		revArticle = (RevDTO)articleList.get(i);
			     		UserDTO userDto = userDao.getUser(revArticle.getReviewId());

		     %>
		     		<tr>    
		     			<td><%= number-- %></td>
						<td><%= sdf.format(revArticle.getReviewDate()) %></td> <%-- 리뷰 등록날짜 무조건 만들어야 함 --%>
		     			<td><a href="/petBill/review/reviewContent.jsp?reviewNo=<%=revArticle.getReviewNo()%>&reviewHosNo=<%=revArticle.getReviewHosNo()%>&reviewId=<%=revArticle.getReviewId()%>&hosId=<%=article.getHosId()%>&pageNum=<%=currentPage%>"> <%=revArticle.getReviewSubject() %><%-- 리뷰 --%> </a></td>																												
				 		<td><%= userDto.getUserNick() %></td> 
				 		<td><%= revArticle.getReviewJudge() %></td> 
		     			</tr>  
		     		<%} %>
		     		<tr> 
		     		</tr> 
		     	</table>
		</div>	
	</div>	     		  
		    <%} %> 
		 <%}// if(revDto != null)  %> 	
	<div style="height: 40px;">	
		<div style="display:flex; justify-content: center; margin-top: 10px;">
			<%-- 페이지번호 --%>
			 	 <%  
					// 페이지번호를 몇개를 보여줄건지 지정 
					int pageBlock = 5;
					// 총 몇페이지가 나오는지 계산 
					int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
					// 현재 페이지에서 보여줄 첫번째 페이지번호 
					int startPage = (int)((currentPage-1)/pageBlock) * pageBlock + 1;
					// 현재 페이지에서 보여줄 마지막 페이지번호 
					int endPage = startPage + pageBlock - 1;
					// 마지막에 보여줄 페이지 번호는 전체 페이지 수에 따라 달라질수있다.
					// 전체 페이지수(pageCount)가 위에서 계산한 endPage(1단위씩) 보다 작으면 
					// 전체 페이지수가 endPage 가 된다.
					if(endPage > pageCount)endPage = pageCount;
				
				// 왼쪽 꺽쇠 : startPage가 10보다 크면 
				if(startPage > pageBlock) { %>
					<a href="list.jsp?pageNum=<%=startPage - pageBlock %>" class="pageNums"> &lt; </a>
			 <% }	 
				
				// 페이지번호 뿌리기 
				for(int i = startPage; i <= endPage; i++){ %>
					<a href="hosContent.jsp?pageNum=<%=i %>&hosNo=<%=hosNo%>" class="pageNums"> &nbsp; <%= i %> &nbsp;</a><br />
			 <% }
				
				// 오른쪽 꺽쇠 : 전체 페이지 개수(pageCount)가 endPage(현재보는페이지에서의 마지막번호) 보다 크면 
				 if(endPage < pageCount) { %>
					<a href="hosContent.jsp?pageNum=<%=startPage+pageBlock %>" class="pageNums"> &gt; </a>
			<%  } %>
		</div>
	</div>
	<div style="display: flex; justify-content: center;">			
				<%if(session.getAttribute("userId") != null){ %> 
					<button onclick="window.location='/petBill/review/reviewWriteForm.jsp?hosNo=<%=hosNo%>&hosGuAddress=<%=article.getHosGuAddress()%>&hosName=<%=article.getHosName()%>'">후기등록</button>
				<%} %>
				<button onclick="history.go(-1)">뒤로가기</button>
				
	</div>				
</div>	
<%}//else %>	

</body>
</html>