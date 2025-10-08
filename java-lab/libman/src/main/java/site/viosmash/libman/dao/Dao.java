package site.viosmash.libman.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * @author Nguyen Quang Phu
 */
public class Dao {

    private static final String URL = "jdbc:mysql://localhost:3306/pttk?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "root";

    protected Connection conn;

    public Dao() {
        try {
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            this.conn = conn;
        } catch (SQLException e) {
            System.err.println("Failed to connect to database: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        Dao dao = new Dao();

    }
}
