CREATE DEFINER=`root`@`localhost` PROCEDURE `updateSelfProfile`(IN PERSONID int,IN FIRSTNAME varchar(45),IN LASTNAME varchar(45),
IN CONTACT varchar(45),IN ABOUTME varchar(45),IN TITLE varchar(45),
IN MARITALSTATUS varchar(45),IN PASSPORT varchar(45))
BEGIN
	if(FIRSTNAME<>'') THEN update PERSON set FIRST_NAME=FIRSTNAME where PERSON_ID=PERSONID;END IF;
    if(LASTNAME<>'') THEN update PERSON set LAST_NAME=LASTNAME where PERSON_ID=PERSONID;END IF;
if(CONTACT<>'') THEN update PERSON set CONTACT_NO=CONTACT where PERSON_ID=PERSONID;END IF;
if(ABOUTME<>'') THEN update PERSON set ABOUT_ME=ABOUTME where PERSON_ID=PERSONID;END IF;
if(TITLE<>'') THEN update PERSON set TITLE=TITLE where PERSON_ID=PERSONID;END IF;
if(MARITALSTATUS<>'') THEN update PERSON set MARITAL_STATUS=MARITALSTATUS where PERSON_ID=PERSONID;END IF;
if(PASSPORT<>'') THEN update PERSON set PASSPORT_NO=PASSPORT where PERSON_ID=PERSONID;END IF;
if(TITLE<>'') THEN update PERSON set TITLE=TITLE where PERSON_ID=PERSONID;END IF;
END