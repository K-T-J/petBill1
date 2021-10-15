<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link href="style.css" rel = "stylesheet" type = "text/css">
</head>
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

<script>
	function check(){//체크 메서드
		var inputs = document.inputForm;
		
		if(inputs.userIdcheck.value == "0"){
			alert("아이디 중복확인을 반드시 해주세요.");
			return false;
		}
		if(inputs.userNickcheck.value == "0"){
			alert("닉네임 중복확인을 반드시 해주세요.");
			return false;
		}
		if(!inputs.userId.value){//id 값이 없을때
			alert("아이디를 입력하세요.")
			return false;
		}
		if(!inputs.userPw.value){
			alert("비밀번호를 입력하세요")
			return false;
		}
		if(!inputs.userPwch.value){
			alert("비밀번호확인란을 입력하세요")
			return false;
		}
		if(!inputs.userName.value){
			alert("이름을 입력하세요")
			return false;
		}
		if(!inputs.userMobile.value){
			alert("휴대폰 번호를 입력하세요")
			return false;
		}
		if(!inputs.userNick.value){
			alert("닉네임을 입력하세요")
			return false;
		}
		
		//비밀번호와 비밀번호 확인란 작성값 동일 체크
		if(inputs.userPw.value != inputs.userPwch,value){
			alert("비밀번호를 동일하게 입력하세요");
			return false;
		}
	}
	
	
		/* 
		
		function userMobile(p) {
		var inputs = document.inputForm;

		p = p.split('-').join('');

		var regPhone = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;

		return regPhone.test(p);

		} */
		
		//아이디 중복체크
		
		function confirmId(inputForm){
			if(inputForm.userId.value == "" || !inputForm.userId.value){//유저id값이 빈칸이거나 값이 없을때
				alert("아이디를 입력하세요.");
				return; //강제종료
			}
			
			
		//팝업으로 띄우기
		var url = "confirmId.jsp?userId=" + inputForm.userId.value;//ex)confirmId.jsp?userId=java
		open(url, "conformId", "toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizeable=no, width=500, height=300");
		}
		
		function confirmNick(inputForm){
			if(inputForm.userNick.value == "" || !inputForm.userNick.value){
				alert("닉네임을 입력하세요.");
				return;
			}
			//팝업으로 띄우기
			var url = "confirmNick.jsp?userNick=" + inputForm.userNick.value;
			open(url, "conformNick", "toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizeable=no, width=500, height=300");
		}

</script>



<body class="body">
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
	<br/>
	<h1 align = "center">일반 회원가입</h1>
	
	<form action="userSignupPro.jsp" method="post" name="inputForm" onsubmit = "return check()">
	<br/>
		<table align="center">
			<tr>
				<td>아이디(필수)<br/>
					<input type="text" name="userId" placeholder="영문/숫자 조합"/>&nbsp;<input style="width: 105px;" class="back" type="button" value="중복 체크" onclick="confirmId(this.form)"/>
					<input type="hidden" name ="userIdcheck" value = "0"/>
				</td> 
			</tr>
			<tr>
				<td>비밀번호(필수)<br/>
					<input type="password" name="userPw"/>
				</td>
			</tr>
			<tr>
				<td>비밀번호 확인(필수)<br/>
					<input type="password" name="userPwch" />
				</td>
			</tr>
			<tr>
				<td>이름(필수)<br/>
					<input type="text" name="userName"/>
				</td>
			</tr>
			<tr>
				<td>휴대폰(필수)<br/>
					<input type="text" name="userMobile" placeholder="'-' 포함" maxlength="13" />
				</td>
			</tr>
			<tr>
				<td>닉네임(필수)<br/>
					<input type="text" name="userNick"/>&nbsp;<input style="width: 105px;" class="back" type="button" value="중복 체크" onclick="confirmNick(this.form)"/>
					<input type="hidden" name ="userNickcheck" value = "0"/>
				</td>
			</tr>
			<tr>
				<td>주소<br/>
					<select name="userSiAddress">
						<option value="서울특별시">서울특별시</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					<select name="userSelectAddress">
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
						<option value="강동구">강동구</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" name="userDetailAddress" placeholder="상세주소"/>
				</td>
			</tr>
			
			<tr>	
				<td>
					<input style="width: 100px;" class ="back" type="submit" value="가입"/>
					<input style="width: 90px;" class = "back" type="reset" value="재작성"/>
					<input class ="back" type="button" onclick= "window.location='/petBill/search/main.jsp'" value="취소"/>
				</td>
			</tr>
		</table>
	</form>
<footer style="height: 30px">
</footer>


</body>
</html>