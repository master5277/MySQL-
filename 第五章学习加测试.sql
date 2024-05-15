#第五章学习加测试
#排序与分页


#1.排序

SELECT * FROM employees;


#如果没有使用排序操作，默认情况下查询返回的数据是按照添加数据的顺序显示的
SELECT * FROM employees;

#练习：按照salary从高到低的顺序显示员工信息

#使用ORDER BY 对查询到的数据进行排序操作
#升序：ASC（ascend）
#降序：DESC(descend)

#降序
SELECT employee_id,last_name,salary
FROM employees
ORDER BY salary DESC;


#升序
SELECT employee_id,last_name,salary
FROM employees
ORDER BY salary ASC;

#默认是升序
SELECT employee_id,last_name,salary
FROM employees
ORDER BY salary;


#我们可以使用列的别名，进行排序
SELECT employee_id,salary,salary*12 annual_sal
FROM employees
ORDER BY annual_sal;

#列的别名只能在order by 中使用，不能在where中使用。
SELECT employee_id,salary,salary*12 annual_sal
FROM employees
WHERE annual_sal>81600;


#from和where是在一起的
SELECT  employee_id,salary
FROM employees
WHERE department_id IN (50,60,70)
ORDER BY department_id DESC;

#强调格式：where 需要声明在from后，order by 之前。
SELECT employee_id,salary
FROM employees
WHERE department_id IN (50,60,70)
ORDER BY department_id ASC;

#4.二级排序
#练习：显示员工信息，按照department_id的降序排序，salary的升序排序

SELECT employee_id,salary,department_id
FROM employees
ORDER BY department_id ASC,salary DESC;


SELECT employee_id,salary,department_id
FROM employees
ORDER BY department_id ,salary DESC;



#2分页
#需求1：每页显示20条记录，此时显示第一页
SELECT employee_id,last_name
FROM employees
LIMIT 0,20;#起始位为0，偏移量为20

#需求2：每页显示20条记录，此时显示第二页
 SELECT employee_id,last_name
 FROM employees
 LIMIT 20,20;#起始位为20，偏移量为20
 
 #需求：每页显示20条记录，此时显示第pageN0页
 #公式：LIMIT (pageNo-1)*pageSize,pageSize;
 
 #2.2 WHERE .... ORDER BY .... LIMIT声明顺序如下：
#LIMIT的格式：严格来说：LIMIT位置偏移量，条目数
#结构"LIMIT 0,条目数"相当于“LIMIT 条目数”; 
 SELECT employee_id,last_name,salary
 FROM employees
 WHERE salary >6000
 ORDER BY salary DESC
 LIMIT 0,10;
 #LIMIT 需要在ORDER BY之后
 
 #练习：表里有107条数据，我们只想要显示第32，33条数据怎么办？
 SELECT employee_id,last_name,salary
 FROM employees
 WHERE salary>6000
 ORDER BY salary DESC
 LIMIT 31,2;#0，1，2，3.....；所以第32条数据是31
 #2是条目数
 SELECT * FROM employees;
 
 #2.3MySQL8.0新特性：LIMIT...OFFSET...
 #练习：表里有107条数据，我们只想要显示第32，33条数据怎么办？
  SELECT employee_id,last_name,salary
 FROM employees
 WHERE salary>6000
 ORDER BY salary DESC
 LIMIT 2 OFFSET 31;
 
 
 #练习：查询员工表中工资最高的员工信息
 SELECT employee_id,first_name,last_name,salary
 FROM employees
 ORDER BY salary DESC
 LIMIT 0,1;
 #LIMIT句子必须放在整个SELECT语句的最后
 
 
#课后练习
#1. 查询员工的姓名和部门号和年薪，按年薪降序,按姓名升序显示 
SELECT employee_id,last_name,first_name,department_id,(salary*(1+IFNULL(commission_pct,0)))*12 annual_salary
FROM employees
ORDER BY annual_salary DESC,last_name ASC;
#2. 选择工资不在 8000 到 17000 的员工的姓名和工资，按工资降序，显示第21到40位置的数据 
SELECT  employee_id,last_name,salary
FROM employees
WHERE salary NOT BETWEEN 8000 AND 17000
ORDER BY salary DESC
LIMIT 20,20;
#3. 查询邮箱中包含 e 的员工信息，并先按邮箱的字节数降序，再按部门号升
SELECT employee_id,last_name,first_name
FROM employees
#where email like '%e%'
WHERE email REGEXP '[e]'
ORDER BY LENGTH(email) DESC,department_id ASC;


