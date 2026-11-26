-- Step 3: Insert the sample data used in the MySQL execution record
-- Run this file only once on a newly created/empty database.
USE StudentPlacementDB;

INSERT INTO Departments
(department_name, department_code, hod_name)
VALUES
('Computer Science and Engineering', 'CSE', 'Dr. Ramesh Kumar'),
('Electronics and Communication', 'ECE', 'Dr. Lakshmi Devi'),
('Electrical and Electronics', 'EEE', 'Dr. Suresh Rao'),
('Information Technology', 'IT', 'Dr. Anil Kumar'),
('Mechanical Engineering', 'MECH', 'Dr. Prasad');

INSERT INTO Students
(roll_number, student_name, email, phone, department_id,
 cgpa, active_backlogs, graduation_year)
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

INSERT INTO Companies
(company_name, industry, location, contact_email, website)
VALUES
('TCS', 'IT Services', 'Hyderabad', 'recruitment@tcs.example', 'https://www.tcs.com'),
('Infosys', 'IT Services', 'Bangalore', 'careers@infosys.example', 'https://www.infosys.com'),
('Wipro', 'IT Services', 'Hyderabad', 'jobs@wipro.example', 'https://www.wipro.com'),
('Accenture', 'Consulting and IT', 'Hyderabad', 'careers@accenture.example', 'https://www.accenture.com'),
('Deloitte', 'Consulting', 'Hyderabad', 'recruitment@deloitte.example', 'https://www.deloitte.com');

INSERT INTO Job_Roles
(company_id, role_title, job_type, location, min_cgpa,
 max_backlogs, package_lpa, application_deadline, job_status)
VALUES
(1, 'Assistant System Engineer', 'Full-Time', 'Hyderabad', 6.00, 0, 3.50, '2026-12-15', 'OPEN'),
(1, 'Data Analyst', 'Full-Time', 'Hyderabad', 7.00, 0, 5.00, '2026-12-20', 'OPEN'),
(2, 'Systems Engineer', 'Full-Time', 'Bangalore', 6.50, 0, 4.50, '2026-12-18', 'OPEN'),
(2, 'Python Developer', 'Full-Time', 'Bangalore', 7.00, 0, 6.00, '2026-12-22', 'OPEN'),
(3, 'Software Developer', 'Full-Time', 'Hyderabad', 6.00, 1, 4.00, '2026-12-25', 'OPEN'),
(4, 'Application Developer', 'Full-Time', 'Hyderabad', 7.00, 0, 5.50, '2026-12-28', 'OPEN'),
(5, 'Business Technology Analyst', 'Full-Time', 'Hyderabad', 7.50, 0, 7.00, '2026-12-30', 'OPEN'),
(5, 'Associate Analyst', 'Full-Time', 'Hyderabad', 6.50, 0, 4.80, '2026-12-31', 'CLOSED');

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

INSERT INTO Interviews
(application_id, interview_round, interview_date, interviewer_name, feedback, result)
VALUES
(1, 'Technical Round', '2026-11-18', 'Ravi Kumar', 'Good programming knowledge', 'PASS'),
(1, 'HR Round', '2026-11-20', 'Priya Sharma', 'Good communication skills', 'PASS'),
(2, 'Technical Round', '2026-11-21', 'Anil Rao', 'Good technical skills', 'PASS'),
(4, 'Technical Round', '2026-11-22', 'Kiran Reddy', 'Strong problem solving', 'PASS'),
(5, 'HR Round', '2026-11-23', 'Sneha Rao', 'Communication needs improvement', 'PENDING'),
(6, 'Technical Round', '2026-11-24', 'Arun Kumar', 'Excellent coding skills', 'PASS'),
(8, 'Technical Round', '2026-11-24', 'Vijay Kumar', 'Good subject knowledge', 'PASS'),
(10, 'HR Round', '2026-11-25', 'Meena Devi', 'Interview evaluation pending', 'PENDING');

INSERT INTO Offers
(application_id, offer_date, package_lpa, joining_date, offer_status)
VALUES
(1, '2026-11-21', 3.50, '2027-01-15', 'ACCEPTED'),
(4, '2026-11-22', 4.50, '2027-02-01', 'PENDING'),
(6, '2026-11-23', 6.00, '2027-01-20', 'ACCEPTED'),
(8, '2026-11-24', 4.00, '2027-02-15', 'REJECTED');

-- Verify inserted row counts
SELECT 'Departments' AS table_name, COUNT(*) AS total_records FROM Departments
UNION ALL SELECT 'Students', COUNT(*) FROM Students
UNION ALL SELECT 'Companies', COUNT(*) FROM Companies
UNION ALL SELECT 'Job_Roles', COUNT(*) FROM Job_Roles
UNION ALL SELECT 'Applications', COUNT(*) FROM Applications
UNION ALL SELECT 'Assessments', COUNT(*) FROM Assessments
UNION ALL SELECT 'Interviews', COUNT(*) FROM Interviews
UNION ALL SELECT 'Offers', COUNT(*) FROM Offers;
