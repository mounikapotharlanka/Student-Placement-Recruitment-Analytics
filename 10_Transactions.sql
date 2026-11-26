-- Step 10: Transaction examples
-- This section is an additional practical section; transaction commands
-- are not included in the supplied project document.
USE StudentPlacementDB;

-- Example 1: Commit a valid CGPA update
START TRANSACTION;

UPDATE Students
SET cgpa = 8.95
WHERE roll_number = '22CSE005';

SELECT student_name, roll_number, cgpa
FROM Students
WHERE roll_number = '22CSE005';

COMMIT;

-- Example 2: Demonstrate ROLLBACK (the update is cancelled)
START TRANSACTION;

UPDATE Students
SET cgpa = 7.00
WHERE roll_number = '22CSE005';

SELECT student_name, roll_number, cgpa
FROM Students
WHERE roll_number = '22CSE005';

ROLLBACK;

-- Confirm the committed CGPA remains after rollback
SELECT student_name, roll_number, cgpa
FROM Students
WHERE roll_number = '22CSE005';

-- Example 3: Use a SAVEPOINT
START TRANSACTION;

UPDATE Students
SET cgpa = 8.90
WHERE roll_number = '22CSE005';

SAVEPOINT after_cgpa_update;

UPDATE Students
SET active_backlogs = 1
WHERE roll_number = '22CSE005';

ROLLBACK TO SAVEPOINT after_cgpa_update;

COMMIT;

-- Verify final student details
SELECT student_name, roll_number, cgpa, active_backlogs
FROM Students
WHERE roll_number = '22CSE005';
