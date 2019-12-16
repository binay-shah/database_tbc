DROP TABLE DEPT CASCADE CONSTRAINTS ; 
DROP TABLE EMP CASCADE CONSTRAINTS ; 
DROP TABLE SALGRADE CASCADE CONSTRAINTS ; 

--commands to create tables
CREATE TABLE DEPT ( 
  DEPTNO  NUMBER (2) , 
  DNAME   VARCHAR2 (14), 
  LOC     VARCHAR2 (13), 
  CONSTRAINT PK_DEPT  PRIMARY KEY ( DEPTNO )); 
  
CREATE TABLE EMP ( 
  EMPNO     NUMBER (4) , 
  ENAME     VARCHAR2 (10), 
  JOB       VARCHAR2 (9), 
  MGR       NUMBER (4), 
  HIREDATE  DATE, 
  SAL       NUMBER (7,2), 
  COMM      NUMBER (7,2), 
  DEPTNO    NUMBER (2) REFERENCES dept (DEPTNO), 
  CONSTRAINT PK_EMP PRIMARY KEY ( EMPNO ));
  
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

