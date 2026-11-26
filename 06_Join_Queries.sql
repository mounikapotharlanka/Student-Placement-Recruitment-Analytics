-- Step 6: JOIN queries from the project document
USE StudentPlacementDB;

-- 1. INNER JOIN: Students and Departments
SELECT s.student_name, d.department_name
FROM Students s
INNER JOIN Departments d
ON s.department_id = d.department_id;

-- 2. INNER JOIN: Companies and Job Roles
SELECT c.company_name, j.job_role_id, j.role_title, j.job_type, j.package_lpa
FROM Companies c
INNER JOIN Job_Roles j
ON c.company_id = j.company_id;

-- 3. INNER JOIN: Students and Applications
SELECT s.student_name, s.roll_number, a.application_id,
       a.application_date, a.application_status
FROM Students s
INNER JOIN Applications a
ON s.student_id = a.student_id;

-- 4. INNER JOIN: Applications and Job Roles
SELECT a.application_id, a.student_id, j.role_title,
       j.package_lpa, a.application_status
FROM Applications a
INNER JOIN Job_Roles j
ON a.job_role_id = j.job_role_id;

-- 5. Three-table JOIN: Students, Applications and Job Roles
SELECT s.student_name, s.roll_number, j.role_title, j.package_lpa,
       a.application_date, a.application_status
FROM Students s
INNER JOIN Applications a ON s.student_id = a.student_id
INNER JOIN Job_Roles j ON a.job_role_id = j.job_role_id;

-- 6. Multiple-table JOIN: Student application and job details
SELECT s.student_name, s.roll_number, j.role_title,
       a.application_date, a.application_status
FROM Students s
INNER JOIN Applications a ON s.student_id = a.student_id
INNER JOIN Job_Roles j ON a.job_role_id = j.job_role_id;

-- 7. LEFT JOIN: All students and their applications
SELECT s.student_id, s.student_name, a.application_id, a.application_status
FROM Students s
LEFT JOIN Applications a
ON s.student_id = a.student_id;

-- 8. LEFT JOIN: Students without applications
SELECT s.student_id, s.student_name
FROM Students s
LEFT JOIN Applications a
ON s.student_id = a.student_id
WHERE a.application_id IS NULL;

-- 9. JOIN: Applications and Assessments
SELECT a.application_id, s.student_name,
       ass.assessment_type, ass.score, ass.result
FROM Applications a
INNER JOIN Students s ON a.student_id = s.student_id
INNER JOIN Assessments ass ON a.application_id = ass.application_id;

-- 10. Complete placement details
SELECT s.student_name, s.roll_number, d.department_name,
       j.role_title, c.company_name, a.application_status,
       o.package_lpa, o.offer_status
FROM Students s
INNER JOIN Departments d ON s.department_id = d.department_id
INNER JOIN Applications a ON s.student_id = a.student_id
INNER JOIN Job_Roles j ON a.job_role_id = j.job_role_id
INNER JOIN Companies c ON j.company_id = c.company_id
LEFT JOIN Offers o ON a.application_id = o.application_id;
