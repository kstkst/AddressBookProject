package ui;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

import Background.AddressDAO;
import Background.AddressDTO;
import Background.AddressData;
import javafx.application.Application;
import javafx.application.Platform;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.event.Event;
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
import javafx.scene.control.cell.TextFieldTableCell;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Modality;
import javafx.stage.Stage;
import javafx.stage.Window;
import javafx.stage.WindowEvent;

/**
 * @class AddressWindow
 * @author 박준석
 * @Date 2019-10-10
 * @brief UI 기능 정의
 */
public class AddressWindow extends Application implements Initializable {
	// UI 버튼 정의
	@FXML private Button btn_search;
	@FXML private Button btn_insert;
	@FXML private Button btn_update;
	@FXML private Button btn_delete;
	
	// 데이터를 입력 받는 텍스트필드 및 콤보박스 정의
	@FXML private TextField txt_name;
	@FXML private ComboBox<String> combo_relationship;
	@FXML private TextField txt_email;
	@FXML private TextField txt_phoneNumber;
	
	// 테이블 및 해당 테이블 컬럼 정의
	@FXML private TableView<AddressData> addressTable;
	@FXML private TableColumn<AddressData, String> table_name;
	@FXML private TableColumn<AddressData, String> table_relationship;
	@FXML private TableColumn<AddressData, String> table_email;
	@FXML private TableColumn<AddressData, String> table_phoneNumber;
	
	AddressDAO addressDAO = new AddressDAO();
	AddressDTO addressDTO = new AddressDTO();
	AddressData addressData = new AddressData(addressDTO);
	
	// 사용자 주소 정보를 저장하는 컬렉션 객체 생성
	ObservableList<AddressData> addressList = FXCollections.observableArrayList();
	
	
	/**
	 * @function
	 * @brief UI 기능 정의
	 */
	public void initialize(URL url, ResourceBundle rb) {
		// 주소 데이터 조회
		addressList = addressDAO.getDBList();
		addressTable.getItems().addAll(addressList);
		//테이블값 선택하기
		AddressData addressData = addressTable.getSelectionModel().getSelectedItem();   
		
		// 추가 버튼 클릭 시
		btn_insert.setOnAction(new EventHandler<ActionEvent>() {
			@Override
			public void handle(ActionEvent event) {			 
				if (handleInsert(event)) {
					System.out.println("Insert 성공");		
				} else {
					System.out.println("Insert 실패");
				}
			}
		});
		
		// 수정 버튼 클릭 시
		btn_update.setOnAction(new EventHandler<ActionEvent>() {

			@Override
			public void handle(ActionEvent event) {
				if (handleUpdate(event)) {
					System.out.println("Update 성공");		
				} else {
					System.out.println("Update 실패");
				}
			}
		
		});
		
		// 삭제 버튼 클릭 시
		btn_delete.setOnAction(new EventHandler<ActionEvent>() {

			@Override
			public void handle(ActionEvent event) {			 
				if (handleDelete(event)) {
					System.out.println("Insert 성공");		
				} else {
					System.out.println("Insert 실패");
				}
			}
		});
		
		// 검색 버튼 클릭 시
		btn_search.setOnAction(new EventHandler<ActionEvent>() {

			@Override
			public void handle(ActionEvent event) {
				// TODO Auto-generated method stub
				
			}
		});
	}
	
	/**
	 * @function
	 * @brief 추가 버튼 클릭 이벤트 시 입력된 데이터를 DB로 insert
	 * @return Insert 성공 유무
	 */
	@FXML
	public boolean handleInsert(ActionEvent event) {
		//DTO 객체에 입력 값 세팅
		addressDTO.setName(txt_name.getText());
		addressDTO.setRelationship(combo_relationship.getValue().toString());
		addressDTO.setEmail(txt_email.getText());
		addressDTO.setPhoneNumber(txt_phoneNumber.getText());
		
		//세팅한 DTO를 AddressData 객체에 넣은 후 앞서 정의한 list 객체에 해당 값 추가
		addressList.add(new AddressData(addressDTO));
		
		//정의되어 있는 각각의 테이블 컬럼들의 해당 주소 값 삽입
		table_name.setCellValueFactory(new PropertyValueFactory<AddressData, String>("table_name"));	
		table_relationship.setCellValueFactory(new PropertyValueFactory<AddressData, String>("table_relationship"));
		table_email.setCellValueFactory(new PropertyValueFactory<AddressData, String>("table_email"));
		table_phoneNumber.setCellValueFactory(new PropertyValueFactory<AddressData, String>("table_phoneNumber"));
		addressTable.setItems(addressList);
		
		return addressDAO.insertDB(addressDTO);
	}
	
	/**
	 * 	@fn			handleDelete(ActionEvent event)
	 *	@brief		1건 삭제
	 *
	 *	@author		김성택
	 *	@date		2019-11-28
	 *
	 *	@param		ActionEvent event 에서 전달된  값
	 *  
	 *	@remark		테이블에서 넘어온 인덱스 값을 remove로 삭제			[2019-11-28; 김성택]
	 */
	
	@FXML
	public boolean handleDelete(ActionEvent event) {
		int selectIndex = addressTable.getSelectionModel().getSelectedIndex();
		if (selectIndex>=0) {
			addressTable.getItems().remove(selectIndex);
		}
		return false;
	}
	
	@FXML
	public boolean handleUpdate(ActionEvent event) {

		int selectIndex = addressTable.getSelectionModel().getSelectedIndex();
		if (selectIndex>=0) {
			addressTable.getItems().remove(selectIndex);
		}
		
		//DTO 객체에 입력 값 세팅
		addressDTO.setName(txt_name.getText());
		addressDTO.setRelationship(combo_relationship.getValue().toString());
		addressDTO.setEmail(txt_email.getText());
		addressDTO.setPhoneNumber(txt_phoneNumber.getText());
		
		//세팅한 DTO를 AddressData 객체에 넣은 후 앞서 정의한 list 객체에 해당 값 추가
		addressList.add(new AddressData(addressDTO));
		
		//정의되어 있는 각각의 테이블 컬럼들의 해당 주소 값 삽입
		table_name.setCellValueFactory(new PropertyValueFactory<AddressData, String>("table_name"));	
		table_relationship.setCellValueFactory(new PropertyValueFactory<AddressData, String>("table_relationship"));
		table_email.setCellValueFactory(new PropertyValueFactory<AddressData, String>("table_email"));
		table_phoneNumber.setCellValueFactory(new PropertyValueFactory<AddressData, String>("table_phoneNumber"));
		addressTable.setItems(addressList);
		
		return addressDAO.insertDB(addressDTO);
	}
		

	public static void main(String[] args) {
		launch(args);
	}
	
	/**
	 * @function
	 * @brief UI 속성이 정의된 FXML 문서를 불러와 UI 생성
	 * @remark 기능적인 역할은 없음
	 */
	@Override
	public void start(Stage primaryStage) throws Exception {
		Parent root = FXMLLoader.load(getClass().getResource("AddressWindow.fxml"));
		Scene scene = new Scene(root, 985, 800);
		
		primaryStage.setTitle("AddressWindow");
		primaryStage.setScene(scene);
		primaryStage.setResizable(false);
		primaryStage.show();		
	}

}
