CREATE DATABASE hrms;
USE hrms;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    hire_date DATE,
    job_title VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2),
    manager_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id),
    FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);

CREATE TABLE departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(100),
    location VARCHAR(100)
);


CREATE TABLE attendance (
    att_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    date DATE,
    status ENUM('Present','Absent','Leave','Half Day'),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

CREATE TABLE leaves (
    leave_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    leave_type ENUM('Sick','Casual','Paid','Unpaid'),
    start_date DATE,
    end_date DATE,
    status ENUM('Pending','Approved','Rejected') DEFAULT 'Pending',
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);


CREATE TABLE payroll (
    payroll_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    month VARCHAR(20),
    basic_salary DECIMAL(10,2),
    bonus DECIMAL(10,2),
    deductions DECIMAL(10,2),
    net_salary DECIMAL(10,2),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

CREATE TABLE performance (
    perf_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    review_date DATE,
    rating INT CHECK(rating BETWEEN 1 AND 5),
    comments VARCHAR(255),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

CREATE TABLE roles (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(50)
);

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(100),
    emp_id INT,
    role_id INT,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

INSERT INTO departments (dept_name, location) VALUES
('Human Resources', 'Mumbai'),
('Finance', 'Pune'),
('Information Technology', 'Bangalore');


INSERT INTO employees (first_name, last_name, email, phone, hire_date, job_title, dept_id, salary, manager_id)
VALUES
('Amit', 'Sharma', 'amit.sharma@hrms.com', '9876543210', '2021-01-10', 'HR Manager', 1, 80000, NULL),
('Priya', 'Patel', 'priya.patel@hrms.com', '9898989898', '2022-03-15', 'HR Executive', 1, 50000, 1),
('Ravi', 'Kumar', 'ravi.kumar@hrms.com', '9823456789', '2020-06-20', 'Finance Manager', 2, 90000, NULL),
('Neha', 'Mehta', 'neha.mehta@hrms.com', '9911223344', '2021-11-10', 'Accountant', 2, 55000, 3),
('Sanjay', 'Verma', 'sanjay.verma@hrms.com', '9900112233', '2019-09-05', 'IT Head', 3, 100000, NULL),
('Rohan', 'Joshi', 'rohan.joshi@hrms.com', '9845012345', '2022-04-01', 'Software Engineer', 3, 60000, 5),
('Sneha', 'Desai', 'sneha.desai@hrms.com', '9856781234', '2023-02-18', 'Web Developer', 3, 55000, 5),
('Kiran', 'Naik', 'kiran.naik@hrms.com', '9834567890', '2021-12-10', 'Data Analyst', 3, 65000, 5),
('Anita', 'Rao', 'anita.rao@hrms.com', '9822001100', '2020-08-15', 'Finance Executive', 2, 48000, 3),
('Vikas', 'Gupta', 'vikas.gupta@hrms.com', '9811223344', '2022-06-25', 'HR Assistant', 1, 40000, 1);


INSERT INTO attendance (emp_id, date, status) VALUES
(1, '2025-10-10', 'Present'), (1, '2025-10-11', 'Present'), (1, '2025-10-12', 'Leave'), (1, '2025-10-13', 'Present'), (1, '2025-10-14', 'Present'),
(2, '2025-10-10', 'Present'), (2, '2025-10-11', 'Absent'), (2, '2025-10-12', 'Present'), (2, '2025-10-13', 'Present'), (2, '2025-10-14', 'Half Day'),
(3, '2025-10-10', 'Present'), (3, '2025-10-11', 'Present'), (3, '2025-10-12', 'Present'), (3, '2025-10-13', 'Present'), (3, '2025-10-14', 'Present'),
(6, '2025-10-10', 'Present'), (6, '2025-10-11', 'Present'), (6, '2025-10-12', 'Leave'), (6, '2025-10-13', 'Present'), (6, '2025-10-14', 'Present');


INSERT INTO leaves (emp_id, leave_type, start_date, end_date, status) VALUES
(2, 'Sick', '2025-09-12', '2025-09-14', 'Approved'),
(6, 'Casual', '2025-09-25', '2025-09-26', 'Approved'),
(10, 'Paid', '2025-10-02', '2025-10-05', 'Pending'),
(4, 'Unpaid', '2025-08-20', '2025-08-22', 'Rejected');


INSERT INTO payroll (emp_id, month, basic_salary, bonus, deductions, net_salary) VALUES
(1, 'September 2025', 80000, 5000, 2000, 83000),
(2, 'September 2025', 50000, 3000, 1500, 51500),
(3, 'September 2025', 90000, 7000, 2500, 94500),
(4, 'September 2025', 55000, 2000, 1000, 56000),
(5, 'September 2025', 100000, 8000, 3000, 105000),
(6, 'September 2025', 60000, 4000, 1500, 62500),
(7, 'September 2025', 55000, 3000, 1200, 56800),
(8, 'September 2025', 65000, 5000, 1800, 68200),
(9, 'September 2025', 48000, 2500, 1000, 49500),
(10, 'September 2025', 40000, 2000, 800, 41200);


INSERT INTO performance (emp_id, review_date, rating, comments) VALUES
(2, '2025-09-30', 4, 'Consistent and reliable'),
(4, '2025-09-30', 3, 'Good, needs improvement in accuracy'),
(6, '2025-09-30', 5, 'Excellent performance'),
(7, '2025-09-30', 4, 'Very creative and dedicated'),
(10, '2025-09-30', 3, 'New employee, learning phase');


INSERT INTO roles (role_name) VALUES
('Admin'),
('Manager'),
('Employee');

INSERT INTO users (username, password, emp_id, role_id) VALUES
('amit_admin', 'password123', 1, 1),
('ravi_mgr', 'password123', 3, 2),
('sanjay_it', 'password123', 5, 2),
('rohan_emp', 'password123', 6, 3),
('priya_emp', 'password123', 2, 3);

-- List all employees with their department names
SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS Employee_Name, d.dept_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;

-- Show employees hired in the current year
SELECT * FROM employees
WHERE YEAR(hire_date) = YEAR(CURDATE());

-- Retrieve all managers (employees who manage others)
SELECT DISTINCT m.emp_id, CONCAT(m.first_name, ' ', m.last_name) AS Manager_Name
FROM employees e
JOIN employees m ON e.manager_id = m.emp_id;

-- List employees whose salary is above the company average(Subquery)
SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);


-- Total salary paid by each department
SELECT 
    d.dept_name AS Department,
    SUM(e.salary) AS Total_Salary_Paid
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
ORDER BY Total_Salary_Paid DESC;

-- List of Employees Currently on Leave
SELECT 
    e.emp_id,
    CONCAT(e.first_name, ' ', e.last_name) AS Employee_Name,
    l.leave_type,
    l.start_date,
    l.end_date,
    l.status
FROM leaves l
JOIN employees e ON l.emp_id = e.emp_id
WHERE l.status = 'Approved'
  AND CURDATE() BETWEEN l.start_date AND l.end_date;
  
-- Monthly Attendance Summary per Employee
SELECT 
    e.emp_id,
    CONCAT(e.first_name, ' ', e.last_name) AS Employee_Name,
    SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) AS Days_Present,
    SUM(CASE WHEN a.status = 'Absent' THEN 1 ELSE 0 END) AS Days_Absent,
    SUM(CASE WHEN a.status = 'Leave' THEN 1 ELSE 0 END) AS Days_On_Leave
FROM attendance a
JOIN employees e ON a.emp_id = e.emp_id
WHERE MONTH(a.date) = MONTH(CURDATE())
  AND YEAR(a.date) = YEAR(CURDATE())
GROUP BY e.emp_id
ORDER BY Days_Present DESC;

-- Top 3 Performers
	SELECT 
    e.emp_id,
    CONCAT(e.first_name, ' ', e.last_name) AS Employee_Name,
    ROUND(AVG(p.rating), 2) AS Avg_Rating
FROM performance p
JOIN employees e ON p.emp_id = e.emp_id
GROUP BY e.emp_id
ORDER BY Avg_Rating DESC
LIMIT 3;

--  Find the highest-paid employee in each department
SELECT e.dept_id, d.dept_name, e.first_name, e.last_name, e.salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE e.salary = (
  SELECT MAX(salary)
  FROM employees
  WHERE dept_id = e.dept_id
);

--  Department with the highest total salary expense
SELECT d.dept_name, SUM(e.salary) AS Total_Salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
ORDER BY Total_Salary DESC
LIMIT 1;

-- Employees who received bonuses greater than ₹10,000
SELECT e.emp_id, e.first_name, e.last_name, p.bonus
FROM payroll p
JOIN employees e ON e.emp_id = p.emp_id
WHERE p.bonus > 5000;

--  Average net salary paid per department
SELECT d.dept_name, ROUND(AVG(p.net_salary), 2) AS Avg_Net_Salary
FROM payroll p
JOIN employees e ON e.emp_id = p.emp_id
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

--  Total leaves taken by each employee
SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS Employee_Name, COUNT(*) AS Total_Leaves
FROM leaves l
JOIN employees e ON l.emp_id = e.emp_id
WHERE l.status = 'Approved'
GROUP BY e.emp_id;

--  Pending leave requests
SELECT e.first_name, e.last_name, l.leave_type, l.start_date, l.end_date
FROM leaves l
JOIN employees e ON l.emp_id = e.emp_id
WHERE l.status = 'Pending';

--  Employees on sick leave this month
SELECT e.first_name, e.last_name, l.start_date, l.end_date
FROM leaves l
JOIN employees e ON l.emp_id = e.emp_id
WHERE l.leave_type = 'Sick'
  AND MONTH(l.start_date) = MONTH(CURDATE())
  AND l.status = 'Approved';
  
--  Employee attendance percentage for this month
SELECT 
  e.emp_id,
  CONCAT(e.first_name, ' ', e.last_name) AS Employee_Name,
  ROUND(SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS Attendance_Percentage
FROM attendance a
JOIN employees e ON a.emp_id = e.emp_id
WHERE MONTH(a.date) = MONTH(CURDATE())
GROUP BY e.emp_id;

--  Average rating of each employee
SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS Employee_Name, 
       ROUND(AVG(p.rating), 2) AS Avg_Rating
FROM performance p
JOIN employees e ON p.emp_id = e.emp_id
GROUP BY e.emp_id
ORDER BY Avg_Rating DESC;


--  Employees with consistently low ratings (≤2)
SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS Employee_Name
FROM performance p
JOIN employees e ON p.emp_id = e.emp_id
GROUP BY e.emp_id
HAVING AVG(p.rating) <= 3;

--  Rank employees by salary within their department
SELECT 
  e.emp_id,
  CONCAT(e.first_name, ' ', e.last_name) AS Employee_Name,
  d.dept_name,
  e.salary,
  RANK() OVER (PARTITION BY e.dept_id ORDER BY e.salary DESC) AS Salary_Rank
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;

--  Show top 2 salaries from each department
SELECT * FROM (
  SELECT e.emp_id, e.first_name, e.salary, e.dept_id,
         RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS rnk
  FROM employees e
) ranked
WHERE rnk <= 2;



