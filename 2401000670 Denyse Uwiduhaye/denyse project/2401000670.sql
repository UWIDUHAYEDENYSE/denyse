create database saloon_mgt_sy;
use saloon_mgt_sy;
 
 
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15),
    email VARCHAR(100),
    address TEXT,
    date_of_birth DATE
);

CREATE TABLE Service (
    service_id INT PRIMARY KEY ,
    service_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    duration INT NOT NULL -- Duration in minutes
);
 
 CREATE TABLE Staff (
    staff_id INT PRIMARY KEY ,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15),
    email VARCHAR(100),
    role VARCHAR(50) NOT NULL, -- E.g., hairstylist, receptionist, etc.
    hire_date DATE,
    salary DECIMAL(10, 2)
);

CREATE TABLE Payment (
    payment_id INT PRIMARY KEY ,
    customer_id INT,
    payment_date DATE ,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50), -- E.g., cash, card
    payment_status VARCHAR(50), -- E.g., completed, pending
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);
 show tables;
 
 
 desc service;
 INSERT INTO Service (service_id,service_name, description, price, duration)
VALUES
    (1,'Haircut', 'Basic haircut for men and women', 20.00, 30),
    (2,'Manicure', 'Nail care and manicure', 15.00, 45),
    (3,'Pedicure', 'Foot care and pedicure', 18.00, 50),
    (4,'Facial', 'Skin facial treatment', 40.00, 60);
select * from Service;


desc customer;
INSERT INTO Customer (customer_id,first_name, last_name, phone_number, email, address, date_of_birth)
VALUES
    (1,'John', 'Doe', '1234567890', 'johndoe@example.com', '123 Main St', '1985-05-20'),
    (2,'Jane', 'Smith', '0987654321', 'janesmith@example.com', '456 Oak St', '1990-07-15');
select * from Customer;


desc Staff;
INSERT INTO Staff (staff_id,first_name, last_name, phone_number, email, role, hire_date, salary)
VALUES
    (1,'Alice', 'Brown', '1122334455', 'alice@salon.com', 'Hairstylist', '2020-01-15', 2500.00),
    (2,'Bob', 'White', '2233445566', 'bob@salon.com', 'Receptionist', '2022-03-01', 2000.00);
select * from Staff;


desc payment;
INSERT INTO Payment (payment_id,customer_id, payment_date, amount, payment_method, payment_status)
VALUES
    (1,1, '2025-02-01 10:30:00', 20.00, 'Card', 'Completed'),
    (2,2, '2025-02-01 11:45:00', 15.00, 'Cash', 'Completed');
select * from payment;

-- update customer
UPDATE Customer
SET phone_number = '9876543210', email = 'john_new@example.com'
WHERE customer_id = 1;
select * from Customer;

-- delete staff
DELETE FROM Staff WHERE staff_id = 1;
select * from Staff;

-- 1. create view all customer
CREATE VIEW View_All_Customers AS
SELECT customer_id, first_name, last_name, phone_number, email, address
FROM Customer;
select * from View_All_Customers;

-- 2. create view for all services
CREATE VIEW View_All_Services AS
SELECT service_id, service_name, description, price, duration
FROM Service;
select * from View_All_Services;
 
 -- 3.create view all staff
CREATE VIEW View_All_Staff AS
SELECT staff_id, first_name, last_name, role, hire_date, salary
FROM Staff;
select * from View_All_Staff;

-- 4 view all payments
CREATE VIEW View_All_Payments AS
SELECT p.payment_id, c.first_name AS customer_name, p.payment_date, p.amount, p.payment_method, p.payment_status
FROM Payment p
JOIN Customer c ON p.customer_id = c.customer_id;
select * from View_All_Payments;

-- 5 create view payments by customer
CREATE VIEW View_Payments_By_Customer AS
SELECT c.first_name AS customer_name, c.last_name, SUM(p.amount) AS total_spent
FROM Payment p
JOIN Customer c ON p.customer_id = c.customer_id
GROUP BY c.customer_id;
select * from View_Payments_By_Customer;
 
 -- 6 create view staff salary
 CREATE VIEW View_Staff_Salary AS
SELECT first_name, last_name, role, salary
FROM Staff;
select * from View_Staff_Salary;

-- STORED PROCEDURE 
-- 1. add a customer
-- delimiter $$
CREATE PROCEDURE AddCustomer (
    IN p_first_name VARCHAR(100),
    IN p_last_name VARCHAR(100),
    IN p_phone_number VARCHAR(15),
    IN p_email VARCHAR(100),
    IN p_address TEXT,
    IN p_date_of_birth DATE
)
-- BEGIN
    INSERT INTO Customer (first_name, last_name, phone_number, email, address, date_of_birth)
    VALUES (p_first_name, p_last_name, p_phone_number, p_email, p_address, p_date_of_birth);
-- END $$
call AddCustomer('Denyse','Uwiduhaye','08989898','uwi@gmail.com','musanze','2004-09-4');
select * from customer;

-- 2. get customer by id
CREATE PROCEDURE GetCustomerById (IN customerId INT)
-- BEGIN
    SELECT * FROM Customer WHERE customer_id = customerId;
-- END;
call GetCustomerById(1);

-- 3. Update Customer
CREATE PROCEDURE UpdateCustomer (
    IN customerId INT, 
    IN phoneNumber VARCHAR(15), 
    IN email VARCHAR(100)
)
-- BEGIN
    UPDATE Customer
    SET phone_number = phoneNumber, email = email
    WHERE customer_id = customerId;
-- END;
call UpdateCustomer('45656','jkjkj',1);

-- 4. get all services
DELIMITER $$
CREATE PROCEDURE GetAllServices()
BEGIN
    SELECT * FROM Service;
    
    -- 5. GetAllCustomers
    DELIMITER $$
CREATE PROCEDURE AddStaff(IN staff_id INT, IN first_name VARCHAR(100), IN last_name VARCHAR(100), IN phone_number VARCHAR(15), IN email VARCHAR(100), IN role VARCHAR(50), IN hire_date DATE, IN salary DECIMAL(10, 2))
BEGIN
    INSERT INTO Staff (staff_id, first_name, last_name, phone_number, email, role, hire_date, salary)
    VALUES (staff_id, first_name, last_name, phone_number, email, role, hire_date, salary);
END $$
DELIMITER ;
call AddStaff(1,'Israel','Israa','078997979','isra@gmail','praying at Bible','2023-06-09',10.45);
select * from Staff;

-- 6. get customer by id
CREATE PROCEDURE GetServiceById (IN service_id  INT)
-- BEGIN
    SELECT * FROM Service WHERE service_id = service_id ;
-- END;
call GetServiceById(1);

-- average and count and sum
-- count customers
SELECT COUNT(*) AS total_customers
FROM Customer;
-- count services
SELECT COUNT(*) AS total_services
FROM Service;
-- Average of service price
SELECT AVG(price) AS average_service_price
FROM Service;
-- average staff salary
SELECT AVG(salary) AS average_staff_salary
FROM Staff;
-- sum of total revenue
SELECT SUM(amount) AS total_revenue
FROM Payment
WHERE payment_status = 'Completed';

-- total spent
SELECT SUM(amount) AS total_spent
FROM Payment
WHERE customer_id = 1 AND payment_status = 'Completed';

-- create user and password
create user '0798965005'@'127.0.0.1' identified by '0798965005';
grant all privileges on saloon_mgt_sy. *to '0798965005'@'127.0.0.1';

















