/*****PLEASE ENTER YOUR DETAILS BELOW*****/
/*Q1a-tds-insert.sql*/
/*Student ID: 30556864*/
/*Student Name: Vanessa Joyce Tan*/
/*Tutorial No: FIT3171 Laboratory 03 Wednesday 1pm*/
SET SERVEROUTPUT ON;


/* Comments for your marker:




*/

/*
1(a) Load selected tables with your own additional test data
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) FOR THIS PART HERE
INSERT INTO offence VALUES (1, TO_DATE('5-Jan-2016 14:28:19', 'dd-Mon-yyyy hh24:mi:ss'), 'Wayward Drive Lysterfield 3156', 99, 10000001, 100081, 'SALMH134090015425');
COMMIT;

INSERT INTO offence VALUES (2, TO_DATE('5-Jan-2016 15:33:48', 'dd-Mon-yyyy hh24:mi:ss'), 'Old Mine Road Lysterfield South 3156', 102, 10000001, 100097, '2T2BK1BA8BC089027');
COMMIT;

INSERT INTO offence VALUES (3, TO_DATE('13-Jun-2016 11:25:55', 'dd-Mon-yyyy hh24:mi:ss'), 'George Street Mountain Gate 3156', 99, 10000018, 100081, 'SALMH134090015425');
COMMIT;

INSERT INTO offence VALUES (4, TO_DATE('21-Aug-2016 17:18:35', 'dd-Mon-yyyy hh24:mi:ss'), 'Cat Alley Dandenong South 3164', 118, 10000013, 100089, 'KM8JUCBC0A0015290');
COMMIT;

INSERT INTO offence VALUES (5, TO_DATE('18-Nov-2016 13:12:32', 'dd-Mon-yyyy hh24:mi:ss'), 'Sunset Drive Huntingdale 3166', 108, 10000011, 100094, 'KNAFB2224Y5512533');
COMMIT;

INSERT INTO offence VALUES (6, TO_DATE('13-Feb-2017 21:09:43', 'dd-Mon-yyyy hh24:mi:ss'), 'Spring Boulevard Menzies Creek 3159', 100, 10000006, 100081, 'SALMH134090015425');
INSERT INTO suspension VALUES (100081, TO_DATE('13-Feb-2017', 'dd-Mon-yyyy'), ADD_MONTHS(TO_DATE('13-Feb-2017', 'dd-Mon-yyyy'), 6));
COMMIT;

INSERT INTO offence VALUES (7, TO_DATE('3-Mar-2017 20:29:25', 'dd-Mon-yyyy hh24:mi:ss'), 'Sparrow Road Oakleigh East 3166', 113, 10000002, 100337, 'ZFF74UFA1D0195883');
COMMIT;

INSERT INTO offence VALUES (8, TO_DATE('29-Apr-2017 18:03:25', 'dd-Mon-yyyy hh24:mi:ss'), 'Old Governor Street Notting Hill 3168', 107, 10000007, 100072, 'JTHGL1EF4F117BL47');
COMMIT;

INSERT INTO offence VALUES (9, TO_DATE('4-Jul-2017 10:17:49', 'dd-Mon-yyyy hh24:mi:ss'), 'Church Street Darling 3145', 118, 10000017, 100097, '2T2BK1BA8BC089027');
COMMIT;

INSERT INTO offence VALUES (10, TO_DATE('14-Sep-2017 05:19:32', 'dd-Mon-yyyy hh24:mi:ss'), 'Middle Road Malvern East 3145', 126, 10000016, 100030, 'WMWZN3C51DT568308');
COMMIT;

INSERT INTO offence VALUES (11, TO_DATE('18-Sep-2017 13:24:18', 'dd-Mon-yyyy hh24:mi:ss'), 'Caravan Road Seville 3139', 105, 10000009, 100034, '1NXAE09E9PZ111066');
COMMIT;

INSERT INTO offence VALUES (12, TO_DATE('21-Dec-2017 11:44:42', 'dd-Mon-yyyy hh24:mi:ss'), 'Misty Avenue Croydon Hills 3136', 129, 10000021, 100097, '2T2BK1BA8BC089027');
COMMIT;

INSERT INTO offence VALUES (13, TO_DATE('24-Dec-2017 02:48:38', 'dd-Mon-yyyy hh24:mi:ss'), 'Lonesome Street Croydon Hills 3136', 100, 10000010, 100097, '2T2BK1BA8BC089027');
INSERT INTO suspension VALUES (100097, TO_DATE('24-Dec-2017', 'dd-Mon-yyyy'), ADD_MONTHS(TO_DATE('24-Dec-2017', 'dd-Mon-yyyy'), 6));
COMMIT;

INSERT INTO offence VALUES (14, TO_DATE('31-Jan-2018 15:17:09', 'dd-Mon-yyyy hh24:mi:ss'), 'Coconut Street Don Valley 3139', 110, 10000005, 100272, 'JM1BG2322N0502061');
COMMIT;

INSERT INTO offence VALUES (15, TO_DATE('19-Mar-2018 16:34:29', 'dd-Mon-yyyy hh24:mi:ss'), 'Hummingbird Avenue Ringwood East 3135', 110, 10000005, 100272, 'JM1BG2322N0502061');
COMMIT;

INSERT INTO offence VALUES (16, TO_DATE('30-May-2018 23:14:07', 'dd-Mon-yyyy hh24:mi:ss'), 'Red Brick Road Vermont 3133', 102, 10000011, 100218, 'ZHWBE37S09LA03599');
COMMIT;

INSERT INTO offence VALUES (17, TO_DATE('20-Jun-2018 13:30:22', 'dd-Mon-yyyy hh24:mi:ss'), 'Cliffside Avenue Ringwood East 3135', 107, 10000015, 100272, 'JM1BG2322N0502061');
COMMIT;

INSERT INTO offence VALUES (18, TO_DATE('7-Aug-2018 14:23:18', 'dd-Mon-yyyy hh24:mi:ss'), 'Waterfall Boulevard Blackburn 3130', 101, 10000006, 100218, 'ZHWBE37S09LA03599');
COMMIT;

INSERT INTO offence VALUES (19, TO_DATE('16-Aug-2018 23:19:39', 'dd-Mon-yyyy hh24:mi:ss'), 'Waterfall Boulevard Blackburn 3130', 102, 10000006, 100218, 'ZHWBE37S09LA03599');
INSERT INTO suspension VALUES (100218, TO_DATE('16-Aug-2018', 'dd-Mon-yyyy'), ADD_MONTHS(TO_DATE('16-Aug-2018', 'dd-Mon-yyyy'), 6));
COMMIT;

INSERT INTO offence VALUES (20, TO_DATE('31-Oct-2018 19:17:54', 'dd-Mon-yyyy hh24:mi:ss'), 'Rainbow Road Canterbury 3126', 99, 10000014, 100243, 'WDDHF8JB7CA658175');
COMMIT;

INSERT INTO offence VALUES (21, TO_DATE('20-Nov-2018 10:10:24', 'dd-Mon-yyyy hh24:mi:ss'), 'Cliffside Avenue Ringwood East 3135', 101, 10000015, 100272, 'JM1BG2322N0502061');
INSERT INTO suspension VALUES (100272, TO_DATE('20-Nov-2018', 'dd-Mon-yyyy'), ADD_MONTHS(TO_DATE('20-Nov-2018', 'dd-Mon-yyyy'), 6));
COMMIT;

INSERT INTO offence VALUES (22, TO_DATE('3-Jan-2019 16:23:19', 'dd-Mon-yyyy hh24:mi:ss'), 'Sunset Drive Huntingdale 3166', 118, 10000011, 100011, 'JTHBF5C27C5173683');
COMMIT;

INSERT INTO offence VALUES (23, TO_DATE('5-Feb-2019 14:33:47', 'dd-Mon-yyyy hh24:mi:ss'), 'Wayward Drive Lysterfield 3156', 125, 10000001, 100081, 'SALMH134090015425');
COMMIT;

INSERT INTO offence VALUES (24, TO_DATE('9-Feb-2019 22:48:47', 'dd-Mon-yyyy hh24:mi:ss'), 'Columbus Street Coatesville 3165', 120, 10000016, 100046, '1HGCM66413A806251');
COMMIT;

INSERT INTO offence VALUES (25, TO_DATE('10-Apr-2019 20:58:45', 'dd-Mon-yyyy hh24:mi:ss'), 'Butterfly Road Upwey 3158', 107, 10000016, 100129, 'SALAG2V61EA704128');
COMMIT;

INSERT INTO offence VALUES (26, TO_DATE('15-Apr-2019 13:23:00', 'dd-Mon-yyyy hh24:mi:ss'), 'Sunset Drive Huntingdale 3166', 118, 10000011, 100011, 'JTHBF5C27C5173683');
COMMIT;

INSERT INTO offence VALUES (27, TO_DATE('29-Apr-2019 14:00:32', 'dd-Mon-yyyy hh24:mi:ss'), 'Sunset Drive Huntingdale 3166', 126, 10000011, 100094, 'KNAFB2224Y5512533');
COMMIT;

INSERT INTO offence VALUES (28, TO_DATE('3-May-2019 18:44:15', 'dd-Mon-yyyy hh24:mi:ss'), 'Sunset Drive Huntingdale 3166', 118, 10000011, 100011, 'JTHBF5C27C5173683');
COMMIT;


-- Display offences
SELECT
    off_no,
    to_char(off_datetime, 'dd-Mon-yyyy hh24:mi:ss') AS "DATE AND TIME",
    off_location AS location,
    dem_code AS "DEMERIT CODE",
    officer_id,
    lic_no,
    veh_vin    
FROM
    offence
ORDER BY
    off_no;

-- Display suspension
SELECT
    lic_no,
    to_char(sus_date, 'dd-Mon-yyyy') AS "START DATE",
    to_char(sus_enddate, 'dd-Mon-yyyy') AS "END DATE"
FROM
    suspension
ORDER BY
    sus_date;









