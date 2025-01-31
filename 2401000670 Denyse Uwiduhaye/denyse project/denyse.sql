create database saloon_manag_system;
use saloon_manag_system;

-- create table of customer

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15),
    email VARCHAR(100),
    address TEXT,
    date_of_birth DATE
);

-- create table of services
CREATE TABLE Services (
    service_id INT PRIMARY KEY AUTO_INCREMENT,
    service_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    duration INT NOT NULL -- Duration in minutes
);
-- create table of staffs


CREATE TABLE Staffs (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15),
    email VARCHAR(100),
    role VARCHAR(50) NOT NULL, -- E.g., hairstylist, receptionist, etc.
    hire_date DATE,
    salary DECIMAL(10, 2)
);
-- create table of payments


CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    payment_date DATETIME NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50), -- E.g., cash, card
    payment_status VARCHAR(50), -- E.g., completed, pending
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);
show tables;


-- insert into customer

INSERT INTO Customers (first_name, last_name, phone_number, email, address, date_of_birth)
VALUES ('denyse', 'uwase', '1234567890', 'duwidu@gmail.com', '123 Main St', '1985-05-20'),
('bote', 'aime', '4334567890', 'wera@gmail.com', '123 Main St', '1964-04-20'),

('keza', 'angel', '3334567890', 'keza@gmail.com', '123 Main St', '1987-03-20');

select*from customers;
desc customers;
-- insert into service

INSERT INTO Services (service_name, description, price, duration)
VALUES ('Haircut', 'Basic haircut for men and women', 20.00, 30),
('member', 'number of member', 10.01, 20),
('physical', 'economic of basic', 30.02, 40);

select*from services;

-- insert into staff

INSERT INTO Staffs (first_name, last_name, phone_number, email, role, hire_date, salary)
VALUES ('Alice', 'Br(own', '1122334455', 'alice@gmail.com', 'Hairstylist', '2024-01-17', 2534.30),

 ('nicole', 'diva', '3452334455', 'bote@gmail.com', 'ecommerce', '2022-03-14', 2534.20),

('nadine', 'bruan', '9802334455', 'ema@gmail.com', 'biology', '2021-02-16', 2578.10);
select*from staffs;


I




