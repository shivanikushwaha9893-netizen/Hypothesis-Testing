/* Q1 */
SELECT 'Q1' Question,
'Null hypothesis assumes no difference or effect.' Answer;

/* Q2 */
SELECT 'Q2',
'Alpha is probability of rejecting true null hypothesis (usually 0.05).';

/* Q3 */
SELECT 'Q3',
'Type I: Reject true H0. Type II: Accept false H0.';

/* Q4 */
SELECT 'Q4',
'One tailed tests direction. Two tailed tests both sides.';

/* Q5 – One Sample t Test */

DROP TABLE IF EXISTS complaints;

CREATE TABLE complaints(time_taken FLOAT);

INSERT INTO complaints VALUES
(12),(11),(13),(10),(14),(9),(12),(11),(12);

WITH q5 AS(
SELECT AVG(time_taken) m, STDEV(time_taken) s, COUNT(*) n
FROM complaints
)
SELECT 'Q5 t-stat',
(m-10)/(s/SQRT(n))
FROM q5;

/* Q6 */
SELECT 'Q6',
'Z test when population SD known or large sample. T test when SD unknown.';

/* Q7 – Paired t Test */

DROP TABLE IF EXISTS productivity;

CREATE TABLE productivity(emp INT,before_val FLOAT,after_val FLOAT);

INSERT INTO productivity VALUES
(1,50,55),(2,60,65),(3,58,59),
(4,55,58),(5,62,63),(6,56,59);

WITH diff AS(
SELECT after_val-before_val d FROM productivity
),
stats AS(
SELECT AVG(d) m, STDEV(d) s, COUNT(*) n FROM diff
)
SELECT 'Q7 Paired t-stat',
m/(s/SQRT(n))
FROM stats;

/* Q8 – Chi Square */

DROP TABLE IF EXISTS gender;

CREATE TABLE gender(gender VARCHAR(10),A FLOAT,B FLOAT);

INSERT INTO gender VALUES
('Male',30,20),
('Female',10,40);

WITH totals AS(
SELECT SUM(A+B) gt, SUM(A) ta, SUM(B) tb FROM gender
),
exp AS(
SELECT A,B,
ta*(A+B)/gt ea,
tb*(A+B)/gt eb
FROM gender, totals
)
SELECT 'Q8 Chi Square',
SUM(POWER(A-ea,2)/ea + POWER(B-eb,2)/eb)
FROM exp;
