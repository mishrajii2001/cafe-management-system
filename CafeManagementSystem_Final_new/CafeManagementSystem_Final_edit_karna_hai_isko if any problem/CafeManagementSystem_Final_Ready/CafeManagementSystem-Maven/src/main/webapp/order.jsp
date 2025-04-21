<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*, jakarta.servlet.http.*" %>
<%
    List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
    if (cart == null || cart.isEmpty()) {
        response.sendRedirect("menu.jsp");
        return;
    }

    double totalPrice = 0.0;
    String invoiceNumber = "INV-" + new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
    double gstRate = 5.0;

    Connection con = null;

    PreparedStatement ps = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cafe_management", "root", "5233");

        for (Map<String, Object> item : cart) {
            ps = con.prepareStatement("INSERT INTO orders (item_name, price, quantity, image, total, invoice_no) VALUES (?, ?, ?, ?, ?, ?)");
            String name = (String) item.get("name");
            double price = (Double) item.get("price");
            int qty = (Integer) item.get("quantity");
            String image = (String) item.get("image");
            double itemTotal = price * qty;

            ps.setString(1, name);
            ps.setDouble(2, price);
            ps.setInt(3, qty);
            ps.setString(4, image);
            ps.setDouble(5, itemTotal);
            ps.setString(6, invoiceNumber);
            ps.executeUpdate();
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (ps != null) {
            ps.close();
        }
        if (con != null) {
            con.close();
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Order Summary</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap');
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Poppins', sans-serif;
            }
            body {
                background: #f7f7f7;
                padding: 20px;
                color: #333;
            }
            .order-container {
                max-width: 800px;
                margin: auto;
                background: #fff;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .order-title {
                text-align: center;
                font-size: 24px;
                font-weight: 600;
                margin-bottom: 20px;
            }
            .order-item {
                display: flex;
                justify-content: space-between;
                padding: 8px 0;
                border-bottom: 1px solid #ccc;
            }
            .item-info {
                display: flex;
                align-items: center;
                gap: 10px;
            }
            .item-info img {
                width: 50px;
                height: 50px;
                border-radius: 5px;
            }
            .btn-container {
                display: flex;
                justify-content: space-between;
                margin-top: 30px;
            }
            .btn {
                padding: 10px 20px;
                border-radius: 5px;
                border: none;
                cursor: pointer;
                font-weight: 500;
            }
            .btn-primary {
                background: #4CAF50;
                color: white;
            }
            .btn-warning {
                background: #ffc107;
                color: black;
            }
            .btn-secondary {
                background: #6c757d;
                color: white;
            }

            #printSection {
                max-width: 600px;
                margin: 40px auto;
                background: #fff;
                padding: 20px;
                border: 1px solid #ccc;
                font-size: 14px;
            }
            #printSection h2 {
                margin: 5px 0;
            }
            #printSection table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
            }
            #printSection th, #printSection td {
                border: 1px solid #ccc;
                padding: 8px;
                text-align: center;
            }
            #printSection .text-right {
                text-align: right;
            }
            #printSection .center {
                text-align: center;
            }
            #printSection img.qr {
                height: 120px;
                margin-top: 10px;
            }
        </style>
    </head>
    <body>

        <div class="order-container">
            <div class="order-title">🛒 Order Summary</div>
            <div class="order-list">
                <%
                    for (Map<String, Object> item : cart) {
                        String name = (String) item.get("name");
                        double price = (Double) item.get("price");
                        int qty = (Integer) item.get("quantity");
                        String image = (String) item.get("image");
                        double itemTotal = price * qty;
                        totalPrice += itemTotal;
                %>
                <div class="order-item">
                    <div class="item-info">
                        <img src="<%= image%>">
                        <span><%= name%> x <%= qty%></span>
                    </div>
                    <span>Rs <%= itemTotal%></span>
                </div>
                <% } %>
            </div>
            <div class="btn-container">
                <button class="btn btn-primary" onclick="printBill()">🖨️ Print / Save PDF</button>
                <a href="menu.jsp" class="btn btn-warning">🍽️ Menu</a>
                <a href="dashboard.jsp" class="btn btn-secondary">🔙 Dashboard</a>
            </div>
        </div>

        <%
            double gstAmount = (totalPrice * gstRate) / 100.0;
            double finalAmount = totalPrice + gstAmount;
        %>

        <div id="printSection" style="max-width: 650px; margin: 40px auto; padding: 25px; border: 1px solid #ccc; border-radius: 12px; background: #fff; font-family: 'Poppins', sans-serif;">
            <div style="text-align: center;">
                <img src="images/logo.png" style="height: 80px; width: auto;" alt="Chai Churi Logo">

                <h2 style="margin: 5px 0; font-size: 24px; color: #333;">☕ Chai Churi Café</h2>
                <p style="margin: 0; font-size: 14px;">📍 Kharar, Mohali</p>
                <p style="margin: 0; font-size: 14px;">🧾 Invoice #: <strong><%= invoiceNumber%></strong></p>
                <p style="font-size: 13px; color: #777;">🕒 <%= new java.util.Date()%></p>
            </div>

            <hr style="margin: 20px 0; border-top: 1px dashed #999;">

            <h3 style="text-align: center; font-size: 20px; margin-bottom: 15px; color: #444;">🧾 Order Receipt</h3>

            <table style="width: 100%; border-collapse: collapse; font-size: 14px;">
                <thead>
                    <tr style="background: #f5f5f5; border-bottom: 2px solid #ccc;">
                        <th style="padding: 10px; text-align: left;">Item</th>
                        <th style="padding: 10px;">Qty</th>
                        <th style="padding: 10px;">Price</th>
                        <th style="padding: 10px; text-align: right;">Total</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Map<String, Object> item : cart) {
                            String name = (String) item.get("name");
                            double price = (Double) item.get("price");
                            int qty = (Integer) item.get("quantity");
                            double itemTotal = price * qty;
                    %>
                    <tr style="border-bottom: 1px solid #eee;">
                        <td style="padding: 10px;"><%= name%></td>
                        <td style="text-align: center;"><%= qty%></td>
                        <td style="text-align: center;">Rs <%= String.format("%.2f", price)%></td>
                        <td style="text-align: right;">Rs <%= String.format("%.2f", itemTotal)%></td>
                    </tr>
                    <% }%>
                </tbody>
            </table>

            <div style="margin-top: 20px;">
                <table style="width: 100%; font-size: 14px;">
                    <tr>
                        <td style="text-align: right; padding: 6px 10px;">Subtotal:</td>
                        <td style="text-align: right; padding: 6px 10px;">Rs <%= String.format("%.2f", totalPrice)%></td>
                    </tr>
                    <tr>
                        <td style="text-align: right; padding: 6px 10px;">GST (5%):</td>
                        <td style="text-align: right; padding: 6px 10px;">Rs <%= String.format("%.2f", gstAmount)%></td>
                    </tr>
                    <tr style="border-top: 2px solid #999;">
                        <td style="text-align: right; padding: 10px; font-weight: bold; font-size: 16px;">Total:</td>
                        <td style="text-align: right; padding: 10px; font-weight: bold; font-size: 16px;">Rs <%= String.format("%.2f", finalAmount)%></td>
                    </tr>
                </table>
            </div>

            <div style="text-align: center; margin-top: 30px;">
                <p style="font-size: 14px;">📱 Scan to Pay / Leave Feedback</p>
                <img src="images/qr_feedback_payment.png" alt="QR Code" style="height: 120px;">
            </div>

            <p style="text-align: center; margin-top: 25px; font-size: 14px; color: #555; font-style: italic;">
                Thank you for visiting <strong>Chai Churi!</strong> 💛<br>We hope to see you again soon 😊
            </p>
        </div>


        <script>
            function printBill() {
                const content = document.getElementById("printSection").innerHTML;
                const original = document.body.innerHTML;
                document.body.innerHTML = content;
                window.print();
                document.body.innerHTML = original;
            }
        </script>

    </body>
</html>
<%
    session.removeAttribute("cart");
%>
