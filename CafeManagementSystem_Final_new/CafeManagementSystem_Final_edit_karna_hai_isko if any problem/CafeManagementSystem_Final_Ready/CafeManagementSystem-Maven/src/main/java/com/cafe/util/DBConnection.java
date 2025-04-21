package com.cafe.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/cafe_management", "root", "5233"
            );
        } catch (Exception e) {
            System.out.println("Connection error: " + e.getMessage());
            return null;
        }
    }
}
