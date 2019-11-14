<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 오류 페이지 정의  -->
<%@ page errorPage="board_error.jsp" %>

<!-- 자바 클래스 Import  -->
<%@ page import = "java.sql.*" %>
<%@ page import = "boardtwolayer.*" %>

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

<%


// action구분 등 파라메터
String action = request.getParameter("action");


BoardDTO boardDTO = new BoardDTO();

//데이터베이스 연결관련 변수 선언
Connection conn = null;
PreparedStatement pstmt = null;

//데이터베이스 연결관련정보를 문자열로 선언
String jdbc_driver = "com.mysql.jdbc.Driver";
String jdbc_url = "jdbc:mysql://127.0.0.1/jspdb?useSSL=true&verifyServerCertificate=false&serverTimezone=UTC";


try{
	
	// JDBC 드라이버 로드
	Class.forName(jdbc_driver);

	// 데이터베이스 연결정보를 이용해 Connection 인스턴스 확보
	conn = DriverManager.getConnection(jdbc_url,"jspbook","1234");


	if (action.equals("edit")) {
		
		int id = Integer.parseInt(request.getParameter("id"));

		String sql = "select * from Board where id = ?";
		
		pstmt = conn.prepareStatement(sql);

		// SQL문에 조회조건 입력
		pstmt.setInt(1,id);

		//SQL문 실행
		ResultSet rs = pstmt.executeQuery();

		// 데이터가 하나만 있으므로 rs.next()를 한번만 실행 한다.
		rs.next();
		
		// DB Select결과를 DO 객체에 저장
		boardDTO.setId(rs.getInt("id"));
		boardDTO.setUserName(rs.getString("userName"));
		boardDTO.setTitle(rs.getString("title"));
		boardDTO.setContent(rs.getString("content"));
	
		// 사용한 자원의 반납.
		rs.close();
		pstmt.close();
		
	} 
	
	conn.close();
		
} catch (Exception e) {
	System.out.println(e);
}


%>



<body>
	<div align="center">
	<H2>게시판 등록</H2>
	<HR>
	
	<a href="board_list.jsp?action=list">게시판목록 조회</a>
	
	<!-- 게시판 등록용 -->
	<form name="form1" method="post" action=board_back.jsp>
	
		<%

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