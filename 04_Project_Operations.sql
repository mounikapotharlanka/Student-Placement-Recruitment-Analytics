-- Step 4: Project operations from the document
-- The original operations have been adjusted to use the actual records/IDs
-- shown in your MySQL execution file.
USE StudentPlacementDB;

-- Operation 1: Register Nikhil Kumar (insert only if not already present)
INSERT INTO Students
(roll_number, student_name, email, phone, department_id, cgpa, active_backlogs, graduation_year)
SELECT '22CSE005', 'Nikhil Kumar', 'nikhil@example.com', '9876500011', 1, 8.60, 0, 2026
WHERE NOT EXISTS (SELECT 1 FROM Students WHERE roll_number = '22CSE005');

-- Operation 2: Register Tech Mahindra (insert only if not already present)
INSERT INTO Companies
(company_name, industry, location, contact_email, website)
SELECT 'Tech Mahindra', 'IT Services', 'Hyderabad',
       'hr@techmahindra.example', 'https://www.techmahindra.com'
WHERE NOT EXISTS (SELECT 1 FROM Companies WHERE company_name = 'Tech Mahindra');

-- Operation 3: Add Software Engineer role (insert only if not already present)
SET @tech_company_id = (
    SELECT company_id FROM Companies WHERE company_name = 'Tech Mahindra' LIMIT 1
);
INSERT INTO Job_Roles
(company_id, role_title, job_type, location, min_cgpa, max_backlogs,
 package_lpa, application_deadline, job_status)
SELECT @tech_company_id, 'Software Engineer', 'Full-Time', 'Hyderabad',
       7.00, 0, 5.00, '2026-12-30', 'OPEN'
WHERE NOT EXISTS (
    SELECT 1 FROM Job_Roles
    WHERE company_id = @tech_company_id AND role_title = 'Software Engineer'
);

-- Operation 4: Update Nikhil's CGPA
UPDATE Students
SET cgpa = 8.90
WHERE roll_number = '22CSE005';

-- Operation 5: Nikhil applies for the Software Engineer role
SET @nikhil_id = (SELECT student_id FROM Students WHERE roll_number = '22CSE005' LIMIT 1);
SET @software_role_id = (
    SELECT job_role_id FROM Job_Roles
    WHERE company_id = @tech_company_id AND role_title = 'Software Engineer'
    LIMIT 1
);
INSERT INTO Applications (student_id, job_role_id, application_date, application_status)
SELECT @nikhil_id, @software_role_id, CURRENT_DATE, 'APPLIED'
WHERE NOT EXISTS (
    SELECT 1 FROM Applications
    WHERE student_id = @nikhil_id AND job_role_id = @software_role_id
);

-- Get the actual application ID for Nikhil's application
SET @nikhil_application_id = (
    SELECT application_id FROM Applications
    WHERE student_id = @nikhil_id AND job_role_id = @software_role_id
    LIMIT 1
);

-- Operation 6: Shortlist the application
UPDATE Applications
SET application_status = 'SHORTLISTED'
WHERE application_id = @nikhil_application_id;

-- Operation 7: Record aptitude assessment (insert only if not already present)
INSERT INTO Assessments (application_id, assessment_type, assessment_date, score, result)
SELECT @nikhil_application_id, 'Aptitude Test', CURRENT_DATE, 85.00, 'PASS'
WHERE NOT EXISTS (
    SELECT 1 FROM Assessments
    WHERE application_id = @nikhil_application_id
      AND assessment_type = 'Aptitude Test'
);

-- Operation 8: Schedule technical interview (insert only if not already present)
INSERT INTO Interviews
(application_id, interview_round, interview_date, interviewer_name, feedback, result)
SELECT @nikhil_application_id, 'Technical Round', '2026-12-05',
       'Mr. Raj', 'Good technical knowledge', 'PENDING'
WHERE NOT EXISTS (
    SELECT 1 FROM Interviews
    WHERE application_id = @nikhil_application_id
      AND interview_round = 'Technical Round'
);

-- Operation 9: Update the technical interview result
UPDATE Interviews
SET result = 'PASS',
    feedback = 'Excellent technical performance'
WHERE application_id = @nikhil_application_id
  AND interview_round = 'Technical Round';

-- Operation 10: Issue an offer (insert only if not already present)
INSERT INTO Offers
(application_id, offer_date, package_lpa, joining_date, offer_status)
SELECT @nikhil_application_id, CURRENT_DATE, 6.00, '2027-01-15', 'PENDING'
WHERE NOT EXISTS (
    SELECT 1 FROM Offers WHERE application_id = @nikhil_application_id
);

-- Operation 11: Accept the offer
UPDATE Offers
SET offer_status = 'ACCEPTED'
WHERE application_id = @nikhil_application_id;

-- Operation 12: Close the Assistant System Engineer opportunity (job_role_id 1)
UPDATE Job_Roles
SET job_status = 'CLOSED'
WHERE job_role_id = 1;

-- Operation 13: Withdraw application_id 3, as in the document
UPDATE Applications
SET application_status = 'WITHDRAWN'
WHERE application_id = 3;

-- Operation 14: Delete the unwanted test student only if it exists
-- Your execution file showed that TEST001 was not present, so this normally deletes 0 rows.
DELETE FROM Students
WHERE roll_number = 'TEST001';

-- Verify the key operation records
SELECT * FROM Students WHERE roll_number = '22CSE005';
SELECT * FROM Companies WHERE company_name = 'Tech Mahindra';
SELECT * FROM Job_Roles WHERE role_title = 'Software Engineer';
SELECT * FROM Applications WHERE application_id = @nikhil_application_id;
SELECT * FROM Assessments WHERE application_id = @nikhil_application_id;
SELECT * FROM Interviews WHERE application_id = @nikhil_application_id;
SELECT * FROM Offers WHERE application_id = @nikhil_application_id;
