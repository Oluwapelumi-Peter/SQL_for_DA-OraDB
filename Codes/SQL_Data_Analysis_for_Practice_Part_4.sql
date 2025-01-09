


--------------------------------------------------------Who are the lowest earners in each department? Provide some information about them.-----------------------------------------------------


WITH z AS (
    SELECT
        *
    FROM
        (
            SELECT
                ROW_NUMBER()
                OVER(PARTITION BY t.employee_id
                     ORDER BY
                         commission_pct
                ) AS ocurrence,
                t.*
            FROM
                employees t
        )
    WHERE
        ocurrence = 1
)
SELECT
    "DEPARTMENT ID",
    "DEPARTMENT NAME",
    "EMPLOYEE ID",
    "FULL NAME",
    "EMAIL ID",
    "PHONE NUMBER",
    "JOB TITLE",
    "HIRE DATE",
    salary,
    "MANAGER NAME"
FROM
    (
        SELECT
            z.department_id   "DEPARTMENT ID",
            d.department_name "DEPARTMENT NAME",
            z.employee_id     "EMPLOYEE ID",
            z.first_name
            || ' '
            || z.last_name    "FULL NAME",
            z.email           "EMAIL ID",
            z.phone_number    "PHONE NUMBER",
            j.job_title       "JOB TITLE",
            z.hire_date       "HIRE DATE",
            z.salary,
            m.first_name
            || ' '
            || m.last_name    "MANAGER NAME",
            RANK()
            OVER(PARTITION BY z.department_id
                 ORDER BY
                     z.salary
            )                 sal_rank
        FROM
            z
            LEFT JOIN departments d ON d.department_id = z.department_id
            LEFT JOIN jobs        j ON z.job_id = j.job_id
            LEFT JOIN employees   m ON z.manager_id = m.employee_id
    )
WHERE
    sal_rank = 1;
  
  
  
  -------------------------------------------Who are the highest earners in each department? Provide some information about them.------------------------------------------
  
  
  
  
  WITH z AS (
    SELECT
        *
    FROM
        (
            SELECT
                ROW_NUMBER()
                OVER(PARTITION BY t.employee_id
                     ORDER BY
                         commission_pct
                ) AS ocurrence,
                t.*
            FROM
                employees t
        )
    WHERE
        ocurrence = 1
)
SELECT
    "DEPARTMENT ID",
    "DEPARTMENT NAME",
    "EMPLOYEE ID",
    "FULL NAME",
    "EMAIL ID",
    "PHONE NUMBER",
    "JOB TITLE",
    "HIRE DATE",
    salary,
    "MANAGER NAME"
FROM
    (
        SELECT
            z.department_id   "DEPARTMENT ID",
            d.department_name "DEPARTMENT NAME",
            z.employee_id     "EMPLOYEE ID",
            z.first_name
            || ' '
            || z.last_name    "FULL NAME",
            z.email           "EMAIL ID",
            z.phone_number    "PHONE NUMBER",
            j.job_title       "JOB TITLE",
            z.hire_date       "HIRE DATE",
            z.salary,
            m.first_name
            || ' '
            || m.last_name    "MANAGER NAME",
            RANK()
            OVER(PARTITION BY z.department_id
                 ORDER BY
                     z.salary DESC
            )                 sal_rank
        FROM
            z
            LEFT JOIN departments d ON d.department_id = z.department_id
            LEFT JOIN jobs        j ON z.job_id = j.job_id
            LEFT JOIN employees   m ON z.manager_id = m.employee_id
    )
WHERE
    sal_rank = 1;