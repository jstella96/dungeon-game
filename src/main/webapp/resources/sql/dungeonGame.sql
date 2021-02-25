SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS diamond_get;
DROP TABLE IF EXISTS diamond;
DROP TABLE IF EXISTS event_clear;
DROP TABLE IF EXISTS event;
DROP TABLE IF EXISTS item_get;
DROP TABLE IF EXISTS item;
DROP TABLE IF EXISTS monster_death;
DROP TABLE IF EXISTS red_diamond_get;
DROP TABLE IF EXISTS member;
DROP TABLE IF EXISTS monster;
DROP TABLE IF EXISTS red_diamond;




/* Create Tables */

CREATE TABLE diamond
(
	diamond_id int NOT NULL AUTO_INCREMENT,
	diamond_map int NOT NULL,
	diamond_x int NOT NULL,
	diamond_y int NOT NULL,
	PRIMARY KEY (diamond_id)
);


CREATE TABLE diamond_get
(
	diamond_id int NOT NULL,
	member_id varchar(50) NOT NULL
);


CREATE TABLE event
(
	event_id int NOT NULL AUTO_INCREMENT,
	event_name varchar(50) NOT NULL,
	event_map int NOT NULL,
	PRIMARY KEY (event_id)
);


CREATE TABLE event_clear
(
	event_id int NOT NULL,
	member_id varchar(50) NOT NULL
);


CREATE TABLE item
(
	item_id int NOT NULL AUTO_INCREMENT,
	item_name varchar(50) NOT NULL,
	item_map int NOT NULL,
	item_x int NOT NULL,
	item_y int NOT NULL,
	PRIMARY KEY (item_id),
	UNIQUE (item_name)
);


CREATE TABLE item_get
(
	item_id int NOT NULL,
	member_id varchar(50) NOT NULL,
	item_use varchar(10) NOT NULL
);


CREATE TABLE member
(
	member_id varchar(50) NOT NULL,
	member_password varchar(2000) NOT NULL,
	member_lastsave date NOT NULL,
	member_life int NOT NULL,
	member_map int NOT NULL,
	member_x int NOT NULL,
	member_y int NOT NULL,
	PRIMARY KEY (member_id)
);


CREATE TABLE monster
(
	monster_id int NOT NULL AUTO_INCREMENT,
	monster_level int NOT NULL,
	monster_life int NOT NULL,
	monster_map int NOT NULL,
	monster_min_x int NOT NULL,
	monster_max_x int,
	monster_min_y int NOT NULL,
	monster_max_y int,
	monster_position varchar(10) NOT NULL,
	PRIMARY KEY (monster_id)
);



CREATE TABLE monster_death
(
	monster_id int NOT NULL,
	member_id varchar(50) NOT NULL,
	monster_x int NOT NULL,
	monster_y int NOT NULL
);

CREATE TABLE red_diamond
(
	red_diamond_id int NOT NULL AUTO_INCREMENT,
	red_diamond_map int,
	red_diamond_x int,
	red_diamond_y int,
	PRIMARY KEY (red_diamond_id)
);


CREATE TABLE red_diamond_get
(
	member_id varchar(50) NOT NULL,
	red_diamond_id int NOT NULL
);



/* Create Foreign Keys */

ALTER TABLE diamond_get
	ADD FOREIGN KEY (diamond_id)
	REFERENCES diamond (diamond_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE event_clear
	ADD FOREIGN KEY (event_id)
	REFERENCES event (event_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE item_get
	ADD FOREIGN KEY (item_id)
	REFERENCES item (item_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE diamond_get
	ADD FOREIGN KEY (member_id)
	REFERENCES member (member_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE event_clear
	ADD FOREIGN KEY (member_id)
	REFERENCES member (member_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE item_get
	ADD FOREIGN KEY (member_id)
	REFERENCES member (member_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE monster_death
	ADD FOREIGN KEY (member_id)
	REFERENCES member (member_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE red_diamond_get
	ADD FOREIGN KEY (member_id)
	REFERENCES member (member_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE monster_death
	ADD FOREIGN KEY (monster_id)
	REFERENCES monster (monster_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE red_diamond_get
	ADD FOREIGN KEY (red_diamond_id)
	REFERENCES red_diamond (red_diamond_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



