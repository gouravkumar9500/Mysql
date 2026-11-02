DROP DATABASE IF EXISTS company_training;
CREATE DATABASE company_training;
USE company_training;

CREATE TABLE departments (
    department_id INT NOT NULL,
    dept_name VARCHAR(80) NOT NULL,
    city VARCHAR(60)
)
ENGINE = InnoDB
CHARSET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

INSERT INTO departments
(department_id, dept_name, city)
VALUES
(2001, 'Development', 'Chandigarh'),
(2002, 'Marketing', 'Ludhiana'),
(2003, 'Finance', 'Amritsar');

CREATE TABLE employees (
    employee_id INT NOT NULL,
    employee_name VARCHAR(100) NOT NULL,
    email VARCHAR(120),
    department_id INT NOT NULL,
    salary DECIMAL(10,2),
    status VARCHAR(20)
);

INSERT INTO employees
(employee_id, employee_name, email, department_id, salary, status)
VALUES
(201, 'Gourav Kumar', 'gouravkumar@example.com', 2001, 45000, 'Active'),
(202, 'Karan Singh', 'karansingh@example.com', 2002, 55000, 'Active'),
(203, 'Neha Sharma', 'nehasharma@example.com', 2003, 40000, 'Active');

ALTER TABLE departments ADD PRIMARY KEY (department_id);

ALTER TABLE employees ADD PRIMARY KEY (employee_id);

ALTER TABLE departments ADD COLUMN location VARCHAR(100);

ALTER TABLE departments CHANGE COLUMN dept_name department_name VARCHAR(80) NOT NULL;

ALTER TABLE employees MODIFY COLUMN salary DECIMAL(12,2) NOT NULL;

ALTER TABLE employees MODIFY COLUMN status VARCHAR(20) DEFAULT 'Active';

ALTER TABLE employees ADD UNIQUE (email);

ALTER TABLE employees RENAME TO staff;

ALTER TABLE staff ADD CONSTRAINT fk_department
FOREIGN KEY (department_id)
REFERENCES departments(department_id);

ALTER TABLE staff DROP INDEX email;

ALTER TABLE staff DROP FOREIGN KEY fk_department;

ALTER TABLE staff DROP PRIMARY KEY;

ALTER TABLE staff ADD PRIMARY KEY (employee_id);

ALTER TABLE departments DROP COLUMN location;



CREATE DATABASE IF NOT EXISTS company_management;

DROP TABLE IF EXISTS company_management.staff;
DROP TABLE IF EXISTS company_management.departments;


RENAME TABLE
company_training.departments TO company_management.departments,
company_training.staff TO company_management.staff;


DROP DATABASE company_training;

USE company_management;

SHOW TABLES;

DESCRIBE departments;

SELECT * FROM departments;

SHOW INDEX FROM staff;

SELECT * FROM staff;