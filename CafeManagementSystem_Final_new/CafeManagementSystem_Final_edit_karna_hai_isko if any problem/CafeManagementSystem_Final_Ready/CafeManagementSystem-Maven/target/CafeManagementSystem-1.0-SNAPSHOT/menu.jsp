<%@ page import="java.util.*, com.cafe.dao.MenuDAO, com.cafe.model.MenuItem" %>
<%
    List<MenuItem> menuList = MenuDAO.getAllMenuItems();

    // Items based on images folder
    menuList.add(new MenuItem("Cappuccino", "Beverages", 250));
    menuList.add(new MenuItem("Chai Paratha", "Combos", 120));
    menuList.add(new MenuItem("Cheese Garlic Bread", "Snacks", 110));
    menuList.add(new MenuItem("Chocolate Cake", "Desserts", 550));
    menuList.add(new MenuItem("Coffee Brownie", "Combos", 130));
    menuList.add(new MenuItem("Cold Coffee", "Beverages", 80));
    menuList.add(new MenuItem("Espresso", "Beverages", 80));
    menuList.add(new MenuItem("French Fries", "Snacks", 99));
    menuList.add(new MenuItem("Green Tea", "Beverages", 50));
    menuList.add(new MenuItem("Latte", "Beverages", 350));
    menuList.add(new MenuItem("Lemon Iced Tea", "Beverages", 60));
    menuList.add(new MenuItem("Masala Fries", "Snacks", 70));
    menuList.add(new MenuItem("Muffin", "Desserts", 60));
    menuList.add(new MenuItem("Veg Sandwich", "Snacks", 90));
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.*" %>
<%
    List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
    if (cart == null) {
        cart = new ArrayList<>();
        session.setAttribute("cart", cart);
    }

    String itemName = request.getParameter("item");
    String priceStr = request.getParameter("price");
    if (itemName != null && priceStr != null) {
        double price = Double.parseDouble(priceStr);
        String image = "images/" + itemName.replaceAll(" ", "_").toLowerCase() + ".jpg";

        boolean found = false;
        for (Map<String, Object> item : cart) {
            if (item.get("name").equals(itemName)) {
                int qty = (int) item.get("quantity");
                item.put("quantity", qty + 1);
                found = true;
                break;
            }
        }

        if (!found) {
            Map<String, Object> newItem = new HashMap<>();
            newItem.put("name", itemName);
            newItem.put("price", price);
            newItem.put("quantity", 1);
            newItem.put("image", image);
            cart.add(newItem);
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Menu - Chai Churi</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <style>
        body {
            background-color: #e2e2e2;
            color: #333;
            font-family: 'Poppins', sans-serif;
            padding: 20px;
        }
        .menu-container {
            max-width: 1000px;
            margin: auto;
            background: #fff;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .menu-title {
            text-align: center;
            margin-bottom: 30px;
            font-weight: bold;
        }
        .menu-section h2 {
            background: #7494ec;
            padding: 12px;
            border-radius: 8px;
            color: white;
            margin-top: 30px;
        }
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .menu-card {
            background: #f9f9f9;
            border-radius: 12px;
            padding: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            text-align: center;
        }
        .menu-img {
            width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: 10px;
        }
        .menu-card h5 {
            margin-top: 10px;
            font-size: 18px;
            font-weight: 600;
        }
        .menu-card p {
            margin: 5px 0;
            font-weight: 500;
        }
        .menu-card .btn {
            margin-top: 10px;
            background: #7494ec;
            color: white;
            font-weight: 500;
            border: none;
            padding: 8px 14px;
            border-radius: 6px;
        }
        .menu-card .btn:hover {
            background: #5c7dd4;
        }
        .cart-container {
            margin-top: 40px;
            background: #f3f7ff;
            padding: 20px;
            border-radius: 12px;
        }
        .cart-items {
            color: #000;
            font-weight: 500;
        }
        .btn-container {
            margin-top: 30px;
            display: flex;
            justify-content: space-between;
        }
    </style>
</head>
<body>
<div class="menu-container">
    <h1 class="menu-title">🍽️ Chai Churi - Menu</h1>

    <%
        Map<String, List<MenuItem>> categorizedItems = new HashMap<>();
        for (MenuItem m : menuList) {
            categorizedItems.computeIfAbsent(m.getCategory(), k -> new ArrayList<>()).add(m);
        }
        for (String category : categorizedItems.keySet()) {
    %>
    <div class="menu-section">
        <h2><%= category %></h2>
        <div class="menu-grid">
        <% for (MenuItem itemObj : categorizedItems.get(category)) { %>
            <div class="menu-card">
                <img src="images/<%= itemObj.getItemName().replaceAll(" ", "_").toLowerCase() %>.jpg" class="menu-img">
                <h5><%= itemObj.getItemName() %></h5>
                <p>Rs <%= itemObj.getPrice() %></p>
                <a href="menu.jsp?item=<%= itemObj.getItemName() %>&price=<%= itemObj.getPrice() %>" class="btn">Add to Cart</a>
            </div>
        <% } %>
        </div>
    </div>
    <% } %>

    <div class="cart-container">
        <h2>Your Cart 🛒</h2>
        <%
            if (cart.isEmpty()) {
                out.println("<p>Your cart is empty.</p>");
            } else {
                for (Map<String, Object> item : cart) {
                    String name = (String) item.get("name");
                    double price = (Double) item.get("price");
                    int qty = (Integer) item.get("quantity");
                    out.println("<p class='cart-items'>" + name + " x " + qty + " — Rs " + (price * qty) + "</p>");
                }
        %>
        <form action="order.jsp" method="post">
            <button type="submit" class="btn btn-success mt-3">Proceed to Order</button>
        </form>
        <% } %>
    </div>
    

    <div class="btn-container">
        <a href="dashboard.jsp" class="btn btn-secondary">🔙 Back to Dashboard</a>
        <a href="order.jsp" class="btn btn-primary">📦 View Orders</a>
    </div>
</div>
</body>
</html>
