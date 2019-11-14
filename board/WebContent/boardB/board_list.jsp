<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 오류 페이지 정의  -->
<%@ page errorPage="board_error.jsp" %>

<!-- taglib 지시어  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>

<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>게시판 조회</title>

	<link rel="stylesheet" href="board.css" type="text/css" media="screen" />

	<script type="text/javascript">
		function retrivalcheck() {
			
			// get방식
			// document.location.href="addr_control.jsp?action=list";
			
			// post방식 디펄트가 list
			document.form1.action.value="list";
			document.form1.submit();
	
			
		}
	
		function addcheck() {
			
			// post방식
			document.form1.action.value="add";
			document.form1.submit();
		}
		
		function editcheck(id) {
		
			// get방식
			// document.location.href="addr_control.jsp?action=edit&id="+id;
			
			// post방식
			document.form1.action.value="edit";
			document.form1.id.value=id;
			document.form1.submit();
	
			
		}
	</script>

</head>

<body>
	<div align=center>
	<H2>게시판 조회</H2>
	<HR>
	
	<!-- 게시판 목록 조회폼 -->
	<!-- action의 실제 URL은 앞에 컨텍스트 Path와 jsp의 패키지가 추가됨 -->
<!--
	<form name="form1" method="post" action="/board/boardB/BoardController">
 -->
	<form name="form1" method="post" action="BoardController">

		<input type="hidden" name="action" value="list">
		<input type="hidden" name="id" value=0>
	
		<table border=1>
			<tr>
				<td colspan=4 align=right>
					<input type="button" value="추가" onClick="addcheck()">				
    				<input type="button" value="조회" onClick="retrivalcheck()">
				</td>
			</tr>
			<tr>
				<th>ID</th>
				<th>성명</th>
				<th>제목</th>
				<th>내용</th>
			</tr>
			
			<c:forEach var="i" items="${boardList}">
				<tr>
					<td><a href="javascript:editcheck(${i.id})">${i.id}</a></td>
					<td>${i.userName}</td>
					<td>${i.title}</td>
					<td>${i.content}</td>
				</tr>
			</c:forEach>			
			
			</table>
		</form>
	</div>
</body>

</html>