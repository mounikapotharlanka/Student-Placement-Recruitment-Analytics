-- Step 9: Triggers from the project document
USE StudentPlacementDB;

DROP TRIGGER IF EXISTS ValidateStudentEligibility;
DROP TRIGGER IF EXISTS ValidateAssessmentScore;
DROP TRIGGER IF EXISTS MarkApplicationSelected;

DELIMITER //

-- Trigger 1: Check student eligibility and job status before application insert
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
    ELSEIF v_cgpa < v_min_cgpa OR v_backlogs > v_max_backlogs THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Student does not meet job eligibility';
    END IF;
END //

-- Trigger 2: Validate assessment score before insert
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

-- Trigger 3: Mark application SELECTED when its offer becomes ACCEPTED
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

-- Verify trigger creation
SHOW TRIGGERS;
