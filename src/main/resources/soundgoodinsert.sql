INSERT INTO "person" ("id", "social_security_number", "first_name", "last_name", "street", "zip", "city") VALUES
(500,	'990315-3233',	'Anya',	'de Graaf',	'84 Lauren Drive',	'54629',	'Fountain City'),
(501,	'000101-3121',	'Julia',	'Saemann',	'Alexander Drive',	'76011',	'Arlington'),
(502,	'951223-7538',	'Vincent',	'Fields',	'3957 Leverton Cove Road',	'01103',	'Springfield'),
(503,	'010605-8674',	'Jessie',	'Wright',	'2000 Jadewood Drive',	'46368',	'Portage'),
(504,	'020918-5554',	'Todd',	'Gerule',	'4770 Lilac Lane',	'30474',	'Vidalia'),
(505,	'981111-0281',	'Angelina',	'Reinhold',	'3085 Java Lane',	'47567',	'Petersburg'),
(506,	'020201-3231',	'Lauren',	'Noel',	'4363 Reynolds Alley',	'92801',	'Anaheim'),
(507,	'970408-7557',	'Daisy',	'Noel',	'4363 Reynolds Alley',	'92801',	'Anaheim'),
(508,	'000756-8098',	'Michael',	'Reinhold',	'3085 Java Lane',	'47567',	'Petersburg'),
(509,	'960325-0209',	'Yuki',	'Cook',	'2749 Russell Street',	'01887',	'Wilmington'),
(510,	'851205-1476',	'Kenneth',	'Wayne',	'1253 Chenoweth Drive',	'37204',	'Nashville'),
(511,	'641024-0993',	'Yolanda',	'Harris',	'1450 Richland Avenue',	'77388',	'Spring'),
(512,	'890420-1213',	'Dave',	'Galvin',	'3740 Heron Way',	'53183',	'Wales'),
(513,	'720508-6060',	'Jennifer',	'Davis',	'4678 Ash Avenue',	'63101',	'Stlouis'),
(514,	'881004-1482',	'Matthew',	'Drake',	'202 Main Street',	'72419',	'Caraway'),
(515,	'750930-1617',	'Margaret',	'Taylor',	'4685 New Creek Road',	'36271',	'Ohatchee'),
(516,	'700808-1929',	'Helen',	'Collins',	'3723 Garrett Street',	'49503',	'Grand Rapids'),
(517,	'670213-4343',	'Barbara',	'Toth',	'1703 Sarah Drive',	'70601',	'Lake Charles'),
(518,	'911111-2122',	'Brandon',	'Castleman',	'4016 Feathers Hooves Drive',	'11612',	'Hicksville'),
(519,	'771001-5422',	'Billy',	'White',	'378 River Road',	'80903',	'Colorado Springs'),
(520, '000603-3299', 'Beatrice', 'Laus', '4034 Leo Street', '80202', 'London'),
(521,	'730706-0998',	'Peter',	'de Graaf',	'84 Lauren Drive',	'54629',	'Fountain City'),
(522,	'630513-4544',	'Simon',	'Saemann',	'Alexander Drive',	'76011',	'Arlington'),
(523,	'791006-6567',	'Linda',	'Fields',	'3957 Leverton Cove Road',	'01103',	'Springfield'),
(524,	'650708-3232',	'William',	'Wright',	'2000 Jadewood Drive',	'46368',	'Portage'),
(525,	'790304-9191',	'Nicole',	'Gerule',	'4770 Lilac Lane',	'30474',	'Vidalia'),
(526,	'600808-6367',	'Gigi',	'Reinhold',	'3085 Java Lane',	'47567',	'Petersburg'),
(527,	'891007-34531',	'Jessica',	'Noel',	'4363 Reynolds Alley',	'92801',	'Anaheim'),
(528,	'590704-0207',	'Mei',	'Cook',	'2749 Russell Street',	'01887',	'Wilmington');

INSERT INTO "skill" ("id", "level") VALUES
(1,	'beginner'),
(2,	'intermediate'),
(3,	'advanced'),
(4, 'all');

INSERT INTO "student" ("id", "maximum_rental_quota", "sibling", "person_id", "skill_id") VALUES
(600,	2,	NULL,	500,	1),
(601,	2,	NULL,	501,	2),
(602,	2,	NULL,	502,	2),
(603,	2,	NULL,	503,	3),
(604,	2,	NULL,	504,	3),
(605,	2,	1,	    505,	2),
(606,	2,	1,	    506,	1),
(607,	2,	NULL,	507,	2),
(608,	2,	1,	    508,	2),
(609,	2,	1,	    509,	2);

INSERT INTO "instructor" ("id", "person_id") VALUES
(401,		511),
(402,		512),
(403,		513),
(404,		514),
(405,		515),
(406,		516),
(407,		517),
(408,		518),
(409,		519),
(400,		510);

INSERT INTO "instrument" ("brand", "id", "fee", "type_of_instrument") VALUES
('YAMAHA',	900,	650,	'piano'),
('Gibson',	901,	635,	'guitar'),
('Cecilio',	902,	500,	'violin'),
('Mapex',	903,	650,	'drums'),
('Jupiter',	904,	535,	'clarinet'),
('Fender',	905,	600,	'bass'),
('Pearl',	906,	650,	'drums'),
('Shigeru Kawai',	907,	695,	'piano'),
('Rossetti',	908,	550,	'trumpet'),
('Yanagisawa',	909,	545,	'saxophone'),
('Epiphone',	910,	650,	'guitar'),
('Mendini',	911,	535,	'violin'),
('Jean Paul',	912,	535,	'clarinet'),
('Hofner',	913,	600,	'bass'),
('Allora',	914,	540,	'trumpet'),
('Ludwig',	915,	640,	'drums'),
('Selmer Paris',	916,	565,	'saxophone'),
('Fender',	917,	635,	'bass'),
('Yamaha YCL',	918,	535,	'clarinet'),
('Sterling',	919,	675,	'bass'),
('Kawai', 920, 700, 'piano'),
('Garrison', 921, 635, 'guitar'),
('Stentor', 922, 550, 'violin');


INSERT INTO "rental" ("id", "start_date", "end_date", "student_id", "instrument_id") VALUES
(800,	'2020-01-02 10:15:00',	'2020-03-02 10:15:00',	600,	900),
(801,	'2020-02-05 10:15:00',	'2020-04-05 15:15:00',	601,	901),
(802,	'2020-02-25 15:15:00',	'2020-04-20 11:15:00',	602,	902),
(803,	'2020-03-14 15:15:00',	'2020-06-05 10:15:00',	603,	903),
(804,	'2020-03-20 11:15:00',	'2020-06-12 14:15:00',	604,	904),
(805,	'2020-04-08 17:15:00',	'2020-08-01 16:15:00',	605,	905),
(806,	'2020-04-13 12:15:00',	'2020-07-12 15:15:00',	606,	906),
(807,	'2020-05-05 09:15:00',	'2020-08-01 13:15:00',	607,	907),
(808,	'2020-05-14 15:15:00',	'2020-10-16 10:15:00',	608,	908),
(809,	'2020-06-05 08:15:00',	'2020-11-20 15:15:00',	609,	909),
(810,	'2020-06-14 14:15:00',	'2020-12-22 12:15:00',	600,	910),
(811,	'2020-07-05 08:15:00',	'2020-09-01 17:15:00',	601,	911),
(812,	'2020-08-08 08:15:00',	'2020-12-28 13:15:00',	602,	912),
(813,	'2020-08-23 08:15:00',	'2020-12-28 13:15:00',	603,	913),
(814,	'2020-09-01 10:15:00',	'2020-10-12 14:15:00',	604,	914),
(815,	'2020-09-20 13:15:00',	'2020-12-05 14:15:00',	605,	915),
(816,	'2020-10-06 12:15:00',	'2020-10-21 13:15:00',	606,	916),
(817,	'2020-10-25 12:15:00',	'2020-11-25 12:15:00',	607,	917),
(818,	'2020-11-11 11:15:00',	'2021-01-02 16:15:00',	608,	918),
(819,	'2020-12-22 09:15:00',	'2020-12-31 13:15:00',	609,	919),
(820,	'2021-01-05 10:15:00',	'2021-09-07 10:15:00',	600,	900);

INSERT INTO "time_slot" ("id", "start_time", "end_time", "instructor_id") VALUES
('3000', '2020-01-05 10:15:00', '2020-01-05 11:15:00', '400'),
('3001', '2020-02-06 09:15:00', '2020-02-06 10:15:00', '401'),
('3002', '2020-03-12 15:15:00', '2020-03-12 16:15:00', '402'),
('3003', '2020-04-13 14:15:00', '2020-04-13 15:15:00', '403'),
('3004', '2020-05-23 09:15:00', '2020-05-23 10:15:00', '404'),
('3005', '2020-06-19 12:15:00', '2020-06-19 13:15:00', '405'),
('3006', '2020-07-08 08:15:00', '2020-07-08 09:15:00', '406'),
('3007', '2020-08-19 15:15:00', '2020-08-19 16:15:00', '407'),
('3008', '2020-09-17 13:15:00', '2020-09-17 14:15:00', '408'),
('3009', '2020-10-01 15:15:00', '2020-10-01 16:15:00', '409'),
('3010', '2020-11-29 15:15:00', '2020-11-29 16:15:00', '401'),
('3011', '2020-12-27 17:15:00', '2020-12-27 18:15:00', '402'),
('3012', '2020-05-20 13:15:00', '2020-05-20 14:15:00', '404'),
('3013', '2020-07-13 17:15:00', '2020-07-13 18:15:00', '406'),
('3014', '2020-10-12 14:15:00', '2020-10-12 15:15:00', '409'),
('3015', '2020-12-28 09:15:00', '2020-12-28 10:15:00', '400');

INSERT INTO "individual_lesson" ("id", "minimum_enrollment", "maximum_enrollment", "student_id", "instrument_id", "instructor_id", "time_slot_id") VALUES 
('2000', '1', '1', '600', '900', '400', '3000'),
('2001', '1', '1', '601', '901', '401', '3001'),
('2002', '1', '1', '602', '902', '402', '3002'),
('2003', '1', '1', '603', '903', '403', '3003'),
('2004', '1', '1', '604', '907', '400', '3012'),
('2005', '1', '1', '605', '908', '401', '3013'),
('2006', '1', '1', '606', '909', '402', '3014'),
('2007', '1', '1', '607', '910', '403', '3014');

INSERT INTO "group_lesson" ("id", "minimum_enrollment", "maximum_enrollment", "instrument_id", "instructor_id", "time_slot_id") VALUES 
('100', '2', '6', '900', '400', '3004'),
('101', '2', '6', '904', '401', '3005'),
('102', '2', '6', '905', '402', '3006'),
('103', '2', '6', '906', '403', '3007');

INSERT INTO "ensemble" ("id", "genre", "minimum_enrollment", "maximum_enrollment", "instructor_id", "time_slot_id") VALUES 
('300', 'classical', '5', '15', '404', '3008'),
('301', 'jazz', '5', '15', '405', '3009'),
('302', 'rock', '5', '15', '406', '3010'),
('303', 'soul', '5', '15', '407', '3011');

INSERT INTO "school" ("id", "available_spots", "minimum_age", "street", "zip", "city", "student_waiting_list") VALUES
('101010', '5', '18', '1448  Olen Thomas Drive', '76026', 'Bridgeport', '1');

INSERT INTO "application" ("id", "instrument", "skill_id", "school_id", "person_id") VALUES
('1', 'guitar', '3', '101010', '520');

INSERT INTO "email_address" ("email", "person_id") VALUES
('t9krd4sjlem@temporary-mail.net', '500'),
('khf4vaoatr@temporary-mail.net', '501'),
('743y2wnziho@temporary-mail.net', '502'),
('ifdgihu2yt@temporary-mail.net', '503'),
('2o1l26okvx2@temporary-mail.net', '504'),
('eqyetix21h9@temporary-mail.net', '505'),
('rnzez3laor@temporary-mail.net', '506'),
('w8fpv3egygk@temporary-mail.net', '507'),
('zyz8d2w06q@temporary-mail.net', '508'),
('mbuygatb2fk@temporary-mail.net', '509'),
('fw0810bu80m@temporary-mail.net', '510'),
('c3atx4jofe@temporary-mail.net', '511'),
('gg5mkkx99jq@temporary-mail.net', '512'),
('h0u3cffk5c@temporary-mail.net', '513'),
('cin10ln716u@temporary-mail.net', '514'),
('lzpp9pd13@temporary-mail.net', '515'),
('zqomz2zqx3@temporary-mail.net', '516'),
('95dv0uf8j2v@temporary-mail.net', '517'),
('upjnk33p7bq@temporary-mail.net', '518'),
('zgmzediemg@temporary-mail.net', '519'),
('mh3yxj1sore@temporary-mail.net', '521'),
('u00q7cjva7@temporary-mail.net', '522'),
('c12o3ed82oi@temporary-mail.net', '523'),
('ycfccwhtwp9@temporary-mail.net', '524'),
('2brvm13hxft@temporary-mail.net', '525'),
('0jzfqqxbaucr@temporary-mail.net', '526'),
('432e6qxbd9u@temporary-mail.net', '527'),
('fg7nln6rt6d@temporary-mail.net', '528');

INSERT INTO "phone_number" ("phone_nr", "person_id") VALUES
('415-983-4381', '500'),
('415-983-4318', '501'),
('724-632-8712', '502'),
('757-971-0489', '503'),
('757-971-0226', '504'),
('620-829-3217', '505'),
('301-291-3310', '506'),
('702-675-2686', '507'),
('702-675-2812', '508'),
('615-507-5934', '509'),
('720-232-4430', '510'),
('270-307-5508', '511'),
('216-444-3483', '512'),
('775-374-9683', '513'),
('503-963-6272', '514'),
('562-275-9459', '515'),
('602-995-6721', '516'),
('602-995-6854', '517'),
('808-856-5071', '518'),
('802-350-5046', '519'),
('317-573-4004', '521'),
('712-326-7669', '522'),
('717-713-1411', '523'),
('619-271-1908', '524'),
('619-840-0189', '525'),
('815-727-7179', '526'),
('815-727-7554', '527'),
('609-893-1851', '528');

INSERT INTO "guardian" (person_id) VALUES
(521),
(522),
(523),
(524),
(525),
(526),
(527),
(528);

INSERT INTO "monthly_salary" (instructor_id, amount) VALUES
('400', '20000'),
('401', '30000'),
('402', '25000'),
('403', '35000'),
('404', '33000'),
('405', '32000'),
('406', '20000'),
('407', '28000'),
('408', '29000'),
('409', '30000');

INSERT INTO "student_fee" ("student_id", "discount", "extra_charge", "total_price") VALUES
('600', NULL, NULL, '650'),
('605', '20', NULL, '480');