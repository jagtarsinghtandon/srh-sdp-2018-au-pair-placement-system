CREATE DEFINER=`root`@`localhost` PROCEDURE `searchByPreference`(
 IN PERSONID int,IN PERSONTYPE varchar(45),
 IN GENDER Varchar(50),IN QUALIFICATION Varchar(50),IN COUNTRY Varchar(50),
 IN CITY Varchar(50),
 IN RANDOMSEARCH Varchar(50)
,IN PREFERREDLANGUAGE Varchar(50)
)
BEGIN
SET @WHERECLAUSE =' Where P.IS_ACTIVE=1';
	 IF GENDER<> '' THEN
     #SET @filterCondition=' AND P.GENDER = '''+GENDER+'''';
     SET @filterCondition=CONCAT(' AND P.GENDER = ''',GENDER);
     SET @filterCondition=CONCAT(@filterCondition,'''');
	 SET @WHERECLAUSE =CONCAT(@WHERECLAUSE,@filterCondition);
	 END IF;
	 IF COUNTRY <> ''THEN
     #SET @WHERECLAUSE =CONCAT(@WHERECLAUSE,' AND CC.COUNTRY_NAME= '''+COUNTRY+'''');
	 SET @filterCondition=CONCAT(' AND CC.COUNTRY_NAME= ''',COUNTRY);
     SET @filterCondition=CONCAT(@filterCondition,'''');
	 SET @WHERECLAUSE =CONCAT(@WHERECLAUSE,@filterCondition);
	 END IF;
	 IF CITY <> ''THEN
	 #SET @WHERECLAUSE =CONCAT(@WHERECLAUSE,' AND A.CITY= '''+CITY+'''');
	 SET @filterCondition=CONCAT(' AND A.CITY= ''',CITY);
     SET @filterCondition=CONCAT(@filterCondition,'''');
	 SET @WHERECLAUSE =CONCAT(@WHERECLAUSE,@filterCondition);
	 END IF;
	 IF PREFERREDLANGUAGE <> ''THEN
	 SET @filterCondition=CONCAT(' AND L.LANGUAGES LIKE ''%',PREFERREDLANGUAGE,'%''');
	 SET @WHERECLAUSE =CONCAT(@WHERECLAUSE,@filterCondition);
	 #SET @WHERECLAUSE =CONCAT(@WHERECLAUSE,' AND P.TITLE LIKE ''%'+RANDOMSEARCH+'%''
     #OR P.ABOUT_ME LIKE ''%'+RANDOMSEARCH+'%''');
	 END IF;
     IF RANDOMSEARCH <> ''THEN	
     SET @filterCondition=CONCAT(' OR AU.HOBBIES LIKE ''%',RANDOMSEARCH);
     SET @filterCondition=CONCAT(@filterCondition,'%''');
	 SET @WHERECLAUSE =CONCAT(@WHERECLAUSE,@filterCondition);
	 END IF;
     IF PERSONTYPE ='HOST'THEN	
	 IF QUALIFICATION <> ''THEN	
     SET @filterCondition=CONCAT(' AND AU.EDU_QUALIFICATION LIKE ''%',QUALIFICATION);
     SET @filterCondition=CONCAT(@filterCondition,'%''');
	 SET @WHERECLAUSE =CONCAT(@WHERECLAUSE,@filterCondition);
	 #SET @WHERECLAUSE =CONCAT(@WHERECLAUSE,' AND AU.`EDU_QUALIFICATION` = '''+ QUALIFICATION+'''
     #OR P.HOBBIES LIKE ''%'+RANDOMSEARCH+'%''');
	 END IF;
     IF RANDOMSEARCH <> ''THEN	
     SET @filterCondition=CONCAT(' OR AU.HOBBIES LIKE ''%',RANDOMSEARCH);
     SET @filterCondition=CONCAT(@filterCondition,'%''');
	 SET @WHERECLAUSE =CONCAT(@WHERECLAUSE,@filterCondition);
	 END IF;
     #IF(HAS_DRIVING_LICENSE IS NOT NULL) THEN
	 #SET @WHERECLAUSE =CONCAT(@WHERECLAUSE,' AND AU.HAS_DRIVING_LICENSE= '+HAS_DRIVING_LICENSE+'');
     #END IF;
     #IF(HAS_DRIVING_LICENSE IS NOT NULL) THEN
	 #SET @WHERECLAUSE =CONCAT(@WHERECLAUSE,' AND AU.HAS_VALID_VISA= '+HAS_VALID_VISA+'');
     #END IF;
	 set @v_Query='SELECT AU.*,P.*,CC.COUNTRY_NAME,A.*,L.* FROM PERSON P INNER JOIN au_pair AU ON 
     P.PERSON_ID=AU.PERSON_ID INNER JOIN address A ON P.PERSON_ID=A.PERSON_ID INNER JOIN 
     `LANGUAGES` L ON P.PERSON_ID=L.PERSON_ID INNER JOIN
     country_currency CC ON CC.COUNTRY_CURRENCY_ID=A.COUNTRY_CURRENCY_ID ';
     ELSEIF PERSONTYPE ='AUPAIR'THEN
     #IF(IS_SALARY_PROVIDED IS NOT NULL) THEN
	 #SET @WHERECLAUSE =CONCAT(@WHERECLAUSE,' AND H.IS_SALARY_PROVIDED= '+IS_SALARY_PROVIDED+'');
     #END IF;
	 set @v_Query='SELECT H.*,P.*,CC.COUNTRY_NAME,A.*,L.* FROM PERSON P INNER JOIN HOSTUSER H ON 
    P.PERSON_ID=H.PERSON_ID INNER JOIN ADDRESS A ON P.PERSON_ID=A.PERSON_ID INNER JOIN  
     `LANGUAGES` L ON P.PERSON_ID=L.PERSON_ID INNER JOIN
    COUNTRY_CURRENCY CC ON CC.COUNTRY_CURRENCY_ID=A.COUNTRY_CURRENCY_ID ';
	 END IF;
     SET @FULLQUERY=CONCAT(@v_Query, @WHERECLAUSE);
         PREPARE STATEMENT FROM  @FULLQUERY;
         EXECUTE STATEMENT;
END
