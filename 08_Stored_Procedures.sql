-- Step 8: Stored procedures
-- The document contains two complete procedure definitions.
-- The first procedure heading mentions an IN parameter, but its actual
-- definition uses an OUT parameter. This file follows the SQL definition.

USE StudentPlacementDB;

DROP PROCEDURE IF EXISTS GetTotalApplications;
DELIMITER //

CREATE PROCEDURE GetTotalApplications(
    OUT p_total INT
)
BEGIN
    SELECT COUNT(*)
    INTO p_total
    FROM Applications;
END //

DELIMITER ;

-- Procedure 3 in the document: Update Application Status (INOUT parameter)
DROP PROCEDURE IF EXISTS UpdateApplicationStatus;
DELIMITER //

CREATE PROCEDURE UpdateApplicationStatus(
    IN p_application_id INT,
    INOUT p_status VARCHAR(20)
)
BEGIN
    UPDATE Applications
    SET application_status = p_status
    WHERE application_id = p_application_id;

    SELECT application_status
    INTO p_status
    FROM Applications
    WHERE application_id = p_application_id;
END //

DELIMITER ;

-- Test Procedure 1 (OUT parameter)
CALL GetTotalApplications(@total_applications);
SELECT @total_applications AS total_applications;

-- Test Procedure 3 (INOUT parameter)
SET @new_status = 'SHORTLISTED';
CALL UpdateApplicationStatus(13, @new_status);
SELECT @new_status AS updated_application_status;
