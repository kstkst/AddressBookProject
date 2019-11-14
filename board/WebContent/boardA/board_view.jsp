<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 오류 페이지 정의  -->
<%@ page errorPage="board_error.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>게시판 등록</title>
	<link rel="stylesheet" href="board.css" type="text/css" media="screen" />

	<script type="text/javascript">

		// window.load는 페이지 로딩 후 실행
		window.onload = function() {
			var action = document.form1.action.value;

			if(action=="edit") {
				document.getElementById("insert").disabled=true;
				// document.getElementById("update").disabled=false;
				// document.getElementById("delete").disabled=false;
			} else if(action=="add") {
				// document.getElementById("insert").disabled=false;
				document.getElementById("update").disabled=true;
				document.getElementById("delete").disabled=true;
			}
		} 
	
		function insertcheck() {
			// post방식
			document.form1.action.value="insert";
			document.form1.submit();
		}
	
		function updatecheck() {
			// post방식
			document.form1.action.value="update";
			document.form1.submit();
		}
	
		function deletecheck() {
			result = confirm("정말로 삭제하시겠습니까 ?");
		
			if(result == true){
				
				// post방식
				document.form1.action.value="delete";
				document.form1.submit();
			}
			else
				return;
		}
	</script>

</head>

<%-- 자바빈즈 사용 --%>   
<jsp:useBean id="boardDTO" scope="request" class="boardA.BoardDTO"></jsp:useBean>

<body>
	<div align="center">
	<H2>게시판 등록</H2>
	<HR>
	
	<a href="board_control.jsp?action=list">게시판목록 조회</a>
	
	<!-- 게시판 등록용 -->
	<form name="form1" method="post" action=board_control.jsp>
	
		<%

			// action구분 등 파라메터(add 또는 edit)
			String action = request.getParameter("action");
			
			// action이 add이면 값 초기화
			if(action.equals("add")) {
				boardDTO.setUserName("");
				boardDTO.setTitle("");
				boardDTO.setContent("");
			}
		%>
	
		<input type="hidden" name="action" value="<%= action %>">
		<input type="hidden" name="id" value="<%= boardDTO.getId() %>">
		
		<table>
			<tr>
				<th>성명</th>
				<td><input type=text size=20 name=userName value="<%= boardDTO.getUserName() %>"></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type=text size=20 name=title value="<%= boardDTO.getTitle() %>"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><input type=text size=100 name=content value="<%= boardDTO.getContent() %>"></td>
			</tr>
			<tr>
				<td colspan=2 align=center>
					<input type="button" id="insert" value="입력" onClick="insertcheck()">
					<input type="button" id="update" value="수정" onClick="updatecheck()">
					<input type="button" id="delete" value="삭제" onClick="deletecheck()">
				</td>
			</tr>
		</table>
	</form>
	</div>

</body>
</html>