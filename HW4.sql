/*--- Create Table Statements---*/
CREATE TABLE Emp (
    eid INTEGER,
    ename CHAR(255),
    age INTEGER,
    salary FLOAT,
    PRIMARY KEY (eid)
);
CREATE TABLE Dept (
    did INTEGER,
    dname CHAR(255),
    budget FLOAT,
    managerid INTEGER,
    PRIMARY KEY (did),
    FOREIGN KEY (managerid) REFERENCES Emp (eid)
);
CREATE TABLE Works (
    eid INTEGER,
    did INTEGER,
    pct_time INTEGER,
    PRIMARY KEY (eid, did),
    FOREIGN KEY (eid) REFERENCES Emp (eid),
    FOREIGN KEY (did) REFERENCES Dept (did)
);


/*--Query One--*/
SELECT ename, age From Emp, Dept, Works 
WHERE Works.eid = emp.eid AND Dept.did = Works.did AND Dept.dname = 'Software' 
Intersect 
SELECT ename, age From Emp, Dept, Works 
WHERE Works.eid = emp.eid AND Dept.did = Works.did AND Dept.dname = 'Hardware';


/*Query 2*/
SELECT did, Count(eid) AS numEmployees 
FROM Works 
GROUP BY did 
HAVING Sum(pct_time)>=1000; 

/*Query 3*/
SELECT ename 
from Emp 
WHERE Emp.eid NOT IN
(Select Works.eid 
From Works, Dept, Emp 
WHERE Works.did = Dept.did AND Emp.salary <= Dept.budget);


/*Query 4*/
SELECT managerid 
from Dept 
WHERE managerid NOT IN 
(SELECT Dept.managerid FROM Dept WHERE Dept.budget<1000000.00);

/*Query 5*/
SELECT ename
FROM Emp
WHERE eid IN (
    SELECT managerID
    FROM Dept
    WHERE budget = (SELECT MAX(budget) FROM Dept)
);
