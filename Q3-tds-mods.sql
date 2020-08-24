/*****PLEASE ENTER YOUR DETAILS BELOW*****/
/*Q3-tds-mods.sql*/
/*Student ID: 30556864*/
/*Student Name: Vanessa Joyce Tan*/
/*Tutorial No: FIT3171 Laboratory 03 Wednesday 1pm*/

/* Comments for your marker:




*/


/*
3(i) Changes to live database 1
*/
/*PLEASE PLACE REQUIRED SQL STATEMENTS FOR THIS PART HERE*/
ALTER TABLE officer ADD officer_book_total NUMBER(4) DEFAULT 0 NOT NULL;

UPDATE officer f
SET
    officer_book_total = (
        SELECT
            COUNT(o.officer_id)
        FROM
            offence o
        WHERE
            o.officer_id = f.officer_id
    );

COMMIT;

/* Display column has been added and initialised*/

SELECT
    *
FROM
    officer
ORDER BY
    officer_id;





/*
3(ii) Changes to live database 2
*/
/*PLEASE PLACE REQUIRED SQL STATEMENTS FOR THIS PART HERE*/

DROP TABLE revocation CASCADE CONSTRAINTS PURGE;

DROP TABLE reason CASCADE CONSTRAINTS PURGE;

/* Create tables*/

CREATE TABLE revocation (
    off_no        NUMBER(8) NOT NULL,
    rev_date      DATE NOT NULL,
    officer_id    NUMBER(8) NOT NULL,
    reason_code   CHAR(3) NOT NULL
);

COMMENT ON COLUMN revocation.off_no IS
    'Offence number (unique)';

COMMENT ON COLUMN revocation.rev_date IS
    'Date the offence was revoked';

COMMENT ON COLUMN revocation.officer_id IS
    'Police officer id number who revoked the offence';

COMMENT ON COLUMN revocation.reason_code IS
    'Reason for revocation';

ALTER TABLE revocation ADD CONSTRAINT revocation_pk PRIMARY KEY ( off_no );

CREATE TABLE reason (
    reason_code          CHAR(3) NOT NULL,
    reason_description   VARCHAR2(75) NOT NULL
);

COMMENT ON COLUMN reason.reason_code IS
    'Reason unique code';

COMMENT ON COLUMN reason.reason_description IS
    'Reason description';

ALTER TABLE reason ADD CONSTRAINT reason_pk PRIMARY KEY ( reason_code );

ALTER TABLE reason ADD CONSTRAINT reason_desc_uk UNIQUE ( reason_description );

ALTER TABLE revocation
    ADD CONSTRAINT offence_revocation FOREIGN KEY ( off_no )
        REFERENCES offence ( off_no );

ALTER TABLE revocation
    ADD CONSTRAINT officer_revocation FOREIGN KEY ( officer_id )
        REFERENCES officer ( officer_id );

ALTER TABLE revocation
    ADD CONSTRAINT reason_revocation FOREIGN KEY ( reason_code )
        REFERENCES reason ( reason_code );

/* Insert revocation reason*/

INSERT INTO reason VALUES (
    'FOS',
    'First offence exceeding the speed limit by less than 10km/h'
);

INSERT INTO reason VALUES (
    'FEU',
    'Faulty equipment used'
);

INSERT INTO reason VALUES (
    'DOU',
    'Driver objection upheld'
);

INSERT INTO reason VALUES (
    'COH',
    'Court hearing'
);

INSERT INTO reason VALUES (
    'EIP',
    'Error in proceedings'
);

COMMIT;


/* Add new column for offence*/

ALTER TABLE offence ADD off_revoked VARCHAR2(3) DEFAULT 'No' NOT NULL;

ALTER TABLE offence
    ADD CONSTRAINT chk_off_revoked CHECK ( off_revoked IN (
        'Yes',
        'No'
    ) );
    
/* Display tables created and offence to show column has been added*/

SELECT
    *
FROM
    revocation;

SELECT
    *
FROM
    reason
ORDER BY
    reason_code;

SELECT
    *
FROM
    offence
ORDER BY
    off_no;