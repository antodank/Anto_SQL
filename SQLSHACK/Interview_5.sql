
--  print dept name and max salary in each dept
select dept1.DeptID,DeptName, maxsalary
from 
Department dept1 inner join  
(select dept.DeptID, MAX(Salary) as maxsalary
from  Employee emp inner join
Department dept on emp.DeptID = dept.DeptID
group by dept.DeptID)  tt 
on dept1.DeptID = tt.DeptID

--  print dept name , emp name  with max salary in each dept
select DeptName,EmpName,Salary from
(select emp.EmpName, emp.Salary,emp.DeptID , dept.DeptName, DENSE_RANK() over (partition by emp.DeptID order by salary  desc ) as drank 
from Employee emp inner join Department dept on emp.DeptID = dept.DeptID) as temp where drank = 1 


-- more than 1 emp living in same area (duplicate rows)

select Address,count(Address) as Empcount from Employee group by Address having count(Address) > 1

-- row_number - more than 1 emp living in same area (duplicate rows)
select Address from
(select Address, ROW_NUMBER() over (partition by Address order by Address desc) as rn from Employee) as temp  where rn > 1


-- Last 5 records of the table
select top 5 * from Employee order by EmpID desc


--- Union removes duplicate rows
select DeptID,DeptName from Department
union 
select GroupID,GroupName from Groups


--- Union All
select DeptID,DeptName from Department
union all
select GroupID,GroupName from Groups

-- intersect shows matching rows
select DeptID,DeptName from Department
intersect 
select GroupID,GroupName from Groups


---- duplicate rows
WITH cte
AS
(select DeptID,DeptName from Department union all select GroupID,GroupName from Groups)
select DeptID,DeptName from 
(select DeptID,DeptName, ROW_NUMBER() over (Partition by DeptID,DeptName order by DeptID ) as rn from cte) 
temp2 where rn > 1

--WITH cte (dup_id, dup_name, dup_count)
--AS
--(SELECT dup_id, dup_name,
-- row_number() over (partition BY dup_id,
-- dup_name ORDER BY dup_id) AS dup_count
-- FROM dup_table)
--SELECT * FROM cte WHERE dup_count > 1;

select *,lSequenceNumber from TxMediaLine













