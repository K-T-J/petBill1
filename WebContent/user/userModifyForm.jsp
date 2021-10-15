<%@page import="pet.user.model.UserDTO"%>
<%@page import="pet.user.model.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
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


<%	
	if(session.getAttribute("userId") == null && session.getAttribute("hosId")==null && session.getAttribute("admin")==null){%>
	<script>
		alert("로그인 해주세요");
		window.location = "/petBill/user/loginForm.jsp";
	</script>	
	
<%}else{
	String id = (String) session.getAttribute("userId");
	UserDAO dao = UserDAO.getInstance();
	UserDTO user = dao.getUser(id);
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
	
	<div style="display: flex; height: 600px;">
		<div style="height: 100%; width: 30%;">
			<div>
				<table style="padding: 80px; margin-left: 26px;">
					<tr bgcolor="lightgray">
						<td>
							<button onclick="window.location='/petBill/user/userMypage.jsp'"><h1>회원정보</h1></button>
						</td>
					</tr>
					<tr>
						<td>
							<button onclick="window.location='/petBill/user/userReviewList.jsp'"><h1>후기관리</h1></button>
						</td>
					</tr>
					<tr>
						<td>
							<button onclick="window.location='/petBill/search/error.jsp'"><h1>QnA</h1></button>
						</td>
					</tr>
					<tr>
						<td>
							<button onclick="window.location='/petBill/user/userDeleteForm.jsp'"><h1>회원탈퇴</h1></button>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div style="height: 100%; width: 50%;">
			<div>
			<h1 style=" margin-left: 195px;">정보 수정</h1>
				<table style="margin-left: 195px;">
					<tr>
						<td>아이디<br/>
							<%=user.getUserId()%>
						</td>
					</tr>
					<tr>
						<td><br /> 비밀번호
						<input class="back" type="button" onclick="window.location='pwModifyForm.jsp'" value="수정" /><br/>
								<%=user.getUserPw() %>
						</td>
					</tr>
					<tr>
						<td>
							<br />이름<br /> <%=user.getUserName()%>
						</td>
					</tr>
					<tr>
						<td>
							<br />휴대폰<br /> <input type="text" name="userMobile" value="<%=user.getUserMobile()%>" placeholder="'-'포함" maxlength="13" />
						</td>
					</tr>
					<tr>
						<td>
							<br />닉네임<br /> <input type="text" name="userNick" value="<%=user.getUserNick()%>" />&nbsp;<input style="width: 105px;" class="back" type="button" value="중복 체크" />
						</td>
					</tr>
					<tr>
						<td><br />주소<br /> 
								<select name="userSiAddress">
									<option value="서울특별시">서울특별시</option>
								</select>
						</td>
					</tr>
					<tr>
						<td><select name="userSelectAddress">
						<option value="종로구"
							<%=user.getUserSelectAddress().equals("종로구") ? " selected" : ""%>>종로구</OPTION>
						<option value="중구"
							<%=user.getUserSelectAddress().equals("중구") ? " selected" : ""%>>중구</OPTION>
						<option value="용산구"
							<%=user.getUserSelectAddress().equals("용산구") ? " selected" : ""%>>용산구</OPTION>
						<option value="성동구"
							<%=user.getUserSelectAddress().equals("성동구") ? " selected" : ""%>>성동구</OPTION>
						<option value="광진구"
							<%=user.getUserSelectAddress().equals("광진구") ? " selected" : ""%>>광진구</OPTION>
						<option value="동대문구"
							<%=user.getUserSelectAddress().equals("동대문구") ? " selected" : ""%>>동대문구</OPTION>
						<option value="중랑구"
							<%=user.getUserSelectAddress().equals("중랑구") ? " selected" : ""%>>중랑구</OPTION>
						<option value="성북구"
							<%=user.getUserSelectAddress().equals("성북구") ? " selected" : ""%>>성북구</OPTION>
						<option value="강북구"
							<%=user.getUserSelectAddress().equals("강북구") ? " selected" : ""%>>강북구</OPTION>
						<option value="도봉구"
							<%=user.getUserSelectAddress().equals("도봉구") ? " selected" : ""%>>도봉구</OPTION>
						<option value="노원구"
							<%=user.getUserSelectAddress().equals("노원구") ? " selected" : ""%>>노원구</OPTION>
						<option value="은평구"
							<%=user.getUserSelectAddress().equals("은평구") ? " selected" : ""%>>은평구</OPTION>
						<option value="서대문구"
							<%=user.getUserSelectAddress().equals("서대문구") ? " selected" : ""%>>서대문구</OPTION>
						<option value="마포구"
							<%=user.getUserSelectAddress().equals("마포구") ? " selected" : ""%>>마포구</OPTION>
						<option value="양천구"
							<%=user.getUserSelectAddress().equals("양천구") ? " selected" : ""%>>양천구</OPTION>
						<option value="강서구"
							<%=user.getUserSelectAddress().equals("강서구") ? " selected" : ""%>>강서구</OPTION>
						<option value="구로구"
							<%=user.getUserSelectAddress().equals("구로구") ? " selected" : ""%>>구로구</OPTION>
						<option value="금천구"
							<%=user.getUserSelectAddress().equals("금천구") ? " selected" : ""%>>금천구</OPTION>
						<option value="영등포구"
							<%=user.getUserSelectAddress().equals("영등포구") ? " selected" : ""%>>영등포구</OPTION>
						<option value="동작구"
							<%=user.getUserSelectAddress().equals("동작구") ? " selected" : ""%>>동작구</OPTION>
						<option value="관악구"
							<%=user.getUserSelectAddress().equals("관악구") ? " selected" : ""%>>관악구</OPTION>
						<option value="서초구"
							<%=user.getUserSelectAddress().equals("서초구") ? " selected" : ""%>>서초구</OPTION>
						<option value="강남구"
							<%=user.getUserSelectAddress().equals("강남구") ? " selected" : ""%>>강남구</OPTION>
						<option value="송파구"
							<%=user.getUserSelectAddress().equals("송파구") ? " selected" : ""%>>송파구</OPTION>
						<option value="강동구"
							<%=user.getUserSelectAddress().equals("강동구") ? " selected" : ""%>>강동구</OPTION>
						</select></td>
					</tr>
					<tr>
						<td>
							<input type="text" name="userDetailAddress" value="<%=user.getUserDetailAddress()%>" placeholder="상세주소" />
						</td>
					</tr>
					
					<tr>	
						<td><br /> 
							<input style="width: 100px;" class ="back" type="submit" value="수정하기" />
							<input style="width: 90px;" class ="back" type="reset" value="재작성" />
							<button class ="back" onclick="window.location='userMypage.jsp'" >취소</button>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>

</body>
<%} %>
</html>