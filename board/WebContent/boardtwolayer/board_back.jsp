<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page errorPage="board_error.jsp" %>
 
 <!-- 자바 클래스 Import  -->
<%@ page import = "java.sql.*" %>
<%@ page import = "boardtwolayer.BoardDTO" %>
<%@ page import = "java.util.ArrayList" %>

<%-- request 내장객체의 한글 인코딩 --%>    
<% request.setCharacterEncoding("UTF-8"); %>

 
<%

    // action구분 등 파라메터
 	String action = request.getParameter("action");


	BoardDTO boardDTO = new BoardDTO();

    // 입력 또는 수정인 경우 화면 	화면 HTML 값을 DTO 객체에 저장
    if(action.equals("insert") || action.equals("update")) {
 		
    	boardDTO.setId(Integer.parseInt(request.getParameter("id")));
    	boardDTO.setUserName(request.getParameter("userName"));
    	boardDTO.setTitle(request.getParameter("title"));
    	boardDTO.setContent(request.getParameter("content"));
 	}

    // 삭제인 경우 화면 HTML ID 값을 DTO 객체에 저장
    if(action.equals("delete")) {
    	
       	boardDTO.setId(Integer.parseInt(request.getParameter("id")));
    }
    
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
	
    
 		if (action.equals("insert")) {
 		
 			String sql ="insert into Board(userName,title, content) values(?,?,?)";
 			
			pstmt = conn.prepareStatement(sql);

			// SQL문에 변수 입력
			pstmt.setString(1,boardDTO.getUserName());
			pstmt.setString(2,boardDTO.getTitle());
			pstmt.setString(3,boardDTO.getContent());
		
			//SQL문 실행
			pstmt.executeUpdate();
			
 		} else if (action.equals("update")) {
 	
 			String sql ="update Board set userName=?, title=?, content=? where id=?";

			pstmt = conn.prepareStatement(sql);

			// SQL문에 변수 입력
			pstmt.setString(1,boardDTO.getUserName());
			pstmt.setString(2,boardDTO.getTitle());
			pstmt.setString(3,boardDTO.getContent());
			pstmt.setInt(4,boardDTO.getId());
 			
			//SQL문 실행
			pstmt.executeUpdate();
 			
 		} else if (action.equals("delete")) {
 			
 			// id로 매칭하여 delete				
 			String sql ="delete from Board where id=?";

			pstmt = conn.prepareStatement(sql);

			// SQL문에 변수 입력
			pstmt.setInt(1,boardDTO.getId());
						
			//SQL문 실행
			pstmt.executeUpdate();
 		} else {

 	 		out.println("<script>alert('action 파라미터를 확인해 주세요!!!')</script>");

 	 	}
	
		// 사용한 자원의 반납.
		pstmt.close();
		conn.close();
 		
		// 조회 호출
 		pageContext.forward("board_list.jsp?action=list");

 		
	} catch (Exception e) {
		System.out.println(e);
	}

 %> 
 
