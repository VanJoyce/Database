/*****PLEASE ENTER YOUR DETAILS BELOW*****/
/*Q2-tds-queries.sql*/
/*Student ID: 30556864*/
/*Student Name: Vanessa Joyce Tan*/
/*Tutorial No: FIT3171 Laboratory 03 Wednesday 1pm*/

/* Comments for your marker:




*/


/*
2(i) Query 1
*/
/*PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
SELECT
    dem_points        AS "Demerit Points",
    dem_description   AS "Demerit Description"
FROM
    demerit
WHERE
    dem_description LIKE '%heavy%'
    OR dem_description LIKE '%Heavy%'
    OR dem_description LIKE 'Exceed%'
ORDER BY
    dem_points,
    dem_description;





/*
2(ii) Query 2
*/
/*PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/

SELECT
    veh_maincolor   AS "Main Colour",
    veh_vin         AS vin,
    to_char(veh_yrmanuf, 'YYYY') AS "Year Manufactured"
FROM
    vehicle
WHERE
    veh_modname IN (
        'Range Rover',
        'Range Rover Sport'
    )
    AND veh_yrmanuf BETWEEN TO_DATE('2012', 'YYYY') AND TO_DATE('2014', 'YYYY')
ORDER BY
    veh_yrmanuf DESC,
    veh_maincolor; 




/*
2(iii) Query 3
*/
/*PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/

SELECT
    d.lic_no AS "Licence No.",
    d.lic_fname
    || ' '
    || d.lic_lname AS "Driver Fullname",
    to_char(d.lic_dob, 'dd-Mon-yyyy') AS dob,
    d.lic_street
    || ' '
    || d.lic_town
    || ' '
    || d.lic_postcode AS "Driver Address",
    to_char(s.sus_date, 'dd/MON/yy') AS "Suspended On",
    to_char(s.sus_enddate, 'dd/MON/yy') AS "Suspended Till"
FROM
    driver       d
    JOIN suspension   s
    ON d.lic_no = s.lic_no
WHERE
    months_between(sysdate, s.sus_date) < 30
ORDER BY
    d.lic_no,
    s.sus_date DESC;






/*
2(iv) Query 4
*/
/*PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/

SELECT
    d.dem_code          AS "Demerit Code",
    d.dem_description   AS "Demerit Description",
    COUNT(o.dem_code) AS "Total Offences (All Months)",
    nvl(SUM(decode(to_char(o.off_datetime, 'Mon'), 'Jan', 1)), 0) AS "Jan",
    nvl(SUM(decode(to_char(o.off_datetime, 'Mon'), 'Feb', 1)), 0) AS "Feb",
    nvl(SUM(decode(to_char(o.off_datetime, 'Mon'), 'Mar', 1)), 0) AS "Mar",
    nvl(SUM(decode(to_char(o.off_datetime, 'Mon'), 'Apr', 1)), 0) AS "Apr",
    nvl(SUM(decode(to_char(o.off_datetime, 'Mon'), 'May', 1)), 0) AS "May",
    nvl(SUM(decode(to_char(o.off_datetime, 'Mon'), 'Jun', 1)), 0) AS "Jun",
    nvl(SUM(decode(to_char(o.off_datetime, 'Mon'), 'Jul', 1)), 0) AS "Jul",
    nvl(SUM(decode(to_char(o.off_datetime, 'Mon'), 'Aug', 1)), 0) AS "Aug",
    nvl(SUM(decode(to_char(o.off_datetime, 'Mon'), 'Sep', 1)), 0) AS "Sep",
    nvl(SUM(decode(to_char(o.off_datetime, 'Mon'), 'Oct', 1)), 0) AS "Oct",
    nvl(SUM(decode(to_char(o.off_datetime, 'Mon'), 'Nov', 1)), 0) AS "Nov",
    nvl(SUM(decode(to_char(o.off_datetime, 'Mon'), 'Dec', 1)), 0) AS "Dec"
FROM
    demerit   d
    LEFT JOIN offence   o
    ON d.dem_code = o.dem_code
GROUP BY
    d.dem_code,
    d.dem_description
ORDER BY
    "Total Offences (All Months)" DESC,
    d.dem_code;




/*
2(v) Query 5
*/
/*PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/

SELECT
    veh_manufname AS "Manufacturer Name",
    COUNT(off_no) AS "Total No. of Offences"
FROM
    vehicle
    NATURAL JOIN offence
    NATURAL JOIN demerit
WHERE
    dem_points >= 2
GROUP BY
    veh_manufname
HAVING
    COUNT(off_no) = (
        SELECT
            MAX(COUNT(off_no))
        FROM
            vehicle
            NATURAL JOIN offence
            NATURAL JOIN demerit
        WHERE
            dem_points >= 2
        GROUP BY
            veh_manufname
    )
ORDER BY
    "Total No. of Offences" DESC,
    "Manufacturer Name";




/*
2(vi) Query 6
*/
/*PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/

SELECT
    lic_no       AS "Licence No.",
    lic_fname
    || ' '
    || lic_lname AS "Driver Name",
    officer_id   AS "Officer ID",
    officer_fname
    || ' '
    || officer_lname AS "Officer Name"
FROM
    (
        SELECT
            d.lic_no,
            d.lic_fname,
            lic_lname,
            o.dem_code,
            COUNT(o.off_no) AS offence_count
        FROM
            ( offence   o
            JOIN officer   f
            ON o.officer_id = f.officer_id )
            JOIN driver    d
            ON ( o.lic_no = d.lic_no
                 AND f.officer_lname = d.lic_lname )
        GROUP BY
            d.lic_no,
            d.lic_fname,
            d.lic_lname,
            o.dem_code
    )
    NATURAL JOIN offence
    NATURAL JOIN officer
WHERE
    offence_count > 1
GROUP BY
    lic_no,
    lic_fname
    || ' '
    || lic_lname,
    officer_id,
    officer_fname
    || ' '
    || officer_lname
ORDER BY
    lic_no;


/*
2(vii) Query 7
*/
/*PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/

SELECT
    dem_code          AS "Demerit Code",
    dem_description   AS "Demerit Description",
    lic_no            AS "Licence No.",
    lic_fname
    || ' '
    || lic_lname AS "Driver Fullname",
    COUNT(lic_no) AS " Total Times Booked"
FROM
    offence
    NATURAL JOIN demerit
    NATURAL JOIN driver
GROUP BY
    dem_code,
    dem_description,
    lic_no,
    lic_fname
    || ' '
    || lic_lname
HAVING
    ( dem_code,
      COUNT(lic_no) ) IN (
        SELECT
            dem_code,
            MAX(booking_count)
        FROM
            (
                SELECT
                    dem_code,
                    lic_no,
                    COUNT(lic_no) AS booking_count
                FROM
                    offence
                GROUP BY
                    dem_code,
                    lic_no
            )
        GROUP BY
            dem_code
    )
ORDER BY
    dem_code,
    lic_no;


/*
2(viii) Query 8
*/
/*PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/

SELECT
    nvl(region, lpad('TOTAL', 15, ' ')) AS "Region",
    SUM(total_veh) AS "Total Vehicles Manufactured",
    lpad(to_char(SUM(percentage_veh), '990.99')
         || '%', 28, ' ') AS "Percentage of Vehicles Manufactured"
FROM
    (
        SELECT
            CASE
                WHEN substr(veh_vin, 1, 1) IN (
                    'A',
                    'B',
                    'C'
                ) THEN
                    'Africa'
                WHEN substr(veh_vin, 1, 1) IN (
                    'J',
                    'K',
                    'L',
                    'M',
                    'N',
                    'O',
                    'P',
                    'Q',
                    'R'
                ) THEN
                    'Asia'
                WHEN substr(veh_vin, 1, 1) IN (
                    'S',
                    'T',
                    'U',
                    'V',
                    'W',
                    'X',
                    'Y',
                    'Z'
                ) THEN
                    'Europe'
                WHEN substr(veh_vin, 1, 1) IN (
                    '1',
                    '2',
                    '3',
                    '4',
                    '5'
                ) THEN
                    'North America'
                WHEN substr(veh_vin, 1, 1) IN (
                    '6',
                    '7'
                ) THEN
                    'Oceania'
                WHEN substr(veh_vin, 1, 1) IN (
                    '8',
                    '9'
                ) THEN
                    'South America'
                ELSE
                    'Unknown'
            END AS region,
            COUNT(veh_vin) AS total_veh,
            round(COUNT(veh_vin) /(
                SELECT
                    COUNT(veh_vin)
                FROM
                    vehicle
            ) * 100, 2) AS percentage_veh
        FROM
            vehicle
        GROUP BY (
            CASE
                WHEN substr(veh_vin, 1, 1) IN (
                    'A',
                    'B',
                    'C'
                ) THEN
                    'Africa'
                WHEN substr(veh_vin, 1, 1) IN (
                    'J',
                    'K',
                    'L',
                    'M',
                    'N',
                    'O',
                    'P',
                    'Q',
                    'R'
                ) THEN
                    'Asia'
                WHEN substr(veh_vin, 1, 1) IN (
                    'S',
                    'T',
                    'U',
                    'V',
                    'W',
                    'X',
                    'Y',
                    'Z'
                ) THEN
                    'Europe'
                WHEN substr(veh_vin, 1, 1) IN (
                    '1',
                    '2',
                    '3',
                    '4',
                    '5'
                ) THEN
                    'North America'
                WHEN substr(veh_vin, 1, 1) IN (
                    '6',
                    '7'
                ) THEN
                    'Oceania'
                WHEN substr(veh_vin, 1, 1) IN (
                    '8',
                    '9'
                ) THEN
                    'South America'
                ELSE
                    'Unknown'
            END
        )
    )
GROUP BY
    ROLLUP(region)
ORDER BY
    "Total Vehicles Manufactured",
    "Region";