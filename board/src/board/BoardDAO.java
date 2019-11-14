package board;

import java.sql.*;
import java.util.ArrayList;

import board.BoardDTO;

// 전달 데이터단위인 (DTO : Data Transfer Object)를 사용하면서 DB 데이터를 직접 처리하는
// DAO(Data Access Object)
public class BoardDAO {

	Connection conn = null;
	PreparedStatement pstmt = null;

	/* MySQL 연결정보 */
	String jdbc_driver = "com.mysql.jdbc.Driver";
	
	String jdbc_url = "jdbc:mysql://127.0.0.1/jspdb?useSSL=true&verifyServerCertificate=false&serverTimezone=UTC";
	
	/******************************************************************************************/
	// DB연결 메서드
	/******************************************************************************************/
	void connect() {
		try {
			Class.forName(jdbc_driver);

			conn = DriverManager.getConnection(jdbc_url,"jspbook","1234");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	/******************************************************************************************/
	// DB 연결해제 메소드
	/******************************************************************************************/
	void disconnect() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} 
		if(conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	/******************************************************************************************/
	// 게시판 입력 메서드
	/******************************************************************************************/
	public boolean insertDB(BoardDTO boardDTO) {
		
		
		connect();
		
		// id 는 자동 등록 되므로 입력하지 않는다.				
			String sql ="insert into Board(userName,title, content) values(?,?,?)";		
		try {
			
			pstmt = conn.prepareStatement(sql);

			// SQL문에 변수 입력
			pstmt.setString(1,boardDTO.getUserName());
			pstmt.setString(2,boardDTO.getTitle());
			pstmt.setString(3,boardDTO.getContent());
			
			//SQL문 실행
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	}
	
	
	/******************************************************************************************/
	// 게시판목록 조회 메서드
	/******************************************************************************************/
	public ArrayList<BoardDTO> getDBList() {
		
		connect();
		
		ArrayList<BoardDTO> boardList = new ArrayList<BoardDTO>();
		
		String sql = "select id, userName, title, content from Board";

		try {
			
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
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return boardList;
	}

	/******************************************************************************************/
	// edit용 게시판 1건 조회 메서드
	/******************************************************************************************/
	public BoardDTO getDB(int id) {
		
		connect();
		
		BoardDTO boardDTO = new BoardDTO();
		
		String sql = "select * from Board where id = ?";
		
		try {
			
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
			
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return boardDTO;
	}


	/******************************************************************************************/
	// 게시판 수정 메서드
	/******************************************************************************************/
	public boolean updateDB(BoardDTO boardDTO) {
		
		
		connect();
		
		// id로 매칭하여 update(게시판일자와 게시판금액만 수정 가능)				
		String sql ="update Board set userName=?, title=?, content=? where id=?";

		try {
			
			pstmt = conn.prepareStatement(sql);

			// SQL문에 변수 입력
			pstmt.setString(1,boardDTO.getUserName());
			pstmt.setString(2,boardDTO.getTitle());
			pstmt.setString(3,boardDTO.getContent());
			pstmt.setInt(4,boardDTO.getId());
		
			//SQL문 실행
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	}
	
	
	/******************************************************************************************/
	// 게좌이체 삭제 메서드
	/******************************************************************************************/
	public boolean deleteDB(int id) {
		
		
		connect();
		
		// id로 매칭하여 delete				
			String sql ="delete from Board where id=?";
		
		try {
			
			pstmt = conn.prepareStatement(sql);

			// SQL문에 변수 입력
			pstmt.setInt(1,id);
						
			//SQL문 실행
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
		}
		return true;
	}
	
	
}

