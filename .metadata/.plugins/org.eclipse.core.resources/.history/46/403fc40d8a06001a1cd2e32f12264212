package Background;

import javafx.beans.property.SimpleStringProperty;

/**
 * @class AddressData
 * @author 박준석
 * @Date 2019-10-10
 * @brief TableView column에 데이터 값 삽입
 */
public class AddressData {
	
	private SimpleStringProperty table_name;
	private SimpleStringProperty table_relationship;
	private SimpleStringProperty table_email;
	private SimpleStringProperty table_phoneNumber;
	AddressDTO addressDTO = new AddressDTO();
	
	// DTO 객체 값을 받는 생성자 메소드
	public AddressData(AddressDTO addressDTO) {
		this.table_name = new SimpleStringProperty(addressDTO.getName());
		this.table_relationship = new SimpleStringProperty(addressDTO.getRelationship());
		this.table_email = new SimpleStringProperty(addressDTO.getEmail());
		this.table_phoneNumber = new SimpleStringProperty(addressDTO.getPhoneNumber());
	}
	
	public String getTable_name() {
		return table_name.get();
	}
	public void setTable_name(String table_name) {
		this.table_name.set(table_name);
	}
	public String getTable_relationship() {
		return table_relationship.get();
	}
	public void setTable_relationship(String table_relationship) {
		this.table_relationship.set(table_relationship);
	}
	public String getTable_email() {
		return table_email.get();
	}
	public void setTable_email(String table_email) {
		this.table_email.set(table_email);
	}
	public String getTable_phoneNumber() {
		return table_phoneNumber.get();
	}
	public void setTable_phoneNumber(String table_phoneNumber) {
		this.table_phoneNumber.set(table_phoneNumber);
	}
}
