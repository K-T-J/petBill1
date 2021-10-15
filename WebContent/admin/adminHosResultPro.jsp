<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pet.hos.model.HosDAO"%>
<%@ page import="pet.hos.model.HosDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 활동상태 변경 Pro</title>
<link href="style.css" rel = "stylesheet" type = "text/css">

</head>
<%
	request.setCharacterEncoding("UTF-8");
	
	HosDAO dao = HosDAO.getInstance();
	HosDTO dto = new HosDTO();
	
	int adminHosNo = Integer.parseInt(request.getParameter("adminHosNo"));
	System.out.println("adminHosResultPro : " + adminHosNo);
		
	String[] hosActiveNum = request.getParameterValues("hosActiveNum");
	System.out.println("hosActiveNum : " + hosActiveNum);
	
	
	int hosAnInt = 0;
	for (String hosAn : hosActiveNum) {
		hosAnInt = Integer.parseInt(hosAn);
	}
	System.out.println("hosAnInt : " + hosAnInt);
	
	String hosReason = request.getParameter("hosReason");
	System.out.println("hosReason : " + hosReason);
	
	// 넘어온 hosNo의 파라미터 값을 dto에 담아 메서드 생성.
	dto.setHosNo(adminHosNo);
	boolean result = dao.updateHosActiveNum(dto, hosAnInt, hosReason);  
	 
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
	
	
	
	
	
		<br />
		<h1 align="center" style="padding:60px;"> 병원 활동상태 정보 수정 </h1>
	<% 
		if (result == true) { 
	%>
		<table align="center">
			<tr>
				<td> <b>병원 활동상태 정보가 수정되었습니다.</b> </td>
			</tr>
			<tr>
				<td align="center"> <button onclick="window.location='adminHosList.jsp'"> 리스트 </button> </td>
			</tr>
		</table>
	<% 
		} else { 
	%>
		<script>
			alert("활동정보 수정 실패. 정보를 다시 확인해주세요.");
			history.go(-1);
		</script>
	<% 
		}
	%>
	
	</body>
</html>