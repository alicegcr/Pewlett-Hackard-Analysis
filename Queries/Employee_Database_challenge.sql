-- Delivery 1 
-- create a table to retrieve employees and titles
SELECT e.emp_no,
e.first_name,
e.last_name,
titles.title, 
titles.from_date,
titles.to_date
-- INTO retirement_titles
FROM employees as e
INNER JOIN titles as titles
ON titles.emp_no = e.emp_no
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no ASC;

-- Remove these duplicates 
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no ASC, to_date DESC;

-- Retrieve the number of employees by their most 
-- recent job title who are about to retire.
SELECT COUNT (emp_no) title_count, title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT (title) DESC;


-- Delivery 2
-- Create a Mentorship Eligibility table
SELECT DISTINCT ON (emp_no)e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
titles.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as titles
ON (e.emp_no = titles.emp_no)
WHERE (de.to_date = '9999-01-01')
    AND (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no