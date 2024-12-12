use company;

CREATE TABLE Worker (
    Worker_Id INT PRIMARY KEY,
    FirstName CHAR(25),
    LastName CHAR(25),
    Salary INT,
    JoiningDate DATETIME,
    Department CHAR(25)
);

INSERT INTO Worker (Worker_Id, FirstName, LastName, Salary, JoiningDate, Department)
VALUES
(1, 'John', 'Doe', 50000, '2023-01-15', 'HR'),
(2, 'Jane', 'Smith', 60000, '2022-06-20', 'Finance'),
(3, 'Robert', 'Brown', 70000, '2021-03-10', 'IT'),
(4, 'Emily', 'Davis', 55000, '2023-08-25', 'HR'),
(5, 'Michael', 'Clark', 75000, '2020-11-05', 'IT');


DELIMITER //

-- stored procedure to add a new record
CREATE PROCEDURE AddWorker(
    IN p_Worker_Id INT, 
    IN p_FirstName CHAR(25), 
    IN p_LastName CHAR(25), 
    IN p_Salary INT, 
    IN p_JoiningDate DATETIME, 
    IN p_Department CHAR(25)
)
BEGIN
    INSERT INTO Worker (Worker_Id, FirstName, LastName, Salary, JoiningDate, Department)
    VALUES (p_Worker_Id, p_FirstName, p_LastName, p_Salary, p_JoiningDate, p_Department);
END //

DELIMITER ;

-- Procedure Call
CALL AddWorker(6, 'SAM', 'CURAN', 45000, '2024-11-23', 'IT');

-- stored procedure to retrieve a worker's salary
DELIMITER //

CREATE PROCEDURE GetSalary(
    IN p_Worker_Id INT, 
    OUT p_Salary INT
)
BEGIN
    SELECT Salary INTO p_Salary 
    FROM Worker 
    WHERE Worker_Id = p_Worker_Id;
END //

DELIMITER ;

-- Procedure Call
CALL GetSalary(1, @p_Salary);
SELECT @p_Salary AS WorkerSalary;

-- stored procedure to update the department
DELIMITER //

CREATE PROCEDURE UpdateDepartment(
    IN p_Worker_Id INT, 
    IN p_Department CHAR(25)
)
BEGIN
    UPDATE Worker 
    SET Department = p_Department 
    WHERE Worker_Id = p_Worker_Id;
END //

DELIMITER ;

-- Procedure Call
CALL UpdateDepartment(1, 'Finance');

-- stored procedure to count workers in a department
DELIMITER //

CREATE PROCEDURE GetWorkerCount(
    IN p_Department CHAR(25), 
    OUT p_WorkerCount INT
)
BEGIN
    SELECT COUNT(*) INTO p_WorkerCount 
    FROM Worker 
    WHERE Department = p_Department;
END //

DELIMITER ;

-- Procedure Call
CALL GetWorkerCount('HR', @p_WorkerCount);
SELECT @p_WorkerCount AS WorkerCount;

-- stored procedure to find the average salary in a department
DELIMITER //

CREATE PROCEDURE GetAverageSalary(
    IN p_Department CHAR(25), 
    OUT p_AvgSalary DECIMAL(15,2)
)
BEGIN
    SELECT AVG(Salary) INTO p_AvgSalary 
    FROM Worker 
    WHERE Department = p_Department;
END //

DELIMITER ;

-- Procedure Call
CALL GetAverageSalary('HR', @p_AvgSalary);
SELECT @p_AvgSalary AS AverageSalary;



