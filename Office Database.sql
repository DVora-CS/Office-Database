--Employee Table:
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    birth_date DATE,
    sex VARCHAR(1),
    salary INT,
    super_id INT,
    branch_id INT
);

--Branch Table:
CREATE TABLE Branch (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(40),
    mgr_id INT,
    mgr_start_date DATE,
    FOREIGN KEY(mgr_id) REFERENCES Employee(emp_id) ON DELETE SET NULL
);

--Adding on FOREIGN KEY "branch_id" to Employee Table:
ALTER TABLE Employee
ADD FOREIGN KEY(branch_id)
REFERENCES Branch(branch_id)
ON DELETE SET NULL;

--Adding on FOREIGN KEY "super_id" to Employee Table:
ALTER TABLE Employee
ADD FOREIGN KEY(super_id)
REFERENCES Employee(emp_id)
ON DELETE SET NULL;

--Client Table:
CREATE TABLE Client(
    client_id INT PRIMARY KEY,
    client_name VARCHAR(40),
    branch_id INT,
    FOREIGN KEY(branch_id) REFERENCES Branch(branch_id) ON DELETE SET NULL
);

--Works_With Table:
CREATE TABLE Works_With (
    emp_id INT,
    client_id INT,
    total_sales INT,
    PRIMARY KEY(emp_id, client_id),
    FOREIGN KEY(emp_id) REFERENCES Employee(emp_id) ON DELETE CASCADE,
    FOREIGN KEY(client_id) REFERENCES Client(client_id) ON DELETE CASCADE
);

--Branch_Supplier Table:
CREATE TABLE Branch_Supplier (
    branch_id INT,
    supplier_name VARCHAR(40),
    supply_type VARCHAR(40),
    PRIMARY KEY(branch_id, supplier_name),
    FOREIGN KEY(branch_id) REFERENCES Branch(branch_id) ON DELETE CASCADE
);

--Inserting Corporate Branch Info:
INSERT INTO Employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

INSERT INTO Branch VALUES(1, 'Corporate', 100, '2006-02-09');

UPDATE Employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO Employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

--Inserting Scranton Branch Info:
INSERT INTO Employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO Branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE Employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO Employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO Employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO Employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

--Inserting Stamford Branch Info:
INSERT INTO Employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO Branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE Employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO Employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO Employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

SELECT * FROM Employee;

SELECT * FROM Branch;

--Inserting Client Table Info:
INSERT INTO Client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO Client VALUES(401, 'Lackawana County', 2);
INSERT INTO Client VALUES(402, 'FedEx', 3);
INSERT INTO Client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO Client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO Client VALUES(405, 'Times Newspaper', 3);
INSERT INTO Client VALUES(406, 'FedEx', 2);

SELECT * FROM Client;

--Inserting Works_With Table Info:
INSERT INTO Works_With VALUES(105, 400, 55000);
INSERT INTO Works_With VALUES(102, 401, 267000);
INSERT INTO Works_With VALUES(108, 402, 22500);
INSERT INTO Works_With VALUES(107, 403, 5000);
INSERT INTO Works_With VALUES(108, 403, 12000);
INSERT INTO Works_With VALUES(105, 404, 33000);
INSERT INTO Works_With VALUES(107, 405, 26000);
INSERT INTO Works_With VALUES(102, 406, 15000);
INSERT INTO Works_With VALUES(105, 406, 130000);

SELECT * FROM Works_With;

--Inserting Branch_Supplier Table Info:
INSERT INTO Branch_Supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO Branch_Supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO Branch_Supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO Branch_Supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO Branch_Supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO Branch_Supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO Branch_Supplier VALUES(3, 'Stamford Labels', 'Custom Forms');

SELECT * FROM Branch_Supplier;

--QUERIES:--
--Find all employees from the Employee Table:
SELECT *
FROM Employee;

--Find all Clients from the Client Table:
SELECT *
FROM Client;

--Find all Employees ordered by salary. Either Or:
SELECT *
FROM Employee
ORDER BY Employee.salary DESC;

SELECT *
FROM Employee
ORDER BY salary DESC;

--Find all employees ordered by sex then name:
SELECT *
FROM Employee
ORDER BY sex, first_name, last_name;

--Find the first 5 employees in the table:
SELECT *
FROM Employee
LIMIT 5;

-- Find the first and the last names of all employees:
SELECT first_name, last_name
FROM Employee;

--Find the forename and surnames of all employees:
SELECT first_name AS forename, last_name AS surname
FROM Employee;


--Find out all the different genders:
SELECT DISTINCT sex AS genders
FROM Employee;

--Find out all the different branch IDs:
SELECT DISTINCT branch_id
FROM Branch;

--SQL Functions:--
--Find the number of employees:
SELECT COUNT(emp_id)
FROM Employee;

--Find how many employees have a supervisor:
SELECT COUNT(super_id) AS EmployeesWithSupervisor
FROM Employee;

--Find the number of female employees born after 1970:
SELECT COUNT(emp_id)
FROM Employee
WHERE sex = 'F' AND birth_date > '1970-01-01';

--Find the average of all employee's salaries:
SELECT AVG(salary)
FROM Employee;

--Find the average of all the male employee's salaries:
SELECT AVG(salary)
FROM Employee
WHERE sex = 'M';

--Find the sum of all employee's salaries:
SELECT SUM(salary)
FROM Employee;

--Found out how many males and females there are:
SELECT COUNT(sex), sex
FROM Employee
GROUP BY sex;

--Find the total sales of each salesman:
SELECT SUM(total_sales), emp_id
FROM Works_With
GROUP BY emp_id;

--SQL Wildcards:--
--Find any clients who are an LLC:
SELECT *
FROM Client
WHERE client_name LIKE '%LLC';

--Find any branch suppliers who are in the label business:
SELECT *
FROM Branch_Supplier
WHERE supplier_name LIKE '%Labels%';

--Find any employees born in October:
SELECT *
FROM Employee
WHERE birth_date LIKE '____-10%';

--Find any emploees born in February:
SELECT *
FROM Employee
WHERE birth_date LIKE '____-02%';

--Find any clients who are schools:
SELECT *
FROM Client
WHERE client_name LIKE '%school%';

--SQL Union:
--Find a list of employee and branch name:
SELECT first_name
FROM Employee
UNION
SELECT branch_name
FROM Branch;

--Find a list of employee, branch name, and client name:
SELECT first_name AS Company_Database_Names
FROM Employee
UNION
SELECT branch_name
FROM Branch
UNION
SELECT client_name
FROM Client;


--Find a list of all clients & branch suppliers' names:
SELECT client_name AS 'Clients & Suppliers List'
FROM Client
UNION
SELECT supplier_name
FROM Branch_Supplier;

--Find a list of all clients & branch suppliers' names:
SELECT client_name, Client.branch_id
FROM Client
UNION
SELECT supplier_name, Branch_Supplier.branch_id
FROM Branch_Supplier;


--Find a list of all money spent or earned by the company:
SELECT salary
FROM Employee
UNION
SELECT total_sales
FROM Works_With;

--Find a list of all money spent or earned by the company:
SELECT salary, Employee.emp_id
FROM Employee
UNION
SELECT total_sales, Works_With.emp_id
FROM Works_With;

--SQL Joins:
INSERT INTO Branch VALUES(4, 'Buffalo', NULL, NULL);

--Prompt #1 - Find all branches and the names of their managers:
SELECT Employee.emp_id, Employee.first_name, Branch.branch_name
FROM Employee
JOIN Branch
ON Employee.emp_id = Branch.mgr_id;

SELECT Employee.emp_id, Employee.first_name, Branch.branch_name
FROM Employee
LEFT JOIN Branch
ON Employee.emp_id = Branch.mgr_id;

SELECT Employee.emp_id, Employee.first_name, Branch.branch_name
FROM Employee
RIGHT JOIN Branch
ON Employee.emp_id = Branch.mgr_id;

--Nested Queries:
--Find names of all employees who have sold over 30,000 to a single client:
-----Step 1 - Getting all of the IDs from Works_With table if they have sold over 30k.
SELECT Works_With.emp_id
FROM Works_With
WHERE Works_With.total_sales > 30000;

-----Step 2 - Get employee's first name and last name.
SELECT Employee.first_name, Employee.last_name
FROM Employee
WHERE Employee.emp_id;

-----Step 3 - Combine it to get the info for the prompt. Aka the final code/result.
SELECT Employee.first_name, Employee.last_name
FROM Employee
WHERE Employee.emp_id IN (
    SELECT Works_With.emp_id
    FROM Works_With
    WHERE Works_With.total_sales > 30000
);

/*Find all the clients who are handled by the branch that Michael Scott manages. Assume you know Michael's ID:*/
-----Step 1 - Figure out the branch ID of the branch that Michael Scott manages.
SELECT Branch.branch_id
FROM Branch
WHERE Branch.mgr_id = 102;

-----Step 2 - Now just get all the clients that are handled by Michael Scott's branch.
SELECT Client.client_name
FROM Client
WHERE Client.branch_id = (
    SELECT Branch.branch_id
    FROM Branch
    WHERE Branch.mgr_id = 102
    LIMIT 1
);

SELECT * FROM Employee;
SELECT * FROM Branch;
SELECT * FROM Client;
SELECT * FROM Works_With;
SELECT * FROM Branch_Supplier;
