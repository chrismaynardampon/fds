CREATE PROCEDURE `sample2` (in studid int, in subid int, out output varchar(20))
BEGIN
declare num int;
declare num2 int;
set num = 829;
call sample(studid, subid, @a,@b);
select @a into num2;
if num < num2 then
	set output = 'hatdog';
else
	set output = 'hatdkik';
end if;
END
---------------------
CREATE PROCEDURE `sample` (studid int, subid int, out output int, out output2 int)
BEGIN
	declare fullsched varchar(20);
    declare sched_time varchar(10);
    declare sched_start int;
    declare sched_end int;
	
    select sched into fullsched from subjects where subjid = subid;
    
    set sched_time = right(fullsched, 7);
    set sched_start = left(sched_time, 3);
    set sched_end = right(sched_time, 3);
    
    set output = sched_start;
    set output2 = sched_end;
END
