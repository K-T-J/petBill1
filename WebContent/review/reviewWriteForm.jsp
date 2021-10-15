<%@page import="pet.user.model.UserDTO"%>
<%@page import="pet.rev.model.RevDAO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="pet.hos.model.HosDAO"%>
<%@page import="pet.hos.model.HosDTO"%>
<%@page import="pet.rev.model.RevDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css">

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
	function check(){
		var inputs = document.inputForm;
		
		if(!inputs.reviewSubject.value){
			alert("제목을 입력하세요.")
			return false;
		}
		if(!inputs.reviewPetKind.value){
			alert("품종을 입력하세요.")
			return false;
		}
		if(!inputs.reviewGender.value){
			alert("성별을 입력하세요.")
			return false;
		}
		if(!inputs.reviewPrice.value){
			alert("금액을 입력하세요.")
			return false;
		}
	}

</script>
<%
	String userId = (String)session.getAttribute("userId");
	String hosId = (String)session.getAttribute("hosId");
	String admin = (String)session.getAttribute("admin");
	String hosNo = request.getParameter("hosNo");
	System.out.println("hosNo : " + hosNo);
	String hosGu = request.getParameter("hosGuAddress");
	System.out.println("hosGu : " + hosGu);
	UserDTO dto = new UserDTO();
	dto.setUserId(userId);
	RevDTO rev = new RevDTO();
	
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
		
		
	<h1 align="center"> 게시글 작성 </h1>
<div>
	<form action="reviewWritePro.jsp?reviewPhoto=multipart" name="inputForm" method="post" enctype="multipart/form-data" onsubmit = "return check()">  
		<div>
			<table align="center"> 
				<tr>
					<td>
						<input type="hidden" name = "reviewId" value = "<%=dto.getUserId()%>"/>
						<input type="hidden" name = "reviewHosNo" value = "<%=hosNo%>"/>
						<input type="hidden" name = "reviewGu" value = "<%=hosGu%>"/>
						제목(필수)&nbsp;<input type="text" name="reviewSubject"/>
					</td>
				</tr>
				<tr>
					<td>
						품종(필수)&nbsp;<input type="text" name="reviewPetKind" />
					</td>
				</tr>
				<tr>
					<td>
						성별(필수)&nbsp;
						<input type="radio" name="reviewGender" value="남"/> 남
						<input type="radio" name="reviewGender" value="여"/> 여
					</td>
				</tr>
				<tr>
					<td>
						나이 &nbsp;<input type="number" name="reviewAge"  placeholder="숫자만 입력하세요"/>세
					</td>
				</tr>
				<tr>
					<td>
						몸무게 &nbsp;<input type="number" name="reviewWeight" placeholder="숫자만 입력하세요" />kg
					</td>
				</tr>
				<tr>
					<td>
						강아지/고양이(필수)&nbsp;
						<input type="radio" name="reviewPetType" value="강아지"/> 강아지
						<input type="radio" name="reviewPetType" value="고양이" checked/> 고양이
					</td>	
				</tr>
				<tr>
					<td>영수증 사진 첨부
						<input type="file" name="reviewPhoto" />
						<input type="hidden" name="exreviewPhoto"/>
					<td>
				</tr>
				<tr>
					<td>
						진료항목(필수)&nbsp;
						<select name="reviewArticle">
							<option value="hosBasicVaccin">기초`접종</option>
							<option value="hosNeuteringMan">중성화 수술(남)</option>
							<option value="hosNeuteringWoman">중성화 수술(여)</option>
							<option value="hosHeartWorm">심장사상충</option>
							<option value="others">기타</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						금액(필수)&nbsp;<input type="number" name="reviewPrice" placeholder="숫자만 입력하세요" /> 원
					</td>
				</tr>
				<tr>
					<td align="center">
						&nbsp;<textarea rows="20" cols="40" name="reviewContent" placeholder="진료항목 '기타'선택시 작성자가 병명 기술"></textarea><br/>
						후기
					</td>
				</tr>
				<tr>
					<td> 
						평가(필수)
						<input type="radio" name="reviewJudge" value="좋아요" checked/> 좋아요
						<input type="radio" name="reviewJudge" value="보통이에요" /> 보통이에요
						<input type="radio" name="reviewJudge" value="나빠요" /> 나빠요
					</td>
				</tr>
			</table>	
			<table align="center">	
				<tr >
					<td>
						<button type="submit">저장</button>
						<button type="reset">재작성</button>
						<button type="button" onclick="history.go(-1);" >뒤로가기</button>
					</td>
				</tr> 
			</table>
		</div>
	</form>
</div>	 
</body> 
</html>
