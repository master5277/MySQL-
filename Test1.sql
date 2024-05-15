#第03章_基本的SELECT语句
#1.SQL的分类
/*
DDL:数据定义语言。CREATE\ALTER\DROP\RENAME\TRUNCATE(清空)

DML:数据操作语言。INSERT\DELETE\UPDATE\SELECT

DCL:数据控制语言。 COMMIT\ROLLBACK\SAVEPOINT\GRANT\REVOKE

学习技巧：大处着眼，小处着手
*/


#SQL语言的规则和规范
USE dbtest1;
SELECT * FROM employees;


INSERT INTO employees VALUES(1002,'Tom');
#select * from employees\g
SHOW CREATE TABLE employees;
-- 单行注释
-- --之后有一个空格
#导入现有的数据表，表的数据

SELECT 1;
SELECT 1+1,3+2;

SELECT 1+1,3+2
FROM DUAL;#dual:伪表

#*:表中所有的字段（或列）
SELECT * FROM employees;

SELECT employee_id,last_name,salary FROM employees;

SELECT employee_id,last_name,salary
FROM employees;


#列的别名
#as:全称：alias(别名)，可以省略；
#列的别名使用一对“”（双引号）引起来，不要使用''(单引号)
SELECT employee_id,last_name,department_id
FROM employees;

SELECT employee_id emp_id,last_name AS lname,department_id dept_id
FROM employees;

SELECT employee_id emp_id,last_name AS lname,department_id "dept_id"
FROM employees;

SELECT employee_id emp_id,last_name AS lname,department_id "部门id"
FROM employees;

SELECT employee_id emp_id,last_name AS lname,department_id "部门id",salary*12 annual_sal
FROM employees;

/*
SELECT employee_id emp_id,last_name AS lname,department_id "部门id",salary*12 annual sal
FROM employees;
*/

SELECT employee_id emp_id,last_name AS lname,department_id "部门id",salary*12 AS "annual sal"
FROM employees;
#去除重复行
#查询员工表中一共由那些部门id呢？
SELECT DISTINCT department_id FROM employees;

#错误的
#Select salary,distinct department_id from employees;
SELECT DISTINCT department_id,salary FROM employees;

#空值参与运算
#空值：null
#null不等同于0,'','null'
#空值参与运算，结果一定也为空；
SELECT * FROM employees;
SELECT employee_id,salary  "月工资",salary*(1+commission_pct)*12 "年工资",commission_pct
FROM employees;