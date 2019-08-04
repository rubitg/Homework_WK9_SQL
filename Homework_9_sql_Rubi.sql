
--  Queries for homework week 10 A mystery - Rubi Trujillo - August 2019  --
--  Data Base HW10_sql was created  --

-- PART 1: Data Engeneering --

drop table if exists  departments;
drop table if exists  dept_emp;
drop table if exists  dept_manager;
drop table if exists  employees;
drop table if exists  salaries;
drop table if exists  titles;

-- using Diagram create tables --

create table "departments" (
    "dept_no" VARCHAR not NULL,
    "dept_name" VARCHAR not NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY ("dept_no")
);

create table "dept_emp" (
    "emp_no" INT   not NULL,
    "dept_no" VARCHAR   not NULL,
    "from_date" DATE   not NULL,
    "to_date" DATE   not NULL
);

create table "dept_manager" (
    "dept_no" VARCHAR   not NULL,
    "emp_no" INT   not NULL,
    "from_date" DATE   not NULL,
    "to_date" DATE   not NULL
);

create table "employees" (
    "emp_no" INT   not NULL,
    "birth_date" DATE   not NULL,
    "first_name" VARCHAR   not NULL,
    "last_name" VARCHAR   not NULL,
    "gender" VARCHAR   not NULL,
    "hire_date" DATE   not NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY ("emp_no")
);
create table "salaries" (
    "emp_no" INT   not NULL,
    "salary" INT   not NULL,
    "from_date" DATE  not NULL,
    "to_date" DATE  not NULL
);

create table "titles" (
    "emp_no" INT   not NULL,
    "title" VARCHAR   not NULL,
    "from_date" DATE   not NULL,
    "to_date" DATE   not NULL
);


alter table "dept_emp" add constraint  "fk_dept_emp_emp_no" foreign key ("emp_no")
references  "employees" ("emp_no");

alter table "dept_emp" add constraint  "fk_dept_emp_dept_no" foreign key("dept_no")
references "departments" ("dept_no");

alter table "dept_manager" add constraint  "fk_dept_manager_dept_no" foreign key("dept_no")
references "departments" ("dept_no");

alter table "dept_manager" add constraint "fk_dept_manager_emp_no" foreign key("emp_no")
references "employees" ("emp_no");

alter table "salaries" add constraint  "fk_salaries_emp_no" foreign key("emp_no")
references "employees" ("emp_no");

alter table "titles" add constraint  "fk_titles_emp_no" foreign key("emp_no")
references "employees" ("emp_no");

--then populate tables---

select * from departments
select * from dept_emp
select * from dept_manager
select * from salaries
select * from titles
select * from employees
 --empty structure..--
 -- manually populate considering order to avoid error due to pk, dept_emp go after employees--
 
 --Begin aking questions...--
 
 --QUESTION 1 - see query_result_1.csv--
 --List the following details of each employee: employee number, last name, first name, gender, and salary.--
 
 select a.emp_no, a.last_name, a.first_name, a.gender,  b.salary
 from employees a 
 inner join salaries b
 on a.emp_no=b.emp_no;

--copy (select a.emp_no, a.last_name, a.first_name, a.gender,  b.salary
-- from employees a 
-- inner join salaries b
-- on a.emp_no=b.emp_no) To 'c:Desktop/Jynote/HW9_Q1.csv' With CSV DELIMITER ',';---

-- csv manually downloaded...--

--QUESTION 2 - see .csv--
--List employees who were hired in 1986.--
--result 36150 rows affected.--

select * 
from employees
where hire_date between '1986-01-01' and '1986-12-31'

--QUESTION 3 --
--lst the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name, and start and end employment dates.--
--result 24 rows affected.--

select a.dept_no,c.emp_no,c.last_name,c.first_name,b.from_date, b.to_date
from departments a
inner join dept_manager b
on a.dept_no=b.dept_no
inner join employees c
on b.emp_no=c.emp_no


--QUESTION 4--
--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.--
--result 331603 rows affected.--
select a.emp_no, a.last_name, a.first_name, b.dept_no, c.dept_name
from employees a 
join dept_emp b
on a.emp_no=b.emp_no
inner join departments c
on b.dept_no=c.dept_no;


--QUESTION 5 --
--list all employees whose first name is "Hercules" and last names begin with "B."--
--result 20 rows affected.--
select *
from employees 
where first_name in ('Hercules') and last_name  like 'B%' 
;


--QUESTION 6 __
--List all employees in the Sales department, including their --
--employee number, last name, first name, and department name.--
--result 52245 rows affected.--

select a.emp_no, a.last_name, a.first_name, c.dept_name
from employees a 
join dept_emp b
on a.emp_no=b.emp_no
inner join departments c
on b.dept_no=c.dept_no 
where c.dept_name in ('Sales')

--QUESTION 7 --
--List all employees in the Sales and Development departments, including their--
--employee number, last name, first name, and department name.
--results 137952 rows affected.--
select a.emp_no, a.last_name, a.first_name, c.dept_name
from employees a 
join dept_emp b
on a.emp_no=b.emp_no
inner join departments c
on b.dept_no=c.dept_no 
where c.dept_name in ('Sales') or c.dept_name in ('Development')


--QUESTION 8 --
--In descending order, list the frequency count of employee last names, i.e., --
--how many employees share each last name.--

select  last_name,count(last_name) as vol_lastname
from employees 
group by last_name
order by vol_lastname desc





