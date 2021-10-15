<%@page import="java.text.DecimalFormat"%>
<%@page import="pet.hos.model.HosDTO"%>
<%@page import="pet.hos.model.HosDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>hospital Mypage</title>
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
%>
	<jsp:useBean id="Dto" class="pet.hos.model.HosDTO"/>
	<jsp:setProperty property="*" name="Dto"/>

<body>
	<!-- 비로그인시 접근불가 -->
<%	
	// 세션id값 없으면 로그인페이지로 이동 
	String hosId = (String)session.getAttribute("hosId");

	//활동상태에 따라 회원정보 수정가능/불가 hosActiveNum='1'번 상태일때만 수정버튼 보이게.		

	
	if(hosId == null){ %>
		<script>
			alert("로그인이 필요합니다.");
			history.go(-1);
		</script>
<% 	}else{ 	
		HosDAO dao = HosDAO.getInstance();
		//회원정보 꺼내오기
		HosDTO hosDto = dao.getHosMember(hosId);
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
	
<!-- ======================================상단메뉴 구분선========================================= -->	
	
	
	<div style="display: flex; height: 600px;">
		<div style="height: 100%; width: 30%;">
			<div>
				<table style="padding: 80px; margin-left: 26px;">
					<tr bgcolor="lightgray">
						<td>
							<button style="width: 190px; height: 95px;" onclick="window.location='/petBill/hospital/hosMypage.jsp'"><h1>병원<br/>회원정보</h1></button>
						</td>
					</tr>
					<tr>
						<td>
							<button style="width: 190px; height: 95px;" onclick="window.location='/petBill/search/error.jsp'"><h1>1:1문의</h1></button>
						</td>
					</tr>
					<tr>
						<td>
							<button style="width: 190px; height: 95px;" onclick="window.location='/petBill/search/error.jsp'"><h1>병원<br/>공지사항</h1></button>
						</td>
					</tr>
					<tr>
						<td>
							<button style="width: 190px; height: 95px;" onclick="window.location='/petBill/search/error.jsp'"><h1>병원<br/>이벤트</h1></button>
						</td>
					</tr>
					<tr>
						<td>
							<button style="width: 190px; height: 95px;" onclick="window.location='/petBill/hospital/hosDeleteForm.jsp'"><h1>회원탈퇴</h1></button>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div style="height: 100%; width: 50%;">
			<div>
			<h1 style=" margin-left: 195px;">병원 회원 정보</h1>
			<form action="hosModifyForm.jsp" method="post">
				<table style="margin-left: 195px;">
					<tr>
						<td>아이디<br />
							<b><%=hosDto.getHosId()%></b>
						</td>
					</tr>
					<tr>
						<td>병원명<br />
							<b><%=hosDto.getHosName()%></b>
						</td>
					</tr>
					<tr>
						<td>병원 전화번호<br />
							<b><%=hosDto.getHosTel()%></b>
						</td>
					</tr>
					<tr>
						<td>병원 주소<br />
							  <br />
							   지역 : <b><%=hosDto.getHosSiAddress()%> <%=hosDto.getHosGuAddress()%></b><br />
							   도로명 주소 : <b><%=hosDto.getHosNewAddress()%></b><br />
							   
							   지번 주소 : 
						   <% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
						  	 if(hosDto.getHosOldAddress() == null) {%>
								(등록된 정보가 없습니다.)
						   <%}else{ %> 
								<b><%=hosDto.getHosOldAddress()%></b>
						   <%}%>	
						</td>
					</tr>
					<tr>
						<td>사업자등록번호<br />
						   <% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
						  	 if(hosDto.getHosNum() == null) {%>
								(등록된 정보가 없습니다.)
						   <%}else{ %> 
								<b><%=hosDto.getHosNum()%></b>
						   <%}%>	
						</td>
					</tr>
					<tr>
						<td>영업시간<br />
							<% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
						  	 if(hosDto.getHosTime() == null) {%>
								(등록된 정보가 없습니다.)
						   <%}else{ %> 
								<b><%=hosDto.getHosTime()%></b>
						   <%}%>	
						</td>
					</tr>
					<tr>
						<td>병원 대표자 명<br />
							<% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
						  	 if(hosDto.getHosUserName() == null) {%>
								(등록된 정보가 없습니다.)
						   <%}else{ %> 
								<b><%=hosDto.getHosUserName()%></b>
						   <%}%>	
						</td>
					</tr>
					<tr>
						<td>대표자 휴대폰번호<br />
							<% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
						  	 if(hosDto.getHosMobile() == null) {%>
								(등록된 정보가 없습니다.)
						   <%}else{ %> 
								<b><%=hosDto.getHosMobile()%></b>
						   <%}%>	
						</td>
					</tr>
					<tr>
						<td>사업자등록증 사진<br />
							<% if(hosDto.getHosNumPhoto() != null) { //사진 저장된 게 있을경우 %>
								<img src="/petBill/photo/<%=hosDto.getHosNumPhoto()%>" width="200"/><br/>
							<% }else{ //사진 저장된 게 없다! %>
								<img src="/petBill/review/imgs/default.png" width="200"/><br/>
							<% }%>
						</td>
					</tr>
					<tr>
						<td>대표자 사진<br />
							<% if(hosDto.getHosProfile() != null) { //사진 저장된 게 있을경우 %>
								<img src="/petBill/photo/<%=hosDto.getHosProfile()%>" width="200"/><br/>
								<br />
								<br />
							<% }else{ //사진 저장된 게 없다! %>
								<img src="/petBill/review/imgs/default.png" width="200"/><br/>
								<br />
								<br />
							<% }%>
						</td>
					</tr>
					<tr>
						<td>병원장 약력<br />
							<% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
						  	 if(hosDto.getHosBio() == null) {%>
								(등록된 정보가 없습니다.)
						   <%}else{ %> 
								<b><%=hosDto.getHosBio()%></b>
						   <%}%>	
						</td>			
					</tr>
					<tr>		<% DecimalFormat df = new DecimalFormat("###,###,###"); %>
						<td>기초접종<br />
							<% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
						  	 if(hosDto.getHosBasicVaccin() == null) {%>
								(등록된 정보가 없습니다.)
						  	 	<br />
								<br />
						   <%}else{ //숫자변환상태 + 천단위','추가해서 출력
							   int Vaccin = Integer.parseInt(hosDto.getHosBasicVaccin().replace(".0", ""));	%> 
								<b><%=df.format(Vaccin)%> 원</b>
								<br />
								<br />
						   <%}%>	
						</td>
					</tr>
					<tr>
						<td>중성화(남)<br />
							<% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
						  	 if(hosDto.getHosNeuteringMan() == null) {%>
								(등록된 정보가 없습니다.)
						  	 	<br />
								<br />
						   <%}else{ 
							   int ntrMan = Integer.parseInt(hosDto.getHosNeuteringMan().replace(".0", ""));%> 
								<b><%=df.format(ntrMan)%> 원</b>
								<br />
								<br />
						   <%}%>	
						</td>
					</tr>
					<tr>
						<td>중성화(여)<br />
							<% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
						  	 if(hosDto.getHosNeuteringWoman() == null) {%>
								(등록된 정보가 없습니다.)
						  	 	<br />
								<br />
						   <%}else{ 
							   int ntrWoman = Integer.parseInt(hosDto.getHosNeuteringWoman().replace(".0", ""));%> 
								<b><%=df.format(ntrWoman)%> 원</b>
								<br />
								<br />
						   <%}%>	
						</td>
					</tr>
					<tr>
						<td>심장사상충<br />
							<% //null로 비어있는 상태면 빈박스 띄워주기 'null'출력방지
						  	 if(hosDto.getHosHeartWorm() == null) {%>
								(등록된 정보가 없습니다.)
						  	 	<br />
								<br />
						   <%}else{ 
							   int heart = Integer.parseInt(hosDto.getHosHeartWorm().replace(".0", ""));%> 
								<b><%=df.format(heart)%> 원</b>
								<br />
								<br />
						   <%}%>	
						</td>
					</tr>
					
					<tr>
							<%if(hosDto.getHosActiveNum() == 1){ //아직 회원가입대기 상태이면 수정버튼 안보이기%>
							<td colspan="2">
							<input style="height:75px; width:175px; font-size: 20px;" class="back" type="submit" value="수정하기">
							<input style="height:75px; width:175px; font-size: 20px;" class="back" type="button" onclick="window.location ='/petBill/search/main.jsp'" value="메인으로"/>
						<% }else if(hosDto.getHosActiveNum() == 2){%>
							<h3>'<%=hosDto.getHosId()%>' 님은 회원가입 신청 대기 상태입니다.</h3>
						<% }else if(hosDto.getHosActiveNum() == 3){%>
							<h3>'<%=hosDto.getHosId()%>' 님은 회원가입 거절 되었습니다 문의는 고객센터로 해주세요.</h3>
							<h3>거절 사유 : '<%=hosDto.getHosReason()%>'</h3>
							<%} %>
						</td>
					</tr>
				</table>
				</form>
			</div>
		</div>
	</div>	
<%	} //else %>
</body>
</html>