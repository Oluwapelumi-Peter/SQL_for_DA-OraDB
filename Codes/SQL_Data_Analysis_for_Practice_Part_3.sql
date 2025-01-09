

SELECT * FROM COUNTRIES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;
SELECT * FROM JOBS;
SELECT * FROM JOB_HISTORY;
SELECT * FROM LOCATIONS;
SELECT * FROM REGIONS;


/**************************-------------------------Aggregate Functions---------------------***************************/

---------Show department-wise information and headcount cost analysis for all active departments----------

SELECT
    d.department_id,
    d.department_name,
    e.first_name
    || ' '
    || e.last_name AS "MANAGER NAME",
    "HEAD COUNT",
    attrition,
    "MIN SALARY",
    "MAX SALARY",
    "AVERAGE SALARY",
    e.salary AS "MANAGER SALARY",
    "TOTAL SALARY",
    l.city,
    l.state_province,
    c.country_name,
    r.region_name
FROM
         employees e
    JOIN departments d ON e.department_id = d.department_id
    JOIN departments d ON e.employee_id = d.manager_id
    JOIN locations   l ON d.location_id = l.location_id
    JOIN countries   c ON l.country_id = c.country_id
    JOIN regions     r ON c.region_id = r.region_id
    JOIN (
        SELECT
            department_id,
            COUNT(*)    AS "HEAD COUNT",
            MIN(salary) AS "MIN SALARY",
            MAX(salary) AS "MAX SALARY",
            round(AVG(salary),
                  0)    AS "AVERAGE SALARY",
            SUM(salary) AS "TOTAL SALARY"
        FROM
            employees
        GROUP BY
            department_id
    )           s ON d.department_id = s.department_id
    LEFT JOIN (
        SELECT
            department_id,
            COUNT(*) AS attrition
        FROM
            job_history
        GROUP BY
            department_id
    )           a ON d.department_id = a.department_id
WHERE
    e.department_id IS NOT NULL
ORDER BY
    d.department_id;



-----------********The same result can be achieved with the alternative below**********--------------

SELECT
    d.department_id,
    d.department_name,
    e.first_name
    || ' '
    || e.last_name AS manager_name,
    "HEAD COUNT",
    "ATTRITION",
    "MIN SALARY",
    "MAX SALARY",
    "AVERAGE SALARY",
    e.salary AS "MANAGERS SALARY",
    "TOTAL SALARY",
    l.city,
    l.state_province,
    c.country_name,
    r.region_name
FROM
    departments d
    LEFT JOIN employees   e ON d.manager_id = e.employee_id
    LEFT JOIN locations   l ON d.location_id = l.location_id
    LEFT JOIN countries   c ON l.country_id = c.country_id
    LEFT JOIN regions     r ON c.region_id = r.region_id
    LEFT JOIN (
        SELECT
            department_id,
            MAX(salary) AS "MAX SALARY",
            MIN(salary) AS "MIN SALARY",
            round(AVG(salary),
                  0)    AS "AVERAGE SALARY",
            SUM(salary) AS "TOTAL SALARY",
            COUNT(*)    AS "HEAD COUNT"
        FROM
            employees
        GROUP BY
            department_id
    )           dept_sal_det ON d.department_id = dept_sal_det.department_id
    LEFT JOIN (
        SELECT
            department_id,
            COUNT(*) AS "ATTRITION"
        FROM
            job_history
        GROUP BY
            department_id
    )           emp_resignation_det ON d.department_id = emp_resignation_det.department_id
WHERE
    d.manager_id IS NOT NULL
ORDER BY
    d.department_id;
    



-----------------*************************Do a city-wise headcount cost analysis for all active cities***********************-----------------------------------


SELECT
    city,
    SUM("HEAD COUNT")   "CITY HEAD COUNT",
    MIN("MIN SALARY")   "CITY MIN SALARY",
    MAX("MAX SALARY")   "CITY MAX SALARY",
    round(AVG("AVERAGE SALARY"),
          0)            "CITY AVERAGE SALARY",
    SUM("TOTAL SALARY") "CITY TOTAL SALARY",
    state_province,
    country_name,
    region_name
FROM
    (
        SELECT
            d.department_id,
            d.department_name,
            e.first_name
            || ' '
            || e.last_name AS manager_name,
            "HEAD COUNT",
            "ATTRITION",
            "MIN SALARY",
            "MAX SALARY",
            "AVERAGE SALARY",
            e.salary       AS "MANAGERS SALARY",
            "TOTAL SALARY",
            l.city,
            l.state_province,
            c.country_name,
            r.region_name
        FROM
            departments d
            LEFT JOIN employees   e ON d.manager_id = e.employee_id
            LEFT JOIN locations   l ON d.location_id = l.location_id
            LEFT JOIN countries   c ON l.country_id = c.country_id
            LEFT JOIN regions     r ON c.region_id = r.region_id
            LEFT JOIN (
                SELECT
                    department_id,
                    MAX(salary) AS "MAX SALARY",
                    MIN(salary) AS "MIN SALARY",
                    round(AVG(salary),
                          0)    AS "AVERAGE SALARY",
                    SUM(salary) AS "TOTAL SALARY",
                    COUNT(*)    AS "HEAD COUNT"
                FROM
                    employees
                GROUP BY
                    department_id
            )           dept_sal_det ON d.department_id = dept_sal_det.department_id
            LEFT JOIN (
                SELECT
                    department_id,
                    COUNT(*) AS "ATTRITION"
                FROM
                    job_history
                GROUP BY
                    department_id
            )           emp_resignation_det ON d.department_id = emp_resignation_det.department_id
        WHERE
            d.manager_id IS NOT NULL
        ORDER BY
            d.department_id
    )
GROUP BY
    city,
    state_province,
    country_name,
    region_name

ORDER BY
    "CITY HEAD COUNT" DESC;
    
    


-----------------*************************Do a country-wise headcount cost analysis for all active countries***********************-----------------------------------


SELECT
    country_name,
    SUM("HEAD COUNT")   "COUNTRY HEAD COUNT",
    MIN("MIN SALARY")   "COUNTRY MIN SALARY",
    MAX("MAX SALARY")   "COUNTRY MAX SALARY",
    round(AVG("AVERAGE SALARY"),
          0)            "COUNTRY AVERAGE SALARY",
    SUM("TOTAL SALARY") "COUNTRY TOTAL SALARY",
    region_name
FROM
    (
        SELECT
            d.department_id,
            d.department_name,
            e.first_name
            || ' '
            || e.last_name AS manager_name,
            "HEAD COUNT",
            "ATTRITION",
            "MIN SALARY",
            "MAX SALARY",
            "AVERAGE SALARY",
            e.salary       AS "MANAGERS SALARY",
            "TOTAL SALARY",
            l.city,
            l.state_province,
            c.country_name,
            r.region_name
        FROM
            departments d
            LEFT JOIN employees   e ON d.manager_id = e.employee_id
            LEFT JOIN locations   l ON d.location_id = l.location_id
            LEFT JOIN countries   c ON l.country_id = c.country_id
            LEFT JOIN regions     r ON c.region_id = r.region_id
            LEFT JOIN (
                SELECT
                    department_id,
                    MAX(salary) AS "MAX SALARY",
                    MIN(salary) AS "MIN SALARY",
                    round(AVG(salary),
                          0)    AS "AVERAGE SALARY",
                    SUM(salary) AS "TOTAL SALARY",
                    COUNT(*)    AS "HEAD COUNT"
                FROM
                    employees
                GROUP BY
                    department_id
            )           dept_sal_det ON d.department_id = dept_sal_det.department_id
            LEFT JOIN (
                SELECT
                    department_id,
                    COUNT(*) AS "ATTRITION"
                FROM
                    job_history
                GROUP BY
                    department_id
            )           emp_resignation_det ON d.department_id = emp_resignation_det.department_id
        WHERE
            d.manager_id IS NOT NULL
        ORDER BY
            d.department_id
    )
GROUP BY
    country_name,
    region_name

ORDER BY
    "COUNTRY HEAD COUNT" DESC;

