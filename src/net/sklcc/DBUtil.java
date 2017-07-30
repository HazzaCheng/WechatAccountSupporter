package net.sklcc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
/**
 * Created by Hazza on 2016/8/7.
 */

class DBUtil {
    DBUtil(String url, String user, String pass) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            this.conn = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
    Connection getConnection() {
        return conn;
    }
    public void close() {
        try {
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    private Connection conn;
}

