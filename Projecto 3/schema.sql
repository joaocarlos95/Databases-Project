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
	 tarifa int not null,
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
