<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
   
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
<link href="style.css" rel = "stylesheet" type = "text/css">
</head>

<%
		request.setCharacterEncoding("UTF-8");
		
		if(session.getAttribute("userId") == null && session.getAttribute("hosId") == null){
			
			String userId = null, userPw = null, auto = null, login = null;
			Cookie [] coos = request.getCookies();
			if(coos != null){
				for(Cookie c : coos){
					if(c.getName().equals("autoId")) { userId = c.getValue();}
					if(c.getName().equals("autoPw")) { userPw = c.getValue();}
					if(c.getName().equals("autoAuto")) { auto = c.getValue();}
					if(c.getName().equals("autologin")) { login = c.getValue();}
				}
			}
			if(auto != null && userId != null && userPw != null && login != null){
				response.sendRedirect("/petBill/user/loginPro.jsp");
			}
		}
	%>
		
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
		<main>		
		
		
			<div style="display: flex; height: 150px; justify-content: center;">
				<div style="width: 40%; display: flex; justify-content: center;">
					<form action="searchMain.jsp" method="post" >
						<input type="text" name="mainHosSearch" placeholder="병원명 / 지역 구 검색" style="width: 550px; height: 75px; margin-top: 40px; border-radius: 10px;">
						<input class="input" type="submit"  value="검색"/>
					</form>
				</div>
			</div>	
		</main>	
			
			<div style="display: flex;">
				<div align="right" style="width: 30%; ">
					<button  onclick = "window.location='/petBill/search/subMain.jsp'" style="margin-top: 40px; border-radius: 10px;"><h2>고양이</h2></button>
				</div>
				<div style="width: 40%;">
				</div>
				<div align="left" style="width: 30%;">
					<button  onclick = "window.location='/petBill/search/error.jsp'"style="margin-top: 40px; border-radius: 10px;" ><h2>강아지</h2></button>
				</div>
			</div>	 
			
			<%--지도api --%>
			<div id="map" style="width:500px;height:400px;">
			
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f55f39534d3cc57f895d1842a900bce2"></script>
				<script>
					var container = document.getElementById('map');
					var options = {
									center: new kakao.maps.LatLng(33.450701, 126.570667),
										level: 3
									};
					var map = new kakao.maps.Map(container, options);
				</script>
			
			</div>
			
			
			<div>
				<div>
					<img src="/petBill/save/로얄캐닌.gif" style="width: 100%; height: 485px;"/>
				</div>
			</div>	
		<footer>
		</footer>
	</body>

</html>