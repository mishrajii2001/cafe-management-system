package com.cafe.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.cafe.model.MenuItem;
import com.cafe.util.DBConnection;
import java.sql.SQLException;

public class MenuDAO {
    public static List<MenuItem> getAllMenuItems() {
        List<MenuItem> menuList = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement pst = conn.prepareStatement("SELECT * FROM menu");
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                menuList.add(new MenuItem(rs.getInt("item_id"), rs.getString("item_name"), rs.getString("category"), rs.getDouble("price")));
            }
        } catch (SQLException e) {
        }
        return menuList;
    }
}