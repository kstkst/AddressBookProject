package Background;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import javafx.collections.FXCollections;
import javafx.collections.ObservableList;

/**
 * @class AddressDAO
 * @author 박준석
 * @Date 2019-10-10
 * @brief DB 행위를 정의한 클래스
 * @remark URL, Connection 정의 시 DB설정은 인계받은 개발자 환경에 맞춰 입력 바람
 */
public class AddressDAO {

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String jdbc_driver = "com.mysql.cj.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://DB주소/DB이름?useUnicode=true&characterEncoding=UTF-8"; 
	
	void connect() {
		try {
			Class.forName(jdbc_driver);
			
			conn = DriverManager.getConnection(jdbc_url, "db권한계정이름", "비밀번호");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	void disconnect() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
		if(conn != null) {
			try {
				conn.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * @param 주소 데이터 DTO
	 * @brief DB 삽입 기능 
	 * @return 삽입 성공 여부
	 */ 
	public boolean insertDB(AddressDTO addressDTO) {
		connect();
		
		String sql = "insert into Address(name, relationship, email, phoneNumber) values(?,?,?,?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, addressDTO.getName());
			pstmt.setString(2, addressDTO.getRelationship());
			pstmt.setString(3, addressDTO.getEmail());
			pstmt.setString(4, addressDTO.getPhoneNumber());
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}
	
	/**
	 * @brief DB 조회 기능 
	 * @return list객체로 반환
	 */
	public ObservableList<AddressData> getDBList() {
		connect();		
		ObservableList<AddressData> addressList = FXCollections.observableArrayList();		
		String sql = "select * from Address";
		
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next()) {
				AddressDTO addressDTO = new AddressDTO();
				
				addressDTO.setId(rs.getInt("id"));
				addressDTO.setName(rs.getString("name"));
				addressDTO.setRelationship(rs.getString("relationship"));
				addressDTO.setEmail(rs.getString("email"));
				addressDTO.setPhoneNumber(rs.getString("phoneNumber"));
				
				addressList.add(new AddressData(addressDTO));
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		
		return addressList;
	}
	
}
