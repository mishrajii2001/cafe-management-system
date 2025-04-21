package com.cafe.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.cafe.util.DBConnection;

public class OrderDAO {
    public static boolean placeOrder(int userId, double totalAmount) {
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement pst = conn.prepareStatement("INSERT INTO orders (user_id, total_amount, status) VALUES (?, ?, 'pending')");
            pst.setInt(1, userId);
            pst.setDouble(2, totalAmount);
            int rows = pst.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}