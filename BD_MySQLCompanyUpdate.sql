CREATE SCHEMA IF NOT EXISTS company_;
USE company_;

CREATE TABLE employee(
	Fname VARCHAR(15) NOT NULL,
	Minit CHAR,
	Lname VARCHAR(15) NOT NULL,
	Ssn CHAR(9) NOT NULL,
	Bdate DATE,
	Address VARCHAR(30),
	Sex CHAR,
	Salary DECIMAL(10,2),
	Super_ssn CHAR(9),
	Dno INT NOT NULL,
	CONSTRAINT chk_salary_employee CHECK (Salary> 2000.0), 
    CONSTRAINT pk_employee PRIMARY KEY (Ssn)
);

-- Alter table employee

ALTER TABLE employee
	ADD CONSTRAINT fk_employee
    FOREIGN KEY(Super_ssn) REFERENCES employee(Ssn)
    ON DELETE SET NULL
    ON UPDATE CASCADE;
-- ----------------------------------------------------------------

CREATE TABLE departament(
	Dname VARCHAR(15) NOT NULL,
    Dnumber INT NOT NULL,
    Mgr_ssn CHAR(9),
    Mgr_star_date DATE,
    Dept_create_date DATE,
    CONSTRAINT chk_date_dept CHECK (Dept_create_date < Mgr_star_date),
    CONSTRAINT pk_dept PRIMARY KEY (Dnumber),
    CONSTRAINT unique_name_dept UNIQUE(Dname),
	CONSTRAINT fk_dept FOREIGN KEY (Mgr_ssn) references employee(Ssn)
);

-- Alter table department 
ALTER TABLE departament DROP CONSTRAINT departament_ibfk_1;
ALTER TABLE departament
		ADD CONSTRAINT fk_MgrSsn_dept FOREIGN KEY (Mgr_ssn) REFERENCES employee(Ssn)
        on update cascade;
-- ----------------------------------------------------------------

CREATE TABLE dept_locations(
	Dnumber INT NOT NULL,
    Dlocation VARCHAR(15) NOT NULL,
    CONSTRAINT Pk_Dept_locations PRIMARY KEY(Dnumber, Dlocation),
    CONSTRAINT fk_Dept_locations FOREIGN KEY(Dnumber) REFERENCES departament(Dnumber)
);


CREATE TABLE project(
	Pname VARCHAR(15) NOT NULL,
    Pnumber INT NOT NULL,
    Plocation VARCHAR(15),
    Dnumber INT NOT NULL,
    PRIMARY KEY (Pnumber),
    CONSTRAINT unique_project UNIQUE (Pname),
    CONSTRAINT fk_project FOREIGN KEY (Dnumber) REFERENCES departament(Dnumber)
);

CREATE TABLE works_on(
	Essn CHAR(9) NOT NULL,
    Pno INT NOT NULL,
    Hours DECIMAL(3,1) NOT NULL,
    PRIMARY KEY (Essn, Pno),
    CONSTRAINT fk_employee_works_on FOREIGN KEY(Essn) REFERENCES employee (Ssn),
	CONSTRAINT fk_project_works_on FOREIGN KEY(Pno) REFERENCES project (Pnumber)
);

CREATE TABLE dependent(
	Essn char(9) NOT NULL,
    Dependent_name VARCHAR(15) NOT NULL,
    Sex CHAR, -- F ou M
    Bdate DATE,
    Relationship VARCHAR(8),
    Age int not null,
    CONSTRAINT chk_age_dependent check (Age < 22),
    CONSTRAINT pk_dependent PRIMARY KEY (Essn, Dependent_name),
    CONSTRAINT fk_dependent FOREIGN KEY(Essn) REFERENCES employee(Ssn)
);
