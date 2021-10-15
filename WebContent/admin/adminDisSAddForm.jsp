<%@page import="pet.cat.model.CatLDTO"%>
<%@page import="java.util.List"%>
<%@page import="pet.cat.model.CatDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대분류 소분류 추가</title>
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
if(session.getAttribute("admin") != null){
CatDAO dao = new CatDAO();
List articleList = dao.Lptdata();

%>

<!-- 파일 업로드! -->
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

<div style="display: flex;">
	<div style="display: flex; align-items: center; justify-content: center; flex-direction: row; width: 900px;">
		<form action="adminDisSAddPro.jsp" method="post" name="adminInputDisForm" enctype="multipart/form-data">
			<div style="height: 170px;">
				<table>
					<tr>
						<td>
							<h1>대분류 명*</h1><br />
							<select name="sublptNo" >
							<%
							CatLDTO article = null;
							for(int i = 0; i<articleList.size(); i++){
								article = (CatLDTO)articleList.get(i); %>
								<option value="<%=article.getLptNo()%>"><%=article.getLptName()%> </option>
							<%}%>
							</select>
							
							<%-- <input type="hidden" name="sublptNo" value="<%=article.getLptNo()%>" /> --%> 
						</td>
					</tr>
				</table>
			</div>
			<div>
				<table>
					<tr>
						<td>소분류 내용*<br />
							<input style="width: 400px; height: 250px;" type="text" name="subName" />
						</td>
					</tr>
				</table>
			</div>
			
		</div>
		<div style="margin-top: 100px;">
				<table>			
					<tr>
						<td>이미지 변경*<br />
							<input type="file" name="subImg" />
						</td>
					</tr>
					<tr>
						<td>
							<input class="back" style="width: 100px" type="submit" value="추가하기" />
							<input class="back" style="width: 100px" type="button" onclick="history.back(-1)" value="뒤로가기">
						</td>
					</tr>
				</table>
			</div>	
		</form>
	</div>
</div>		








</body>
<%}else{ %>
		<script>
	  	 alert("잘못된 경로입니다."); 
	  	 window.location = "/petBill/search/main.jsp"; 
		</script>
<%} %>
</html>