DROP TABLE QUIZ_QUESTIONS;
DROP TABLE DEPT CASCADE CONSTRAINTS ; 
DROP TABLE EMP CASCADE CONSTRAINTS ; 
DROP TABLE SALGRADE CASCADE CONSTRAINTS ; 

--commands to create tables
CREATE TABLE DEPT ( 
  DEPTNO  NUMBER (2) , 
  DNAME   VARCHAR2 (14), 
  LOC     VARCHAR2 (13), 
  CONSTRAINT PK_DEPT5  PRIMARY KEY ( DEPTNO )); 
  
CREATE TABLE EMP ( 
  EMPNO     NUMBER (4) , 
  ENAME     VARCHAR2 (10), 
  JOB       VARCHAR2 (9), 
  MGR       NUMBER (4), 
  HIREDATE  DATE, 
  SAL       NUMBER (7,2), 
  COMM      NUMBER (7,2), 
  DEPTNO    NUMBER (2) REFERENCES dept (DEPTNO), 
  CONSTRAINT PK_EMP5 PRIMARY KEY ( EMPNO ));
  
CREATE TABLE SALGRADE ( 
  GRADE  NUMBER, 
  LOSAL  NUMBER, 
  HISAL  NUMBER);


-- insert data into dept, emp and salgrade, note salgrade is not linked to emp and dept, however dept is a FK in emp

INSERT INTO   DEPT (DEPTNO, DNAME,  LOC) VALUES (10, 'ACCOUNTING', 'NEW YORK');
 INSERT INTO   DEPT (DEPTNO, DNAME,  LOC) VALUES (20, 'RESEARCH', 'DALLAS');
 INSERT INTO   DEPT (DEPTNO, DNAME,  LOC) VALUES (30,'SALES', 'CHICAGO');
 INSERT INTO   DEPT (DEPTNO, DNAME,  LOC) VALUES (40,'OPERATIONS',  'BOSTON');


    INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7369, 'SMITH', 'CLERK ', 7902, '12/17/80',  800, null, 20);
    INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7499, 'ALLEN',  'SALESMAN', 7698, '02/20/81',1600, 300, 30);
    INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7521, 'WARD',   'SALESMAN', 7698, '02/22/81', 1250, 500, 30);
    INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7566, 'JONES',  'MANAGER',   7839, '04/02/81',  2975, null, 20);
    INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES ( 7654, 'MARTIN','SALESMAN', 7698, '09/28/81',  1250, 1400, 30);
    INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES ( 7698, 'BLAKE',  'MANAGER',  7839, '05/01/81',  2850, null, 30);
    INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7782, 'CLARK',  'MANAGER',  7839, '06/09/81',   2450, null, 10);
    INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7788, 'SCOTT',  'ANALYST',  7566, '04/19/87',  3000, null, 20);
    INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES ( 7839, 'KING',  'PRESIDENT', null, '11/17/81',  5000, null, 10);
    INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES ( 7844, 'TURNER','SALESMAN', 7698, '09/08/81',  1500,  0,  30);
    INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES ( 7876, 'ADAMS', 'CLERK',    7788, '05/23/87',  1100,  null, 20);
    INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES ( 7900, 'JAMES', 'CLERK',    7698, '12/03/81',  950,   null, 30);
    INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES ( 7902, 'FORD',  'ANALYST',  7566, '12/03/81',  3000,  null, 20);
    INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES ( 7934, 'MILLER','CLERK',    7782, '01/03/82',   1300 , null, 10);


    INSERT INTO salgrade(GRADE, LOSAL,HISAL) VALUES (1,       700,      1200);
    INSERT INTO salgrade(GRADE, LOSAL,HISAL) VALUES (2,      1201,      1400);
    INSERT INTO salgrade(GRADE, LOSAL,HISAL) VALUES (3,      1401,      2000);
    INSERT INTO salgrade(GRADE, LOSAL,HISAL) VALUES (4,      2001,      3000);
    INSERT INTO salgrade(GRADE, LOSAL,HISAL) VALUES (5,      3001,      9999);

-- this command will add FK constraint to emp table, based on the recursive relationship
ALTER TABLE emp ADD CONSTRAINT fk_manager FOREIGN KEY (mgr)REFERENCES emp(empno);

-- this command is to create and drop sequences for PK columns in emp and dept tables
DROP sequence dept_seq;
CREATE sequence dept_seq start with 50;
DROP sequence emp_seq;
CREATE sequence emp_seq start with 8000;

COMMIT;
create or replace trigger emp_T1
BEFORE insert on emp
for each row
begin
IF :NEW.empno  IS NULL THEN
SELECT emp_SEQ.NEXTVAL INTO :NEW.empno FROM SYS.DUAL;
END IF;
end;
/
commit;

create or replace trigger dept_T1
BEFORE
insert on dept
for each row
begin
  if :NEW.deptno is null then 
    select dept_SEQ.nextval into :NEW.deptno from sys.dual; 
  end if; 
end;
/
commit;

/

CREATE TABLE QUIZ_QUESTIONS (
question_no NUMBER(10) PRIMARY KEY,
q_type VARCHAR2(200),
challenge VARCHAR2(1000),
sugg_solution VARCHAR2(1000)
);
COMMIT;

REM INSERTING into QUIZ_QUESTIONS

-- SECTION 1 Basic and Intermediate SQL

Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (1,'Basic','Select all the information from the salgrade table','SELECT * FROM salgrade;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (2,'Basic','Select all information from the emp table','select * from emp;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (3,'Basic','List all employees who have a salary between 1000 and 2000.','SELECT ename, deptno, sal FROM emp WHERE sal between 1000 and 2000;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (4,'Basic','List department numbers and names in department name order','select deptno, dname
from dept order by dname;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (5,'Basic','Display all different job types','select distinct job from emp;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (6,'Intermediate','List the details of the employees in departments 10 and 20  in alphabetical order of name','select * from emp where deptno in (10,20) order by ename;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (7,'Basic','List names and jobs of all clerks in department 20','select ename, job
from emp
where job = ''CLERK''
and deptno = 20;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (8,'Intermediate','Display all employees names which have TH or LL in them','select ename
from emp
where ename like ''%TH%''
or    ename like ''%LL%'';');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (9,'Intermediate','List the employee name, job and salary for all employees who have a manager','select ename, job, sal
from emp
where mgr is not null;');

Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (10,'Intermediate','Display all employees who were hired during 1981.','select ename, hiredate from emp where hiredate like ''%81'';');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (11,'Intermediate','Display name, annual salary and commission of all salesmen whose monthly salary is greater than their commission. The output should be ordered by salary, highest first, and then if two or more employees have the same salary, by employee name.','select ename, sal*12 annual_sal, comm
from  emp
where sal> comm
order by sal desc, ename;');

Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (12,'Basic','Select the employee name and job as one column, like SMITHCLERK ...','select ename||job as employee_job from emp;');

--Challenge your skills with these:

Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (13,'Intermediate','Select data so that the output for all employees reads like SMITH has held the position of CLERK in DEPT 20 since 13-JUN-83
','select  ename||
	'' has held the position of ''||
	job ||
	'' in dept ''||
	deptno||
	'' since ''||
	hiredate "who,what and when"
from emp;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (14,'Intermediate','Display all employee information in ascending order of manager number. King must be last.','select *
from emp
order by nvl(mgr,9999);');


-- SECTION 2 Simple Joins
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (15,'Basic-Simple Joins','Display all employee names and their department name','select ename, dname
from emp, dept
where emp.deptno = dept.deptno;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (16,'Basic-Simple Joins','Display all employee names, department number and name.','select ename, e.deptno, dname
from   emp e, dept d
where e.deptno = d.deptno;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (17,'Basic-Simple Joins','Display employee names, location and department whose salary is more than 1500 a month.','select  ename, loc location, dname
from	emp, dept
where	emp.deptno = dept.deptno
and	sal >1500;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (18,'Intermediate-Simple Joins','Produce a list showing employees salary grades.
','select  ename, job, sal, grade
from	emp, salgrade
where	sal between losal and hisal;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (19,'Intermediate-Simple Joins','Show only employees on Grade 3.','select  ename, job, sal, grade
from	emp, salgrade
where	sal between losal and hisal
and	grade = 3;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (20,'Basic-Simple Joins','Show all employees in Dallas.','select  ename, sal, loc location
from	emp, dept
where	emp.deptno = dept.deptno
and	loc = ''DALLAS'';');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (21,'Intermediate-Simple Joins','List employee name, job, salary, grade and department name for everyone in the company except clerks, sort on salary highest first.','select  ename, job, sal, grade, dname
from	emp, salgrade, dept
where	emp.deptno = dept.deptno
and	sal between losal and hisal
and	job != ''CLERK''
order by sal desc;');

-- SECTION 3 Group Functions 

Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (22,'Intermediate-Group Functions','Find the minimum salary of all employees','select min(sal) minimum
from emp;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (23,'Intermediate-Group Functions','Find the minimum, maximum, and average salaries of all employees','select  max(sal), min(sal), avg(sal)
from emp;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (24,'Intermediate-Group Functions','List the minimum and maximum salary for each job type.','select  job,
	max(sal) maximum,
	min(sal) minimum
from emp
group by job;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (25,'Intermediate-Group Functions','Find out how many managers there are without listing them.','select count(*) empno from emp where job= ''MANAGER'';');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (26,'Advanced-Group Functions','Find the average salary and average total remuneration for each job type. Remember salesmen earn commission.','select  job,
	avg(sal) avsal,
	avg(sal*12+nvl(comm,0)) avcomp
from	emp
group by job;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (27,'Intermediate-Group Functions','Find the difference between the highest and lowest salaries.','select  max(sal) - min(sal) difference
from emp;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (28,'Advanced-Group Functions','Find all departments which have more than 3 employees.','select  deptno, count(*)
from	emp
group by deptno
having  count(*) > 3;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (29,'Advanced-Group Functions','Check whether all employee numbers are indeed unique.','select  empno
from	emp
group by empno
having count(*) > 0;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (30,'Advanced-Group Functions','List lowest paid employees working for each manager. Exclude any groups where the salary is less than 1000. Sort the output by salary.','select          mgr, min(sal)
from	        emp
group by        mgr
having          min(sal) > 1000
order by min(sal);');

-- SECTION 4  SQL using Functions 

Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (31,'Advanced','Display name and total remuneration of all employees','select ename, sal*12+nvl(comm,0) remuneration from emp;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (32,'Intermediate-Using Functions','List the employee name and salary increased by 15% and expressed as a whole number.','select deptno, ename, round(sal*1.15) pctsal
from emp;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (33,'Advanced-Using Functions','Display employee name with hiredate, and their salary reviewdate. Assume that the review date is one year after the hiredate.
','select  ename, hiredate,add_months(hiredate,12) review from emp
order by add_months(hiredate,12);');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (34,'Advanced-Using Functions','Display a list of all employees with an identifier which is a composite of the first two characters of their job, the middle two digits of their employee number and soundex code of their name.i.e.
SMITH	CL36S530
ALLEN	SA49A450
','select  ename name,
	substr(job,1,2)||
	substr(empno,2,2)||
	soundex(ename) code
from emp;');

-- SECTION 5 Other Join Methods
-- no question 35 :)

Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (36,'Intermediate-Other Join Methods','Display the department that has no employees
','select  d.deptno, dname
from	emp e, dept d
where	e.deptno(+) = d.deptno
and	e.empno is null;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (37,'Intermediate-Other Join Methods','List all employees by name and number along with their manager''s name and number.','select  emps.empno,
	emps.ename,
	mgrs.empno mgrno,
	mgrs.ename mgr_name
from	emp emps, emp mgrs
where	emps.mgr = mgrs.empno;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (38,'Intermediate-Other Join Methods', 'Modify previous solution to the question to display KING who has no manager.
','select  emps.empno,
	emps.ename,
	mgrs.empno mgrno,
	mgrs.ename mgr_name
from	emp emps, emp mgrs
where	emps.mgr = mgrs.empno(+);');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (39,'Intermediate-Other Join Methods','Find any jobs that were filled in the first half of 1981 and were also filled during the same period 1984.','select  job
from	emp
where	hiredate between ''01-jan-81'' and ''30-jun-81''
union
select  job
from	emp
where	hiredate between ''01-Jan-84'' and ''30-JUN-84'';');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (40,'Intermediate-Other Join Methods','Find all employees who joined the company before their manager.','select  e.ename employee,
	e.hiredate,
	m.ename manager,
	m.hiredate
from	emp e, emp m
where	e.mgr = m.empno
and	e.hiredate < m.hiredate;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (41,'Intermediate-Other Join Methods','Display those who manage employees in either department 10 or 20. Order by manager number.','select  mgr
from	emp
where	deptno = 10
union   
select  mgr
from	emp
where	deptno = 20
order by 1;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (42,'Intermediate-Other Join Methods','Find another query method to display the department that has no employees.','select  deptno, dname
from	dept
minus
select  emp.deptno, dname
from	emp, dept
where	emp.deptno = dept.deptno;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (43,'Intermediate-Other Join Methods','Find the names of those who manage employees of grade 1,2 and 3 only.
','select  m.ename
from	emp w,emp m,salgrade
where	w.mgr   = m.empno
and	w.sal between losal and hisal
and	grade = 1
intersect
select  m.ename
from	emp w, emp m, salgrade
where	w.mgr = m.empno
and	w.sal between losal and hisal
and	grade = 2
intersect
select  m.ename
from	emp w, emp m, salgrade
where	w.mgr = m.empno
and	w.sal between losal and hisal
and	grade = 3
minus
select  m.ename
from	emp w, emp m, salgrade
where	w.mgr = m.empno
and	w.sal between losal and hisal
and	grade in (4,5);');


-- SECTION 6 Advance Query Techniques

Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (44,'Advance Query Techniques','Find the employee(s) who earn the highest salary in each job type.
','select  job, ename, sal
from	emp
where	sal in ( select max(sal)
		from emp
		group by job)
order by sal desc;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (45,'Advance Query Techniques','Find the employees who earn the minimum salary for their job. Display the result in ascending order of salary','select  ename, job, sal
from	emp
where	sal in (select min(sal)
	from emp
	group by job)
order by sal desc;');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (46,'Advance Query Techniques','Find the most recently hired employees in each department.
','select  deptno, ename, hiredate
from	emp
where	(hiredate, deptno) in
(select max(hiredate), deptno from emp
		group by deptno);');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (47,'Advance Query Techniques','Show the following details for any employee who earns a salary greater than the average for their department:

employee name, salary, department no.
','select  ename, sal salary, deptno
from	emp e
where	sal > (select avg(sal)
from   emp
	where deptno = e.deptno);');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (48,'Advance Query Techniques','List all the departments where there are no employees (using a subquery this time).','select  deptno, dname
from	dept
where	deptno not in
(select deptno from emp);');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (49,'Advance Query Techniques','Who works for the Sales Department, but is not a SALESMAN?
','select  ename, job, sal
from	emp
where	job != ''SALESMAN''
and	deptno in ( select deptno
			from dept
			where dname = ''SALES'');');
Insert into QUIZ_QUESTIONS (QUESTION_NO,Q_TYPE,CHALLENGE,SUGG_SOLUTION) values (50,'Advance Query Techniques','Who are the top three earners in the company? Display their names and salaries','select  ename, sal
from	emp e
where	3 > (select count(*)
		from emp
		where e.sal < sal );');

