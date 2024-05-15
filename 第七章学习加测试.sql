#单行函数
#一行输入，对应一行输出


#1.数值函数
SELECT
ABS(-123),ABS(32),SIGN(-23),SIGN(43),PI(),CEIL(32.32),CEILING(-43.23),FLOOR(32.32),
FLOOR(-43.23),MOD(12,5)
FROM DUAL;


SELECT
ABS(-123),ABS(32),SIGN(-23),SIGN(43),PI(),CEIL(32.32),CEILING(-43.23),FLOOR(32.32),
FLOOR(-43.23),MOD(12,5),12 MOD 5,12 % 5
FROM DUAL;


#RAND() :返回0~1的随机值
#RAND(x):返回0~1的随机值，其中x的值用作种子值，相同的X值会产生相同的随机数
SELECT RAND(),RAND(),RAND(10),RAND(10),RAND(-1),RAND(-1)
FROM DUAL;


#四舍五入,后面的数字代表着留几位小数
SELECT ROUND(123.556),ROUND(123.456,0),ROUND(123.456,1),ROUND(123.456,2),
ROUND(123.456,-1),ROUND(153.456,-2)
FROM DUAL;

#截断操作
SELECT TRUNCATE(123.456,0),TRUNCATE(123.496,1),TRUNCATE(129.45,-1)
FROM DUAL;

#单行函数可以嵌套
SELECT TRUNCATE(ROUND(123.456,2),0)
FROM DUAL;

#角度与弧度的互换函数
SELECT RADIANS(30),RADIANS(45),RADIANS(60),RADIANS(90),
DEGREES(2*PI()),DEGREES(RADIANS(60))
FROM DUAL;

#三角函数
SELECT SIN(RADIANS(30)),DEGREES(ASIN(1)),TAN(RADIANS(45)),DEGREES(ATAN(1))
FROM DUAL;

#指数和对数
SELECT POW(2,5),POWER(2,5),EXP(2)
FROM DUAL;


SELECT EXP(2),LN(EXP(2))
FROM DUAL;


SELECT LN(EXP(2)),LOG(EXP(2)),LOG10(10),LOG2(4)
FROM DUAL;

#进制间的转换,二进制，十六进制，八进制
SELECT BIN(10),HEX(10),OCT(10),CONV(1010,2,8)
FROM DUAL;

#2.字符串函数,只跟第一个字符有关系，UTF-8里面一个汉字三个字节
SELECT ASCII('abc'),CHAR_LENGTH('hello'),CHAR_LENGTH('我们'),LENGTH('hello'),LENGTH('我们')
FROM DUAL;

#xxx worked for yyy
SELECT CONCAT(emp.last_name,'  worked for  ',mgr.last_name)
FROM employees emp JOIN employees mgr
WHERE emp.`manager_id`=mgr.`manager_id`;

#使用短横线连接字符串
SELECT CONCAT_WS('-','hello','world','hello','beijing')
FROM DUAL;

#字符串的索引式从1开始的
SELECT INSERT('helloworld',2,3,'aaaa'),REPLACE('hello','ll','mmm')
FROM DUAL;

#大小写替换
SELECT UPPER('Hello'),LOWER('Hello')
FROM DUAL;

#
SELECT last_name,salary
FROM employees
WHERE LOWER(last_name)= 'King';

SELECT LEFT('hello',2),RIGHT('hello',13)
FROM DUAL;

#不足10位，在左边补*
#LPAD:实现右对齐的效果
#RPAD:实现右对齐的效果
SELECT employee_id,last_name,RPAD(salary,10,'*')
FROM employees;

#TRIM(s),去除字符开始与结尾的空格
#TRIM(s1 from s)：去除字符开始与结尾的s1字符
SELECT  TRIM('    h  el   lo   ')
FROM DUAL;

SELECT CONCAT('---',LTRIM('  h  el  lo  '),'***')
FROM DUAL;

SELECT CONCAT('---',RTRIM('  h  el  lo  '),'***')
FROM DUAL;


SELECT CONCAT('---',TRIM('  h  el  lo  '),'***')
FROM DUAL;

SELECT CONCAT('--',LTRIM('  h  el  lo  '),'***',TRIM('oo'FROM'ooheoolloo'))
FROM DUAL;

#REPEAT:重复几次
SELECT REPEAT('hello',4),SPACE(5),LENGTH(SPACE(5))
FROM DUAL;
#比较字符串s1,s2的ASCII码值的大小
SELECT STRCMP('abc','abe')
FROM DUAL;


#返回从字符串s的index位置其len个字符
SELECT SUBSTR('hello',2,2)
FROM DUAL;

#字符段首次出现在字符串中的位置
SELECT LOCATE('lll','hello')
FROM DUAL;

#返回第几个字符
SELECT ELT(2,'a','b','c','d')
FROM DUAL;

#返回字符串s在字符串列表中第一次出现的位置
SELECT FIELD('mm','gg','aa','mm')
FROM DUAL;

#返回字符串s1在字符串s2中出现的位置，其中，字符s2是一个以都好分隔的字符串
SELECT FIND_IN_SET('mm','gg,mm')
FROM DUAL;

#NULLIF比较两个字符串，如果value1与value2相等，则返回NULL，否则返回value1
SELECT employee_id,NULLIF(LENGTH(first_name),LENGTH(last_name)) "compare"
FROM employees;

#3.日期和时间函数
#3.1	获取日期，时间
SELECT CURDATE(),CURRENT_DATE(),CURTIME(),NOW(),SYSDATE(),
UTC_DATE(),UTC_TIME()
FROM DUAL;


#3.2日期与时间戳的转换
SELECT UNIX_TIMESTAMP(),UNIX_TIMESTAMP('2021-10-01 12:12:32'),
FROM_UNIXTIME(1715656570),FROM_UNIXTIME(1633061552)
FROM DUAL;

#3.3获取月份，星期，星期数，天数等函数
SELECT YEAR(CURDATE()),MONTH(CURDATE()),DAY(CURDATE()),
HOUR(CURTIME()),MINUTE(NOW()),SECOND(SYSDATE())
FROM DUAL;

SELECT MONTHNAME('2021-10-26'),DAYNAME('2021-10-26'),WEEKDAY('2021-10-26'),
QUARTER(CURDATE()),WEEK(CURDATE()),DAYOFYEAR(NOW()),
DAYOFMONTH(NOW()),DAYOFWEEK(NOW())
FROM DUAL;

#3.4日期的操作函数
SELECT EXTRACT(MINUTE FROM NOW()),EXTRACT( WEEK FROM NOW()),
EXTRACT( QUARTER FROM NOW()),EXTRACT( MINUTE_SECOND FROM NOW())
FROM DUAL;

#3.5时间和秒钟转换的函数
SELECT TIME_TO_SEC(CURTIME()),
SEC_TO_TIME(54939)
FROM DUAL;

#3.6计算日期和时间的函数
SELECT NOW(),DATE_ADD(NOW(),INTERVAL 1 YEAR),
DATE_ADD(NOW(),INTERVAL -1 YEAR),
DATE_SUB(NOW(),INTERVAL 1 YEAR)
FROM DUAL;

SELECT CURDATE(),CURDATE()+0,CURTIME()+0,NOW()+0
FROM DUAL;

#3.7日期的格式化与解析
#格式化：日期-->字符串
#解析：  字符串-->日期

#此时我们谈的是日期的显式格式化和解析
#之前，我们接触过隐式的格式化或解析

SELECT *
FROM employees
WHERE hire_date = '1993-01-13';

#格式化：
SELECT DATE_FORMAT(CURDATE(),'%Y-%M-%D'),
DATE_FORMAT(NOW(),'%Y-%m-%d'),TIME_FORMAT(CURTIME(),'%h:%i:%S'),
DATE_FORMAT(NOW(),'%Y-%M-%D %h:%i:%S %W %w %T %r')
FROM DUAL;

#解析，格式化的逆过程
SELECT STR_TO_DATE('2024-May-14th 03:35:52 Tuesday 2','%Y-%M-%D %h:%i:%S %W %w')
FROM DUAL;

SELECT GET_FORMAT(DATE,'USA')
FROM DUAL;


SELECT DATE_FORMAT(CURDATE(),GET_FORMAT(DATE,'USA'))
FROM DUAL;

#4.流程控制函数
#IF(VALUE,VALUE1,VALUE2)

SELECT last_name,salary,IF(salary>=6000,'高工资','低工资') "details"
FROM employees;

SELECT last_name,commission_pct,IF(commission_pct IS NOT NULL,commission_pct,0) "details",
salary*12*(1+IF(commission_pct IS NOT NULL,commission_pct,0)) "annual_sal"
FROM employees;

#4.2IFNULL(VALUE1,VALUE2):
SELECT last_name,commission_pct,IFNULL(commission_pct,0) "details"
FROM employees;


#4.3 CASE WHEN ... THEN...WHEN...THEN...ELSE...END
#类似于java的if...else if ... else if

SELECT employee_id,salary,CASE WHEN salary>=15000 THEN '高薪'
		WHEN salary>=10000 THEN '潜力股'
		WHEN salary>=8000  THEN  '屌丝'
		ELSE '草根' END  "描述"
FROM employees;

SELECT last_name,job_id,salary,
		CASE job_id WHEN 'IT_PROG' THEN 1.10*salary
			    WHEN 'ST_CLERK' THEN 1.15*salary
			    WHEN 'SA_REP'  THEN 1.20*salary
			    ELSE  salary  END  "REVISED_SALARY"
FROM employees; 


#5. 加密与解密的函数
#PASSWORD()在mysql18.0中弃用
SELECT MD5('mysql'),SHA('mysql'),MD5(MD5('mysql'))
FROM DUAL;

/*
ENDCODE()被启用
SELECT ENCODE('atguigu','mysql')
FROM DUAL;
*/


#7 其他函数
#如果n的值小于或者等于0,则只保留整数部分
SELECT VERSION(),CONNECTION_ID(),DATABASE(),USER(),CURRENT_USER(),SYSTEM_USER(),CHARSET('尚硅谷'),COLLATION('尚硅谷')
FROM DUAL;

SELECT FORMAT(123.123,2),FORMAT(123.523,0),FORMAT(123.123,-2)
FROM DUAL;

SELECT CONV(16,10,2),CONV(8888,10,16),CONV(NULL,10,2)
FROM DUAL;

SELECT INET_ATON('192.168.1.100')
FROM DUAL;

SELECT INET_NTOA(3232235876)
FROM DUAL;

SELECT BENCHMARK(1,MD5('mysql'))
FROM DUAL;

SELECT BENCHMARK(1000000,MD5('mysql'))
FROM DUAL;

SELECT CHARSET('mysql'),CHARSET(CONVERT('mysql' USING 'gbk'))
FROM DUAL;

#课后练习
# 1.显示系统时间(注：日期+时间)
SELECT NOW()
FROM DUAL;
# 2.查询员工号，姓名，工资，以及工资提高百分之20%后的结果（new salary）
SELECT employee_id,last_name,salary,salary*1.2 "new salary"
FROM employees;
# 3.将员工的姓名按首字母排序，并写出姓名的长度（length）
SELECT last_name,LENGTH(last_name)
FROM employees
ORDER BY last_name DESC;
# 4.查询员工id,last_name,salary，并作为一个列输出，别名为OUT_PUT
SELECT CONCAT(employee_id,',',last_name,',',salary) OUT_PUT
FROM employees;
# 5.查询公司各员工工作的年数、工作的天数，并按工作年数的降序排序
SELECT DATEDIFF(SYSDATE(),hire_date)/365 worked_years,DATEDIFF(SYSDATE(),hire_date) worded_days
FROM employees
ORDER BY worked_years DESC
# 6.查询员工姓名，hire_date , department_id，满足以下条件：雇用时间在1997年之后，department_id为80 或 90 或110, commission_pct不为空
SELECT last_name,hire_date,department_id
FROM employees
WHERE DATE_FORMAT(hire_date,'%Y')>= '1997'
AND department_id IN (80,90,110)
AND commission_pct IS NOT NULL
# 7.查询公司中入职超过10000天的员工姓名、入职时间
SELECT last_name,hire_date
FROM employees
WHERE DATEDIFF(NOW(),hire_date)>1000;
# 8.做一个查询，产生下面的结果
/*
-- <last_name> earns `<salary>` monthly but wants <salary*3>
-- Dream Salary
-- King earns 24000 monthly but wants 72000
*/
SELECT CONCAT(last_name,' earns ',TRUNCATE(salary,0),' monthly but wants',TRUNCATE(salary*3,0)) "Dream Salary"
FROM employees;
# 9.使用case-when，按照下面的条件：
/*
-- job grade
-- AD_PRES A
-- ST_MAN B
-- IT_PROG C
-- SA_REP D
-- ST_CLERK E
-- 产生下面的结果
-- Last_name Job_id Grade
-- king AD_PRES A
*/

SELECT last_name "Last_name",job_id "Job_id",CASE job_id WHEN 'AD_PRES' THEN 'A'
						     WHEN 'ST_MAN' THEN 'B'
						     WHEN 'IT_PROG' THEN 'C'
						     WHEN 'SA_REP' THEN 'D'
						     WHEN 'ST_CLERK' THEN 'E'
						     ELSE 'F'
						     END  "grade"
FROM employees;