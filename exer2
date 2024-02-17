USE `enrollmentsystem`;
DELIMITER $$

CREATE TRIGGER `Students_AINS` AFTER INSERT ON Students FOR EACH ROW
BEGIN
declare no_more_rows int default 0;
declare temp varchar(20);
declare checker cursor for
	select subjcode from subjects;
DECLARE CONTINUE HANDLER FOR NOT FOUND
	SET no_more_rows = 1;
call courseyear(new.studid, @studcourse,@studyear);
open checker;
fetch checker into temp;

REPEAT
	select subjid from subjects where subjcode = temp;
	call process_subjcode(temp, @course,@yr);
	if @course = @studcourse and @yr = @studyear then
		insert into enroll(studid,subjid) values(new.studid,subjid);
	end if;
    
	FETCH checker INTO temp;
UNTIL no_more_rows = 1
END REPEAT;

CLOSE checker;
end

///////
-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE PROCEDURE `enrollmentsystem`.`process_subjcode` (subjcode varchar(20), out output varchar(20), out output2 int)
BEGIN
	declare fullcourse varchar(20);
    declare subjectyear int;

    set fullcourse = left(subjcode, 2);
    set subjectyear = substring(subjcode, 3, 1);
    
    set output = fullcourse;
    set output2 = subjectyear;
END
///////////
-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE PROCEDURE `enrollmentsystem`.`courseyear` (Studid int, out output varchar(20), out output2 int)
BEGIN
	declare course varchar(20);
    declare studyear int;
	select studcourse,studyear into course,studyear from students where studid = Studid;
	
    set course = right(course, 2);
    set studyear = left(studyear, 1);
    
    set output = course;
    set output2 = studyear;
END
---------------------------IN PROGRESS ---------------------------------------
CREATE DEFINER = CURRENT_USER TRIGGER `enrollmentsystem`.`Students_AFTER_INSERT` AFTER INSERT ON `Students` FOR EACH ROW
BEGIN
declare no_more_rows int default 0;
declare temp varchar(20);
declare studcourse varchar(20);
declare studyear int;
declare fullcourse varchar(20);
declare subjectyear int;
declare subjectid int;

declare checker cursor for
	select subjcode from subjects;
DECLARE CONTINUE HANDLER FOR NOT FOUND
	SET no_more_rows = 1;

select studcourse,studyear into studcourse,studyear from students where studid = new.studid;
set studcourse = right(studcourse, 2);
set studyear = left(studyear, 1);

open checker;
fetch checker into temp;
REPEAT
	select subjid into subjectid from subjects where subjcode = temp;
	set fullcourse = left(temp, 2);
    set subjectyear = substring(temp, 3, 1);
	if fullcourse = studcourse and subjectyear = studyear then
		insert into enroll(studid,subjid) values(new.studid,subjectid);
	end if;
    
	FETCH checker INTO temp;
UNTIL no_more_rows = 1
END REPEAT;
CLOSE checker;
END
