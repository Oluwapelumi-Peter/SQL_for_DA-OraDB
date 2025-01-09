/************************** Inner Join: display employee/department details. **************************/


-- List out the departments without managers in ascending order, with their city, state, country and region.

----Traditional Code-----
SELECT
    departments.department_name,
    locations.city,
    locations.state_province,
    countries.country_name,
    regions.region_name
FROM
    departments,
    locations,
    countries,
    regions
WHERE
    departments.manager_id IS NULL
    AND departments.location_id = locations.location_id
    AND locations.country_id = countries.country_id
    AND countries.region_id = regions.region_id
ORDER BY
    department_name ASC;

-----ANSI Code------
SELECT
    departments.department_name,
    locations.city,
    locations.state_province,
    countries.country_name,
    regions.region_name
FROM
         departments
    INNER JOIN locations ON departments.location_id = locations.location_id
                            AND departments.manager_id IS NULL
    INNER JOIN countries ON locations.country_id = countries.country_id
    INNER JOIN regions ON countries.region_id = regions.region_id
ORDER BY
    department_name ASC;



-- List out the departments that have managers in ascending order, with their managers, city, state, country and region.


----Traditional Code-----
SELECT
    departments.department_name,
    employees.first_name
    || ' '
    || employees.last_name manager_name,
    locations.city,
    locations.state_province,
    countries.country_name,
    regions.region_name
FROM
    departments,
    locations,
    countries,
    regions,
    employees
WHERE
    departments.manager_id IS NOT NULL
    AND departments.location_id = locations.location_id
    AND locations.country_id = countries.country_id
    AND countries.region_id = regions.region_id
    AND employees.employee_id = departments.manager_id
ORDER BY
    department_name ASC;

-----ANSI Code------
SELECT
    departments.department_name,
    employees.first_name
    || ' '
    || employees.last_name manager_name,
    locations.city,
    locations.state_province,
    countries.country_name,
    regions.region_name
FROM
         departments
    INNER JOIN locations ON departments.location_id = locations.location_id
                            AND departments.manager_id IS NOT NULL
    INNER JOIN employees ON employees.employee_id = departments.manager_id
    INNER JOIN countries ON locations.country_id = countries.country_id
    INNER JOIN regions ON countries.region_id = regions.region_id
ORDER BY
    department_name ASC;



-----List out all the employees and display all relevant information for each of them.


----Traditional Code-----
SELECT
    e.first_name
    || ' '
    || e.last_name employee_name,
    e.email,
    e.phone_number,
    e.hire_date,
    jobs.job_title,
    e.salary,
    e.commission_pct,
    departments.department_name,
    locations.city,
    locations.state_province,
    countries.country_name,
    regions.region_name,
    m.first_name
    || ' '
    || m.last_name manager_name
FROM
    departments,
    locations,
    countries,
    regions,
    employees e,
    employees m,
    jobs
WHERE
        e.job_id = jobs.job_id
    AND e.department_id = departments.department_id (+)
    AND departments.location_id = locations.location_id (+)
    AND locations.country_id = countries.country_id (+)
    AND countries.region_id = regions.region_id (+)
    AND e.manager_id = m.employee_id (+)
ORDER BY
    employee_name ASC;

-----ANSI Code

SELECT
    e.first_name
    || ' '
    || e.last_name employee_name,
    e.email,
    e.phone_number,
    e.hire_date,
    jobs.job_title,
    e.salary,
    e.commission_pct,
    departments.department_name,
    locations.city,
    locations.state_province,
    countries.country_name,
    regions.region_name,
    m.first_name
    || ' '
    || m.last_name manager_name
FROM
    employees e
    LEFT JOIN employees m ON e.manager_id = m.employee_id
    LEFT JOIN departments ON e.department_id = departments.department_id
    LEFT JOIN locations ON departments.location_id = locations.location_id
    LEFT JOIN countries ON locations.country_id = countries.country_id
    LEFT JOIN regions ON countries.region_id = regions.region_id
    LEFT JOIN jobs ON e.job_id = jobs.job_id
ORDER BY
    employee_name ASC;



------Hw many sales staff are there in the organization? List them out with all the relevantinformation about them.------


-----Traditional Code

SELECT
    e.first_name
    || ' '
    || e.last_name employee_name,
    e.email,
    e.phone_number,
    e.hire_date,
    jobs.job_title,
    e.salary,
    e.commission_pct,
    departments.department_name,
    locations.city,
    locations.state_province,
    countries.country_name,
    regions.region_name,
    m.first_name
    || ' '
    || m.last_name manager_name
FROM
    departments,
    locations,
    countries,
    regions,
    employees e,
    employees m,
    jobs
WHERE
        e.job_id = jobs.job_id
    AND e.department_id = departments.department_id (+)
    AND departments.location_id = locations.location_id (+)
    AND locations.country_id = countries.country_id (+)
    AND countries.region_id = regions.region_id (+)
    AND e.manager_id = m.employee_id (+)
    AND jobs.job_title LIKE '%Sales%'
ORDER BY
    employee_name ASC;

------ANSI Code

SELECT
    e.first_name
    || ' '
    || e.last_name employee_name,
    e.email,
    e.phone_number,
    e.hire_date,
    jobs.job_title,
    e.salary,
    e.commission_pct,
    departments.department_name,
    locations.city,
    locations.state_province,
    countries.country_name,
    regions.region_name,
    m.first_name
    || ' '
    || m.last_name manager_name
FROM
    employees e
    LEFT JOIN employees m ON e.manager_id = m.employee_id
    LEFT JOIN departments ON e.department_id = departments.department_id
    LEFT JOIN locations ON departments.location_id = locations.location_id
    LEFT JOIN countries ON locations.country_id = countries.country_id
    LEFT JOIN regions ON countries.region_id = regions.region_id
    LEFT JOIN jobs ON e.job_id = jobs.job_id
WHERE
    jobs.job_title LIKE '%Sales%'
ORDER BY
    employee_name ASC;



------Hw many managers are there in the organization? List them out with all the relevantinformation about them.------


SELECT
    e.first_name
    || ' '
    || e.last_name employee_name,
    e.email,
    e.phone_number,
    e.hire_date,
    jobs.job_title,
    e.salary,
    e.commission_pct,
    departments.department_name,
    locations.city,
    locations.state_province,
    countries.country_name,
    regions.region_name,
    m.first_name
    || ' '
    || m.last_name manager_name
FROM
    departments,
    locations,
    countries,
    regions,
    employees e,
    employees m,
    jobs
WHERE
        e.job_id = jobs.job_id
    AND e.department_id = departments.department_id (+)
    AND departments.location_id = locations.location_id (+)
    AND locations.country_id = countries.country_id (+)
    AND countries.region_id = regions.region_id (+)
    AND e.manager_id = m.employee_id (+)
    AND jobs.job_title LIKE '%Manager%'
ORDER BY
    employee_name ASC;

------ANSI Code

SELECT
    e.first_name
    || ' '
    || e.last_name employee_name,
    e.email,
    e.phone_number,
    e.hire_date,
    jobs.job_title,
    e.salary,
    e.commission_pct,
    departments.department_name,
    locations.city,
    locations.state_province,
    countries.country_name,
    regions.region_name,
    m.first_name
    || ' '
    || m.last_name manager_name
FROM
    employees e
    LEFT JOIN employees m ON e.manager_id = m.employee_id
    LEFT JOIN departments ON e.department_id = departments.department_id
    LEFT JOIN locations ON departments.location_id = locations.location_id
    LEFT JOIN countries ON locations.country_id = countries.country_id
    LEFT JOIN regions ON countries.region_id = regions.region_id
    LEFT JOIN jobs ON e.job_id = jobs.job_id
WHERE
    jobs.job_title LIKE '%Manager%'
ORDER BY
    employee_name ASC;



-------List the employees who earn below the average salary and display all the relevant information about them---------


----Traditional Code-----
SELECT
    e.first_name
    || ' '
    || e.last_name employee_name,
    e.email,
    e.phone_number,
    e.hire_date,
    jobs.job_title,
    e.salary,
    e.commission_pct,
    departments.department_name,
    locations.city,
    locations.state_province,
    countries.country_name,
    regions.region_name,
    m.first_name
    || ' '
    || m.last_name manager_name
FROM
    departments,
    locations,
    countries,
    regions,
    employees e,
    employees m,
    jobs
WHERE
        e.job_id = jobs.job_id
    AND e.department_id = departments.department_id (+)
    AND departments.location_id = locations.location_id (+)
    AND locations.country_id = countries.country_id (+)
    AND countries.region_id = regions.region_id (+)
    AND e.manager_id = m.employee_id (+)
    AND e.salary < (
        SELECT
            AVG(salary)
        FROM
            employees
    )
ORDER BY
    employee_name ASC,
    e.salary DESC;


-----------------------------------------------------------------------------------------------------------


SELECT
    e.first_name
    || ' '
    || e.last_name employee_name,
    e.email,
    e.phone_number,
    e.hire_date,
    jobs.job_title,
    e.salary,
    e.commission_pct,
    departments.department_name,
    locations.city,
    locations.state_province,
    countries.country_name,
    regions.region_name,
    m.first_name
    || ' '
    || m.last_name manager_name
FROM
    employees e
    LEFT JOIN employees m ON e.manager_id = m.employee_id
    LEFT JOIN departments ON e.department_id = departments.department_id
    LEFT JOIN locations ON departments.location_id = locations.location_id
    LEFT JOIN countries ON locations.country_id = countries.country_id
    LEFT JOIN regions ON countries.region_id = regions.region_id
    LEFT JOIN jobs ON e.job_id = jobs.job_id
WHERE
    e.salary < (
        SELECT
            AVG(salary)
        FROM
            employees
    )
ORDER BY
    employee_name ASC,
    e.salary DESC;



/************************** LEFT OUTER JOIN: List down all the departments along with employees working under it. **************************/


--Traditional Code----
SELECT
    d.department_id,
    d.department_name,
    e.employee_id,
    e.first_name
    || ' '
    || e.last_name name,
    e.email
FROM
    departments d,
    employees   e
WHERE
    d.department_id = e.department_id (+)
ORDER BY
    d.department_id;

--ANSI Code----
SELECT
    d.department_id,
    d.department_name,
    e.employee_id,
    e.first_name
    || ' '
    || e.last_name name,
    e.email
FROM
    departments d
    LEFT OUTER JOIN employees   e ON d.department_id = e.department_id
ORDER BY
    d.department_id;

/************************** RIGHT OUTER JOIN: List down all the employees along with department details. **************************/

--List down all the employees along with department details.
SELECT
    e.employee_id,
    e.first_name
    || ' '
    || e.last_name name,
    e.email,
    d.department_id,
    d.department_name
FROM
    departments d,
    employees   e
WHERE
    d.department_id (+) = e.department_id
ORDER BY
    d.department_id;

--ANSI JOIN
SELECT
    e.employee_id,
    e.first_name
    || ' '
    || e.last_name name,
    e.email,
    d.department_id,
    d.department_name
FROM
    departments d
    RIGHT OUTER JOIN employees   e ON d.department_id = e.department_id
ORDER BY
    d.department_id;


/************************** FULL OUTER JOIN and SELF JOIN **************************/

--FULL OUTER JOIN: Display all the employee and department records along with missing data.


--ANSI Code

SELECT
    d.department_id,
    d.department_name,
    e.employee_id,
    e.first_name
    || ' '
    || e.last_name name,
    e.email
FROM
    departments d
    FULL OUTER JOIN employees   e ON d.department_id = e.department_id
ORDER BY
    d.department_id;--SELF JOIN: display employee details along with manager details

----Traditional Code-----

SELECT
    e.employee_id,
    e.first_name
    || ' '
    || e.last_name name,
    e.email,
    m.employee_id  AS mgr_employee_id,
    m.first_name
    || ' '
    || m.last_name mgr_name
FROM
    employees e,
    employees m
WHERE
    e.manager_id = m.employee_id (+)
ORDER BY
    e.employee_id;
    

--------ANSI Code


SELECT
    e.employee_id,
    e.first_name
    || ' '
    || e.last_name name,
    e.email,
    m.employee_id  AS mgr_employee_id,
    m.first_name
    || ' '
    || m.last_name mgr_name
FROM
    employees e
    LEFT JOIN employees m ON e.manager_id = m.employee_id
ORDER BY
    e.employee_id;


--FULL OUTER JOIN: Display all the employee and department records along with missing data.


--Traditional Code---

SELECT
    d.department_id,
    d.department_name,
    e.employee_id,
    e.first_name
    || ' '
    || e.last_name name,
    e.email
FROM
    departments d,
    employees   e
WHERE
    d.department_id = e.department_id (+)
UNION
SELECT
    d.department_id,
    d.department_name,
    e.employee_id,
    e.first_name
    || ' '
    || e.last_name name,
    e.email
FROM
    departments d,
    employees   e
WHERE
    d.department_id (+) = e.department_id;


--ANSI Code----

SELECT
    d.department_id,
    d.department_name,
    e.employee_id,
    e.first_name
    || ' '
    || e.last_name name,
    e.email
FROM
    departments d
    FULL OUTER JOIN employees   e ON d.department_id = e.department_id
ORDER BY
    d.department_id;


---------****************************The End**************************---------------------------



