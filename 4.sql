-- 1. List all the student detailsstudying in fourth semester ‘C’section.
SELECT S.*, SS.SEM, SS.SEC
FROM STUDENT S, SEMSEC SS, CLASS C 
WHERE S.USN = C.USN AND SS.SSID = C.SSID AND SS.SEM = 4 AND SS.S='C';

-- 2. Computethe totalnumberofmale andfemale studentsineachsemester and in eachsection.
SELECT SS.SEM, SS.SEC, S.GENDER, COUNT (S.GENDER) AS COUNT FROM STUDENT S, SEMSEC SS, CLASS C
WHERE S.USN = C.USN AND SS.SSID =C.SSID
GROUP BY SS.SEM, SS.SEC, S.GENDER 
ORDER BY SEM;

-- 3. Create a view of Test1 marks ofstudent USN ‘1BI15CS101’ in allsubjects.
CREATE VIEW STU_TEST1_MARKS_VIEW 
AS SELECT TEST1, SUBCODE
FROM IAMARKS
WHERE USN = '1RN13CS091';

-- Calculate the FinalIA (average of besttwo testmarks) and update the corresponding table for all students.

CREATE OR REPLACE PROCEDURE AVGMARKS 
IS CURSOR C_IAMARKS IS
SELECT GREATEST(TEST1,TEST2) AS A, GREATEST(TEST1,TEST3) AS B, GREATEST(TEST3,TEST2) ASC
FROM IAMARKS
WHERE FINALIA IS 
NULL FOR UPDATE;
C_ANUMBER; 
C_BNUMBER; 
C_CNUMBER; 
C_SMNUMBER; 
C_AVNUMBER;

BEGIN
OPEN 
C_IAMARKS; 
LOOP
FETCH C_IAMARKS INTO C_A, C_B, C_C; 
EXIT WHEN C_IAMARKS%NOTFOUND;
IF (C_A != C_B) THEN
C_SM:=C_A+C_B; 
ELSE
C_SM:=C_A+C_C; 
END IF;
C_AV:=C_SM/2;
UPDATE IAMARKS SET FINALIA=C_AV WHERE CURRENT OF C_IAMARKS;
END LOOP;
CLOSE 
C_IAMARKS; END;

-- Categorize students based on the following criterion: 
-- If FinalIA = 17 to 20 then CAT = ‘Outstanding’ 
-- If FinalIA = 12 to 16 then CAT = ‘Average’ 
-- If FinalIA< 12 then CAT = ‘Weak’ 
-- Give these details only for 8th semester A, B, and C section students.

SELECT S.USN,S.SNAME,S.ADDRESS,S.PHONE,S.GENDER, 
(CASE
WHEN IA.FINALIA BETWEEN 17 AND 20 THEN'OUTSTANDING' 
WHEN IA.FINALIA BETWEEN 12 AND 16 THEN 'AVERAGE' ELSE 'WEAK'
END) 
AS CAT FROM STUDENT S, SEMSEC SS, IAMARKS IA, SUBJECT SUB 
WHERE S.USN = IA.USN AND SS.SSID = IA.SSID AND SUB.SUBCODE = IA.SUBCODE AND SUB.SEM = 8;


