CREATE DATABASE cafe_management;
USE cafe_management;
CREATE TABLE users (user_id INT PRIMARY KEY AUTO_INCREMENT, name VARCHAR(100), email VARCHAR(100) UNIQUE, phone VARCHAR(15), password VARCHAR(255), role ENUM('admin', 'staff', 'customer'));


-- Added menu and orders tables

CREATE TABLE menu (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    description TEXT,
    price DECIMAL(10, 2),
    available BOOLEAN DEFAULT TRUE
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
