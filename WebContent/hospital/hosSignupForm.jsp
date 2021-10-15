<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>신규 병원회원가입</title>
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
	//전화번호 중복 체크 확인
	function confirmHosTel(hosInputForm){ // <-- this.form 객체 받음 
		if(hosInputForm.hosTel.value == "" || !hosInputForm.hosTel.value){ // 비었거나, hosTel가 같지않다. 
			alert("전화번호를 입력하세요.");
			return;
		}
		//팝업 
		var url ="confirmHosTel.jsp?hosTel="+ hosInputForm.hosTel.value;
		open(url, "confirmHosTel", "toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, width=500, height=500"); // 새창이 열리는 open!
	
	}
	// 유효성검사 (가입누르기 전에 검사!)
	function check(){
		// inputs변수에 폼데이터를 넣어줌 
		var inputs = document.hosInputForm;
		
		if(inputs.hosIdCheck.value == "0"){
			alert("아이디 중복확인을 반드시 해주세요.");
			return false;
		}
		if(inputs.hosTelCheck.value == "0"){
			alert("전화번호 중복확인을 반드시 해주세요.");
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
		if(!inputs.hosName.value){
			alert("병원명을 입력하세요.");
			return false;
		}
		if(!inputs.hosTel.value){
			alert("전화번호를 입력하세요.");
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
	
	<h1 align="center">신규 병원회원가입</h1>
	<div align="center">
	
	<!-- enctype="multipart/form-data" 파일 업로드위해 추가 -->
	<form action="hosSignupPro.jsp" method="post" name="hosInputForm" enctype="multipart/form-data" onsubmit="return check()">
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
				<td>병원명 (필수)<br />
				<input type="text" name="hosName"/>
				</td>
			</tr>
			<tr>
				<td>전화번호 (필수)<br />
				<input type="text" name="hosTel" placeholder="'-'포함"/>
				<input style="width: 105px;" class="back" type="button" value="중복체크" onclick="confirmHosTel(this.form)"/>
				<input type="hidden" name="hosTelCheck" value="0"/>
				</td>
			</tr>
			<tr>
				<td>병원 대표자 명 (필수)<br />
				<input type="text" name="hosUserName"/>
				</td>
			</tr>
			<tr>
				<td>대표자 휴대폰번호 (필수)<br />
				<input type="text" name="hosMobile" placeholder="'-'포함"/>
				</td>
			</tr>
			<tr>
			<td>도로명 주소*<br />
				<select name="hosSiAddress" >
				<option value="서울특별시">서울특별시</option>
			</select>
			<select name="hosGuAddress">
					<option value="종로구" selected>종로구</option>
					<option value="중구">중구</option>
					<option value="용산구">용산구</option>
					<option value="성동구">성동구</option>
					<option value="광진구">광진구</option>
					<option value="동대문구">동대문구</option>
					<option value="중랑구">중랑구</option>
					<option value="성북구">성북구</option>
					<option value="강북구">강북구</option>
					<option value="도봉구">도봉구</option>
					<option value="노원구">노원구</option>
					<option value="은평구">은평구</option>
					<option value="서대문구">서대문구</option>
					<option value="마포구">마포구</option>
					<option value="양천구">양천구</option>
					<option value="강서구">강서구</option>
					<option value="구로구">구로구</option>
					<option value="금천구">금천구</option>
					<option value="영등포구">영등포구</option>
					<option value="동작구">동작구</option>
					<option value="관악구">관악구</option>
					<option value="서초구">서초구</option>
					<option value="강남구">강남구</option>
					<option value="송파구">송파구</option>
					<option value="강동구">강동구</option> </select> 
					
					<input type="text" name="hosNewAddress" placeholder="상세주소"/>
				</td>
			</tr>
			<tr>
				<td>지번 주소<br />
				<input type="text" name="hosOldAddress"/>
				</td>
			</tr>
			<tr>
				<td>영업시간<br />
				<input type="text" name="hosTime" placeholder="ex) 09:00~18:00"/>
				</td>
			</tr>
			<tr>
				<td>사업자 등록번호<br />
				<input type="text" name="hosNum" placeholder="'-'포함"/>
				</td>
			</tr>
			<tr>
				<td>사업자등록증 사진<br />
				<input type="file" name="hosNumPhoto" />
				</td>
			</tr>
			<tr>
				<td>대표자 사진<br />
				<input type="file" name="hosProfile" />
				</td>
			</tr>
			<tr>
				<td>병원장 약력<br />
				<textarea name="hosBio" rows="10" cols="25" placeholder="2000자 내외"></textarea>
				</td>
			</tr>
			<!— 진료비 입력란 추가 21.07.20 —>
			<tr>
				<td>기초접종 비용<br />
				<input type="text" name="hosBasicVaccin" placeholder="숫자만 입력"/>
				</td>
			</tr>
			<tr>
				<td>중성화(남) 비용<br />
				<input type="text" name="hosNeuteringMan" placeholder="숫자만 입력"/>
				</td>
			</tr>
			<tr>
				<td>중성화(여) 비용<br />
				<input type="text" name="hosNeuteringWoman" placeholder="숫자만 입력"/>
				</td>
			</tr>
			<tr>
				<td>심장사상충 비용<br />
				<input type="text" name="hosHeartWorm" placeholder="숫자만 입력"/>
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="신청하기"/>
					<input type="reset" value="다시작성"/>
					<input type="button" value="취소"/>
				</td>
			</tr>
			<tr>
				<td>
					<input style="width: 100px;" class ="back" type="submit" value="신청하기"/>
					<input style="width: 90px;" class = "back" type="reset" value="재작성"/>
					<input class ="back" type="button" onclick="window.location='/petBill/search/main.jsp'" value="취소"/>
				</td>
			</tr>
		</table>
	</form>
	</div>

<body>

</body>
</html>