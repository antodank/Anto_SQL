DROP TABLE IF EXISTS tblStudent

CREATE TABLE tblStudent
(
    id INT,
    name VARCHAR(50) NOT NULL,
    gender VARCHAR(50) NOT NULL,
    DOB datetime NOT NULL,
    total_score INT NOT NULL,
    city VARCHAR(50) NOT NULL
 )

 EXECUTE sp_helpindex tblStudent

 INSERT INTO tblStudent
VALUES  
(6, 'Kate', 'Female', '03-JAN-1985', 500, 'Liverpool'), 
(2, 'Jon', 'Male', '02-FEB-1974', 545, 'Manchester'),
(9, 'Wise', 'Male', '11-NOV-1987', 499, 'Manchester'), 
(3, 'Sara', 'Female', '07-MAR-1988', 600, 'Leeds'), 
(1, 'Jolly', 'Female', '12-JUN-1989', 500, 'London'),
(4, 'Laura', 'Female', '22-DEC-1981', 400, 'Liverpool'),
(7, 'Joseph', 'Male', '09-APR-1982', 643, 'London'),  
(5, 'Alan', 'Male', '29-JUL-1993', 500, 'London'), 
(8, 'Mice', 'Male', '16-AUG-1974', 543, 'Liverpool'),
(10, 'Elis', 'Female', '28-OCT-1990', 400, 'Leeds');

select * from tblStudent

CREATE CLUSTERED INDEX  [PK_tblStudent_1] 
ON tblStudent ([id] ASC)

/* composite index */
CREATE CLUSTERED INDEX IX_tblStudent_Gender_Score
ON tblStudent(gender ASC, total_score DESC)
 

 CREATE NONCLUSTERED INDEX IX_tblStudent_Name
ON tblStudent(name ASC)


/*Drop index */
drop index IX_tblStudent_Name
drop index PK_tblStudent_1

 /*   

   Clustered indexes only sort tables. Therefore, they do not consume extra storage.
   
   Mostly if we applied PRIMARY_KEY to a table then it becomes clustered index 
   
   We can create custom clustered index using two or more column

   Primary key can be clustered index if no other cluster index specified else it act as non clustered
   

   a non-clustered index is stored at one place and table data is stored in another place.
   This allows for more than one non-clustered index per table

   non-clustered index usage - 
   when there is more than one set of columns that are used in the WHERE clause of queries


*/