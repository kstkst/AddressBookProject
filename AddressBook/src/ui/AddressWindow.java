package ui;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class AddressWindow extends Application {

	public static void main(String[] args) {
		launch(args);
	}

	@Override
	public void start(Stage primaryStage) throws Exception {
		Parent root = FXMLLoader.load(getClass().getResource("AddressWindow.fxml"));
		Scene scene = new Scene(root, 300, 275);
		
		primaryStage.setTitle("AddressWindow");
		primaryStage.setScene(scene);
		primaryStage.show();
	}

}
