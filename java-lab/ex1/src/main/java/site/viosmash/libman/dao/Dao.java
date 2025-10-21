package site.viosmash.libman.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * @author Nguyen Quang Phu
 */
public class Dao {
    protected Connection conn;

    private static final String URL = "jdbc:mysql://localhost:3306/pttk?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "root";


   public Dao() {
        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("DB connected");
        } catch (SQLException e) {
            throw new RuntimeException("Failed to connect to DB", e);
        }
    }
    
    
}
