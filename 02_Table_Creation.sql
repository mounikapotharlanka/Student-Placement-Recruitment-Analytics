-- Step 2: Create all 8 tables
USE StudentPlacementDB;

CREATE TABLE IF NOT EXISTS Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL,
    department_code VARCHAR(20) NOT NULL UNIQUE,
    hod_name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    roll_number VARCHAR(30) NOT NULL UNIQUE,
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    department_id INT NOT NULL,
    cgpa DECIMAL(3,2) NOT NULL,
    active_backlogs INT DEFAULT 0,
    graduation_year INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    CHECK (cgpa BETWEEN 0 AND 10),
    CHECK (active_backlogs >= 0)
);

CREATE TABLE IF NOT EXISTS Companies (
    company_id INT PRIMARY KEY AUTO_INCREMENT,
    company_name VARCHAR(100) NOT NULL,
    industry VARCHAR(100),
    location VARCHAR(100),
    contact_email VARCHAR(100) UNIQUE,
    website VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Job_Roles (
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
    FOREIGN KEY (company_id) REFERENCES Companies(company_id),
    CHECK (min_cgpa BETWEEN 0 AND 10),
    CHECK (max_backlogs >= 0),
    CHECK (package_lpa IS NULL OR package_lpa >= 0),
    CHECK (job_status IN ('OPEN','CLOSED'))
);

CREATE TABLE IF NOT EXISTS Applications (
    application_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    job_role_id INT NOT NULL,
    application_date DATE NOT NULL,
    application_status VARCHAR(30) DEFAULT 'APPLIED',
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (job_role_id) REFERENCES Job_Roles(job_role_id),
    UNIQUE (student_id, job_role_id),
    CHECK (application_status IN
        ('APPLIED','SHORTLISTED','REJECTED','SELECTED','WITHDRAWN'))
);

CREATE TABLE IF NOT EXISTS Assessments (
    assessment_id INT PRIMARY KEY AUTO_INCREMENT,
    application_id INT NOT NULL,
    assessment_type VARCHAR(50) NOT NULL,
    assessment_date DATE,
    score DECIMAL(5,2),
    result VARCHAR(20),
    FOREIGN KEY (application_id) REFERENCES Applications(application_id),
    CHECK (score IS NULL OR score BETWEEN 0 AND 100),
    CHECK (result IS NULL OR result IN ('PASS','FAIL','PENDING'))
);

CREATE TABLE IF NOT EXISTS Interviews (
    interview_id INT PRIMARY KEY AUTO_INCREMENT,
    application_id INT NOT NULL,
    interview_round VARCHAR(50) NOT NULL,
    interview_date DATE,
    interviewer_name VARCHAR(100),
    feedback VARCHAR(255),
    result VARCHAR(20) DEFAULT 'PENDING',
    FOREIGN KEY (application_id) REFERENCES Applications(application_id),
    CHECK (result IN ('PASS','FAIL','PENDING'))
);

CREATE TABLE IF NOT EXISTS Offers (
    offer_id INT PRIMARY KEY AUTO_INCREMENT,
    application_id INT NOT NULL UNIQUE,
    offer_date DATE,
    package_lpa DECIMAL(8,2) NOT NULL,
    joining_date DATE,
    offer_status VARCHAR(20) DEFAULT 'PENDING',
    FOREIGN KEY (application_id) REFERENCES Applications(application_id),
    CHECK (package_lpa > 0),
    CHECK (offer_status IN ('ACCEPTED','REJECTED','PENDING'))
);

-- Verify table creation
SHOW TABLES;
