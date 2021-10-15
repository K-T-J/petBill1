<%@page import="java.text.DecimalFormat"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="pet.hos.model.HosDTO"%>
<%@page import="pet.hos.model.HosDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공공데이터 병원검색결과</title>
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
	<jsp:useBean id="hosDto" class="pet.hos.model.HosDTO"/>
	<jsp:setProperty property="*" name="hosDto"/>
<%
	HosDAO hosDao = HosDAO.getInstance();
	//전화번호로 공공데이터 검색
	HosDTO searchDto = hosDao.getHospital(hosDto.getHosTel());
	//검색결과 searchDto가 null값일 때 꺼내려고하면 에러난다!!!! 몇시간걸려서 깨달은건지...하..
/* 	System.out.println("hosId = "+ searchDto.getHosId());
	System.out.println("hosTel = "+ searchDto.getHosTel());
	System.out.println("hosNo = "+ searchDto.getHosNo()); */
%>
	<script>
	//아이디 중복 체크 확인
	function confirmHosId(hosInputForm){ // <-- this.form 객체 받음 
		if(hosInputForm.hosId.value == "" || !hosInputForm.hosId.value){ // 비었거나, id가 같지않다. 
			alert("아이디를 입력하세요.");
			return;
		}
		//팝업 
		var url ="confirmHosId.jsp?hosId="+ hosInputForm.hosId.value; // confirmId.jsp?id=rani
		open(url, "confirmHosId", "toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, width=500, height=500"); // 새창이 열리는 open!
	}
	// 유효성검사 (가입누르기 전에 검사!)
	function check(){
		// id 있는지 없는지 
		var inputs = document.hosInputForm;
		
		if(inputs.hosIdCheck.value == "0"){
			alert("아이디 중복확인을 반드시 해주세요.");
			return false;
		}
		if(!inputs.hosId.value){
			alert("아이디를 입력하세요.");
			return false;
		}
		if(!inputs.hosPw.value){
			alert("비밀번호를 입력하세요.");
			return false;
		}
		if(!inputs.hosPwCk.value){
			alert("비밀번호 확인란을 입력하세요.");
			return false;
		}
		if(!inputs.hosUserName.value){
			alert("비밀번호 찾기에 사용됩니다. 병원대표자 명을 입력하세요.");
			return false;
		}
		if(!inputs.hosMobile.value){
			alert("비밀번호 찾기에 사용됩니다. 휴대폰번호를 입력하세요.");
			return false;
		}
		//비밀번호와 비밀번호 확인란 작성값 동일 체크
		if(inputs.hosPw.value != inputs.hosPwCk.value){
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
		
	}// check함수 
	</script>
	
<% 
	try{
		//1.검색결과 searchDto 데이터 값이 들어있는 경우
		if(searchDto != null){ 

			// 1) hosId 없음 : 공공데이터에 추가되는 회원가입
			if(searchDto.getHosId() == null || searchDto.getHosId().equals("none")){
				System.out.println("가입안된 공공데이터 병원임");%>
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
		
				<h1 align="center">병원회원가입</h1>
				<p align="center"><%=searchDto.getHosName()%> 님, 환영합니다!</p>
				<div align="center">
				<!-- 유효성검사 마지막 아이디,비번,비번쳌,병원명,전화번호 -->
				<form action="hosExistSignupPro.jsp" method="post" enctype="multipart/form-data" name="hosInputForm" onsubmit="return check()">
	
				<!-- 글 고유번호 숨겨서 전송 -->
				<input type="hidden" name="hosNo" value="<%=searchDto.getHosNo()%>"/>	
			
				<table>
				<tr>
					<td>아이디 (필수)<br />
						<input type="text" name="hosId" placeholder="영문+숫자조합" />
						<input style="width: 105px;" class="back" type="button" value="중복체크" onclick="confirmHosId(this.form)"/>
						<input type="hidden" name ="hosIdCheck" value ="0"/>
					</td>
				</tr>
				<tr>
					<td>비밀번호 (필수)<br />
						<input type="password" name="hosPw"/>
					</td>
				</tr>
				<tr>
					<td>비밀번호 확인 (필수)<br />
						<input type="password" name="hosPwCk"/>
					</td>
				</tr>
				<tr>
					<td>병원 대표자 명 (필수)<br />
						<input type="text" name="hosUserName"/>
					</td>
				</tr>
				<tr>
					<td>대표자 휴대폰번호 (필수)<br />
						<input type="text" name="hosMobile" placeholder="'-'포함해서 입력"/>
					</td>
				</tr>
				<tr>
					<td>병원명 <br />
						<p><%=searchDto.getHosName()%></p>
					</td>
				</tr>
				<tr>
					<td>전화번호 <br />
						<p><%=searchDto.getHosTel()%></p>
					</td>
				</tr>
				<tr>
					<td>도로명 주소<br />
						<p><%=searchDto.getHosNewAddress()%></p>
					</td>
				</tr>
				<tr>
					<td>지번 주소<br />
						<p><%=searchDto.getHosOldAddress()%></p>
					</td>
				</tr>
				<!-- 진료비 추가 21.07.20  -->
				<tr>
					<% DecimalFormat df = new DecimalFormat("###,###,###"); %>
					<td>기초접종 (회원 가입승인 시 금액 변경이 가능합니다)<br />
					<% int Vaccin = Integer.parseInt(searchDto.getHosBasicVaccin().replace(".0", "")); %>
						<p><%=df.format(Vaccin)%> 원 </p>
					</td>
				</tr>
				<tr>
					<% int ntrMan = Integer.parseInt(searchDto.getHosNeuteringMan().replace(".0", "")); %>
					<td>중성화(남) (회원 가입승인 시 금액 변경이 가능합니다)<br />
						<p><%=df.format(ntrMan)%> 원 </p>
					</td>
				</tr>
				<tr>
					<% int ntrWoman = Integer.parseInt(searchDto.getHosNeuteringWoman().replace(".0", "")); %>
					<td>중성화(여) (회원 가입승인 시 금액 변경이 가능합니다)<br />
						<p><%=df.format(ntrWoman)%> 원 </p>
					</td>
				</tr>
				<tr>
					<% int heart = Integer.parseInt(searchDto.getHosHeartWorm().replace(".0", "")); %>
					<td>심장사상충 (회원 가입승인 시 금액 변경이 가능합니다)<br />
						<p><%=df.format(heart)%> 원 </p>
					</td>
				</tr>
				
				<tr>
					<td>사업자 등록번호<br />
						<input type="text" name="hosNum" placeholder="'-'포함"/>
					</td>
				</tr>
				<tr>
					<td>영업시간<br />
						<input type="text" name="hosTime" placeholder="ex) 09:00~18:00"/>
					</td>
				</tr>
				<tr>
					<td>사업자등록증 사진<br />
						<input type="file" name="hosNumPhoto" />
					</td>
				</tr>
				<tr>
					<td>대표자 사진<br />
						<input type="file" name="hosProfile"/>
					</td>
				</tr>
				<tr>
					<td>병원장 약력<br />
						<textarea name="hosBio" rows="10" cols="25" placeholder="2000자 내외"></textarea>
					</td>
				</tr>
				<tr>
					<td>
						<input style="width: 100px;" class="back" type="submit" value="신청하기"/>
						<input style="width: 100px;" class="back" type="reset" value="재작성"/>
						<input class="back" type="button" id="back" onclick="window.location='/petBill/search/main.jsp'" value="취소"/>
					</td>
				</tr>
				</table>
				</form>
				</div>
		
		  <%}else {
		  		System.out.println("hosId = " + searchDto.getHosId());
		  		System.out.println("hosPw = " + searchDto.getHosPw());%>
				<script>
					// 2) hosId 있음 = 가입내역있음 : 로그인페이지로 보냄
					alert("이미 등록된 회원입니다. 로그인 페이지로 이동합니다.");
					window.location.href = "../user/loginForm.jsp";
				</script>
		  <%} 
			
		//2. 공공데이터 없으면 신규회원가입 
		}else{//(searchDto == null)%>
			<script>
				alert("등록된 정보가 없습니다.");
				window.location.href = "hosSignupForm.jsp";
			</script>	
					
<%		}//if(searchDto != null

	}catch(Exception e){
		e.printStackTrace();
	}%>
		
<body>


</body>
</html>





