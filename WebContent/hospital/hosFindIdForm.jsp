<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css"/>
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
				<button onclick = "window.location = '/petBill/user/loginForm.jsp'" style="margin-left: 80px; margin-right: 10px; height: 30%; width: 130px; border-radius: 10px;"><h3>로그인</h3></button>
				<button onclick = "window.location = '/petBill/user/signupMain.jsp'" style="height: 30%; width: 138px; border-radius: 10px;" ><h3>회원가입</h3></button>
		</div>
	</header>
	<div style="height: 300px; margin-top: 74px">	
	<form action="hosFindIdPro.jsp" method="post">
			<table align="center">
				<tr>
					<td>병원명<br/>
						<input type="text" name="hosName"/>
					</td>
				</tr>
				<tr>
					<td>병원전화번호<br/>
					<input type="text" name="hosTel" placeholder="02-1234-1234"/></td>
				</tr>
			</table>
			<table align="center">	
				<tr>	
					<td><br/>
						<input style="width: 115px;" class="back" type="submit" value="아이디 찾기"/>
						<input style="width: 130px;" class="back" type="button" value="비밀번호 찾기" onclick = "window.location='hosFindPwForm.jsp'"/>
						<input class="back" type="button" value="취소" onclick= "window.location='../user/loginForm.jsp'"/>
					</td>
				</tr>
			</table>
	</form>
	</div>
</body>
</html>