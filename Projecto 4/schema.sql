/*SET foreign_key_checks=0;*/

drop table fiscaliza cascade;
drop table posto cascade;
drop table espaco cascade;
drop table aluga cascade;
drop table oferta cascade;
drop table paga cascade;
drop table estado cascade;
drop table arrenda cascade;
drop table alugavel cascade;
drop table reserva cascade;
drop table edificio cascade;
drop table fiscal cascade;
drop table user cascade;
drop table location_dimension;
drop table date_dimension;
drop table time_dimension;
drop table reserva_reading;

/*SET foreign_key_checks=1;*/

create table user
	(nif int not null unique,
	 nome varchar(255) not null,
	 telefone int not null,
	 primary key(nif));

create table fiscal
	(id int not null unique,
	 empresa varchar(255) not null,
	 primary key(id));

create table edificio
	(morada varchar(255) not null unique,
	 primary key(morada));

create table alugavel
	(morada varchar(255) not null,
	 codigo int not null,
	 foto varchar(255),
	 primary key(morada, codigo),
	 constraint foreign key(morada) references edificio(morada) on delete cascade);

create table arrenda
	(morada varchar(255) not null,
	 codigo int not null,
	 nif int not null,
	 primary key(morada, codigo),
	 constraint foreign key(morada, codigo) references alugavel(morada, codigo) on delete cascade,
	 constraint foreign key(nif) references user(nif) on delete cascade);

create table fiscaliza
	(id int not null,
	 morada varchar(255) not null,
	 codigo int not null,
	 primary key(id, morada, codigo),
	 constraint foreign key(id) references fiscal(id) on delete cascade,
	 constraint foreign key(morada, codigo) references arrenda(morada, codigo) on delete cascade);

create table espaco
	(morada varchar(255) not null,
	 codigo int not null,
	 primary key(morada, codigo),
	 constraint foreign key(morada, codigo) references alugavel(morada, codigo) on delete cascade);

create table posto
	(morada varchar(255) not null,
	 codigo int not null,
	 codigo_espaco int not null,
	 primary key(morada, codigo),
	 constraint foreign key(morada, codigo) references alugavel(morada, codigo) on delete cascade,
	 constraint foreign key(morada, codigo_espaco) references espaco(morada, codigo) on delete cascade);

create table oferta
	(morada varchar(255) not null,
	 codigo int not null,
	 data_inicio date not null,
	 data_fim date not null,
	 tarifa decimal(10,2) not null,
	 primary key(morada, codigo, data_inicio),
	 constraint foreign key(morada, codigo) references alugavel(morada, codigo) on delete cascade);

create table reserva
	(numero int not null unique,
	 primary key(numero));

create table paga
	(numero int not null unique,
	 data timestamp not null,
	 metodo varchar(255) not null,
	 primary key(numero),
	 constraint foreign key(numero) references reserva(numero) on delete cascade);

create table estado
	(numero int not null,
	 time_stamp timestamp not null,
	 estado varchar(255) not null,
	 primary key(numero, time_stamp),
	 constraint foreign key(numero) references reserva(numero) on delete cascade);

create table aluga
	(morada varchar(255) not null,
	 codigo int not null,
	 data_inicio date not null,
	 nif int not null,
	 numero int not null,
	 primary key(morada, codigo, data_inicio, nif, numero),
	 constraint foreign key(morada, codigo, data_inicio) references oferta(morada, codigo, data_inicio) on delete cascade, 
	 constraint foreign key(nif) references user(nif) on delete cascade,
	 constraint foreign key(numero) references reserva(numero) on delete cascade);

create table location_dimension
	(location_id int auto_increment,
	 morada varchar(255) not null,
	 codigo_espaco int,
	 codigo int,
	 primary key(location_id)
	 constraint foreign key(morada) references edificio(morada) on delete cascade);

create table time_dimension
	(time_id int not null,
	 time_of_day time not null,
	 hour_of_day int not null,
	 minute_of_day int not null,
	 minute_of_hour int not null,
	 primary key(time_id));

create table date_dimension
	(date_id int not null,
	 date_time date not null,
	 date_year int not null,
	 date_semester int not null,
	 date_month_number int not null,
	 date_week_number int not null,
	 date_day_of_month_number int not null,
	 primary key(date_id));

create table reserva_reading
	(nif int not null,
	 location_id int not null default 0,
	 time_id int not null default 0,
	 date_id int not null default 0,
	 montante_pago decimal(10,2) not null default 0,
	 duracao_dias int not null default 0,
	 primary key(nif,location_id,time_id,date_id),
	 constraint foreign key(nif) references user(nif) on delete cascade,
	 constraint foreign key(location_id) references location_dimension(location_id) on delete cascade,
	 constraint foreign key(time_id) references time_dimension(time_id) on delete cascade,
	 constraint foreign key(date_id) references date_dimension(date_id) on delete cascade);



DROP PROCEDURE populate_time_dimension;
DROP PROCEDURE populate_date_dimension;
DROP TRIGGER populate_location_dimension_posto;
DROP TRIGGER populate_location_dimension_espaco;
DROP TRIGGER populate_location_dimension_edificio;

delimiter //
CREATE PROCEDURE populate_time_dimension()
BEGIN
	DECLARE time_id INT;
	DECLARE time_of_day time;
	DECLARE hour_of_day INT;
	DECLARE minute_of_day INT;
	DECLARE minute_of_hour INT;
	SET @time_id=0;
	SET @time_of_day='00:00:00';
	SET @hour_of_day=0;
	SET @minute_of_day=0;
	SET @minute_of_hour=0;
	WHILE @hour_of_day < 24 DO
	WHILE @minute_of_hour < 60 DO
		insert into time_dimension values (@time_id, @time_of_day, @hour_of_day, @minute_of_day, @minute_of_hour);
			SET @time_id = @time_id + 1;
			SET @minute_of_hour = @minute_of_hour + 1;
			SET @minute_of_day = @minute_of_day + 1;
			SET @time_of_day = ADDTIME(@time_of_day, '0:1');
	END WHILE;
	SET @minute_of_hour = 0; SET @hour_of_day = @hour_of_day + 1;
	END WHILE;
END //

CREATE PROCEDURE populate_date_dimension()
BEGIN
	DECLARE date_id int;
	DECLARE date_time date;
	DECLARE date_year int;
	DECLARE date_semester int;
	DECLARE date_month_number int;
	DECLARE date_month_name varchar(255);
	DECLARE date_week_number int;
	DECLARE date_week_day_number int;
	DECLARE date_week_day_name varchar(255);
	DECLARE date_day_of_month_number int;
	DECLARE date_day_number int;
	DECLARE var int;
	
	SET @date_id=1;
	SET @date_time='2016-01-01';
	SET @date_year=YEAR(@date_time);
	SET @date_semester=1;
	SET @date_month_number=MONTH(@date_time);
	SET @date_month_name=MONTHNAME(@date_time);
	SET @date_week_number=1;
	SET @date_week_day_number=DAYOFWEEK(@date_time) - 1;
	IF @date_week_day_number = 0 THEN
	SET @date_week_day_number = 7;
	END IF;
	SET @date_week_day_name=DAYNAME(@date_time);
	SET @date_day_of_month_number=DAYOFMONTH(@date_time);
	SET @date_day_of_year_number=DAYOFYEAR(@date_time);
	SET var = @date_year;
	WHILE @date_year < 2018 DO
		insert into date_dimension values (@date_id, @date_time, @date_year, @date_semester, @date_month_number, @date_week_number, @date_day_of_month_number);
			SET @date_id = @date_id + 1;
			SET @date_time=ADDDATE(@date_time, INTERVAL 1 DAY);
			SET @date_year=YEAR(@date_time);
			SET @date_month_number=MONTH(@date_time);
			SET @date_month_name=MONTHNAME(@date_time);
			SET @date_week_day_number=DAYOFWEEK(@date_time) - 1;
			SET @date_week_day_name=DAYNAME(@date_time);
			SET @date_day_of_month_number=DAYOFMONTH(@date_time);
			SET @date_day_of_year_number=DAYOFYEAR(@date_time);
			IF @date_month_number < 7 THEN
			SET @date_semester=1;
			ELSE
			SET @date_semester=2;
			END IF;
			IF @date_week_day_number = 0 THEN
			SET @date_week_day_number = 7;
			END IF;
			IF @date_week_day_number = 1 THEN
			SET @date_week_number=@date_week_number + 1;
			END IF;
			IF @date_year <> var THEN
			SET @date_week_number=1;
			SET var = @date_year;
			END IF;
	END WHILE;
END //

CREATE TRIGGER populate_location_dimension_posto AFTER INSERT ON posto 
FOR EACH ROW
BEGIN
insert into location_dimension (morada, codigo_espaco, codigo) values (NEW.morada, NEW.codigo_espaco, NEW.codigo);
END //

CREATE TRIGGER populate_location_dimension_espaco AFTER INSERT ON espaco 
FOR EACH ROW
BEGIN
insert into location_dimension (morada, codigo_espaco, codigo) values (NEW.morada, NEW.codigo, NEW.codigo);
END //

CREATE TRIGGER populate_location_dimension_edificio AFTER INSERT ON edificio 
FOR EACH ROW
BEGIN
insert into location_dimension (morada) values (NEW.morada);
END //

CREATE TRIGGER populate_reserva_reading AFTER INSERT ON paga
FOR EACH ROW
BEGIN
DECLARE nif int;
DECLARE location_id int;
DECLARE time_id int;
DECLARE date_id int;
DECLARE montante_pago decimal(10,2);
DECLARE duracao int;

SET @nif = (select a.nif 
			from aluga a 
			where a.numero = NEW.numero);
SET @location_id = (SELECT l.location_id 
					FROM location_dimension l 
					NATURAL JOIN oferta 
					NATURAL JOIN aluga a 
					WHERE a.numero = NEW.numero);
SET @time_id = (select t.time_id 
				from time_dimension t 
				NATURAL JOIN (
					select TIME(p.data) time 
					FROM paga p 
					WHERE p.numero = NEW.numero) x 
				WHERE HOUR(x.time) = t.hour_of_day AND MINUTE(x.time) = t.minute_of_hour);
SET @date_id = (select d.date_id 
				from date_dimension d 
				NATURAL JOIN (
					select DATE(p.data) data 
					FROM paga p 
					WHERE p.numero = NEW.numero) x 
				WHERE x.data = d.date_time);
SET @montante_pago = (SELECT o.tarifa*(DATEDIFF(o.data_fim, o.data_inicio)+1) 
					FROM oferta o 
					NATURAL JOIN aluga a 
					WHERE a.numero = NEW.numero);
SET @duracao= (SELECT DATEDIFF(o.data_fim, o.data_inicio)+1 
				FROM oferta o 
				NATURAL JOIN aluga a 
				WHERE a.numero = NEW.numero);
insert into reserva_reading (nif, location_id, time_id, date_id, montante_pago, duracao_dias) 
	values (@nif, @location_id, @time_id, @date_id, @montante_pago, @duracao); 

END //

delimiter ;

CALL populate_time_dimension();
CALL populate_date_dimension();
