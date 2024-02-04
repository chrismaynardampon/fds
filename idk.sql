CREATE PROCEDURE `sample2` (in Studid int, in subid int, out output varchar(20))
BEGIN
declare num int;
declare num2 int;
declare num3 int;
declare temp varchar(20);
declare checker cursor for
	select sched from (students left outer join enroll on students.studid = enroll.studid) left outer join subjects on subjects.subjid = enroll.subjid where enroll.studid = Studid;
open checker;
fetch checker into temp;


set num = 829;
call sample(Studid, subid, @a,@b);
select @a into num2;
select @b into num3;
if num < num2 and num > num3 then
	set output = 'hatdog';
else
	set output = 'hatkik';
end if;
END
