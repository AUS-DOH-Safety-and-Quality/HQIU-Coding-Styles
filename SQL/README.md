# HQIU SQL Coding Style

The following document provides an overview of HQIU's coding style for SQL, in particular Snowflake SQL. The examples are based in Snowflake, however the principles documented below can be applied across other versions of SQL.

# Purpose

Maintaining reproducibility and transparency is a core value the Healthcare Quality Intelligence team, and a SQL style guide can help us achieve that goal. Additionally, adhering to the basic rules in this style guide will improve our ability to share, maintain, and extend our analytics when working with SQL.

This document is written as a manual for anyone working in the HQIU team, but also as a guide for anyone who would like to write clean and clear code that is meant to be shared.

**NOTE**: This style guide is written for use with [Snowflake SQL](https://docs.snowflake.com/en/sql-reference-commands), but much of it can be applied to any SQL database.

# Principles

* We take a disciplined and practical approach to writing code.
* We regularly check-in code to Github
* We believe consistency in style is very important.
* We demonstrate intent explicitly in code, via clear structure and comments where needed.

# Rules

## General stuff

* Snowflake is case-insensitive so always capitalise functions and variables for consistency.
* Check code into github early and often.
* Tabs are defaulted to 2 spaces per indent.
  * When using VSCode for building your queries, set the following options in the settings (`Ctrl + ,`) to assist with indentation:
    * "editor.tabSize": 2
    * "editor.insertSpaces": true
    * "editor.detectIndentation": false
* No trailing whitespace.
* Always capitalize SQL keywords (e.g., `SELECT` or `AS`)
* Variable names should be underscore separated and capitalised ([screaming snake case](https://www.pluralsight.com/blog/software-development/programming-naming-conventions-explained#screaming-snake-case)):

  __GOOD__:
  `SELECT COUNT(*) AS EVENT_COUNT`

  __BAD__:
  `SELECT COUNT(*) AS eventCount`

* Comments should go near the top of your query, or at least near the closest `SELECT`
* Try to only comment on things that aren't obvious about the query (e.g., why a particular ID is hardcoded, etc.), that explains the reasoning behind your code
* Don't use single letter variable names be as descriptive as possible given the context:

  __GOOD__:
  `SELECT MORB_EP.SEPARATION_DATE AS MORB_SEPARATION_DATE`

  __BAD__:
  `SELECT MORB_EP.SEPARATION_DATE AS S`
* Don't use single letter table names, also be as descriptive as possible given the context:

  __GOOD__:
  `FROM MORBIDITY_EPISODE AS MORB_EP`

  __BAD__:
  `FROM MORBIDITY_EPISODE AS TB1`


* Use [Common Table Expressions](https://docs.snowflake.com/en/user-guide/queries-cte) (CTEs) early and often, and name them well.

## `SELECT`

Align all columns to the first column on their own line:

```sql
SELECT
  MORB_EP.UMRN,
  CLIENT.DATE_OF_BIRTH,
  MORB_ICD.ICD_CODE,
  COUNT(MORB_EP.EVENT_ID) AS EVENT_COUNT
FROM ...
```

`SELECT` goes on its own line:

```sql
SELECT
  UMRN,
  ...
```

Always rename aggregates and function-wrapped columns:

```sql
SELECT
  UMRN,
  SUM(LENGTH_OF_STAY_DAYS) AS SUM_LOS
FROM ...
```

Always select with table aliases if you have joins:
```sql
SELECT
  MORB_EP.UMRN,
  CLIENT.DATE_OF_BIRTH,
  SUM(MORB_EP.LENGTH_OF_STAY_DAYS) AS SUM_LOS
FROM HMDC.MORBIDITY_EPISODE AS MORB_EP
INNER JOIN HMDC.CLIENT AS CLIENT ON ...
```

Always rename all columns when selecting with table aliases:

```sql
SELECT
  MORB_EP.UMRN AS UMRN,
  CLIENT.DATE_OF_BIRTH AS DATE_OF_BIRTH,
  SUM(MORB_EP.LENGTH_OF_STAY_DAYS) AS SUM_LOS
FROM HMDC.MORBIDITY_EPISODE AS MORB_EP
INNER JOIN HMDC.CLIENT AS CLIENT ON ...
```

Always use `AS` to rename columns:

__GOOD__:

```sql
SELECT
  MORB_EP.UMRN AS UMRN,
  SUM(MORB_EP.LENGTH_OF_STAY_DAYS) AS SUM_LOS
...
```

__BAD__:

```sql
SELECT
  MORB_EP.UMRN UMRN,
  SUM(MORB_EP.LENGTH_OF_STAY_DAYS) SUM_LOS
...
```

Long [Window functions](https://docs.snowflake.com/en/user-guide/functions-window-using) should be split across multiple lines: one for the `PARTITION`, `ORDER` and frame clauses, aligned to the `PARTITION` keyword. Multiple partition keys should be one-per-line, aligned to the first, with aligned commas. Order (`ASC`, `DESC`) should always be explicit. All window functions should be aliased.

```sql
ROW_NUM() OVER (
  PARTITION BY 
    UMRN,
    SEPARATION_YEAR
  ORDER BY SEPARATION_DATE DESC
  ROWS UNBOUNDED PRECEDING
) AS ORDERED_EVENTS_BY_UMRN_YEAR
```

## `FROM`

Only one table should be in the `FROM`. Never use `FROM`-joins:

__GOOD__:

```sql
SELECT
  MORB_EP.UMRN,
  CLIENT.DATE_OF_BIRTH,
  COUNT(MORB_EP.EVENT_ID) AS EVENT_COUNT
FROM HMDC.MORBIDITY_EPISODE AS MORB_EP
INNER JOIN HMDC.CLIENT AS CLI 
  ON MORB_EP.UMRN = CLI.UMRN
...
```

__BAD__:

```sql
SELECT
  MORB_EP.UMRN,
  CLIENT.DATE_OF_BIRTH,
  COUNT(MORB_EP.EVENT_ID) AS EVENT_COUNT
FROM HMDC.MORBIDITY_EPISODE AS MORB_EP, HMDC.CLIENT AS CLI 
WHERE 
  MORB_EP.UMRN = CLI.UMRN
...
```

Always provide aliases for your tables and use `AS` to rename tables:

__GOOD__:

```sql
SELECT
  MORB_EP.UMRN AS UMRN
FROM HMDC.MORBIDITY_EPISODE AS MORB_EP
...
```

__BAD__:

```sql
SELECT
  MORB_EP.UMRN UMRN
FROM HMDC.MORBIDITY_EPISODE MORB_EP
...
```
## `JOIN`
[From Snowflake](https://docs.snowflake.com/en/user-guide/querying-joins)
> A join combines rows from two tables to create a new combined row that can be used in the query.

Explicitly use `INNER JOIN` not just `JOIN`, making multiple lines of `INNER JOIN`s easier to scan:

__GOOD__:

```sql
SELECT
  MORB_EP.UMRN,
  CLIENT.DATE_OF_BIRTH
FROM HMDC.MORBIDITY_EPISODE AS MORB_EP
INNER JOIN HMDC.CLIENT AS CLI 
  ON ...
INNER JOIN ...
LEFT JOIN HMDC.MORBIDITY_ICD AS MORB_ICD 
  ON ...
LEFT JOIN ...
```

__BAD__:

```sql
SELECT
  MORB_EP.UMRN,
  CLIENT.DATE_OF_BIRTH
FROM HMDC.MORBIDITY_EPISODE AS MORB_EP
JOIN HMDC.CLIENT AS CLI 
  ON ...
JOIN ...
LEFT JOIN HMDC.MORBIDITY_ICD AS MORB_ICD 
  ON ...
LEFT JOIN ...
```

The `ON` keyword and condition goes in the `INNER JOIN` go on a new indented line:

```sql
SELECT
  MORB_EP.UMRN,
  CLIENT.DATE_OF_BIRTH
FROM HMDC.MORBIDITY_EPISODE AS MORB_EP
INNER JOIN HMDC.CLIENT AS CLI 
  ON MORB_EP.UMRN = CLI.UMRN
...
```

Additional filters in the `INNER JOIN` go on a new double indented line, beginning with the `AND` and `OR` SQL operator:

```sql
SELECT
  MORB_EP.UMRN,
  CLIENT.DATE_OF_BIRTH
FROM HMDC.MORBIDITY_EPISODE AS MORB_EP
INNER JOIN HMDC.CLIENT AS CLI 
  ON MORB_EP.UMRN = CLI.UMRN
    AND MORB_EP.DATE_OF_BIRTH = CLI.DATE_OF_BIRTH
...
```

Begin with `INNER JOIN`s and then list `LEFT JOIN`s, order them semantically, and do not intermingle `LEFT JOIN`s with `INNER JOIN`s unless necessary:

__GOOD__:

```sql
INNER JOIN HMDC.MORBIDITY_ICD AS MORB_ICD 
  ON ...
INNER JOIN HMDC.ADMISSION_STATUS AS ADM_STAT 
  ON ...
INNER JOIN HMDC.MODE_OF_SEPARATION AS MODE_SEP 
  ON ...
LEFT JOIN HMDC.CLIENT AS CLI 
  ON ...
LEFT JOIN ...
```

__BAD__:

```sql
INNER JOIN HMDC.MORBIDITY_ICD AS MORB_ICD 
  ON ...
LEFT JOIN HMDC.CLIENT AS CLI 
  ON ...
INNER JOIN HMDC.ADMISSION_STATUS AS ADM_STAT 
  ON ...
LEFT JOIN ...
```

## `WHERE`

Multiple `WHERE` clauses should go on different lines and begin with the SQL operator:

```sql
SELECT
  UMRN,
  SEPARATION_DATE
FROM HMDC.MORBIDITY_EPISODE AS MORB_EP
WHERE
  ESTABLISHMENT_CODE = 101
  AND SEPARATION_DATE >= '2020-01-01'
...
```

## `GROUP BY`

Align all columns to the first column on their own line:

```sql
GROUP BY
  MORB_EP.UMRN,
  MORB_ICD.ICD_CODE
```

`GROUP BY` goes on its own line:

```sql
GROUP BY
  UMRN,
  ...
```

Remember that in Snowflake you can utilise named variables from your `SELECT` statement in `GROUP BY`:

```sql
SELECT
  UMRN,
  LAST_DAY(SEPARATION_YEAR, 'month') AS SEPARATION_MONTH,
  COUNT(EVENT_ID) AS EVENT_COUNT
FROM HMDC.MORBIDITY_EPISODE AS MORB_EP
GROUP BY
  UMRN,
  SEPARATION_MONTH
```

## `ORDER BY`

Follow the same conventions as the `GROUP BY` section for intending and named variables.

Be explicit in the direction of ordering:

```sql
ORDER BY
  UMRN ASC,
  SEPARATION_MONTH DESC
```

## `CASE`

`CASE` statements aren't always easy to format but try to align each `WHEN` and `THEN` on a new indented row, and the final `ELSE` on a new indented row inside `CASE` and `END`:

```sql
CASE 
  WHEN ESTABLISHMENT_CODE = 101 THEN 'A'
  WHEN ESTABLISHMENT_CODE = 102 THEN 'B'
  ELSE NULL
END
```

## Common Table Expressions (CTEs)

[From Snowflake](https://docs.snowflake.com/en/user-guide/queries-cte):

> A CTE (common table expression) is a named subquery defined in a `WITH` clause. You can think of the CTE as a temporary view for use in the statement that defines the CTE. The CTE defines the temporary view’s name, an optional list of column names, and a query expression (i.e. a `SELECT` statement). The result of the query expression is effectively a table. Each column of that table corresponds to a column in the (optional) list of column names.

The body of a CTE must be one indent further than the `WITH` keyword. Open them at the end of a line and close them on a new line:

```sql
WITH EVENTS_PER_UMRN AS (
  SELECT
    UMRN,
    ...
)
```

Multiple CTEs should be formatted accordingly:

```sql
WITH EVENTS_PER_UMRN AS (
  SELECT
    ...
), 
EVENTS AS (
  SELECT
    ...
), 
UMRN AS (
  ...
)
SELECT * FROM UMRN
```

Always use CTEs over inlined subqueries.

__BAD__:

```sql
SELECT *
FROM (
  SELECT *
  FROM (
    SELECT *
    FROM ...
  )
)
LEFT JOIN (
  SELECT *
  FROM ...
)
```