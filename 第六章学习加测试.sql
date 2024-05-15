#第六章：多表查询
#熟悉常见的几个表

DESC employees;

DESC departments;

DESC locations;

SELECT * 
FROM 
WHERE 

#查询员工名为'Abel‘的人在那个城市工作？
SELECT * 
FROM employees
WHERE last_name='Abel';

SELECT * 
FROM departments
WHERE department_id =80;

SELECT * 
FROM locations
WHERE location_id=2500;

#2.多表的查询如何实现？

#错误的方式；
SELECT employee_id,department_name
FROM employees,departments;#2889条记录


SELECT * 
FROM employees;#107条记录

SELECT 2889/107
FROM DUAL;

SELECT *
FROM departments;#27条记录
#笛卡尔积：交叉连接

#3.多表查询的正确方式：需要有连接条件
SELECT employee_id,department_name
FROM employees,departments
WHERE employees.`department_id`=departments.`department_id`;


SELECT employee_id,department_name
FROM employees,departments
WHERE employees.`department_id`<=>departments.`department_id`;

#如果查询语句中出现了多个表中都存在的字段，则必须指明此字段所在的表
SELECT employee_id,department_name,departments.`department_id`
FROM employees,departments
WHERE employees.`department_id`=departments.`department_id`;
#越严格，效率越高,指定查询哪一个表中的字段，可以使得查询效率更高
#建议：从sql优化的角度，建议多表查询时，每个字段前都指明其所在的表

#可以给表起别名，在select和where中使用表的别名。
#先执行from,执行之后就可以知道别名了
#执行的顺序时FROM->WHERE->SELECT

#可以给表起别名，在select 和where中使用表的别名

SELECT emp.`employee_id`,dept.`department_name`,emp.`department_id` 
FROM employees emp,departments dept
WHERE emp.`department_id`=dept.`department_id`;


#如果给表起了别名，一旦在select或where中使用表名的话，则必须使用表的别名，而不能使用表的别名
#如下的操作是错误的
SELECT emp.`employee_id`,departments.`department_name`,emp.`department_id`
FROM employees emp,departments dept
WHERE emp.`department_id`=departments.`department_id`


#练习
#查询员工的employee_id,last_name,department_name,city
SELECT employee_id,last_name,department_name,city
FROM employees,departments,locations
WHERE employees.`department_id`=departments.`department_id`
AND locations.`location_id`=departments.`location_id`;


#使用别名
SELECT e.employee_id,e.last_name,d.department_name,l.city
FROM employees e,departments d,locations l
WHERE e.`department_id`=d.`department_id`
AND d.`location_id`=l.`location_id`;

#如果有n个表实现多表的查询，则需要至少n-1个连接条件
/*
演绎式：提出问题1---》解决问题1---》提出问题2---》解决问题2
归纳式：总--分
*/

#7.多表查询的分类
/*
角度1:等值连接 vs 非等值连接

角度2;自连接 vs 非自连接

角度3：内连接  vs 外连接

*/

#7.1等值连接  vs  非等值连接
#非等值连接的例子：
SELECT *
FROM job_grades;

SELECT last_name,salary,j.grade_level
FROM employees e,job_grades j
WHERE e.`salary`BETWEEN j.`lowest_sal` AND j.`highest_sal`;
#between 下限 and 上限

SELECT e.last_name,e.`salary`,j.grade_level
FROM employees e,job_grades j
WHERE e.salary >=j.`lowest_sal` AND e.`salary`<=j.`highest_sal`;

#7.2 自连接  vs 非自连接

#挂掉，要指定是哪一个表的
SELECT employee_id,last_name,employee_id,last_name
FROM employees emp1,employees emp2
WHERE emp1.`manager_id`=emp2.`employee_id`; 

SELECT emp1.employee_id,emp1.last_name,emp2.employee_id,emp2.last_name
FROM employees emp1,employees emp2
WHERE emp1.`manager_id`=emp2.`employee_id`;

#7.3内连接  vs 外连接
#内连接：
#合并具有同一列的两个以上的表的行，结果集中不包含一个表与另一个表不匹配的行
SELECT employee_id,department_name
FROM employees e,departments d
WHERE e.`department_id`=d.`department_id`;

#外连接：
#外连接：合并具有同一列的两个以上的表的行，结果集中除了包含一个表与另一个表匹配的行
#        还查询到了左表或右表中不匹配的行。

#外连接的分类：左外连接，右外连接，满外连接
#左外连接：两个表在连接过程中除了返回满足连接条件的行以外还返回左表中不满足条件的行
#右外连接：两个表在连接过程中除了返回满足连接条件的行以外还返回右表中不满足条件的行
#满外连接：两个表在连接过程中除了返回满足连接条件的行以外还返回左右表中不满足条件的行

#练习：查询所有的员工的last_name,department_name

SELECT employee_id,department_name
FROM employees e,departments d
WHERE e.`department_id`=d.`department_id`;

#SQL语法实现内连接；见上
#SQL92语法实现外连接：使用+
#下面需要使用到外连接
#MySQL 不支持SQL92语法中的外连接的写法！
SELECT employee_id,department_name
FROM employees e,departments d
WHERE e.`department_id`=d.`department_id`{+};

#SQL99语法中使用JOIN...ON的方式实现多表的查询。这种方式也能解决外连接的问题。MySQL是支持此种方式的
#SQL99语法如何实现多表的查询。

#SQL99语法实现内连接：
SELECT last_name,department_name
FROM employees e JOIN departments d
ON e.`department_id`=d.`department_id`;


SELECT last_name,department_name
FROM employees e INNER JOIN departments d
ON e.`department_id`=d.`department_id`;

#三张表
SELECT last_name,department_name,city
FROM employees e JOIN departments d
ON e.`department_id`=d.`department_id`
JOIN locations l
ON d.`location_id`=l.`location_id`;


SELECT last_name,department_name,city
FROM employees e INNER JOIN departments d
ON e.`department_id`=d.`department_id`
JOIN locations l
ON d.`location_id`=l.`location_id`;
#SQL99语法实现外连接：
#练习：查询所有的员工的last_name,department_name信息
#左外连接
SELECT last_name,department_name
FROM employees e LEFT OUTER JOIN departments d
ON e.`department_id`=d.`department_id`;

#INNER 和OUTER可以省略掉
#右外连接
SELECT last_name,department_name
FROM employees e RIGHT OUTER JOIN departments d
ON e.`department_id`=d.`department_id`;

#满外连接：MySQL 不支持FULL JOIN的满外连接
SELECT last_name,department_name
FROM employees e RIGHT OUTER JOIN departments d
ON e.`department_id`=d.`department_id`;

#7中SQL JOIN的实现
#UNION /UNION ALL

#8.UNION和UNION ALL的使用
#UNION会执行去重的操作
#UNION ALL：不会去执行去重的操作
#结论：如果明确知道合并数据后的结果数据不存在重复数据
#则尽量使用UNION ALL语句，以提高数据查询的效率；

#9.7种JSON的实现

#中图：内连接
SELECT employee_id,department_name
FROM employees e INNER JOIN departments d
ON e.`department_id`=d.`department_id`;

#左上图：左外连接
SELECT employee_id,department_name
FROM employees e LEFT OUTER JOIN departments d
ON e.`department_id`=d.`department_id`;

#右上图：右外连接
SELECT employee_id,department_name
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`;

#左中图：
SELECT e.employee_id,d.department_name
FROM employees e LEFT OUTER JOIN departments d
ON e.`department_id`=d.`department_id`
WHERE d.`department_id` IS NULL;

SELECT e.employee_id,d.department_name,d.`department_id`
FROM employees e LEFT OUTER JOIN departments d
ON e.`department_id`=d.`department_id`
WHERE d.`department_id` IS NULL;

#右中图
SELECT employee_id,department_name
FROM employees e RIGHT JOIN departments d
ON e.`department_id`=d.`department_id`
WHERE e.`department_id` IS NULL;

#左下图：满外连接
#方式1:左上图 UNION ALL 右中图,注意第一段没有分号
SELECT employee_id,department_name
FROM employees e LEFT OUTER JOIN departments d
ON e.`department_id`=d.`department_id`
UNION ALL
SELECT employee_id,department_name
FROM employees e RIGHT JOIN departments d
ON e.`department_id`=d.`department_id`
WHERE e.`department_id` IS NULL;

#方式2：左中图 UNION ALL 右上图
SELECT employee_id,department_name
FROM employees e LEFT JOIN departments d
ON e.`department_id`=d.`department_id`
WHERE d.`department_id`IS NULL
UNION ALL
SELECT employee_id,department_name
FROM employees e RIGHT JOIN departments d
ON e.`department_id`=d.`department_id`;

#使用的是is null 而不能是=null
#右下图：左中图 UNION ALL 右中图
SELECT employee_id,department_name
FROM employees e LEFT JOIN departments d
ON e.`department_id`=d.`department_id`
WHERE d.`department_id`IS NULL
UNION ALL
SELECT employee_id,department_name
FROM employees e RIGHT JOIN departments d
ON e.`department_id`=d.`department_id`
WHERE e.`department_id` IS NULL;

#多表查询
#练习-2


#10.SQL99语法新特性：自然连接
SELECT employee_id,last_name,department_name
FROM employees e JOIN departments d
ON e.`department_id`= d.`department_id`
AND e.`manager_id`=d.`manager_id`;


SELECT employee_id,last_name,department_name
FROM employees e JOIN departments d 
ON e.`department_id`=d.`department_id`
AND e.`manager_id`=d.`manager_id`;

#自然连接
#NATURAL JOIN:他会帮你自动查询两张连接表中“所有相同的字段”，然后进行“等值连接”
SELECT employee_id,last_name,department_name
FROM employees e NATURAL JOIN departments d;

#11.SQL99语法的新特性2：USING
SELECT employee_id,last_name,department_name
FROM employees e JOIN departments d
USING (department_id);

#多表查询课后练习
#练习1
# 1.显示所有员工的姓名，部门号和部门名称。
	#所有的员工，意识到是外连接，左外连接
SELECT e.employee_id,e.last_name,d.department_id,d.department_name
FROM employees e LEFT OUTER JOIN departments d
ON e.`department_id`=d.`department_id`;
# 2.查询90号部门员工的job_id和90号部门的location_id

SELECT e.employee_id,e.last_name,e.job_id,l.location_id
FROM employees e ,departments d,locations l
WHERE e.`department_id`=d.`department_id`
AND d.`location_id`=l.`location_id`
AND d.`department_id`=90;

SELECT e.job_id,d.`location_id`
FROM employees e JOIN departments d
ON e.`department_id`=d.`department_id`
AND e.`department_id`=90
JOIN locations l
ON d.`location_id`=l.location_id;


#第2题答案：
SELECT e.`job_id`,d.`location_id`
FROM employees e JOIN departments d
ON e.`department_id`=d.`department_id`
WHERE e.`department_id`=90;
# 3.选择所有有奖金的员工的 last_name , department_name , location_id , city
SELECT * FROM locations;

SELECT e.last_name,d.department_name,l.location_id,l.city
FROM employees e LEFT  JOIN departments d
ON e.`department_id`=d.`department_id`
AND e.`commission_pct` IS NOT NULL
JOIN locations l
ON d.`location_id`=l.`location_id`; 

#正确答案
#需要添加两遍的LEFT，不然会查询丢失
SELECT e.last_name,d.department_name,l.location_id,l.city
FROM employees e 
LEFT JOIN departments d
ON e.`department_id`=d.`department_id`
LEFT JOIN locations l
ON d.`location_id`=l.`location_id`
WHERE e.`commission_pct` IS NOT NULL;


SELECT * 
FROM employees
WHERE commission_pct IS NOT NULL;
# 4.选择city在Toronto工作的员工的 last_name , job_id , department_id , department_name

SELECT e.employee_id,e.last_name,e.`job_id`,d.`department_id`,d.department_name,l.location_id,l.city
FROM employees e JOIN departments d
ON e.`department_id`=d.`department_id`
JOIN locations l
ON d.`location_id`=l.`location_id`
AND l.city='Toronto';

# 5.查询员工所在的部门名称、部门地址、姓名、工作、工资，其中员工所在部门的部门名称为’Executive’

SELECT * FROM employees;

SELECT e.employee_id,e.last_name,d.department_name,l.city,e.job_id,e.salary
FROM employees e JOIN departments d
ON e.`department_id`=d.`department_id`
JOIN locations l
ON d.`location_id`=l.`location_id`
WHERE d.`department_name`='Executive';
#AND d.`department_name`='Executive';

DESC departments;
# 6.选择指定员工的姓名，员工号，以及他的管理者的姓名和员工号，结果类似于下面的格式
#全部的员工，使用左外连接，LEFT JOIN 	
SELECT emp1.employee_id,emp1.last_name,emp2.employee_id,emp2.last_name
FROM employees emp1 LEFT JOIN employees emp2
ON emp1.`manager_id`=emp2.`employee_id`;

#正确答案


# 7.查询哪些部门没有员工

SELECT department_name,employee_id
FROM employees e RIGHT JOIN departments d
ON e.`department_id`=d.`department_id`
#and e.`department_id` is null;
WHERE e.`department_id`IS NULL;


SELECT department_name,employee_id
FROM employees e RIGHT JOIN departments d
ON e.`department_id`IS NULL;
# 8. 查询哪个城市没有部门

SELECT * FROM departments;
SELECT * FROM locations;

SELECT l.`location_id`,l.`city`,d.`location_id`
FROM departments d
RIGHT JOIN locations l
ON d.`location_id`=l.`location_id`;


#正确答案
SELECT l.`location_id`,l.`city`,d.`location_id`
FROM departments d
RIGHT JOIN locations l
ON d.`location_id`=l.`location_id`
WHERE d.`location_id` IS NULL;
# 9. 查询部门名为 Sales 或 IT 的员工信息
SELECT e.employee_id,e.last_name,d.department_name,l.city,e.job_id,e.salary
FROM employees e LEFT JOIN departments d
ON e.`department_id`=d.`department_id`
LEFT JOIN locations l
ON d.`location_id`=l.`location_id`
WHERE d.`department_name` IN ('Sales','IT');
#where d.`department_name`='Sales'or d.`department_name`='IT';


#练习-2
CREATE TABLE `t_dept` (
`id` INT(11) NOT NULL AUTO_INCREMENT,
`deptName` VARCHAR(30) DEFAULT NULL,
`address` VARCHAR(40) DEFAULT NULL,
PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
CREATE TABLE `t_emp` (
`id` INT(11) NOT NULL AUTO_INCREMENT,
`name` VARCHAR(20) DEFAULT NULL,
`age` INT(3) DEFAULT NULL,
`deptId` INT(11) DEFAULT NULL,
empno INT NOT NULL,
PRIMARY KEY (`id`),
KEY `idx_dept_id` (`deptId`)
#CONSTRAINT `fk_dept_id` FOREIGN KEY (`deptId`) REFERENCES `t_dept` (`id`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
#1. 所有有门派的人员信息
#（ A、B两表共有）
INSERT INTO t_dept(deptName,address) VALUES('华山','华山');
INSERT INTO t_dept(deptName,address) VALUES('丐帮','洛阳');
INSERT INTO t_dept(deptName,address) VALUES('峨眉','峨眉山');
INSERT INTO t_dept(deptName,address) VALUES('武当','武当山');
INSERT INTO t_dept(deptName,address) VALUES('明教','光明顶');
INSERT INTO t_dept(deptName,address) VALUES('少林','少林寺');
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('风清扬',90,1,100001);
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('岳不群',50,1,100002);
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('令狐冲',24,1,100003);
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('洪七公',70,2,100004);
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('乔峰',35,2,100005);
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('灭绝师太',70,3,100006);
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('周芷若',20,3,100007);
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('张三丰',100,4,100008);
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('张无忌',25,5,100009);
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('韦小宝',18,NULL,100010);

SELECT * FROM t_dept;
SELECT * FROM t_emp;

#1.所有有门派的人员信息
	#（ A、B两表共有）


SELECT t1.name,t1.age,t1.deptId,t1.empno,t2.`deptName`,t2.`address`
FROM t_emp t1 LEFT JOIN t_dept t2
ON t1.`deptId`=t2.`id`
WHERE t1.deptId IS NOT NULL;

SELECT *
FROM t_emp a INNER JOIN t_dept b
ON a.deptId = b.id;

#2.列出所有用户，并显示其机构信息
	#（A的全集）
SELECT t1.name,t1.age,t1.deptId,t1.empno,t2.`deptName`,t2.`address`
FROM t_emp t1 LEFT JOIN t_dept t2
ON t1.`deptId`=t2.`id`;

SELECT *
FROM t_emp a LEFT JOIN t_dept b
ON a.deptId = b.id;
#3.列出所有门派
	#（B的全集）
SELECT deptName,address
FROM t_dept;
#4.所有不入门派的人员
	#（A的独有）
	
	
SELECT t1.name,t2.deptName
FROM t_emp t1 LEFT JOIN t_dept t2
ON t1.`deptId`=t2.`id`
WHERE t2.`id` IS NULL;

SELECT *
FROM t_emp a LEFT JOIN t_dept b
ON a.deptId = b.id
WHERE b.id IS NULL;


#5.所有没人入的门派
	#（B的独有）
	
	
SELECT t1.deptname,t2.name
FROM t_dept t1 LEFT JOIN t_emp t2
ON t1.`id`=t2.`deptId`;

SELECT t1.deptname,t2.name
FROM t_dept t1 LEFT JOIN t_emp t2
ON t1.`id`=t2.`deptId`
WHERE t2.`deptId` IS NULL;

SELECT *
FROM t_dept b LEFT JOIN t_emp a
ON a.deptId = b.id
WHERE a.deptId IS NULL;

#6.列出所有人员和机构的对照关系
	#(AB全有)
#MySQL Full Join的实现 因为MySQL不支持FULL JOIN,下面是替代方法
#left join + union(可去除重复数据)+ right join

SELECT NAME,age,deptId,empno,deptname,address
FROM t_emp t1 LEFT JOIN t_dept t2
ON t1.`deptId`=t2.`id`
WHERE t2.id IS NULL
UNION ALL
SELECT NAME,age,deptId,empno,deptname,address
FROM t_emp t1 RIGHT JOIN t_dept t2
ON t1.`deptId`=t2.`id`;


SELECT *
FROM t_emp A LEFT JOIN t_dept B
ON A.deptId = B.id
UNION
SELECT *
FROM t_emp A RIGHT JOIN t_dept B
ON A.deptId = B.id;


#7.列出所有没入派的人员和没人入的门派
	#（A的独有+B的独有）
SELECT NAME,age,deptId,empno,deptname,address
FROM t_emp t1 LEFT JOIN t_dept t2
ON t1.`deptId`=t2.`id`
WHERE t2.`id`IS NULL
UNION ALL
SELECT NAME,age,deptId,empno,deptname,address
FROM t_emp t1 RIGHT JOIN t_dept t2
ON t1.`deptId`=t2.`id`
WHERE t1.`deptId`IS NULL;



SELECT *
FROM t_emp A LEFT JOIN t_dept B
ON A.deptId = B.id
WHERE B.`id` IS NULL
UNION
SELECT *
FROM t_emp A RIGHT JOIN t_dept B
ON A.deptId = B.id
WHERE A.`deptId` IS NULL;