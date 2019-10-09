package Background;

import javafx.beans.property.SimpleStringProperty;

public class AddressData {
	
	private SimpleStringProperty table_name;
	private SimpleStringProperty table_relationship;
	private SimpleStringProperty table_email;
	private SimpleStringProperty table_phoneNumber;
	
	public AddressData(String name, String relationship, String email, String phoneNumber) {
		this.table_name = new SimpleStringProperty(name);
		this.table_relationship = new SimpleStringProperty(relationship);
		this.table_email = new SimpleStringProperty(email);
		this.table_phoneNumber = new SimpleStringProperty(phoneNumber);
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
