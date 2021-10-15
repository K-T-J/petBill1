<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="pet.hos.model.HosDTO"%>
<%@ page import="pet.hos.model.HosDAO"%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 검색 결과</title>
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
	
	// adminHosList 및 adminHosTotalList에서 넘어온 파라미터값 꺼내주기 
	int adminHosNo = Integer.parseInt(request.getParameter("hosNo"));
	System.out.println("HosNo : " + adminHosNo);
	
	HosDAO dao = HosDAO.getInstance();
	HosDTO adHosDto = dao.getAdminHos(adminHosNo); 
%>		 
		
	</head>
	<body>

<%
	if (userId == null && hosId == null && admin == null) { // session check 'admin != true'
%>
		<script>
			alert("잘못된 페이지 요청입니다.");
			window.location = "/petBill/search/main.jsp";
		</script>
	
<%	
	} else { // sesion check 'admin == true'
%>
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
		<div style="height: 100%; width: 50%;">
		<div>
		<h1 style=" margin-left: 195px;">회원정보</h1>
		<form action="adminHosResultPro.jsp?adminHosNo=<%=adminHosNo%>" method="post">
			<table style="margin-left: 195px;">
				<tr>
					<td>아이디*<br />
						<p><%=adHosDto.getHosId()%></p>
					</td>
				</tr>
				<tr>
					<td>병원명*<br />
						<p><%=adHosDto.getHosName()%></p>
					</td>
				</tr>
				<tr>
					<td>병원 전화번호*<br />
						<p><%=adHosDto.getHosTel()%></p>
					</td>
				</tr>
				<tr>
					<td>병원 주소*<br />
						<p><%=adHosDto.getHosSiAddress()%> <%=adHosDto.getHosGuAddress()%><br /><br />
						   도로명 주소 : <%=adHosDto.getHosNewAddress()%><br />
						   
						   지번 주소 : 
					   <% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
					  	 if(adHosDto.getHosOldAddress() == null) {%>
							(등록된 정보가 없습니다.)
					   <%}else{ %> 
							<%=adHosDto.getHosOldAddress()%>
					   <%}%>	
					</td>
				</tr>
				<tr>
					<td>사업자등록번호<br />
						<% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
					  	 if(adHosDto.getHosNum() == null) {%>
							(등록된 정보가 없습니다.)
					   <%}else{ %> 
							<p><%=adHosDto.getHosNum()%></p>
					   <%}%>	
					</td>
				</tr>
				<tr>
					<td>영업시간<br />
						<% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
					  	 if(adHosDto.getHosTime() == null) {%>
							(등록된 정보가 없습니다.)
					   <%}else{ %> 
							<p><%=adHosDto.getHosTime()%></p>
					   <%}%>	
					</td>
				</tr>
				<tr>
					<td>병원 대표자 명<br />
						<% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
					  	 if(adHosDto.getHosUserName() == null) {%>
							(등록된 정보가 없습니다.)
					   <%}else{ %> 
							<p><%=adHosDto.getHosUserName()%></p>
					   <%}%>	
					</td>
				</tr>
				<tr>
					<td>대표자 휴대폰번호<br />
						<% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
					  	 if(adHosDto.getHosMobile() == null) {%>
							(등록된 정보가 없습니다.)
					   <%}else{ %> 
							<p><%=adHosDto.getHosMobile()%></p>
					   <%}%>	
					</td>
				</tr>
				<tr>
					<td>대표자 사진<br />
						<% if(adHosDto.getHosProfile() != null) { //사진 저장된 게 있을경우 %>
							<img src="/petBill/photo/<%=adHosDto.getHosProfile()%>" width="200"/><br/>
						<% }else{ //사진 저장된 게 없다! %>
							<img src="/petBill/review/imgs/default.png" width="200"/><br/>
						<% }%>
					</td>
				</tr>
				<tr>
					<td>사업자등록증 사진<br />
						<% if(adHosDto.getHosNumPhoto() != null) { //사진 저장된 게 있을경우 %>
							<img src="/petBill/photo/<%=adHosDto.getHosNumPhoto()%>" width="200"/><br/>
						<% }else{ //사진 저장된 게 없다! %>
							<img src="/petBill/review/imgs/default.png" width="200"/><br/>
						<% }%>
					</td>
				</tr>
				<tr>
					<td>병원장 약력<br />
						<% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
					  	 if(adHosDto.getHosBio() == null) {%>
							(등록된 정보가 없습니다.)
					   <%}else{ %> 
							<p><%=adHosDto.getHosBio()%></p>
					   <%}%>	
					</td>
				</tr>
				<tr>
					<td> 가입 정보 : (0)탈퇴,(1)승인,(2)가입대기,(3)거절,(4)공공DB<br /></td>
					
				</tr>
				<tr>
					<td> 가입 상태 : <%=adHosDto.getHosActiveNum()%></td>
				</tr>
				<tr>
					<td> 가입상태 변경 <br />
						<select type="text" name="hosActiveNum"> 
							<option value="<%=adHosDto.getHosActiveNum()%>" selected> 활동상태 선택 </option>
							<!-- <option value="0"> 탈퇴 (0) </option> -->
							<option value="1"> 승인 (1) </option>
							<option value="2"> 대기 (2) </option>
							<option value="3"> 거절 (3) </option>
							<option value="4"> 공공DB (4) </option>
						</select>
						<input type="text" name="hosReason" placeholder="사유를 입력하세요."/>
						<input type="submit" value="활동상태 변경"> 
						<input type="reset" value="재작성">
					</td>
				</tr>
			</table>
			</form>
		</div>
		
		<div align="center">
			<button onclick="window.location='adminHosList.jsp'">리스트</button>
		</div>
	</div>	
</div>
</body>
<%}%>	
</html>