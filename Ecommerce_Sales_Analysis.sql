CREATE DATABASE ecommerce_analysis;
USE ecommerce_analysis;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50)
);
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id));
INSERT INTO Customers VALUES
(1, 'Rahul', 'Hyderabad', 'Telangana'),
(2, 'Priya', 'Pune', 'Maharashtra'),
(3, 'Arjun', 'Mumbai', 'Maharashtra'),
(4, 'Sneha', 'Bangalore', 'Karnataka'),
(5, 'Kiran', 'Hyderabad', 'Telangana'),
(6, 'Anjali', 'Chennai', 'Tamil Nadu'),
(7, 'Ravi', 'Pune', 'Maharashtra'),
(8, 'Meena', 'Vijayawada', 'Andhra Pradesh'),
(9, 'Vikram', 'Bangalore', 'Karnataka'),
(10, 'Divya', 'Chennai', 'Tamil Nadu');
INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 55000),
(102, 'Smartphone', 'Electronics', 25000),
(103, 'Headphones', 'Electronics', 3000),
(104, 'Keyboard', 'Electronics', 1500),
(105, 'Mouse', 'Electronics', 800),
(106, 'Office Chair', 'Furniture', 7500),
(107, 'Desk', 'Furniture', 10000),
(108, 'Backpack', 'Accessories', 2000),
(109, 'Watch', 'Accessories', 5000),
(110, 'Tablet', 'Electronics', 18000);
INSERT INTO Orders VALUES
(1001, 1, 101, '2026-01-05', 1),
(1002, 2, 102, '2026-01-08', 2),
(1003, 3, 103, '2026-01-12', 3),
(1004, 4, 106, '2026-01-15', 1),
(1005, 5, 105, '2026-01-20', 4),
(1006, 6, 107, '2026-02-02', 1),
(1007, 7, 101, '2026-02-10', 1),
(1008, 8, 108, '2026-02-14', 2),
(1009, 9, 109, '2026-02-18', 1),
(1010, 10, 110, '2026-02-25', 2),
(1011, 1, 102, '2026-03-03', 1),
(1012, 2, 103, '2026-03-07', 2),
(1013, 3, 104, '2026-03-12', 3),
(1014, 4, 107, '2026-03-18', 1),
(1015, 5, 101, '2026-03-22', 1),
(1016, 6, 109, '2026-04-05', 2),
(1017, 7, 110, '2026-04-10', 1),
(1018, 8, 105, '2026-04-15', 5),
(1019, 9, 106, '2026-04-20', 1),
(1020, 10, 108, '2026-04-25', 3);


#TOTAL SALES
SELECT SUM(p.price * o.quantity) AS total_sales
FROM Orders o
JOIN Products p
ON o.product_id = p.product_id;

#TOP 5 PRODUCTS BY SALES
USE ecommerce_analysis;
SELECT p.product_name,
       SUM(p.price * o.quantity) AS total_sales
FROM Orders o
JOIN Products p
ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC
LIMIT 5;

#TOP CUSTOMERS
SELECT c.customer_name,
       SUM(p.price * o.quantity) AS total_spent
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
JOIN Products p
ON o.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;

#SALES BY CATEGORY
SELECT p.category,
       SUM(p.price * o.quantity) AS total_sales
FROM Products p
JOIN Orders o
ON p.product_id = o.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

#SALES BY CITY
SELECT c.city,
       SUM(p.price * o.quantity) AS total_sales
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
JOIN Products p
ON o.product_id = p.product_id
GROUP BY c.city
ORDER BY total_sales DESC;

#MONTHLY SALES
SELECT MONTHNAME(o.order_date) AS month,
       SUM(p.price * o.quantity) AS total_sales
FROM Orders o
JOIN Products p
ON o.product_id = p.product_id
GROUP BY MONTH(o.order_date), MONTHNAME(o.order_date)
ORDER BY MONTH(o.order_date);

#CUSTOMERS SPENDING MORE THAN 10,000
SELECT c.customer_name,
       SUM(p.price * o.quantity) AS total_spent
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
JOIN Products p
ON o.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
HAVING total_spent > 10000
ORDER BY total_spent DESC;

#MOST ORDERED PRODUCTS
SELECT p.product_name,
       SUM(o.quantity) AS total_quantity
FROM Products p
JOIN Orders o
ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity DESC;
