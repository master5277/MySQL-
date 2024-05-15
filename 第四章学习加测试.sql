#第四章，运算符
#算术运算符：+ - * /或div %或mod


SELECT 100,100+0,100-0,100+50,100+50-30,100+35.5,100-35.5
FROM DUAL;#伪表

#在SQL中，+没有连接的作用，就表示加法运算。此时，会将字符串转换为数值（隐式转换）
SELECT 100+'1'#在java语言中，结果是1001.
FROM DUAL;


SELECT 100+'a'#此时将'a'看作0处理
FROM DUAL;

SELECT 100+NULL#null值参与运算，结果为null
FROM DUAL;


SELECT 100,100*1,100*1.0,100/1.0,100/2,
100+2*5/2,100/3,100 DIV 0
FROM DUAL;

#取模运算：%mod
SELECT 12%3,12%5,12 MOD -5,-12%5,-12 % -5
FROM DUAL;#MOD前后要有空格

#练习
SELECT employee_id,last_name,salary
FROM employees
WHERE employee_id%2=0;
#查询员工id为偶数的员工信息
SELECT employee_id,last_name,salary
FROM employees
WHERE employee_id%2=0;

#2.比较运算符
#2.1 = <=> <> != < <= > >=
#字符串存在隐式转换。如果转换数值不成功，则看做0
SELECT 1=2,1!=2,1='1',1='a',0='a'
FROM DUAL;

#如果等号两边均为字符串的话，则按照ANSI的比较规则进行比较。
SELECT 'a'='a','ab'='ab','a'='b'
FROM DUAL;

#只要有null参与判断，结果就为null
SELECT 1=NULL,NULL=NULL
FROM DUAL;

SELECT last_name,salary
FROM employees
WHERE salary =6000;#返回结果是1的保存下来

#where参与运算将结果不为1的全部过滤掉
SELECT last_name,salary
FROM employees
WHERE commission_pct=NULL;#此时执行，不会有任何结果

#<=>：安全等于。  记忆技巧：为null而生
SELECT 1<=>2,1<=>'1',1<=>'a',0<=>'a'
FROM DUAL;

SELECT 1<=>NULL,NULL<=>NULL
FROM DUAL;

#查询表中commission_pct为null的数据有哪些
SELECT last_name,salary,commission_pct
FROM employee  s
WHERE commission_pct <=> NULL;

SELECT 3<>2,'4'<>NULL,''!=NULL,NULL!=NULL
FROM DUAL;

#2.2
#IS NULL\IS NOT NULL \ISNULL
#练习：查询表中commission_pct为null的数据有那些
SELECT last_name,salary,commission_pct
FROM employees
WHERE commission_pct IS NULL;

#或使用函数的方法
SELECT last_name,salary,commission_pct
FROM employees
WHERE ISNULL(commission_pct);

#练习：查询表中commission_pct不为null的数据有那些
SELECT last_name,salary,commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;
#或
SELECT last_name,salary,commission_pct
FROM employees
WHERE NOT commission_pct <=> NULL;

#LEAST()\GREATEST
SELECT LEAST('g','b','t','m'),GREATEST('g','b','t','m')
FROM DUAL;

SELECT first_name,last_name,LEAST(first_name,last_name)
FROM employees;

SELECT LEAST(first_name,last_name)
FROM employees;

SELECT LEAST(first_name,last_name),LEAST(LENGTH(first_name),LENGTH(last_name))
FROM employees;

#BETWEEN ... AND
#查询工资在6000到8000的员工信息
#BETWEEN 条件下界1 AND 条件上界2(查询条件1和条件2范围内的数据，包含边界) 
SELECT employee_id,last_name,salary
FROM employees
WHERE salary BETWEEN 6000 AND 8000;

SELECT employee_id,last_name,salary
FROM employees
WHERE salary>=6000 && salary <=8000;

#查询工资不在6000到8000的员工信息
SELECT employee_id,last_name,salary
FROM employees
WHERE salary <6000 OR salary>8000

SELECT employee_id,last_name,salary
FROM employees
WHERE salary NOT BETWEEN 6000 AND 8000;

#in(set)\not in (sset)
#练习:查询部门为10,20,30部门的员工信息

#OR后面直接是不为0的数字，所以看成1，
SELECT last_name,salary,department_id
FROM employees
WHERE department_id=10 OR 20 OR 30;

#和上面的对比，筛选的条件必须是完整的；
#方式1
SELECT last_name,salary,department_id
FROM employees
WHERE department_id=10 OR department_id=20 OR department_id=30;

#方式2
SELECT last_name,salary,department_id
FROM employees
WHERE department_id IN (10,20,30);


#查询工资是6000，7000，8000的员工信息
SELECT last_name,salary,department_id
FROM employees
WHERE salary IN (6000,7000,8000);

##查询工资不是6000，7000，8000的员工信息
SELECT last_name,salary,department_id
FROM employees
WHERE NOT salary IN (6000,7000,8000);

#LIKE :模糊查询
#练习：查询last_name中包含字符'a'的员工信息

#%：代表不确定个数的字符
SELECT last_name
FROM employees
WHERE last_name LIKE '%a%';

#查询last_name中以字符'a'开头的员工信息
SELECT last_name
FROM employees
WHERE last_name LIKE 'a%';

#查询last_name中包含字符'a'且包含字符'e'的员工信息

#写法1
SELECT last_name
FROM employees
WHERE last_name LIKE '%a%' AND last_name LIKE '%e%';

#写法2
#错误写法如下，逻辑条件必须写完整
SELECT last_name
FROM employees
WHERE last_name LIKE '%a%e%' OR '%e%a%';

#正确
SELECT last_name
FROM employees
WHERE last_name LIKE '%a%e%' OR last_name LIKE '%e%a%';

#_:代表一个不确定的字符
#查询第二个字符是'a'的员工信息
SELECT last_name
FROM employees
WHERE last_name LIKE '_a%';
#查询前二个字符是'a'的员工信息
SELECT last_name
FROM employees
WHERE last_name LIKE '__a%';

#查询第二个字符是_且第三个字符是'a'的员工信息
#需要使用转义字符：\
SELECT last_name 
FROM employees
WHERE last_name LIKE '_\_a%';
SELECT * FROM employees;

#默认使用\作为转义符，现在使用$作为转义符
SELECT last_name
FROM employees
WHERE last_name LIKE '_$_a%' ESCAPE '$';

#正则表达式
#REGEXP\RLIKE:正则表达式

SELECT 'shkstart' REGEXP '^s','shkstart'REGEXP 't$','shkstart'REGEXP'hk'
FROM DUAL;

SELECT 'atguigu' REGEXP 'gu.gu','atguigu' REGEXP '[ab]'
FROM DUAL;


#逻辑运算符：OR || AND && NOT ! XOR

#or and 
SELECT last_name,salary,department_id
FROM employees
#where department_id =10 or department_id =20;
#where department_id =10 and department_id =20;
WHERE department_id =20 && salary>6000;

#not
SELECT last_name,salary,department_id
FROM employees
#where commission_pct is not null;
#WHERE commission_pct IS NULL;
#where salary between 6000 and 8000;
WHERE salary NOT BETWEEN 6000 AND 8000;

#XOR异或，相同为0，不同为1
#满足其中一个条件的同时，不能满足另外一个条件
#XOR：追求的“异”
SELECT last_name,salary,department_id
FROM employees
WHERE department_id =50 XOR salary>6000;

#and要先进行运算
#运算符的优先级
#想要先进行运算的时候，可以使用小括号()
#4.位运算符：&:按位与 |：按位或 ^:按位异或 ~:非运算 >>:右移 <<：左移
SELECT 12 & 5,12 |5,12^5
FROM DUAL;

SELECT 10 & ~1
FROM DUAL;
#1  	00000001
#~1 	11111110
#10 	00001010
#10&~1 	00001010


#在一定范围内，左移相当于乘以2，右移相当于除以2
SELECT <<1,8>>1
FROM DUAL;

#运算符课后练习题
#1.选择工资不在5000到12000的员工的姓名和工资
SELECT last_name,salary
FROM employees
WHERE salary NOT BETWEEN 5000 AND 12000;
#where salary < 5000 or salary > 12000

# 2.选择在20或50号部门工作的员工姓名和部门号
SELECT last_name,department_id
FROM employees
WHERE department_id IN (20,50);
#where department_id =20 oor department_id = 50;

# 3.选择公司中没有管理者的员工姓名及job_id
SELECT * FROM employees;
SELECT last_name,job_id
FROM employees
WHERE manager_id <=>NULL;
#where manager_id is null;


 # 4.选择公司中有奖金的员工姓名，工资和奖金级别
 SELECT last_name,salary,commission_pct
 FROM employees
 WHERE commission_pct IS NOT NULL;
# 5.选择员工姓名的第三个字母是a的员工姓名
SELECT last_name
FROM employees
WHERE last_name LIKE '__a%';
# 6.选择姓名中有字母a和k的员工姓名
SELECT last_name
FROM employees
WHERE last_name LIKE '%a%' && last_name LIKE '%k%';
#where last_name like '%a%k%' or last_name like '%k%a%';

# 7.显示出表 employees 表中 first_name 以 'e'结尾的员工信息
SELECT first_name,last_name
FROM employees
#where first_name like '%e';
WHERE first_name REGEXP 'e$';#'^s';:以s开头的


# 8.显示出表 employees 部门编号在 80-100 之间的姓名、工种

SELECT first_name,last_name,job_id,department_id
FROM employees
WHERE department_id BETWEEN 80 AND 100;
#where department_id >=80 and department_id <=100;


# 9.显示出表 employees 的 manager_id 是 100,101,110 的员工姓名、工资、管理者id
SELECT first_name,last_name,salary,manager_id
FROM employees 
WHERE manager_id IN (100,101,110);
