-- SUPPLEMENTARY SQL QUERIES FROM THE USER'S MYSQL EXECUTION TRANSCRIPT
-- Project: Student Placement and Recruitment Analytics System
-- Source: queries of student placement recruiter analysis(2).txt
--
-- This file contains SQL commands entered during the recorded MySQL session.
-- MySQL result tables and status messages have intentionally been excluded.
--
-- IMPORTANT:
-- 1. This is an execution-history/reference file, not a replacement for files 01-10.
-- 2. It repeats database/table creation and sample-data insertion commands.
-- 3. Do NOT run this entire file on your existing database: duplicate-key and
--    already-existing-object errors may occur.
-- 4. The uploaded transcript contains trigger definitions, but does not contain
--    CREATE VIEW, CREATE PROCEDURE, or transaction statements. Those remain in
--    the corresponding individual project scripts where provided.
--
create Database StudentPlacementDB;

USE StudentPlacementDB;

show databases;

select database();

CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL,
    department_code VARCHAR(20) NOT NULL UNIQUE,
    hod_name VARCHAR(100)
);

DESC Departments;

CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    roll_number VARCHAR(30) NOT NULL UNIQUE,
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    department_id INT NOT NULL,
    cgpa DECIMAL(3,2) NOT NULL,
    active_backlogs INT DEFAULT 0,
    graduation_year INT NOT NULL,
    FOREIGN KEY (department_id)
        REFERENCES Departments(department_id),
    CHECK (cgpa BETWEEN 0 AND 10),
    CHECK (active_backlogs >= 0)
);

DESC Students;

CREATE TABLE Companies (
    company_id INT PRIMARY KEY AUTO_INCREMENT,
    company_name VARCHAR(100) NOT NULL,
    industry VARCHAR(100),
    location VARCHAR(100),
    contact_email VARCHAR(100) UNIQUE,
    website VARCHAR(255)
);

DESC Companies;

CREATE TABLE Job_Roles (
    job_role_id INT PRIMARY KEY AUTO_INCREMENT,
    company_id INT NOT NULL,
    role_title VARCHAR(100) NOT NULL,
    job_type VARCHAR(50),
    location VARCHAR(100),
    min_cgpa DECIMAL(3,2) NOT NULL,
    max_backlogs INT DEFAULT 0,
    package_lpa DECIMAL(8,2),
    application_deadline DATE,
    job_status VARCHAR(20) DEFAULT 'OPEN',
    FOREIGN KEY (company_id)
        REFERENCES Companies(company_id),
    CHECK (min_cgpa BETWEEN 0 AND 10),
    CHECK (max_backlogs >= 0),
    CHECK (package_lpa IS NULL OR package_lpa >= 0),
    CHECK (job_status IN ('OPEN','CLOSED'))
);

DESC Job_Roles;

CREATE TABLE Applications (
    application_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    job_role_id INT NOT NULL,
    application_date DATE NOT NULL,
    application_status VARCHAR(30) DEFAULT 'APPLIED',
    FOREIGN KEY (student_id)
        REFERENCES Students(student_id),
    FOREIGN KEY (job_role_id)
        REFERENCES Job_Roles(job_role_id),
    UNIQUE (student_id, job_role_id),
    CHECK (application_status IN
    ('APPLIED','SHORTLISTED','REJECTED','SELECTED','WITHDRAWN'))
);

DESC Applications;

CREATE TABLE Assessments (
    assessment_id INT PRIMARY KEY AUTO_INCREMENT,
    application_id INT NOT NULL,
    assessment_type VARCHAR(50) NOT NULL,
    assessment_date DATE,
    score DECIMAL(5,2),
    result VARCHAR(20),
    FOREIGN KEY (application_id)
        REFERENCES Applications(application_id),
    CHECK (score IS NULL OR score BETWEEN 0 AND 100),
    CHECK (result IS NULL OR result IN ('PASS','FAIL','PENDING'))
);

DESC Assessments;

CREATE TABLE Interviews (
    interview_id INT PRIMARY KEY AUTO_INCREMENT,
    application_id INT NOT NULL,
    interview_round VARCHAR(50) NOT NULL,
    interview_date DATE,
    interviewer_name VARCHAR(100),
    feedback VARCHAR(255),
    result VARCHAR(20) DEFAULT 'PENDING',
    FOREIGN KEY (application_id)
        REFERENCES Applications(application_id),
    CHECK (result IN ('PASS','FAIL','PENDING'))
);

DESC Interviews;

CREATE TABLE Offers (
    offer_id INT PRIMARY KEY AUTO_INCREMENT,
    application_id INT NOT NULL UNIQUE,
    offer_date DATE,
    package_lpa DECIMAL(8,2) NOT NULL,
    joining_date DATE,
    offer_status VARCHAR(20) DEFAULT 'PENDING',
    FOREIGN KEY (application_id)
        REFERENCES Applications(application_id),
    CHECK (package_lpa > 0),
    CHECK (offer_status IN ('ACCEPTED','REJECTED','PENDING'))
);

DESC Offers;

INSERT INTO Departments
(department_name, department_code, hod_name)
VALUES
('Computer Science and Engineering', 'CSE', 'Dr. Ramesh Kumar'),
('Electronics and Communication', 'ECE', 'Dr. Lakshmi Devi'),
('Electrical and Electronics', 'EEE', 'Dr. Suresh Rao'),
('Information Technology', 'IT', 'Dr. Anil Kumar'),
('Mechanical Engineering', 'MECH', 'Dr. Prasad');

SELECT * FROM Departments;

INSERT INTO Students
(roll_number, student_name, email, phone,
 department_id, cgpa, active_backlogs, graduation_year)
VALUES
('22CSE001', 'Mounika Potharlanka', 'mounika@gmail.com', '9182257721', 1, 8.00, 0, 2026),
('22CSE002', 'Rahul Sharma', 'rahul@gmail.com', '9876500001', 1, 8.50, 0, 2026),
('22CSE003', 'Priya Reddy', 'priya@gmail.com', '9876500002', 1, 9.00, 0, 2026),
('22ECE001', 'Arjun Kumar', 'arjun@gmail.com', '9876500003', 2, 7.80, 0, 2026),
('22ECE002', 'Sneha Rao', 'sneha@gmail.com', '9876500004', 2, 8.20, 1, 2026),
('22EEE001', 'Kiran Kumar', 'kiran@gmail.com', '9876500005', 3, 7.50, 0, 2026),
('22IT001', 'Divya Sharma', 'divya@gmail.com', '9876500006', 4, 8.70, 0, 2026),
('22IT002', 'Vamsi Krishna', 'vamsi@gmail.com', '9876500007', 4, 7.90, 0, 2026),
('22MECH001', 'Anusha Reddy', 'anusha@gmail.com', '9876500008', 5, 8.10, 0, 2026),
('22CSE004', 'Sai Teja', 'saiteja@gmail.com', '9876500009', 1, 6.80, 2, 2026);

SELECT * FROM Students;

INSERT INTO Companies
(company_name, industry, location, contact_email, website)
VALUES
('TCS', 'IT Services', 'Hyderabad', 'recruitment@tcs.example', 'https://www.tcs.com'),
('Infosys', 'IT Services', 'Bangalore', 'careers@infosys.example', 'https://www.infosys.com'),
('Wipro', 'IT Services', 'Hyderabad', 'jobs@wipro.example', 'https://www.wipro.com'),
('Accenture', 'Consulting and IT', 'Hyderabad', 'careers@accenture.example', 'https://www.accenture.com'),
('Deloitte', 'Consulting', 'Hyderabad', 'recruitment@deloitte.example', 'https://www.deloitte.com');

SELECT * FROM Companies;

INSERT INTO Job_Roles
(company_id, role_title, job_type, location,
 min_cgpa, max_backlogs, package_lpa,
 application_deadline, job_status)
VALUES
(1, 'Assistant System Engineer', 'Full-Time', 'Hyderabad', 6.00, 0, 3.50, '2026-12-15', 'OPEN'),
(1, 'Data Analyst', 'Full-Time', 'Hyderabad', 7.00, 0, 5.00, '2026-12-20', 'OPEN'),
(2, 'Systems Engineer', 'Full-Time', 'Bangalore', 6.50, 0, 4.50, '2026-12-18', 'OPEN'),
(2, 'Python Developer', 'Full-Time', 'Bangalore', 7.00, 0, 6.00, '2026-12-22', 'OPEN'),
(3, 'Software Developer', 'Full-Time', 'Hyderabad', 6.00, 1, 4.00, '2026-12-25', 'OPEN'),
(4, 'Application Developer', 'Full-Time', 'Hyderabad', 7.00, 0, 5.50, '2026-12-28', 'OPEN'),
(5, 'Business Technology Analyst', 'Full-Time', 'Hyderabad', 7.50, 0, 7.00, '2026-12-30', 'OPEN'),
(5, 'Associate Analyst', 'Full-Time', 'Hyderabad', 6.50, 0, 4.80, '2026-12-31', 'CLOSED');

SELECT * FROM Job_Roles;

INSERT INTO Applications
(student_id, job_role_id, application_date, application_status)
VALUES
(1, 1, '2026-11-10', 'SELECTED'),
(1, 4, '2026-11-12', 'SHORTLISTED'),
(2, 1, '2026-11-11', 'REJECTED'),
(2, 3, '2026-11-13', 'SELECTED'),
(3, 2, '2026-11-14', 'SHORTLISTED'),
(3, 4, '2026-11-15', 'SELECTED'),
(4, 3, '2026-11-16', 'APPLIED'),
(5, 5, '2026-11-17', 'SELECTED'),
(6, 5, '2026-11-18', 'REJECTED'),
(7, 6, '2026-11-19', 'SHORTLISTED'),
(8, 7, '2026-11-20', 'APPLIED'),
(10, 1, '2026-11-21', 'REJECTED');

SELECT * FROM Applications;

INSERT INTO Assessments
(application_id, assessment_type, assessment_date, score, result)
VALUES
(1, 'Aptitude Test', '2026-11-12', 85.00, 'PASS'),
(1, 'Technical Test', '2026-11-13', 90.00, 'PASS'),
(2, 'Coding Test', '2026-11-14', 78.00, 'PASS'),
(3, 'Aptitude Test', '2026-11-15', 45.00, 'FAIL'),
(4, 'Technical Test', '2026-11-16', 88.00, 'PASS'),
(5, 'Aptitude Test', '2026-11-17', 75.00, 'PASS'),
(6, 'Coding Test', '2026-11-18', 92.00, 'PASS'),
(7, 'Aptitude Test', '2026-11-19', 65.00, 'PASS'),
(8, 'Technical Test', '2026-11-20', 81.00, 'PASS'),
(9, 'Coding Test', '2026-11-21', 40.00, 'FAIL'),
(10, 'Aptitude Test', '2026-11-22', 80.00, 'PASS'),
(11, 'Technical Test', '2026-11-23', 70.00, 'PASS');

SELECT * FROM Assessments;

INSERT INTO Interviews
(application_id, interview_round, interview_date,
 interviewer_name, feedback, result)
VALUES
(1, 'Technical Round', '2026-11-18', 'Ravi Kumar', 'Good programming knowledge', 'PASS'),
(1, 'HR Round', '2026-11-20', 'Priya Sharma', 'Good communication skills', 'PASS'),
(2, 'Technical Round', '2026-11-21', 'Anil Rao', 'Good technical skills', 'PASS'),
(4, 'Technical Round', '2026-11-22', 'Kiran Reddy', 'Strong problem solving', 'PASS'),
(5, 'HR Round', '2026-11-23', 'Sneha Rao', 'Communication needs improvement', 'PENDING'),
(6, 'Technical Round', '2026-11-24', 'Arun Kumar', 'Excellent coding skills', 'PASS'),
(8, 'Technical Round', '2026-11-24', 'Vijay Kumar', 'Good subject knowledge', 'PASS'),
(10, 'HR Round', '2026-11-25', 'Meena Devi', 'Interview evaluation pending', 'PENDING');

SELECT * FROM Interviews;

INSERT INTO Offers
(application_id, offer_date, package_lpa, joining_date, offer_status)
VALUES
(1, '2026-11-21', 3.50, '2027-01-15', 'ACCEPTED'),
(4, '2026-11-22', 4.50, '2027-02-01', 'PENDING'),
(6, '2026-11-23', 6.00, '2027-01-20', 'ACCEPTED'),
(8, '2026-11-24', 4.00, '2027-02-15', 'REJECTED');

SELECT * FROM Offers;

SELECT 'Departments' AS table_name, COUNT(*) AS total_records FROM Departments
UNION ALL
SELECT 'Students', COUNT(*) FROM Students
UNION ALL
SELECT 'Companies', COUNT(*) FROM Companies
UNION ALL
SELECT 'Job_Roles', COUNT(*) FROM Job_Roles
UNION ALL
SELECT 'Applications', COUNT(*) FROM Applications
UNION ALL
SELECT 'Assessments', COUNT(*) FROM Assessments
UNION ALL
SELECT 'Interviews', COUNT(*) FROM Interviews
UNION ALL
SELECT 'Offers', COUNT(*) FROM Offers;

SELECT * FROM Departments;

SELECT * FROM Students;

SELECT * FROM Companies;

SELECT * FROM Job_Roles;

SELECT * FROM Applications;

SELECT * FROM Assessments;

SELECT * FROM Interviews;

SELECT * FROM Offers;

SELECT *
FROM Students
WHERE roll_number = '22CSE005';

SELECT *
FROM Departments
WHERE department_code = 'CSE';

INSERT INTO Students
(
    roll_number,
    student_name,
    email,
    phone,
    department_id,
    cgpa,
    active_backlogs,
    graduation_year
)
VALUES
(
    '22CSE005',
    'Nikhil Kumar',
    'nikhil@example.com',
    '9876500011',
    1,
    8.60,
    0,
    2026
);

SELECT *
FROM Students
WHERE roll_number = '22CSE005';

SELECT *
FROM Companies
WHERE company_name = 'Tech Mahindra';

INSERT INTO Companies
(company_name, industry, location, contact_email, website)
VALUES
(
    'Tech Mahindra',
    'IT Services',
    'Hyderabad',
    'hr@techmahindra.example',
    'https://www.techmahindra.com'
);

SELECT *
FROM Companies
WHERE company_name = 'Tech Mahindra';

SELECT *
FROM Job_Roles
WHERE company_id = 6
AND role_title = 'Software Engineer';

INSERT INTO Job_Roles
(
    company_id,
    role_title,
    job_type,
    location,
    min_cgpa,
    max_backlogs,
    package_lpa,
    application_deadline,
    job_status
)
VALUES
(
    6,
    'Software Engineer',
    'Full-Time',
    'Hyderabad',
    7.00,
    0,
    5.00,
    '2026-12-30',
    'OPEN'
);

SELECT *
FROM Job_Roles
WHERE company_id = 6;

SELECT student_name, roll_number, cgpa
FROM Students
WHERE roll_number = '22CSE005';

UPDATE Students
SET cgpa = 8.90
WHERE roll_number = '22CSE005';

SELECT student_name, roll_number, cgpa
FROM Students
WHERE roll_number = '22CSE005';

SELECT *
FROM Applications
WHERE student_id = 11
AND job_role_id = 9;

INSERT INTO Applications
(student_id, job_role_id, application_date, application_status)
VALUES
(11, 9, CURRENT_DATE, 'APPLIED');

SELECT *
FROM Applications
WHERE student_id = 11
AND job_role_id = 9;

UPDATE Applications
SET application_status = 'SHORTLISTED'
WHERE application_id = 13;

SELECT *
FROM Applications
WHERE application_id = 13;

SELECT *
FROM Assessments
WHERE application_id = 13;

INSERT INTO Assessments
(
    application_id,
    assessment_type,
    assessment_date,
    score,
    result
)
VALUES
(
    13,
    'Aptitude Test',
    CURRENT_DATE,
    85.00,
    'PASS'
);

SELECT *
FROM Assessments
WHERE application_id = 13;

SELECT *
FROM Interviews
WHERE application_id = 13;

INSERT INTO Interviews
(
    application_id,
    interview_round,
    interview_date,
    interviewer_name,
    feedback,
    result
)
VALUES
(
    13,
    'Technical Round',
    '2026-12-05',
    'Mr. Raj',
    'Good technical knowledge',
    'PENDING'
);

SELECT *
FROM Interviews
WHERE application_id = 13;

UPDATE Interviews
SET result = 'PASS',
    feedback = 'Excellent technical performance'
WHERE interview_id = 9;

SELECT *
FROM Interviews
WHERE interview_id = 9;

SELECT *
FROM Offers
WHERE application_id = 13;

INSERT INTO Offers
(
    application_id,
    offer_date,
    package_lpa,
    joining_date,
    offer_status
)
VALUES
(
    13,
    CURRENT_DATE,
    6.00,
    '2027-01-15',
    'PENDING'
);

SELECT *
FROM Offers
WHERE application_id = 13;

UPDATE Offers
SET offer_status = 'ACCEPTED'
WHERE offer_id = 5;

SELECT *
FROM Offers
WHERE offer_id = 5;

SELECT *
FROM Applications
WHERE application_id = 13;

SHOW TRIGGERS;

DELIMITER //

CREATE TRIGGER ValidateStudentEligibility
BEFORE INSERT ON Applications
FOR EACH ROW
BEGIN
    DECLARE v_cgpa DECIMAL(3,2);
    DECLARE v_backlogs INT;
    DECLARE v_min_cgpa DECIMAL(3,2);
    DECLARE v_max_backlogs INT;
    DECLARE v_job_status VARCHAR(20);
    SELECT cgpa, active_backlogs
    INTO v_cgpa, v_backlogs
    FROM Students
    WHERE student_id = NEW.student_id;
    SELECT min_cgpa, max_backlogs, job_status
    INTO v_min_cgpa, v_max_backlogs, v_job_status
    FROM Job_Roles
    WHERE job_role_id = NEW.job_role_id;
    IF v_job_status <> 'OPEN' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'This job role is closed';
    ELSEIF v_cgpa < v_min_cgpa
       OR v_backlogs > v_max_backlogs THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Student does not meet job eligibility';
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER ValidateAssessmentScore
BEFORE INSERT ON Assessments
FOR EACH ROW
BEGIN
    IF NEW.score IS NOT NULL
       AND (NEW.score < 0 OR NEW.score > 100) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Assessment score must be between 0 and 100';
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER MarkApplicationSelected
AFTER UPDATE ON Offers
FOR EACH ROW
BEGIN
    IF NEW.offer_status = 'ACCEPTED'
       AND OLD.offer_status <> 'ACCEPTED' THEN
        UPDATE Applications
        SET application_status = 'SELECTED'
        WHERE application_id = NEW.application_id;
    END IF;
END //

DELIMITER ;

SHOW TRIGGERS;

UPDATE Offers
SET offer_status = 'PENDING'
WHERE offer_id = 5;

UPDATE Offers
SET offer_status = 'ACCEPTED'
WHERE offer_id = 5;

SELECT *
FROM Applications
WHERE application_id = 13;

SELECT *
FROM Job_Roles
WHERE job_role_id = 1;

UPDATE Job_Roles
SET job_status = 'CLOSED'
WHERE job_role_id = 1;

SELECT *
FROM Job_Roles
WHERE job_role_id = 1;

SELECT *
FROM Applications
WHERE application_id = 3;

UPDATE Applications
SET application_status = 'WITHDRAWN'
WHERE application_id = 3;

SELECT *
FROM Applications
WHERE application_id = 3;

SELECT *
FROM Students
WHERE roll_number = 'TEST001';

DELETE FROM Students
WHERE roll_number = 'TEST001';

SELECT *
FROM Students
WHERE roll_number = 'TEST001';

SELECT
    s.student_name,
    s.roll_number,
    d.department_name,
    j.role_title,
    c.company_name,
    a.application_status,
    o.package_lpa,
    o.offer_status
FROM Students s
INNER JOIN Departments d
    ON s.department_id = d.department_id
INNER JOIN Applications a
    ON s.student_id = a.student_id
INNER JOIN Job_Roles j
    ON a.job_role_id = j.job_role_id
INNER JOIN Companies c
    ON j.company_id = c.company_id
LEFT JOIN Offers o
    ON a.application_id = o.application_id;

SELECT
COUNT(DISTINCT student_id) AS total_students_applied,
    COUNT(*) AS total_applications,
    SUM(application_status = 'SELECTED') AS selected_applications,
    SUM(application_status = 'REJECTED') AS rejected_applications,
    SUM(application_status = 'SHORTLISTED') AS shortlisted_applications
FROM Applications;

SELECT
    COUNT(*) AS total_accepted_offers,
    ROUND(AVG(package_lpa), 2) AS average_package_lpa,
    MAX(package_lpa) AS highest_package_lpa
FROM Offers
WHERE offer_status = 'ACCEPTED';

SELECT
    COUNT(DISTINCT student_id) AS total_students_applied,
    COUNT(*) AS total_applications,
    SUM(application_status = 'SELECTED') AS selected_applications,
    SUM(application_status = 'REJECTED') AS rejected_applications,
    SUM(application_status = 'SHORTLISTED') AS shortlisted_applications
FROM Applications;
