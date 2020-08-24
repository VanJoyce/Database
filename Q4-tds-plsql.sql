/*****PLEASE ENTER YOUR DETAILS BELOW*****/
/*Q4-tds-plsql.sql*/
/*Student ID: 30556864*/
/*Student Name: Vanessa Joyce Tan*/
/*Tutorial No: FIT3171 Laboratory 03 Wednesday 1pm*/

/* Comments for your marker:



*/

/* (i) Write a trigger which will, from this point forward, automatically maintain the total number of times each police officer has booked a driver for a traffic offence attribute you added in Task 3. 
*/
/*Please copy your trigger code and any other necessary SQL statements after this line*/
CREATE OR REPLACE TRIGGER maintain_officer_bookings AFTER
    INSERT ON offence
    FOR EACH ROW
BEGIN
    UPDATE officer
    SET
        officer_book_total = officer_book_total + 1
    WHERE
        officer_id = :new.officer_id;

END;
/

/*- TEST HARNESS (i) ---*/
/*- Display officer before ---*/

SELECT
    *
FROM
    officer;

/*- Insert offence ---*/

INSERT INTO offence VALUES (
    130,
    TO_DATE('13-May-2020 19:00;05', 'dd-Mon-yyyy hh24:mi:ss'),
    'Sandy Road Croydon Hills 3136',
    99,
    10000001,
    100034,
    '1NXAE09E9PZ111066',
    'No'
);

/*- Display officer after ---*/

SELECT
    *
FROM
    officer;

ROLLBACK;





/* (ii) Write a trigger which will, from this point forward, make sure that driver and police have at least one name before their data is added into the database. The trigger must prevent the insertion if both names are nulls. 
*/
/*Please copy your trigger code and any other necessary SQL statements after this line*/

/* trigger for officer's name*/

CREATE OR REPLACE TRIGGER chk_officer_name BEFORE
    INSERT ON officer
    FOR EACH ROW
BEGIN
    IF ( :new.officer_fname IS NULL AND :new.officer_lname IS NULL ) THEN
        raise_application_error(-20001, 'Officer''s first name and last name cannot both be null.'
        );
    END IF;
END;
/

/*- TEST HARNESS FOR OFFICER NAME ---*/
/*- Display officer table before insert ---*/

SELECT
    *
FROM
    officer;

/*- insert officer with only first name ---*/

INSERT INTO officer VALUES (
    10000022,
    'DJ',
    '',
    0
);

/*- insert officer with only last name ---*/

INSERT INTO officer VALUES (
    10000023,
    '',
    'Red',
    0
);

/*- insert officer with both nulls as first and last name ---*/

INSERT INTO officer VALUES (
    10000025,
    '',
    '',
    0
);

/*- Display officer table to show the name with both nulls wasn't inserted ---*/

SELECT
    *
FROM
    officer;

ROLLBACK;

/* trigger for driver's name*/

CREATE OR REPLACE TRIGGER chk_driver_name BEFORE
    INSERT ON driver
    FOR EACH ROW
BEGIN
    IF ( :new.lic_fname IS NULL AND :new.lic_lname IS NULL ) THEN
        raise_application_error(-20002, 'Driver''s first name and last name cannot both be null.'
        );
    END IF;
END;
/

/*- TEST HARNESS FOR DRIVER NAME ---*/
/*- Display driver table before insert ---*/

SELECT
    *
FROM
    driver;

/*- insert driver with only first name ---*/

INSERT INTO driver VALUES (
    100400,
    'Remy',
    '',
    0486204800,
    '0 Grim Trail',
    'Richmond East',
    '3121',
    TO_DATE('03-Jan-1964', 'dd-Mon-yyyy'),
    TO_DATE('14-Aug-2020', 'dd-Mon-yyyy')
);

/*- insert driver with only last name ---*/

INSERT INTO driver VALUES (
    100401,
    '',
    'Irma',
    0486204801,
    '5 Grim Trail',
    'Richmond East',
    '3121',
    TO_DATE('30-Jul-1989', 'dd-Mon-yyyy'),
    TO_DATE('24-Sep-2022', 'dd-Mon-yyyy')
);

/*- insert driver with both nulls as first and last name ---*/

INSERT INTO driver VALUES (
    100402,
    '',
    '',
    0486204802,
    '8 Grim Trail',
    'Richmond East',
    '3121',
    TO_DATE('05-May-1995', 'dd-Mon-yyyy'),
    TO_DATE('07-Aug-2024', 'dd-Mon-yyyy')
);

/*- Display driver table to show the name with both nulls wasn't inserted ---*/

SELECT
    *
FROM
    driver;

ROLLBACK;

/* (iii) The local government wants to maintain a history of all drivers’ license expiry dates. Write a trigger to record the current and new lic_expiry date of a driver’s license whenever there is a change in a driver’s license expiry date. The trigger must check if the new licence expiry date is at least 30 months (2.5 years) later than current license expiry date, otherwise it must prevent the change.
Hint: to carry out this task, you need to create another table where the history of all drivers’ license expiry dates is recorded. In the table, include the licence number, the current expiry date, the new expiry date and the date when the update is done.
*/
/*Please copy your trigger code and any other necessary SQL statements after this line*/

DROP TABLE lic_history CASCADE CONSTRAINTS PURGE;

CREATE TABLE lic_history (
    lic_no         CHAR(10) NOT NULL,
    his_update     DATE NOT NULL,
    his_curr_exp   DATE NOT NULL,
    his_new_exp    DATE NOT NULL
);

COMMENT ON COLUMN lic_history.lic_no IS
    'License number';

COMMENT ON COLUMN lic_history.his_update IS
    'Date the update was done';

COMMENT ON COLUMN lic_history.his_curr_exp IS
    'Current expiry date of license';

COMMENT ON COLUMN lic_history.his_new_exp IS
    'New expiry date of license';

ALTER TABLE lic_history ADD CONSTRAINT lic_history_pk PRIMARY KEY ( lic_no,
                                                                    his_update );

ALTER TABLE lic_history
    ADD CONSTRAINT driver_lic_history FOREIGN KEY ( lic_no )
        REFERENCES driver ( lic_no );
        
/* trigger*/

CREATE OR REPLACE TRIGGER maintain_lic_history BEFORE
    UPDATE OF lic_expiry ON driver
    FOR EACH ROW
BEGIN
    IF ( :new.lic_expiry < add_months(:old.lic_expiry, 30) ) THEN
        raise_application_error(-20003, 'The new expiry date must be at least 30 months (2.5 years) later than the current license expiry date.'
        );
    ELSE
        INSERT INTO lic_history VALUES (
            :new.lic_no,
            sysdate,
            :old.lic_expiry,
            :new.lic_expiry
        );

    END IF;
END;
/

/*- TEST HARNESS FOR LIC_HISTORY ---*/
/*- Display lic_history and license which we are updating ---*/

SELECT
    *
FROM
    lic_history;

SELECT
    *
FROM
    driver
WHERE
    lic_no = 100393;

/*- Update to a date more than 30 months away from current expiry date ---*/

UPDATE driver
SET
    lic_expiry = TO_DATE('30-Mar-2025', 'dd-Mon-yyyy')
WHERE
    lic_no = 100393;

/*- row is inserted into lic_history---*/

SELECT
    *
FROM
    lic_history;

/*- display to show that lic_expiry is updated ---*/

SELECT
    *
FROM
    driver
WHERE
    lic_no = 100393;

ROLLBACK;

/*- Display lic_history and license which we are updating ---*/

SELECT
    *
FROM
    lic_history;

SELECT
    *
FROM
    driver
WHERE
    lic_no = 100393;

/*- Update to a date less than 30 months away from current expiry date ---*/

UPDATE driver
SET
    lic_expiry = TO_DATE('30-Jan-2021', 'dd-Mon-yyyy')
WHERE
    lic_no = 100393;

/*- nothing is inserted into lic_history---*/

SELECT
    *
FROM
    lic_history;

/*- display to show that lic_expiry is not updated ---*/

SELECT
    *
FROM
    driver
WHERE
    lic_no = 100393;
    
rollback;