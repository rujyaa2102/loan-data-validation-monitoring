DROP DATABASE IF EXISTS loan_db;
CREATE DATABASE loan_db;
USE loan_db;

CREATE TABLE loans (
    loan_id INT,
    customer_name VARCHAR(50),
    amount DECIMAL(10,2),
    status VARCHAR(20)
);

INSERT INTO loans VALUES
(101, 'Amit Patil', 50000, 'ACTIVE'),
(102, 'Sneha Kulkarni', 120000, 'ACTIVE'),
(103, 'Rahul Jadhav', 75000, 'CLOSED'),
(104, 'Priya Shinde', 30000, 'ACTIVE'),
(105, 'Vikas More', 90000, 'ACTIVE'),
(106, 'Neha Deshmukh', 45000, 'CLOSED'),
(107, 'Suresh Pawar', 60000, 'ACTIVE'),
(103, 'Rahul Jadhav', 75000, 'CLOSED'),
(108, NULL, 80000, 'ACTIVE'),
(109, 'Kiran Gaikwad', -25000, 'ACTIVE');


