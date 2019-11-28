<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 오류 페이지 정의  -->
<%@ page errorPage="board_error.jsp" %>

<!-- 자바 클래스 Import  -->
<%@ page import = "java.sql.*" %>
<%@ page import = "boardtwolayer.*" %>
<%@ page import = "java.util.ArrayList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>

<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>게시판 조회</title>

	<link rel="stylesheet" href="board.css" type="text/css" media="screen" />

	<script type="text/javascript">
	
		function retrivalcheck() {
		
			// get방식
			// document.location.href="board_list.jsp?action=list";
		
			// post방식 디펄트가 list
			document.form1.action.value="list";
			document.form1.submit();

		}
	
	
		function editcheck(id) {
		
			// get방식
			document.location.href="board_view.jsp?action=edit&id="+id;
			
			// document.location.href="/board/boardtwolayer/board_view.jsp?action=edit&id="+id;
			
			// document.location.href="./urltest/HelloJSP.jsp";
			
			// document.location.href="../boardtwolayerJava/board_view.jsp?action=edit&id="+id;
			
			
			
			// post방식
			// document.form1.action.value="edit";
			// document.form1.id.value=id;
			// document.form1.submit();
	
			
		}
	</script>

</head>

<%

//action구분 등 파라메터
String action = request.getParameter("action");

ArrayList<BoardDTO> boardList = new ArrayList<BoardDTO>();

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


	if (action.equals("list")) {
		
		String sql = "select id, userName, title, content from Board";
			
		pstmt = conn.prepareStatement(sql);

		//SQL문 실행
		ResultSet rs = pstmt.executeQuery();

		while(rs.next()) {
			
			// DO 객체 생성
			BoardDTO boardDTO = new BoardDTO();
			
			// DB Select결과를 DO 객체에 저장
			boardDTO.setId(rs.getInt("id"));
			boardDTO.setUserName(rs.getString("userName"));
			boardDTO.setTitle(rs.getString("title"));
			boardDTO.setContent(rs.getString("content"));

			boardList.add(boardDTO);
		}
	
		// 사용한 자원의 반납.
		pstmt.close();
		
	} 
	
	conn.close();
		
} catch (Exception e) {
	System.out.println(e);
}


%>


<body>
	<div align=center>
	<H2>게시판 조회</H2>
	<HR>
	<a href="board_view.jsp?action=add">게시판 등록</a><BR>
	
	<!-- 게시판 목록 조회폼 -->
	<form name="form1" method="post" action="board_list.jsp">
		<input type="hidden" name="action" value="list">
	
		<table border=1>
			<tr>
				<td colspan=4 align=right>
    				<input type="button" value="조회" onClick="retrivalcheck()">
				</td>
			</tr>
			<tr>
				<th>ID</th>
				<th>성명</th>
				<th>제목</th>
				<th>내용</th>
			</tr>
			<%
				if(boardList != null) {
					
						// boardList 변수 List 반복처리
						for(BoardDTO boardDTO : (ArrayList<BoardDTO>) boardList) {
			%>
						<tr>
							<td><a href="javascript:editcheck(<%=boardDTO.getId() %>)"><%=boardDTO.getId() %></a></td>
							<td><%=boardDTO.getUserName() %></td>
							<td><%=boardDTO.getTitle() %></td>
							<td><%=boardDTO.getContent() %></td>
						</tr>
			<%	
					}
				}
			%>
			</table>
		</form>
	</div>
</body>

</html>