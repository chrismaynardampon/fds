CREATE PROCEDURE `sample2` (in Studid int, in subid int, out output varchar(20))
BEGIN
declare no_more_products int default 0;
DECLARE conflict BOOLEAN DEFAULT FALSE;
declare sched1 varchar(20);
declare sched2 int;
declare sched3 int;
declare temp varchar(20);
declare checker cursor for
	select sched from (students left outer join enroll on students.studid = enroll.studid) left outer join subjects on subjects.subjid = enroll.subjid where enroll.studid = Studid;
DECLARE CONTINUE HANDLER FOR NOT FOUND
	SET no_more_products = 1;

call sample(Studid, subid, @a,@b,@c);
select @a into sched1;
select @b into sched2;
select @c into sched3;

open checker;
fetch checker into temp;
REPEAT
	-- Extract year, month, and day from expiration date
	call process_sched(checker, @sched_day,@sched_start,@sched_end);
	-- Check if the product is expired
	IF sched2 > sched_start THEN
		SET conflict = TRUE;
	elseif num = YEAR(NOW()) and num <= MONTH(NOW())  THEN
		SET conflict = TRUE;
	END IF;
	-- If the product is not expired, insert the order
	IF NOT num THEN
		INSERT INTO enroll (studid, subjid) VALUES (studid, subjid);
	END IF;
	FETCH checker INTO temp;
UNTIL no_more_products = 1
END REPEAT;
CLOSE checker;

END
------------------------------------
CREATE PROCEDURE `sample` (studid int, subid int, out output int, out output2 int, out output3 varchar(10))
BEGIN
	declare fullsched varchar(20);
    declare sched_time varchar(20);
    declare sched_day varchar(10);
    declare sched_start int;
    declare sched_end int;
	
    select sched into fullsched from subjects where subjid = subid;
    
    set sched_day = left(fullsched, 4);
    set sched_time = right(fullsched, 9);
    set sched_start = left(sched_time, 4);
    set sched_end = right(sched_time, 4);
    
    set output = sched_start;
    set output2 = sched_end;
    set output3 = sched_day;
END
------------------------------------
CREATE PROCEDURE `process_sched` (fullsched varchar(20), out output varchar(20), out output2 int, out output3 int)
BEGIN
	declare sched_time varchar(20);
    declare sched_day varchar(10);
    declare sched_start int;
    declare sched_end int;
	
    set sched_day = left(fullsched, 4);
    set sched_time = right(fullsched, 9);
    set sched_start = left(sched_time, 4);
    set sched_end = right(sched_time, 4);
    
    set output = sched_day;
    set output2 = sched_start;
    set output3 = sched_end;
END
----------------------
CREATE PROCEDURE `in progress` (in Studid int, in subid int, out output varchar(20),out output2 varchar(20))
BEGIN
declare no_more_rows int default 0;
DECLARE enrollment_count INT;
DECLARE conflict BOOLEAN DEFAULT FALSE;
declare sched1 varchar(20);
declare sched2 int;
declare sched3 int;
declare temp varchar(20);
declare checker cursor for
	select sched from (students left outer join enroll on students.studid = enroll.studid) left outer join subjects on subjects.subjid = enroll.subjid where enroll.studid = Studid;
DECLARE CONTINUE HANDLER FOR NOT FOUND
	SET no_more_rows = 1;
set output = 'conflict';
call sample(Studid, subid, @a,@b,@c);
select @a into sched1;
select @b into sched2;
select @c into sched3;

SELECT COUNT(*) INTO enrollment_count from (students left outer join enroll on students.studid = enroll.studid) left outer join subjects on subjects.subjid = enroll.subjid where enroll.studid = Studid; 
set enrollment_count = enrollment_count + 1;
set output2 = enrollment_count;
open checker;
fetch checker into temp;
REPEAT
	set enrollment_count = enrollment_count - 1;
	-- Extract year, month, and day from expiration date
	call process_sched(temp, @sched_day,@sched_start,@sched_end);
	-- Check if the product is expired
    CASE 
		WHEN 831 BETWEEN @sched_start AND @sched_end or 830 BETWEEN @sched_start AND @sched_end THEN
        if sched1 = @sched_day then
        SET conflict = true;
        else
        set conflict = false;
        end if;
        else
        SET conflict = false;
	end case;
    
	-- If the product is not expired, insert the order
	IF NOT conflict and enrollment_count = 0 THEN
		INSERT INTO enroll (studid, subjid) VALUES (Studid, subid);
        set output = 'enrolled';
	END IF;
    
	FETCH checker INTO temp;
UNTIL no_more_rows = 1
END REPEAT;
CLOSE checker;

END
