SELECT * FROM LOCATIONS;
SELECT * FROM DEPARTMENTS;
SELECT * FROM JOBS;
SELECT * FROM EMPLOYEES;
SELECT * FROM JOB_HISTORY;
SELECT * FROM REGIONS;
SELECT * FROM COUNTRIES;



/************************** Find employee and department details based on specific condition **************************/

-- Which of the departments are without managers? List them in ascending order.

SELECT
    department_name
FROM
    departments
WHERE
    manager_id IS NULL
ORDER BY
    department_name ASC;



--Which cities, states and countries are the departments without managers located?

SELECT
    city,
    state_province,
    country_id
FROM
    locations
WHERE
    location_id IN (
        SELECT DISTINCT
            location_id
        FROM
            departments
        WHERE
            manager_id IS NULL
    );
     
     
     
--Which departments have at least an employee who does not have a manager?

SELECT
    department_name
FROM
    departments
WHERE
    department_id IN (
        SELECT
            department_id
        FROM
            employees
        WHERE
            manager_id IS NULL
    );


-- Provide the full names of all the employess who do not have managers in ascending order.

SELECT
    first_name
    || ' '
    || last_name AS "FULL NAME"
FROM
    employees
WHERE
    manager_id IS NULL
ORDER BY
    "FULL NAME" ASC;


--Provide the full names of all the managers in ascending order.

SELECT
    first_name
    || ' '
    || last_name AS "LIST OF MANAGERS"
FROM
    employees
WHERE
    employee_id IN (
        SELECT DISTINCT
            manager_id
        FROM
            departments
        WHERE
            manager_id IS NOT NULL
    )
ORDER BY
    "LIST OF MANAGERS" ASC;


--Who are the employees whose salary is more than the average salary?

SELECT
    first_name
    || ' '
    || last_name AS "EMPLOYEES WITH PAY ABOVE AVERAGE",
    salary
FROM
    employees
WHERE
    salary > (
        SELECT
            AVG(salary)
        FROM
            employees
    )
ORDER BY
    salary ASC;


--Who are the employees whose salary is less than the average salary?


SELECT
    first_name
    || ' '
    || last_name AS "EMPLOYEES WITH PAY BELOW AVERAGE",
    salary
FROM
    employees
WHERE
    salary < (
        SELECT
            AVG(salary)
        FROM
            employees
    )
ORDER BY
    salary DESC;


--Who are the employees in the Shipping department who earn below the average salary?

SELECT
    first_name
    || ' '
    || last_name AS "SHIPPING EMPLOYEES WITH PAY BELOW AVERAGE",
    salary
FROM
    employees
WHERE
        department_id = 50
    AND salary < (
        SELECT
            AVG(salary)
        FROM
            employees
    )
ORDER BY
    salary ASC;




--Who are the employees in the Sales department who earn above the average salary?

SELECT
    first_name
    || ' '
    || last_name AS "SALES EMPLOYEES WITH PAY ABOVE AVERAGE",
    salary
FROM
    employees
WHERE
        department_id = 80
    AND salary > (
        SELECT
            AVG(salary)
        FROM
            employees
    )
ORDER BY
    salary ASC;


/************************** Display records in a ordered manner and deal with NULL values. **************************/


-- Who are the employees who earn sales commission? List them in the order of the commission they earn.

SELECT
    first_name
    || ' '
    || last_name AS "EMPLOYEES WITH COMMISSION",
    commission_pct
FROM
    employees
WHERE
    commission_pct IS NOT NULL
ORDER BY
    commission_pct DESC;



-- List all the employess in order of the date they were hired beginning from the most recent.

SELECT
    first_name
    || ' '
    || last_name AS "EMPLOYEE NAME",
    hire_date
FROM
    employees
ORDER BY
    hire_date DESC,
    first_name,
    last_name;
