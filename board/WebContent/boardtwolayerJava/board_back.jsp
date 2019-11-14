<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page errorPage="board_error.jsp" %>
 
 <!-- 자바 클래스 Import  -->
<%@ page import = "boardtwolayerJava.*" %>
<%@ page import = "java.util.ArrayList" %>

<%-- request 내장객체의 한글 인코딩 --%>    
<% request.setCharacterEncoding("UTF-8"); %>

 
<%

    // action구분 등 파라메터
 	String action = request.getParameter("action");


	BoardDAO boardDAO = new BoardDAO();
	
	BoardDTO boardDTO = new BoardDTO();

	
    // 입력 또는 수정인 경우 화면 	화면 HTML 값을 DTO 객체에 저장
    if(action.equals("insert") || action.equals("update")) {
 		
    	boardDTO.setId(Integer.parseInt(request.getParameter("id")));
    	boardDTO.setUserName(request.getParameter("userName"));
    	boardDTO.setTitle(request.getParameter("title"));
    	boardDTO.setContent(request.getParameter("content"));
 	}

   
 	if (action.equals("insert")) {
 		
 		// 게시판 입력
 		if (boardDAO.insertDB(boardDTO)) {

 			// 조회 호출
 			pageContext.forward("board_list.jsp?action=list");
 		} else {
 			throw new Exception("DB 입력오류");
 		}
 	}  else if (action.equals("update")) {
 		
		// 게시판 수정
 		if (boardDAO.updateDB(boardDTO)) {

 			// 조회 호출
 			pageContext.forward("board_list.jsp?action=list");
 		} else {
 			throw new Exception("DB 수정오류");
 		}
 		
 	} else if (action.equals("delete")) {
 		
		// 계좌이체 삭제
 		if (boardDAO.deleteDB(Integer.parseInt((String) request.getParameter("id")))) {

 			// 조회를 위하여 controll 호출
			pageContext.forward("board_list.jsp?action=list");
 		} else {
 			throw new Exception("DB 삭제오류");
 		}
 		
 	}
    
 
 %> 
 
