<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page errorPage="board_error.jsp" %>
 
 <!-- 자바 클래스 Import  -->
<%@ page import = "boardA.*" %>
<%@ page import = "java.util.ArrayList" %>

<%-- request 내장객체의 한글 인코딩 --%>    
<% request.setCharacterEncoding("UTF-8"); %>

<%-- 자바빈즈 사용 --%>   
<jsp:useBean id="boardDTO" class="boardA.BoardDTO" scope="request" ></jsp:useBean>

<%-- 자바빈즈에 폼정보 전달 --%> 
<jsp:setProperty property="*" name="boardDTO"/>

<%-- 자바빈즈 사용, scope은 request --%>  
<jsp:useBean id="boardDAO" class="boardA.BoardDAO" scope="request" ></jsp:useBean>
 
<%

    // action구분 등 파라메터
 	String action = request.getParameter("action");

    ///////////////////////////////////////////
    // action에 따라 각각 처리
    /////////////////////////////////////////// 
 	if (action.equals("add")) {

 		// 게시판 입력화면 오픈
 		pageContext.forward("board_view.jsp?action=add");

 	} else if (action.equals("insert")) {

 		// 게시판 입력
 		if (boardDAO.insertDB(boardDTO)) {

 			// 조회를 위하여 controll 호출
 			pageContext.forward("board_control.jsp?action=list");
 		} else {
 			throw new Exception("DB 입력오류");
 		}

 	} else if (action.equals("list")) {

 		// 게시판 조회결과
 		ArrayList<BoardDTO> boardList = boardDAO.getDBList();

 		// List를 setAttribute
 		request.setAttribute("boardList", boardList);
 		pageContext.forward("board_list.jsp");
 	} else if (action.equals("edit")) {

 		// edit용 1건을 select
 		boardDTO = boardDAO.getDB(Integer.parseInt((String) request.getParameter("id")));

 		// edit를 setAttribute
 		request.setAttribute("boardDTO", boardDTO);
 		pageContext.forward("board_view.jsp?action=edit");

 	} else if (action.equals("update")) {

 		// 게시판 수정
 		if (boardDAO.updateDB(boardDTO)) {

 			// 조회를 위하여 controll 호출
 			pageContext.forward("board_control.jsp?action=list");
 		} else {
 			throw new Exception("DB 수정오류");
 		}

 	} else if (action.equals("delete")) {

 		// 게시판 삭제
 		if (boardDAO.deleteDB(Integer.parseInt((String) request.getParameter("id")))) {

 			// 조회를 위하여 controll 호출
 			pageContext.forward("board_control.jsp?action=list");
 		} else {
 			throw new Exception("DB 삭제오류");
 		}

 	} else {

 		out.println("<script>alert('action 파라미터를 확인해 주세요!!!')</script>");

 	}
 %> 
 
