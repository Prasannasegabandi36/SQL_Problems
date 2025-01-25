drop table employee;
create table employee
( emp_ID int
, emp_NAME varchar(50)
, DEPT_NAME varchar(50)
, SALARY int);

insert into employee values(101, 'Mohan', 'Admin', 4000);
insert into employee values(102, 'Rajkumar', 'HR', 3000);
insert into employee values(103, 'Akbar', 'IT', 4000);
insert into employee values(104, 'Dorvin', 'Finance', 6500);
insert into employee values(105, 'Rohit', 'HR', 3000);
insert into employee values(106, 'Rajesh',  'Finance', 5000);
insert into employee values(107, 'Preet', 'HR', 7000);
insert into employee values(108, 'Maryam', 'Admin', 4000);
insert into employee values(109, 'Sanjay', 'IT', 6500);
insert into employee values(110, 'Vasudha', 'IT', 7000);
insert into employee values(111, 'Melinda', 'IT', 8000);
insert into employee values(112, 'Komal', 'IT', 10000);
insert into employee values(113, 'Gautham', 'Admin', 2000);
insert into employee values(114, 'Manisha', 'HR', 3000);
insert into employee values(115, 'Chandni', 'IT', 4500);
insert into employee values(116, 'Satya', 'Finance', 6500);
insert into employee values(117, 'Adarsh', 'HR', 3500);
insert into employee values(118, 'Tejaswi', 'Finance', 5500);
insert into employee values(119, 'Cory', 'HR', 8000);
insert into employee values(120, 'Monica', 'Admin', 5000);
insert into employee values(121, 'Rosalin', 'IT', 6000);
insert into employee values(122, 'Ibrahim', 'IT', 8000);
insert into employee values(123, 'Vikram', 'IT', 8000);
insert into employee values(124, 'Dheeraj', 'IT', 11000);
COMMIT;
select * from employee;
select max(salary) as max_salary from employee;
select max(salary) as max_salary from employee;

-- find max salary in each department
select dept_name ,max(salary) as max_salary
from employee
group by dept_name
 -- department max salary comparision
 select e.*,
 max(salary) over(partition by dept_name) as max_salary
 from employee e;

 --- row_num, rank,dense_rank,lead and lag
 select * from(
 select e.*,
 row_number() over(partition by dept_name) as rn
 from employee e) x
 where x.rn<3;
 
 --fetch top 3 employees in each dep earn max salary
 select * from(
    select e.*,
	rank() over(partition by dept_name order by salary desc ) as rnk
	from employee e) x
	where x.rnk<4;

 -- fetch quey disply if salary of employee is high,low
 -- use lag for record from previous
 select e.*,
 lag(salary) over(partition by dept_name order by emp_id) as prev_emp_salary
 from employee e;

 select e.*,
 lag(salary) over(partition by dept_name order by emp_id) as prev_emp_salary
 case when e.salary > lag(salary) over(partition by dept_name order by emp_id) then 'higher than previous employee'
 when e.salary < lag(salary) over(partition by dept_name order by emp_id) then 'lower than previous employee'
 when e.salary = lag(salary) over(partition by dept_name order by emp_id) then 'same as previous employee'
 end sal_range
 from employee e;