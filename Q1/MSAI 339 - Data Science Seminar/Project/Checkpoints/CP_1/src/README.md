# Checkpoint 1 - Source (SQL Queries) - Relational Analytics

### Salary Distribution
1.1 <u>Allegations per Officer and Corresponding Salary</u>
   ```sql
SELECT foo.number_complaints, foo.officer, s.salary, s.year
FROM (
     SELECT c.id as officer, count(t.*) as number_complaints
     FROM data_officerallegation t, data_officer c
     WHERE t.officer_id = c.id
     GROUP BY c.id
     HAVING count(t.*) > 1) as foo, data_salary s
WHERE s.officer_id = officer;
    ```

1.2 <u>Allegations per Officer with Distinct Salary and Corresponding Years</u>
   ```sql
SELECT f.number_complaints, f.officer, f.salary, s.year
FROM(
    SELECT DISTINCT foo.number_complaints, foo.officer, s.salary, s.id
    FROM(
        SELECT c.id as officer, count(t.*) as number_complaints
        FROM data_officerallegation t, data_officer c
        WHERE t.officer_id = c.id
        GROUP BY c.id
        HAVING count(t.*) > 1) as foo, data_salary s
    WHERE s.officer_id = officer) as f, data_salary s
WHERE f.id = s.id;
    ```

### Police Unit Distribution
2.1 <u>Allegations per Unit ID</u>
   ```sql
SELECT unit_id, count(*)as complaints
FROM(
    SELECT a.start_date as a_start,
           coalesce(a.end_date, coalesce(o.resignation_date, current_date))as a_end,
           h.effective_date as o_start,
           coalesce(h.end_date, coalesce(o.resignation_date, current_date)) as o_end,
           a.officer_id,
           h.unit_id
    FROM data_officerallegation a, data_officerhistory h, data_officer o
    WHERE a.officer_id = h.officer_id AND o.id = a.officer_id
    ORDER BY o.id) as q1
WHERE (a_start BETWEEN o_start AND o_end) AND (a_end BETWEEN o_start AND o_end)
GROUP BY unit_id
ORDER BY complaints
    ```

2.2 <u>Allegations per District</u>
   ```sql
SELECT unit_id, count(*) as complaints
FROM(
    SELECT a.start_date as a_start,
           coalesce(a.end_date, coalesce(o.resignation_date, current_date)) as a_end,
           h.effective_date as o_start,
           coalesce(h.end_date, coalesce(o.resignation_date, current_date)) as o_end,
           a.officer_id,
           h.unit_id
    FROM data_officerallegation a, data_officerhistory h, data_officer o
    WHERE a.officer_id = h.officer_id AND o.id = a.officer_id
    ORDER BY o.id) as q1
WHERE (a_start BETWEEN o_start AND o_end) AND (a_end BETWEEN o_start AND o_end) AND unit_id BETWEEN 2 AND 26
GROUP BY unit_id
ORDER BY complaints
    ```

### Officer Rank Allegation Distribution
3.1 <u>Allegations per Rank</u>
   ```sql
SELECT c.id, count(t.*) as COMPLAINTS FROM data_officerallegation t, data_officer c
WHERE t.officer_id = c.id
GROUP BY c.id
HAVING count(t.*) > 1
    ```

### Allegation Categories and Subcategories
4.1 <u>Allegations per Allegation Category</u>
   ```sql
SELECT c.category, count(t.*) as count
FROM data_officerallegation t, data_allegationcategory c
WHERE c.id = t.allegation_category_id
GROUP BY c.category
    ```

4.2 <u>Allegations per Allegation Subcategory</u>
   ```sql
SELECT c.allegation_name, count(t.*) as count
FROM data_officerallegation t, data_allegationcategory c
WHERE c.id = t.allegation_category_id
GROUP BY c.allegation_name
    ```