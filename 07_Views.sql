-- Step 7: Views from the project document
USE StudentPlacementDB;

CREATE OR REPLACE VIEW Student_Department_View AS
SELECT s.student_id, s.roll_number, s.student_name,
       d.department_name, s.cgpa, s.active_backlogs
FROM Students s
INNER JOIN Departments d
ON s.department_id = d.department_id;

CREATE OR REPLACE VIEW Company_Job_View AS
SELECT c.company_name, j.role_title, j.job_type, j.location,
       j.package_lpa, j.application_deadline, j.job_status
FROM Companies c
INNER JOIN Job_Roles j
ON c.company_id = j.company_id;

CREATE OR REPLACE VIEW Application_Tracking_View AS
SELECT a.application_id, s.student_name, s.roll_number,
       c.company_name, j.role_title,
       a.application_date, a.application_status
FROM Applications a
INNER JOIN Students s ON a.student_id = s.student_id
INNER JOIN Job_Roles j ON a.job_role_id = j.job_role_id
INNER JOIN Companies c ON j.company_id = c.company_id;

CREATE OR REPLACE VIEW Placement_Offer_View AS
SELECT s.student_name, s.roll_number, c.company_name,
       j.role_title, o.package_lpa, o.offer_date,
       o.joining_date, o.offer_status
FROM Offers o
INNER JOIN Applications a ON o.application_id = a.application_id
INNER JOIN Students s ON a.student_id = s.student_id
INNER JOIN Job_Roles j ON a.job_role_id = j.job_role_id
INNER JOIN Companies c ON j.company_id = c.company_id;

-- View outputs: run these SELECT statements to see the saved views
SELECT * FROM Student_Department_View;
SELECT * FROM Company_Job_View;
SELECT * FROM Application_Tracking_View;
SELECT * FROM Placement_Offer_View;
