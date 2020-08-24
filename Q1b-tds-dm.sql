/*****PLEASE ENTER YOUR DETAILS BELOW*****/
/*Q1b-tds-dm.sql*/
/*Student ID: 30556864*/
/*Student Name: Vanessa Joyce Tan*/
/*Tutorial No: FIT3171 Laboratory 03 Wednesday 1pm*/
SET SERVEROUTPUT ON;


/* Comments for your marker:




*/


/*
1b(i) Create a sequence 
*/
/*PLEASE PLACE REQUIRED SQL STATEMENT(S) FOR THIS PART HERE*/

DROP SEQUENCE offence_seq;

CREATE SEQUENCE offence_seq START WITH 100 INCREMENT BY 1;



/*
1b(ii) Take the necessary steps in the database to record data.
*/
/*PLEASE PLACE REQUIRED SQL STATEMENT(S) FOR THIS PART HERE*/

INSERT INTO offence VALUES (
    offence_seq.NEXTVAL,
    TO_DATE('10-Aug-2019 08:04:00', 'dd-Mon-yyyy hh24:mi:ss'),
    'Rum Street Richmond South 3121',
    (
        SELECT
            dem_code
        FROM
            demerit
        WHERE
            dem_description = 'Blood alcohol charge'
    ),
    10000011,
    100389,
    'JYA3HHE05RA070562'
);

COMMIT;

INSERT INTO offence VALUES (
    offence_seq.NEXTVAL,
    TO_DATE('16-Oct-2019 21:00:00', 'dd-Mon-yyyy hh24:mi:ss'),
    'Fallaway Avenue Richmond 3121',
    (
        SELECT
            dem_code
        FROM
            demerit
        WHERE
            dem_description = 'Level crossing offence'
    ),
    10000015,
    100389,
    'JYA3HHE05RA070562'
);

COMMIT;

INSERT INTO offence VALUES (
    offence_seq.NEXTVAL,
    TO_DATE('7-Jan-2020 07:07:00', 'dd-Mon-yyyy hh24:mi:ss'),
    'Sky Boulevard Richmond 3121',
    (
        SELECT
            dem_code
        FROM
            demerit
        WHERE
            dem_description = 'Exceeding the speed limit by 25 km/h or more'
    ),
    10000015,
    100389,
    'JYA3HHE05RA070562'
);

INSERT INTO suspension VALUES (
    100389,
    TO_DATE('7-Jan-2020', 'dd-Mon-yyyy'),
    add_months(TO_DATE('7-Jan-2020', 'dd-Mon-yyyy'), 6)
);

COMMIT;

/*Display offence to show Lion Lawless's offences have been added*/

SELECT
    off_no,
    to_char(off_datetime, 'dd-Mon-yyyy hh24:mi:ss') AS "DATE AND TIME",
    off_location   AS location,
    dem_code       AS "DEMERIT CODE",
    officer_id,
    lic_no,
    veh_vin
FROM
    offence
ORDER BY
    off_no;
    
/*Display suspension to show Lion Lawless was suspended    */

SELECT
    lic_no,
    to_char(sus_date, 'dd-Mon-yyyy') AS "START DATE",
    to_char(sus_enddate, 'dd-Mon-yyyy') AS "END DATE"
FROM
    suspension
ORDER BY
    sus_date;



/*
1b(iii) Take the necessary steps in the database to record changes. 
*/
/*PLEASE PLACE REQUIRED SQL STATEMENT(S) FOR THIS PART HERE*/

UPDATE offence
SET
    dem_code = (
        SELECT
            dem_code
        FROM
            demerit
        WHERE
            dem_description = 'Exceeding the speed limit by 10 km/h or more but less than 25 km/h'
    )
WHERE
    lic_no = 100389
    AND off_datetime = TO_DATE('7-Jan-2020 07:07:00', 'dd-Mon-yyyy hh24:mi:ss');

DELETE FROM suspension
WHERE
    lic_no = 100389
    AND sus_date = TO_DATE('7-Jan-2020', 'dd-Mon-yyyy');
    
COMMIT;

/*Display offence to show Lion Lawless's offence have been changed*/

SELECT
    off_no,
    to_char(off_datetime, 'dd-Mon-yyyy hh24:mi:ss') AS "DATE AND TIME",
    off_location   AS location,
    dem_code       AS "DEMERIT CODE",
    officer_id,
    lic_no,
    veh_vin
FROM
    offence
ORDER BY
    off_no;
    
/*Display suspension to show Lion Lawless's suspension has been lifted   */

SELECT
    lic_no,
    to_char(sus_date, 'dd-Mon-yyyy') AS "START DATE",
    to_char(sus_enddate, 'dd-Mon-yyyy') AS "END DATE"
FROM
    suspension
ORDER BY
    sus_date;
