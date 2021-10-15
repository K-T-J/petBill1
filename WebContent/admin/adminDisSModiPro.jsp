<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="pet.cat.model.CatDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소분류 수정 pro 페이지</title>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="dto" class="pet.cat.model.CatSDTO"/>
<%


	//사진 저장
	String path = request.getRealPath("photo");
	System.out.println(path); 
	int max = 1024*1024*5;
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);

	//***** 파일은 getFilesystemName으로만 꺼낼수있다.
	String disProfile = mr.getFilesystemName("subImg");
	System.out.println("질병 사진명 : " + disProfile);

	if(disProfile != null){  // 이미지일 경우 
		// 파일 컨텐트 타입만 먼저 뽑아서 image 타입인지 확인 
		String contentType = mr.getContentType("subImg");
		System.out.println("파일타입 = " + contentType);
		String[] type = contentType.split("/");
	
	if(!(type != null && type[0].equals("image"))){ // 이미지가 아닐경우 
		File f = mr.getFile("disProfile");
		f.delete();
		System.out.println("파일삭제 완료");
%>
		<script>
			alert("이미지 파일만 업로드 가능합니다.");
			history.go(-1);
		</script>
<%}
	// 넘어온 데이터들 하나 하나 빼서 CatSDTO에 저장
	 
	dto.setSubNo(Integer.parseInt(mr.getParameter("subNo")));
	dto.setSubLptNo(mr.getParameter("sublptNo"));
	System.out.println("dto : " + dto.getSubLptNo());
	dto.setSubName(mr.getParameter("subName"));
	System.out.println("subname : " + dto.getSubName());
	dto.setSubImg(mr.getFilesystemName("subImg"));
	System.out.println("subImg : " + mr.getParameter("subImg"));
	
	
	// 저장
	CatDAO dao = new CatDAO();
	int result = dao.updateCatS(dto);
	System.out.println("result 머냐? : " + result);
	
	if(result == 1){%>
	<script>
		alert("수정 되었습니다.");
		window.location="adminDisSModify.jsp";
	</script>
	<%}else{%>
	<script>
		alert("다시 시도해 주세요!");
		history.go(-1);
	</script>
<%}
}else{ // null일때
		dto.setSubNo(Integer.parseInt(mr.getParameter("subNo")));
		dto.setSubLptNo(mr.getParameter("sublptNo"));
		System.out.println("dto : " + dto.getSubLptNo());
		dto.setSubName(mr.getParameter("subName"));
		System.out.println("subname : " + dto.getSubName());
		dto.setSubImg(mr.getFilesystemName("subImg"));
		System.out.println("subImg : " + mr.getParameter("subImg"));
		
		
	// 저장
	CatDAO dao = new CatDAO();
	int result = dao.updateCatS(dto);
	System.out.println("result 머냐? : " + result);
	
	
		if(result == 1){%>
			<script>
				alert("수정 되었습니다.");
				window.location="adminDisSModify.jsp";
			</script>
		<%}else{%>
			<script>
				alert("다시 시도해 주세요!");
				history.go(-1);
			</script>
		<%}
		}%> 
	
</head>
<body>

</body>
</html>