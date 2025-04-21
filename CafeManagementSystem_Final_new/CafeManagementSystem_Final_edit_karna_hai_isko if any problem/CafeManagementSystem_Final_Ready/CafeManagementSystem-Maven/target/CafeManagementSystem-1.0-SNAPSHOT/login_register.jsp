<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login/Signup Form</title>
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap');
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: "Poppins", sans-serif;
                text-decoration: none;
                list-style: none;
            }
            body {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                background: linear-gradient(90deg, #e2e2e2, #c9d6ff);
            }
            .container {
                position: relative;
                width: 850px;
                height: 550px;
                background: #fff;
                margin: 20px;
                border-radius: 30px;
                box-shadow: 0 0 30px rgba(0, 0, 0, .2);
                overflow: hidden;
            }
            .container h1 {
                font-size: 36px;
                margin: -10px 0;
            }
            .container p {
                font-size: 14.5px;
                margin: 15px 0;
            }
            form {
                width: 100%;
            }
            .form-box {
                position: absolute;
                right: 0;
                width: 50%;
                height: 100%;
                background: #fff;
                display: flex;
                align-items: center;
                color: #333;
                text-align: center;
                padding: 40px;
                z-index: 1;
                transition: .6s ease-in-out 1.2s, visibility 0s 1s;
            }
            .container.active .form-box {
                right: 50%;
            }
            .form-box.register {
                visibility: hidden;
            }
            .container.active .form-box.register {
                visibility: visible;
            }
            .input-box {
                position: relative;
                margin: 30px 0;
            }
            .input-box input {
                width: 100%;
                padding: 13px 50px 13px 20px;
                background: #eee;
                border-radius: 8px;
                border: none;
                outline: none;
                font-size: 16px;
                color: #333;
                font-weight: 500;
            }
            .input-box input::placeholder {
                color: #888;
                font-weight: 400;
            }
            .input-box i {
                position: absolute;
                right: 20px;
                top: 50%;
                transform: translateY(-50%);
                font-size: 20px;
            }
            .btn {
                width: 100%;
                height: 48px;
                background: #7494ec;
                border-radius: 8px;
                border: none;
                cursor: pointer;
                font-size: 16px;
                color: #fff;
                font-weight: 600;
            }
            .toggle-box {
                position: absolute;
                width: 100%;
                height: 100%;
            }
            .toggle-box::before {
                content: '';
                position: absolute;
                left: -250%;
                width: 300%;
                height: 100%;
                background: #7494ec;
                border-radius: 150px;
                z-index: 2;
                transition: 1.8s ease-in-out;
            }
            .container.active .toggle-box::before {
                left: 50%;
            }
            .toggle-panel {
                position: absolute;
                width: 50%;
                height: 100%;
                color: #fff;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                z-index: 2;
                transition: .6s ease-in-out;
            }
            .toggle-panel.toggle-left {
                left: 0;
                transition-delay: 1.2s;
            }
            .container.active .toggle-panel.toggle-left {
                left: -50%;
                transition-delay: .6s;
            }
            .toggle-panel.toggle-right {
                right: -50%;
                transition-delay: .6s;
            }
            .container.active .toggle-panel.toggle-right {
                right: 0;
                transition-delay: 1.2s;
            }
        </style>
    </head>
    <body>
        <% if (request.getParameter("error") != null) {%>
        <p style="color:red;position:absolute;top:20px;"><%= request.getParameter("error")%></p>
        <% } else if (request.getParameter("success") != null) {%>
        <p style="color:green;position:absolute;top:20px;"><%= request.getParameter("success")%></p>
        <% }%>
        <div class="container">
            <div class="form-box login">
                <form action="login_signupServlet" method="post">
                    <h1>Login</h1>
                    <input type="hidden" name="action" value="login">
                    <div class="input-box">
                        <input type="email" name="email" placeholder="Email" required>
                        <i class='bx bxs-user'></i>
                    </div>
                    <div class="input-box">
                        <input type="password" name="password" placeholder="Password" required>
                        <i class='bx bxs-lock-alt'></i>
                    </div>
                    <button type="submit" class="btn">Login</button>
                </form>
            </div>
            <div class="form-box register">
                <form action="login_signupServlet" method="post">
                    <h1>Registration</h1>
                    <input type="hidden" name="action" value="register">
                    <div class="input-box">
                        <input type="text" name="name" placeholder="Username" required>
                        <i class='bx bxs-user'></i>
                    </div>
                    <div class="input-box">
                        <input type="email" name="email" placeholder="Email" required>
                        <i class='bx bxs-envelope'></i>
                    </div>
                    <div class="input-box">
                        <input type="text" name="phone" placeholder="Phone Number" required>
                        <i class='bx bxs-phone'></i>
                    </div>
                    <div class="input-box">
                        <input type="password" name="password" placeholder="Password" required>
                        <i class='bx bxs-lock-alt'></i>
                    </div>
                    <button type="submit" class="btn">Register</button>
                </form>
            </div>
            <div class="toggle-box">
                <div class="toggle-panel toggle-left">
                    <h1>Hello, Welcome!</h1>
                    <p>Don't have an account?</p>
                    <button class="btn register-btn">Register</button>
                </div>
                <div class="toggle-panel toggle-right">
                    <h1>Welcome Back!</h1>
                    <p>Already have an account?</p>
                    <button class="btn login-btn">Login</button>
                </div>
            </div>
        </div>
        <script>
            const container = document.querySelector('.container');
            const registerBtn = document.querySelector('.register-btn');
            const loginBtn = document.querySelector('.login-btn');
            registerBtn.addEventListener('click', () => {
                container.classList.add('active');
            });
            loginBtn.addEventListener('click', () => {
                container.classList.remove('active');
            });
        </script>
    </body>
</html>
