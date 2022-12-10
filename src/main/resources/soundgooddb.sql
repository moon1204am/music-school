CREATE TABLE instrument (
 id SERIAL NOT NULL,
 type_of_instrument VARCHAR(50) NOT NULL,
 brand VARCHAR(50)
 fee INT
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (id);


CREATE TABLE person (
 id SERIAL NOT NULL,
 social_security_number VARCHAR(12) NOT NULL,
 first_name VARCHAR(50),
 last_name VARCHAR(50),
 street VARCHAR(50),
 zip VARCHAR(10),
 city VARCHAR(50)
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (id);


CREATE TABLE phone_number (
 phone_nr VARCHAR(20) NOT NULL,
 person_id SERIAL NOT NULL
);

ALTER TABLE phone_number ADD CONSTRAINT PK_phone_number PRIMARY KEY (phone_nr,person_id);


CREATE TABLE school (
 id SERIAL NOT NULL,
 available_spots INT,
 minimum_age INT,
 street VARCHAR(50),
 zip VARCHAR(10),
 city VARCHAR(50),
 student_waiting_list INT
);

ALTER TABLE school ADD CONSTRAINT PK_school PRIMARY KEY (id);


CREATE TABLE skill (
 id SERIAL NOT NULL,
 level VARCHAR(20) NOT NULL
);

ALTER TABLE skill ADD CONSTRAINT PK_skill PRIMARY KEY (id);


CREATE TABLE student (
 id SERIAL NOT NULL,
 maximum_rental_quota INT,
 sibling INT,
 person_id SERIAL NOT NULL,
 skill_id SERIAL NOT NULL
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (id);


CREATE TABLE student_fee (
 student_id SERIAL NOT NULL,
 discount INT,
 extra_charge INT,
 total_price INT
);

ALTER TABLE student_fee ADD CONSTRAINT PK_student_fee PRIMARY KEY (student_id);


CREATE TABLE application (
 id SERIAL NOT NULL,
 instrument VARCHAR(50),
 skill_id SERIAL NOT NULL,
 school_id SERIAL NOT NULL,
 person_id SERIAL NOT NULL
);

ALTER TABLE application ADD CONSTRAINT PK_application PRIMARY KEY (id);


CREATE TABLE audition (
 id SERIAL NOT NULL,
 grade VARCHAR(10) NOT NULL
);

ALTER TABLE audition ADD CONSTRAINT PK_audition PRIMARY KEY (id);


CREATE TABLE email_address (
 email VARCHAR(50) NOT NULL,
 person_id SERIAL NOT NULL
);

ALTER TABLE email_address ADD CONSTRAINT PK_email_address PRIMARY KEY (email,person_id);


CREATE TABLE guardian (
 person_id SERIAL NOT NULL
);

ALTER TABLE guardian ADD CONSTRAINT PK_guardian PRIMARY KEY (person_id);


CREATE TABLE instructor (
 id SERIAL NOT NULL,
 person_id SERIAL NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (id);


CREATE TABLE instructor_instrument (
 instructor_id SERIAL NOT NULL,
 instrument_id SERIAL NOT NULL
);

ALTER TABLE instructor_instrument ADD CONSTRAINT PK_instructor_instrument PRIMARY KEY (instructor_id,instrument_id);


CREATE TABLE monthly_salary (
 instructor_id SERIAL NOT NULL,
 amount INT NOT NULL
);

ALTER TABLE monthly_salary ADD CONSTRAINT PK_monthly_salary PRIMARY KEY (instructor_id);


CREATE TABLE rental (
 id SERIAL NOT NULL,
 start_date TIMESTAMP(10) NOT NULL,
 end_date TIMESTAMP(10) NOT NULL,
 student_id SERIAL NOT NULL,
 instrument_id SERIAL NOT NULL
);

ALTER TABLE rental ADD CONSTRAINT PK_rental PRIMARY KEY (id);


CREATE TABLE time_slot (
 id SERIAL NOT NULL,
 start_time TIMESTAMP(10),
 end_time TIMESTAMP(10),
 instructor_id SERIAL NOT NULL
);

ALTER TABLE time_slot ADD CONSTRAINT PK_time_slot PRIMARY KEY (id);


CREATE TABLE ensemble (
 id SERIAL NOT NULL,
 genre VARCHAR(50) NOT NULL,
 minimum_enrollment INT NOT NULL,
 maximum_enrollment INT NOT NULL,
 instructor_id SERIAL NOT NULL,
 time_slot_id SERIAL
);

ALTER TABLE ensemble ADD CONSTRAINT PK_ensemble PRIMARY KEY (id);


CREATE TABLE group_lesson (
 id SERIAL NOT NULL,
 minimum_enrollment INT NOT NULL,
 maximum_enrollment INT NOT NULL,
 instrument_id SERIAL NOT NULL,
 instructor_id SERIAL NOT NULL,
 time_slot_id SERIAL
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (id);


CREATE TABLE individual_lesson (
 id CHAR(10) NOT NULL,
 minimum_enrollment INT NOT NULL,
 maximum_enrollment INT NOT NULL,
 student_id SERIAL NOT NULL,
 instrument_id SERIAL NOT NULL,
 instructor_id SERIAL NOT NULL,
 time_slot_id SERIAL
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (id);


CREATE TABLE student_ensemble (
 student_id SERIAL NOT NULL,
 ensemble_id SERIAL NOT NULL
);

ALTER TABLE student_ensemble ADD CONSTRAINT PK_student_ensemble PRIMARY KEY (student_id,ensemble_id);


CREATE TABLE student_group_lesson (
 student_id SERIAL NOT NULL,
 group_lesson_id SERIAL NOT NULL
);

ALTER TABLE student_group_lesson ADD CONSTRAINT PK_student_group_lesson PRIMARY KEY (student_id,group_lesson_id);


ALTER TABLE phone_number ADD CONSTRAINT FK_phone_number_0 FOREIGN KEY (person_id) REFERENCES person (id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (person_id) REFERENCES person (id);
ALTER TABLE student ADD CONSTRAINT FK_student_1 FOREIGN KEY (skill_id) REFERENCES skill (id);


ALTER TABLE student_fee ADD CONSTRAINT FK_student_fee_0 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE application ADD CONSTRAINT FK_application_0 FOREIGN KEY (skill_id) REFERENCES skill (id);
ALTER TABLE application ADD CONSTRAINT FK_application_1 FOREIGN KEY (school_id) REFERENCES school (id);
ALTER TABLE application ADD CONSTRAINT FK_application_2 FOREIGN KEY (person_id) REFERENCES person (id);


ALTER TABLE audition ADD CONSTRAINT FK_audition_0 FOREIGN KEY (id) REFERENCES application (id);


ALTER TABLE email_address ADD CONSTRAINT FK_email_address_0 FOREIGN KEY (person_id) REFERENCES person (id);


ALTER TABLE guardian ADD CONSTRAINT FK_guardian_0 FOREIGN KEY (person_id) REFERENCES person (id);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (person_id) REFERENCES person (id);


ALTER TABLE instructor_instrument ADD CONSTRAINT FK_instructor_instrument_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);
ALTER TABLE instructor_instrument ADD CONSTRAINT FK_instructor_instrument_1 FOREIGN KEY (instrument_id) REFERENCES instrument (id);


ALTER TABLE monthly_salary ADD CONSTRAINT FK_monthly_salary_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE rental ADD CONSTRAINT FK_rental_0 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE rental ADD CONSTRAINT FK_rental_1 FOREIGN KEY (instrument_id) REFERENCES instrument (id);


ALTER TABLE time_slot ADD CONSTRAINT FK_time_slot_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE ensemble ADD CONSTRAINT FK_ensemble_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);
ALTER TABLE ensemble ADD CONSTRAINT FK_ensemble_1 FOREIGN KEY (time_slot_id) REFERENCES time_slot (id);


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (instrument_id) REFERENCES instrument (id);
ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_1 FOREIGN KEY (instructor_id) REFERENCES instructor (id);
ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_2 FOREIGN KEY (time_slot_id) REFERENCES time_slot (id);


ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_1 FOREIGN KEY (instrument_id) REFERENCES instrument (id);
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_2 FOREIGN KEY (instructor_id) REFERENCES instructor (id);
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_3 FOREIGN KEY (time_slot_id) REFERENCES time_slot (id);


ALTER TABLE student_ensemble ADD CONSTRAINT FK_student_ensemble_0 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE student_ensemble ADD CONSTRAINT FK_student_ensemble_1 FOREIGN KEY (ensemble_id) REFERENCES ensemble (id);


ALTER TABLE student_group_lesson ADD CONSTRAINT FK_student_group_lesson_0 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE student_group_lesson ADD CONSTRAINT FK_student_group_lesson_1 FOREIGN KEY (group_lesson_id) REFERENCES group_lesson (id);


