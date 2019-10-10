package ui;

import java.net.URL;
import java.util.ResourceBundle;

import Background.AddressDAO;
import Background.AddressData;
import javafx.application.Application;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.stage.Stage;

public class AddressWindow extends Application implements Initializable {
	
	@FXML private Button btn_search;
	@FXML private Button btn_insert;
	@FXML private Button btn_update;
	@FXML private Button btn_delete;
	@FXML private TextField txt_name;
	@FXML private ComboBox<String> combo_relationship;
	@FXML private TextField txt_email;
	@FXML private TextField txt_phoneNumber;
	@FXML private TableView<AddressData> addressTable;
	@FXML private TableColumn<AddressData, String> table_name;
	@FXML private TableColumn<AddressData, String> table_relationship;
	@FXML private TableColumn<AddressData, String> table_email;
	@FXML private TableColumn<AddressData, String> table_phoneNumber;
	
	AddressDAO addressDAO = new AddressDAO();
	
	private static String name;
	private static String relationship;
	private static String email;
	private static String phoneNumber;
	
	public void initialize(URL url, ResourceBundle rb) {
		btn_insert.setOnAction(new EventHandler<ActionEvent>() {
			boolean success;
			public void handle(ActionEvent event) {
				success = handleInsert(event);
				if (success) {
					System.out.println("입력 성공");		
				}
			}
			
		});
	}
	
	@FXML
	public boolean handleInsert(ActionEvent event) {
		name = txt_name.getText();
		relationship = combo_relationship.getValue().toString();
		email = txt_email.getText();
		phoneNumber = txt_phoneNumber.getText();
		
        ObservableList<AddressData> addressList = FXCollections.observableArrayList();
		addressList.add(new AddressData(name, relationship, email, phoneNumber));
		
		table_name.setCellValueFactory(new PropertyValueFactory<AddressData, String>("table_name"));	
		table_relationship.setCellValueFactory(new PropertyValueFactory<AddressData, String>("table_relationship"));
		table_email.setCellValueFactory(new PropertyValueFactory<AddressData, String>("table_email"));
		table_phoneNumber.setCellValueFactory(new PropertyValueFactory<AddressData, String>("table_phoneNumber"));
		addressTable.setItems(addressList);	
		
		return addressDAO.insertDB(name, relationship, email, phoneNumber);
	}
	
	
	public static void main(String[] args) {
		launch(args);
	}

	@Override
	public void start(Stage primaryStage) throws Exception {
		Parent root = FXMLLoader.load(getClass().getResource("AddressWindow.fxml"));
		Scene scene = new Scene(root, 1000, 800);
		
		primaryStage.setTitle("AddressWindow");
		primaryStage.setScene(scene);
		primaryStage.show();				 
	}
}
