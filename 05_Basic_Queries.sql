-- Step 5: Basic SQL queries
-- NOTE: This separate Basic Queries section is an additional practice/reporting section.
USE StudentPlacementDB;

-- 1. Display all students
SELECT * FROM Students;

-- 2. Display student names, roll numbers and CGPA
SELECT student_name, roll_number, cgpa
FROM Students;

-- 3. Students with CGPA greater than 8.00
SELECT student_name, roll_number, cgpa
FROM Students
WHERE cgpa > 8.00;

-- 4. Students with no active backlogs
SELECT student_name, roll_number, active_backlogs
FROM Students
WHERE active_backlogs = 0;

-- 5. Students ordered by CGPA (highest first)
SELECT student_name, roll_number, cgpa
FROM Students
ORDER BY cgpa DESC;

-- 6. Top 5 students by CGPA
SELECT student_name, roll_number, cgpa
FROM Students
ORDER BY cgpa DESC
LIMIT 5;

-- 7. Count the total number of students
SELECT COUNT(*) AS total_students
FROM Students;

-- 8. Average CGPA of students
SELECT ROUND(AVG(cgpa), 2) AS average_cgpa
FROM Students;

-- 9. Number of students in each department
SELECT department_id, COUNT(*) AS total_students
FROM Students
GROUP BY department_id;

-- 10. Departments having more than one student
SELECT department_id, COUNT(*) AS total_students
FROM Students
GROUP BY department_id
HAVING COUNT(*) > 1;

-- 11. Display all open job roles
SELECT role_title, location, package_lpa, application_deadline
FROM Job_Roles
WHERE job_status = 'OPEN';

-- 12. Job roles with package greater than or equal to 5 LPA
SELECT role_title, package_lpa
FROM Job_Roles
WHERE package_lpa >= 5.00
ORDER BY package_lpa DESC;

-- 13. Count applications by status
SELECT application_status, COUNT(*) AS total_applications
FROM Applications
GROUP BY application_status;

-- 14. Count offers by status
SELECT offer_status, COUNT(*) AS total_offers
FROM Offers
GROUP BY offer_status;
