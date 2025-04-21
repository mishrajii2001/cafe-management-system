
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Poppins", sans-serif;
            text-decoration: none;
            list-style: none;
        }

        body {
            min-height: 100vh;
            background: linear-gradient(90deg, #e2e2e2, #c9d6ff);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .dashboard-container {
            background: #fff;
            padding: 50px;
            border-radius: 30px;
            box-shadow: 0 0 30px rgba(0, 0, 0, .2);
            width: 850px;
            animation: fadeIn 1s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.95); }
            to { opacity: 1; transform: scale(1); }
        }

        h2 {
            font-size: 36px;
            font-weight: 700;
            color: #333;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: #f9f9f9;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        th td {
            padding: 20px;
            text-align: center;
            font-size: 16px;
            color: #333;
        }

        th {
            background: #7494ec;
            color: #fff;
            font-size: 18px;
        }

        tr:nth-child(even) {
            background: #f0f4ff;
        }

        .btn-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: #7494ec;
            color: #fff;
            border-radius: 8px;
            font-weight: 600;
            font-size: 15px;
            transition: 0.3s;
            border: none;
            cursor: pointer;
        }

        .btn-link:hover {
            background: #5c7dd4;
            transform: scale(1.05);
        }

        .logout {
            margin-top: 30px;
            width: 100%;
            padding: 14px;
            background: #ff4d4d;
            color: #fff;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            transition: all 0.3s ease-in-out;
            box-shadow: 0 4px 10px rgba(255, 0, 0, 0.3);
            border: none;
            cursor: pointer;
        }

        .logout:hover {
            background: #ff1a1a;
            transform: scale(1.05);
        }

        @media (max-width: 768px) {
            .dashboard-container {
                padding: 30px 20px;
                width: 90%;
            }

            table {
                font-size: 14px;
            }

            th, td {
                padding: 15px;
            }

            .btn-link, .logout {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>

    <div class="dashboard-container">
        <h2>Chai Churi - Admin Dashboard</h2>

        <table>
            <thead>
                <tr>
                    <th>Section</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Menu Management</td>
                    <td><a href="menu.jsp" class="btn-link"><i class='bx bxs-food-menu'></i> View Menu</a></td>
                </tr>
                <tr>
                    <td>Order Management</td>
                    <td><a href="order.jsp" class="btn-link"><i class='bx bxs-cart'></i> View Orders</a></td>
                </tr>
            </tbody>
        </table>

        <form action="logout" method="get">
            <button type="submit" class="logout"><i class='bx bx-log-out'></i> Logout</button>
        </form>
    </div>

</body>
</html>
