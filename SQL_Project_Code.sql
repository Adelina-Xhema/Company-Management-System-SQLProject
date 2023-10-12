create database AdelinaXhema
use AdelinaXhema

create table Kompania(
	id_kompania int primary key,
	emri varchar(20) not null,
	viti_themelimit int not null,
	qyteti varchar(20) not null ,
	rruga varchar(20) ,
	zipkodi int null
);

create table Sponzori(
	id_sponzorit int primary key,
	emri varchar(20) not null,
	shifra_monetare char(1) not null,
	shuma_monetare int not null,
	lloji_sponzorit varchar(20) not null,
	koha_sponzorit date not null,
	email char(25) unique,
	id_kompania int foreign key references Kompania(id_kompania)
	);

create table Stafi(
	stafi_id int primary key,
	emri varchar(20) not null,
	mbiemri varchar(20) not null,
	data_lindjes date not null,
	llogaria_bankes varchar(12) unique,
	kontrata varchar(20) not null,
	id_kompania int foreign key references Kompania(id_kompania)
);

create table Drejtori(
	drejtori_id int primary key identity(1,1),
	gjinia char(1) check (gjinia in('F','M')),
	emri varchar(10) not null,
	mbiemri varchar(10) not null,
	id_kompania int unique foreign key references Kompania(id_kompania)
);

create table Menaxheri(
	stafi_id_menaxheri int not null REFERENCES Stafi(stafi_id) ,
	eksperienca int not null,
	gjinia char(1) check (gjinia in('F','M')),
	Primary key(stafi_id_menaxheri)
	);

	create table Punetori(
	stafi_id_punetori int primary key ,
	gjinia char(1) check (gjinia in('F','M')),
	stafi_id int foreign key REFERENCES Stafi(stafi_id),
	menaxhuesi_id int foreign key references Punetori(stafi_id_punetori)
);

create table StafiMirembajtes(
	stafi_id_mirembajtes int not null REFERENCES Stafi(stafi_id) ,
	eksperienca int not null,
	Primary key(stafi_id_mirembajtes)
	);

	create table Praktikanti(
	praktikanti_id int primary key,
	emri varchar(20) not null,
	mbiemri varchar(20) not null,
	data_lindjes date not null,
	nr_telefonit int not null,
	email char (25) unique,
	lloji_trajnimit varchar(50),
	id_kompania int foreign key references Kompania(id_kompania)
);

create table Trajnimi(
	trajnimi_id int primary key,
	emri varchar(20) not null,
	kohezgjatja varchar(20) not null,
	nr_participanteve int,
	data_mbajtjes date,
);

create table MerrPjese(
	trajnimi_id int references Trajnimi(trajnimi_id),
    praktikanti_id int references Praktikanti(praktikanti_id),
	primary key(praktikanti_id,trajnimi_id)
);

create table Orari(
	 trajnimi_id int,
     koha_mbajtjes CHAR(30),
	 kohezgjatja char(10),
    PRIMARY KEY (trajnimi_id, koha_mbajtjes),
     FOREIGN KEY (trajnimi_id) REFERENCES Trajnimi
	 );

create table Salla(
	salla_id int primary key,
	nr_ulseve int,
	nr_katit int,
);

create table Mbahet(
	trajnimi_id int references Trajnimi(trajnimi_id),
    salla_id int references Salla(salla_id)
	primary key(salla_id,trajnimi_id)
);

create table Pajisje(
	pajisja_id int primary key,
	emri_pajisjes varchar(20) not null,
	nr_pajisjeve int,
	prodhuesi varchar(20) not null,
	qmimi money,
	stafi_id_mirembajtes int foreign key references StafiMirembajtes(stafi_id_mirembajtes),
    salla_id int foreign key references Salla(salla_id)
);

create table Klienti(
	klienti_id int primary key,
	emri varchar(20) not null,
	mbiemri varchar(20) not null,
	nr_leternjoftimit varchar(12) not null,
	llogaria_bankes varchar(12) not null,
	email char (25) unique,
	adresa varchar(20) not null,
);

create table Projekti(
	projekti_id int primary key,
	emri_projektit varchar(20) not null,
	kohezgjatja varchar(20),
	stafi_id_menaxheri int foreign key references Menaxheri(stafi_id_menaxheri),
    klienti_id int not null foreign key  references Klienti(klienti_id)
);

create table Paga(
	paga_id int primary key,
	shuma money not null,
	numri_stafit int,
	id_kompania int foreign key references Kompania(id_kompania)
);

create table Pranon(
	primary key(stafi_id,paga_id),
	stafi_id int REFERENCES Stafi(stafi_id),
	paga_id int REFERENCES Paga(paga_id)
);

create table Ligjeron(
	trajnimi_id int references Trajnimi(trajnimi_id),
	stafi_id_punetori int references Punetori(stafi_id_punetori),
	primary key(stafi_id_punetori,trajnimi_id)
);

create table Pagesa(
	pagesa_id int primary key,
	shuma int,
	pranimi_projektit BIT not null,/*1,0*/
	klienti_id int foreign key references Klienti(klienti_id)
);
alter table Pagesa add id_kompania int foreign key references Kompania(id_kompania)


create table Bashkepunoni(
    praktikanti_id int foreign key references Praktikanti(praktikanti_id),
	stafi_id_punetori int foreign key references Punetori(stafi_id_punetori),
	primary key (praktikanti_id,stafi_id_punetori),
);

create table Mbikqyr(
	praktikanti_id int,
	stafi_id_punetori int,
	stafi_id_menaxheri int,
	primary key(stafi_id_punetori,praktikanti_id,stafi_id_menaxheri),
	foreign key (praktikanti_id,stafi_id_punetori) references Bashkepunoni(praktikanti_id,stafi_id_punetori),
	foreign key (stafi_id_menaxheri) references Menaxheri(stafi_id_menaxheri)
);

create table Kryejn(
	praktikanti_id int,
	stafi_id_punetori int,
	trajnimi_id int,
	primary key(stafi_id_punetori,praktikanti_id,trajnimi_id),
	foreign key (praktikanti_id,stafi_id_punetori) references Bashkepunoni(praktikanti_id,stafi_id_punetori),
	foreign key (trajnimi_id) references Trajnimi(trajnimi_id)
);

create table Departamenti(
	lloji_departamentit char(20),
	buxheti money,
	nr_punetoreve int,
	zyre_departamenti char(20)
);
alter table Departamenti add departamenti_id int primary key

create table Dep_Komp_Pun(
	id_kompania int foreign key references Kompania(id_kompania),
	stafi_id_punetori int foreign key references Punetori(stafi_id_punetori),
	departamenti_id int  foreign key references Departamenti(departamenti_id),
	primary key(departamenti_id,stafi_id_punetori),

);
INSERT into Kompania (id_kompania, emri, viti_themelimit, qyteti, rruga, zipkodi) VALUES (10, 'ARTECH',2000,'Mitrovice','Mbreteresha Teuta',40000)
INSERT into Kompania (id_kompania, emri, viti_themelimit, qyteti, rruga, zipkodi) VALUES (11, 'ARTECH',2001,'Prishtine','Ali Zeneli',10000)
INSERT into Kompania (id_kompania, emri, viti_themelimit, qyteti, rruga, zipkodi) VALUES (12, 'ARTECH',2002,'Peje','Eqrem Qabej',20000)
INSERT into Kompania (id_kompania, emri, viti_themelimit, qyteti, rruga, zipkodi) VALUES (13, 'ARTECH',2003,'Prizren','Skenderbeu',30000)
INSERT into Kompania (id_kompania, emri, viti_themelimit, qyteti, rruga, zipkodi) VALUES (14, 'ARTECH',2004,'Gjilan','Gjergj Kastrioti',50000)
INSERT into Kompania (id_kompania, emri, viti_themelimit, qyteti, rruga, zipkodi) VALUES (15, 'ARTECH',2005,'Gjakove','Sami Frasheri',60000)
INSERT into Kompania (id_kompania, emri, viti_themelimit, qyteti, rruga, zipkodi) VALUES (16, 'ARTECH',2006,'Malisheve','Fan Noli',70000)
INSERT into Kompania (id_kompania, emri, viti_themelimit, qyteti, rruga, zipkodi) VALUES (17, 'ARTECH',2007,'Deqan','Naim Frasheri',80000)
INSERT into Kompania (id_kompania, emri, viti_themelimit, qyteti, rruga, zipkodi) VALUES (18, 'ARTECH',2008,'Istog','Isa Boletini',90000)
INSERT into Kompania (id_kompania, emri, viti_themelimit, qyteti, rruga, zipkodi) VALUES (19, 'ARTECH',2009,'Ferizaj','Adem Jashari',110000)


INSERT into Sponzori (id_sponzorit, emri, shifra_monetare,shuma_monetare, lloji_sponzorit, koha_sponzorit, email, id_kompania) VALUES (1,'Alida-Commerce','$',1000,'Softuer',CAST(N'1998-12-17' AS Date),'acomm@hotmail.com',11)
INSERT into Sponzori (id_sponzorit, emri, shifra_monetare, shuma_monetare,lloji_sponzorit, koha_sponzorit, email, id_kompania) VALUES (2,'Lider-Commerce','$',20000,'Web',CAST(N'2000-01-11' AS Date),'licomm@hotmail.com',12)
INSERT into Sponzori (id_sponzorit, emri, shifra_monetare, shuma_monetare,lloji_sponzorit, koha_sponzorit, email, id_kompania) VALUES (3,'River-Commerce','$',30000,'Web',CAST(N'2001-03-12' AS Date),'ricomm@hotmail.com',15)
INSERT into Sponzori (id_sponzorit, emri, shifra_monetare, shuma_monetare,lloji_sponzorit, koha_sponzorit, email, id_kompania) VALUES (4,'ASp-Commerce','$',40000,'Softuer',CAST(N'2013-11-16' AS Date),'ascomm@hotmail.com',14)
INSERT into Sponzori (id_sponzorit, emri, shifra_monetare,shuma_monetare, lloji_sponzorit, koha_sponzorit, email, id_kompania) VALUES (5,'LOW-Commerce','$',50000,'Softuer',CAST(N'2014-09-15' AS Date),'lecomm@hotmail.com',13)
INSERT into Sponzori (id_sponzorit, emri, shifra_monetare,shuma_monetare, lloji_sponzorit, koha_sponzorit, email, id_kompania) VALUES (6,'Pseudo-Commerce','$',60000,'Web',CAST(N'2015-10-19' AS Date),'pcomm@hotmail.com',18)
INSERT into Sponzori (id_sponzorit, emri, shifra_monetare,shuma_monetare, lloji_sponzorit, koha_sponzorit, email, id_kompania) VALUES (7,'Lape-Commerce','$',70000,'Web',CAST(N'2016-04-27' AS Date),'lcomm@hotmail.com',17)
INSERT into Sponzori (id_sponzorit, emri, shifra_monetare, shuma_monetare,lloji_sponzorit, koha_sponzorit, email, id_kompania) VALUES (8,'Que-Commerce','$',20000,'Web',CAST(N'2017-06-25' AS Date),'qcomm@hotmail.com',15)
INSERT into Sponzori (id_sponzorit, emri, shifra_monetare,shuma_monetare, lloji_sponzorit, koha_sponzorit, email, id_kompania) VALUES (9,'Arev-Commerce','$',10000,'Softuer',CAST(N'2019-08-30' AS Date),'arcomm@hotmail.com',16)
INSERT into Sponzori (id_sponzorit, emri, shifra_monetare,shuma_monetare, lloji_sponzorit, koha_sponzorit, email, id_kompania) VALUES (10,'Vret-Commerce','$',30000,'Softuer',CAST(N'2021-09-29' AS Date),'vcomm@hotmail.com',10)
INSERT into Sponzori (id_sponzorit, emri, shifra_monetare,shuma_monetare, lloji_sponzorit, koha_sponzorit, email, id_kompania) VALUES (11,'Arex-Commerce','$',12000,'Web',CAST(N'2020-08-30' AS Date),'arxcomm@hotmail.com',12)
INSERT into Sponzori (id_sponzorit, emri, shifra_monetare,shuma_monetare, lloji_sponzorit, koha_sponzorit, email, id_kompania) VALUES (12,'Vrer-Commerce','$',35000,'Softuer',CAST(N'2020-09-29' AS Date),'vrrcomm@hotmail.com',13)


INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (1001,'Ana','Vitaku',CAST(N'1998-12-17' AS Date),'261462824921','7 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (2002,'Albesa','Gashi',CAST(N'2000-01-11' AS Date),'124128649812','3 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (3003,'Lisi','Krasniqi',CAST(N'1991-03-12' AS Date),'124128649813','7 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (4004,'Medina','Tmava',CAST(N'1993-11-16' AS Date),'124128649816','4 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (5005,'Shpati','Sejdiu',CAST(N'1994-09-15' AS Date),'124128649819','3 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (6006,'Lumi','Syla',CAST(N'1995-10-19' AS Date),'324128649812','7 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (7007,'Ardita','Voca',CAST(N'1996-04-27' AS Date),'124128669812','7 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (8008,'Asllani','Aliu',CAST(N'1997-06-25' AS Date),'874128649812','10 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (9009,'Rea','Osmani',CAST(N'1999-08-30' AS Date),'454128649812','9 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (1002,'Bleona','Ferizi',CAST(N'1991-09-29' AS Date),'924128649812','7 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (1003,'Dion','Spahiu',CAST(N'1999-12-17' AS Date),'784128649812','5 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (2003,'Jakup','Kelmendi',CAST(N'1990-01-11' AS Date),'094128649812','7 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (3004,'Dielleza','Rama',CAST(N'1991-03-12' AS Date),'754128649812','7 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (4005,'Arta','Behrami',CAST(N'1993-11-16' AS Date),'456128649812','8 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (5006,'Alfred','Berisha',CAST(N'1994-09-15' AS Date),'678928649812','8 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (6007,'Poema','Aliu',CAST(N'1995-10-19' AS Date),'543128649812','8 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (7008,'Ledri','Voca',CAST(N'1996-04-27' AS Date),'876128649812','6 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (8009,'Sara','Hoxha',CAST(N'1997-06-25' AS Date),'038435686346','9 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (9000,'Xheri','Vula',CAST(N'1979-08-30' AS Date),'746453423243','5 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (1004,'Alisa','Qerkini',CAST(N'1981-09-29' AS Date),'076128649812','7 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (1005,'Riad','Nimani',CAST(N'1988-12-17' AS Date),'437293748398','8 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (2006,'Xhemile','Vishi',CAST(N'1990-01-11' AS Date),'167128649812','3 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (3007,'Shaban','Cana',CAST(N'1991-03-12' AS Date),'124126459812','1 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (4008,'Bahri','Sfishta',CAST(N'1993-11-16' AS Date),'124128684612','5 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (5009,'Besim','Hajrizi',CAST(N'1994-09-15' AS Date),'124128647652','3 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (6004,'Arjeta','Istrefi',CAST(N'1995-10-19' AS Date),'124128649345','2 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (7003,'Vahide','Rugova',CAST(N'1996-04-27' AS Date),'124128649111','9 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (8002,'Shqipe','Uka',CAST(N'1997-06-25' AS Date),'124999649812','8 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (9002,'Violeta','Rexhepi',CAST(N'1997-08-30' AS Date),'124128649222','6 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (1012,'Monika','Kastrati',CAST(N'1998-09-29' AS Date),'111128649812','5 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (6213,'Selmina','Vocaj',CAST(N'1999-04-27' AS Date),'100028649812','3 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (6210,'Selmin','Voca',CAST(N'1998-04-27' AS Date),'276128649812','6 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (6310,'Dona','Hamza',CAST(N'1995-06-25' AS Date),'338435686346','9 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (6410,'Erna','Vula',CAST(N'1972-08-30' AS Date),'446453423243','5 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (6751,'Besa','Qerkini',CAST(N'1989-09-29' AS Date),'800128649812','7 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (6610,'Kian','Nimani',CAST(N'1985-12-17' AS Date),'537293748398','8 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (6102,'Valon','Istrefi',CAST(N'1996-10-19' AS Date),'224128649345','2 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (6103,'Jetmira','Gashi',CAST(N'1998-04-27' AS Date),'554128649111','9 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (6104,'Diona','Uka',CAST(N'1998-06-25' AS Date),'994999649812','4 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (6105,'Almin','Fila',CAST(N'1999-08-30' AS Date),'664128649222','6 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (6106,'Nik','Kastrati',CAST(N'1999-09-29' AS Date),'221128649812','5 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (6710,'Zana','Vishi',CAST(N'1995-01-11' AS Date),'127128649812','3 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (6810,'Rigon','Cana',CAST(N'1991-03-12' AS Date),'154126459812','1 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (6910,'Ardit','Sfishta',CAST(N'1994-11-16' AS Date),'924128684612','5 Vjeqare')
INSERT into Stafi (stafi_id, emri, mbiemri, data_lindjes, llogaria_bankes, kontrata) VALUES (6101,'Leart','Hajrizi',CAST(N'1997-09-15' AS Date),'824128647652','2 Vjeqare')


SET IDENTITY_INSERT Drejtori ON
INSERT into Drejtori (drejtori_id, emri, mbiemri, gjinia,id_kompania) VALUES (10000,'Astrit','Kastrati','M',12)
INSERT into Drejtori (drejtori_id, emri, mbiemri, gjinia,id_kompania) VALUES (10001,'Alma','Syla','F',13)
INSERT into Drejtori (drejtori_id, emri, mbiemri, gjinia,id_kompania) VALUES (10002,'Berat','Aliji','M',14)
INSERT into Drejtori (drejtori_id, emri, mbiemri, gjinia,id_kompania) VALUES (10003,'Zara','Murseli','F',15)
INSERT into Drejtori (drejtori_id, emri, mbiemri, gjinia,id_kompania) VALUES (10004,'Albert','Hoxha','M',16)
INSERT into Drejtori (drejtori_id, emri, mbiemri, gjinia,id_kompania) VALUES (10005,'Sara','Ferati','F',17)
INSERT into Drejtori (drejtori_id, emri, mbiemri, gjinia,id_kompania) VALUES (10006,'Bleart','Dinaj','M',18)
INSERT into Drejtori (drejtori_id, emri, mbiemri, gjinia,id_kompania) VALUES (10007,'Jara','Sadiku','F',19)
INSERT into Drejtori (drejtori_id, emri, mbiemri, gjinia,id_kompania) VALUES (10008,'Ylli','Sadriu','M',10)
INSERT into Drejtori (drejtori_id, emri, mbiemri, gjinia,id_kompania) VALUES (10009,'Anisa','Voca','F',11)


INSERT into Menaxheri(stafi_id_menaxheri, eksperienca, gjinia) VALUES (2002,5,'F')
INSERT into Menaxheri(stafi_id_menaxheri, eksperienca, gjinia) VALUES (3007,4,'M')
INSERT into Menaxheri(stafi_id_menaxheri, eksperienca, gjinia) VALUES (5009,3,'M')
INSERT into Menaxheri(stafi_id_menaxheri, eksperienca, gjinia) VALUES (8002,2,'F')
INSERT into Menaxheri(stafi_id_menaxheri, eksperienca, gjinia) VALUES (9002,1,'F')
INSERT into Menaxheri(stafi_id_menaxheri, eksperienca, gjinia) VALUES (1003,4,'M')
INSERT into Menaxheri(stafi_id_menaxheri, eksperienca, gjinia) VALUES (7007,5,'F')
INSERT into Menaxheri(stafi_id_menaxheri, eksperienca, gjinia) VALUES (1005,7,'M')
INSERT into Menaxheri(stafi_id_menaxheri, eksperienca, gjinia) VALUES (7008,8,'M')
INSERT into Menaxheri(stafi_id_menaxheri, eksperienca, gjinia) VALUES (1012,9,'F')


INSERT into Punetori(stafi_id_punetori, gjinia,menaxhuesi_id) VALUES (6007,'F',null)
INSERT into Punetori(stafi_id_punetori, gjinia, menaxhuesi_id) VALUES (6008,'M',6007)
INSERT into Punetori(stafi_id_punetori, gjinia, menaxhuesi_id) VALUES (3003,'M',null)
INSERT into Punetori(stafi_id_punetori, gjinia, menaxhuesi_id) VALUES (5005,'M',null)
INSERT into Punetori(stafi_id_punetori, gjinia, menaxhuesi_id) VALUES (9009,'F',6007)
INSERT into Punetori(stafi_id_punetori, gjinia,menaxhuesi_id) VALUES (3004,'F',null)
INSERT into Punetori(stafi_id_punetori, gjinia,menaxhuesi_id) VALUES (6006,'M',null)
INSERT into Punetori(stafi_id_punetori, gjinia, menaxhuesi_id) VALUES (8009,'F',null)
INSERT into Punetori(stafi_id_punetori, gjinia, menaxhuesi_id) VALUES (5006,'M',null)
INSERT into Punetori(stafi_id_punetori, gjinia,menaxhuesi_id) VALUES (4005,'F',null)
INSERT into Punetori(stafi_id_punetori, gjinia,menaxhuesi_id) VALUES (6213,'F',null)
INSERT into Punetori(stafi_id_punetori, gjinia, menaxhuesi_id) VALUES (6210,'M',6007)
INSERT into Punetori(stafi_id_punetori, gjinia, menaxhuesi_id) VALUES (6310,'F',null)
INSERT into Punetori(stafi_id_punetori, gjinia, menaxhuesi_id) VALUES (6410,'F',null)
INSERT into Punetori(stafi_id_punetori, gjinia, menaxhuesi_id) VALUES (6751,'F',6007)
INSERT into Punetori(stafi_id_punetori, gjinia,menaxhuesi_id) VALUES (6610,'M',null)
INSERT into Punetori(stafi_id_punetori, gjinia,menaxhuesi_id) VALUES (6710,'F',null)
INSERT into Punetori(stafi_id_punetori, gjinia, menaxhuesi_id) VALUES (6810,'M',null)
INSERT into Punetori(stafi_id_punetori, gjinia, menaxhuesi_id) VALUES (6910,'M',null)
INSERT into Punetori(stafi_id_punetori, gjinia,menaxhuesi_id) VALUES (6101,'M',null)
INSERT into Punetori(stafi_id_punetori, gjinia,menaxhuesi_id) VALUES (6102,'M',null)
INSERT into Punetori(stafi_id_punetori, gjinia, menaxhuesi_id) VALUES (6103,'F',6007)
INSERT into Punetori(stafi_id_punetori, gjinia, menaxhuesi_id) VALUES (6104,'M',null)
INSERT into Punetori(stafi_id_punetori, gjinia, menaxhuesi_id) VALUES (6105,'M',null)
INSERT into Punetori(stafi_id_punetori, gjinia, menaxhuesi_id) VALUES (6106,'M',6007)


INSERT into StafiMirembajtes(stafi_id_mirembajtes, eksperienca) VALUES (8009,4)
INSERT into StafiMirembajtes(stafi_id_mirembajtes, eksperienca) VALUES (9000,7)
INSERT into StafiMirembajtes(stafi_id_mirembajtes, eksperienca) VALUES (1004,8)
INSERT into StafiMirembajtes(stafi_id_mirembajtes, eksperienca) VALUES (1003,9)
INSERT into StafiMirembajtes(stafi_id_mirembajtes, eksperienca) VALUES (2006,3)
INSERT into StafiMirembajtes(stafi_id_mirembajtes, eksperienca) VALUES (1001,2)
INSERT into StafiMirembajtes(stafi_id_mirembajtes, eksperienca) VALUES (2002,6)
INSERT into StafiMirembajtes(stafi_id_mirembajtes, eksperienca) VALUES (4005,5)
INSERT into StafiMirembajtes(stafi_id_mirembajtes, eksperienca) VALUES (5009,3)
INSERT into StafiMirembajtes(stafi_id_mirembajtes, eksperienca) VALUES (4008,6)


INSERT into Praktikanti(praktikanti_id, emri, mbiemri, data_lindjes, nr_telefonit, email,lloji_trajnimit,id_kompania) VALUES (50000,'Berna','Vitaku',CAST(N'1998-03-15' AS Date),049232122,'bv11@hotmail.com','Ueb',14)
INSERT into Praktikanti(praktikanti_id, emri, mbiemri, data_lindjes, nr_telefonit, email,lloji_trajnimit,id_kompania) VALUES (50010,'Blerton','Kqiqi',CAST(N'1999-05-17' AS Date),044532122,'kq11@hotmail.com','Softuer',13)
INSERT into Praktikanti(praktikanti_id, emri, mbiemri, data_lindjes, nr_telefonit, email,lloji_trajnimit,id_kompania) VALUES (50020,'Albi','Mehmeti',CAST(N'1993-07-12' AS Date),049234122,'am11@hotmail.com','Ueb',12)
INSERT into Praktikanti(praktikanti_id, emri, mbiemri, data_lindjes, nr_telefonit, email,lloji_trajnimit,id_kompania) VALUES (50030,'Alberta','Rrmoku',CAST(N'1990-09-11' AS Date),049234522,'ar11@hotmail.com','Softuer',11)
INSERT into Praktikanti(praktikanti_id, emri, mbiemri, data_lindjes, nr_telefonit, email,lloji_trajnimit,id_kompania) VALUES (50040,'Arsa','Salihu',CAST(N'1994-04-27' AS Date),044232452,'as11@hotmail.com','Softuer',14)
INSERT into Praktikanti(praktikanti_id, emri, mbiemri, data_lindjes, nr_telefonit, email,lloji_trajnimit,id_kompania) VALUES (50050,'Anid','Zasella',CAST(N'1995-08-12' AS Date),049237622,'az11@hotmail.com','Softuer',15)
INSERT into Praktikanti(praktikanti_id, emri, mbiemri, data_lindjes, nr_telefonit, email,lloji_trajnimit,id_kompania) VALUES (50060,'Alban','Ramosaj',CAST(N'1996-09-22' AS Date),049267122,'ara11@hotmail.com','Ueb',16)
INSERT into Praktikanti(praktikanti_id, emri, mbiemri, data_lindjes, nr_telefonit, email,lloji_trajnimit,id_kompania) VALUES (50070,'Ardian','Selmani',CAST(N'1999-10-17' AS Date),045672122,'ass11@hotmail.com','Ueb',17)
INSERT into Praktikanti(praktikanti_id, emri, mbiemri, data_lindjes, nr_telefonit, email,lloji_trajnimit,id_kompania) VALUES (50080,'Albiona','Broja',CAST(N'1998-11-17' AS Date),049287122,'ab11@hotmail.com','Softuer',16)
INSERT into Praktikanti(praktikanti_id, emri, mbiemri, data_lindjes, nr_telefonit, email,lloji_trajnimit,id_kompania) VALUES (50090,'Altea','Aliu',CAST(N'1999-12-17' AS Date),049232156,'aa11@hotmail.com','Ueb',19)


insert into Trajnimi(trajnimi_id, emri, kohezgjatja, nr_participanteve,data_mbajtjes) values (11111,'Tech-Heroes','6-muaj',100,CAST(N'2020-10-19' AS Date))
insert into Trajnimi(trajnimi_id, emri, kohezgjatja, nr_participanteve,data_mbajtjes) values (11112,'Cisco','6-muaj',10,CAST(N'2020-10-20' AS Date))
insert into Trajnimi(trajnimi_id, emri, kohezgjatja, nr_participanteve,data_mbajtjes) values (11113,'TMaintain Training','4-muaj',50,CAST(N'2020-10-21' AS Date))
insert into Trajnimi(trajnimi_id, emri, kohezgjatja, nr_participanteve,data_mbajtjes) values (11114,'Traded Training.','3-muaj',60,CAST(N'2020-10-24' AS Date))
insert into Trajnimi(trajnimi_id, emri, kohezgjatja, nr_participanteve,data_mbajtjes) values (11115,'A-List Education','2-muaj',70,CAST(N'2020-10-26' AS Date))
insert into Trajnimi(trajnimi_id, emri, kohezgjatja, nr_participanteve,data_mbajtjes) values (11116,'Kryptonites','8-muaj',80,CAST(N'2020-10-28' AS Date))
insert into Trajnimi(trajnimi_id, emri, kohezgjatja, nr_participanteve,data_mbajtjes) values (11117,'EasyLearn','9-muaj',90,CAST(N'2020-10-29' AS Date))
insert into Trajnimi(trajnimi_id, emri, kohezgjatja, nr_participanteve,data_mbajtjes) values (11118,'Leap 2 Learn','12-muaj',100,CAST(N'2020-10-30' AS Date))
insert into Trajnimi(trajnimi_id, emri, kohezgjatja, nr_participanteve,data_mbajtjes) values (11119,'The EdVantage','6-muaj',20,CAST(N'2020-10-23' AS Date))
insert into Trajnimi(trajnimi_id, emri, kohezgjatja, nr_participanteve,data_mbajtjes) values (11110,'Modern Tricks','6-muaj',80,CAST(N'2020-10-11' AS Date))


INSERT into MerrPjese (trajnimi_id, praktikanti_id) VALUES (11112, 50080)
INSERT into MerrPjese (trajnimi_id, praktikanti_id) VALUES (11113, 50010)
INSERT into MerrPjese (trajnimi_id, praktikanti_id) VALUES (11114, 50020)
INSERT into MerrPjese (trajnimi_id, praktikanti_id) VALUES (11115, 50040)
INSERT into MerrPjese (trajnimi_id, praktikanti_id) VALUES (11112, 50060)
INSERT into MerrPjese (trajnimi_id, praktikanti_id) VALUES (11112, 50010)
INSERT into MerrPjese (trajnimi_id, praktikanti_id) VALUES (11116, 50070)
INSERT into MerrPjese (trajnimi_id, praktikanti_id) VALUES (11113, 50090)
INSERT into MerrPjese (trajnimi_id, praktikanti_id) VALUES (11111, 50050)
INSERT into MerrPjese (trajnimi_id, praktikanti_id) VALUES (11112, 50030)
INSERT into MerrPjese (trajnimi_id, praktikanti_id) VALUES (11113, 50070)
INSERT into MerrPjese (trajnimi_id, praktikanti_id) VALUES (11119, 50060)
INSERT into MerrPjese (trajnimi_id, praktikanti_id) VALUES (11118, 50050)
INSERT into MerrPjese (trajnimi_id, praktikanti_id) VALUES (11110, 50030)
INSERT into MerrPjese (trajnimi_id, praktikanti_id) VALUES (11112, 50040)
INSERT into MerrPjese (trajnimi_id, praktikanti_id) VALUES (11117, 50050)
INSERT into MerrPjese (trajnimi_id, praktikanti_id) VALUES (11115, 50070)
INSERT into MerrPjese (trajnimi_id, praktikanti_id) VALUES (11114, 50080)
INSERT into MerrPjese (trajnimi_id, praktikanti_id) VALUES (11112, 50090)
INSERT into MerrPjese (trajnimi_id, praktikanti_id) VALUES (11114, 50030)
INSERT into MerrPjese (trajnimi_id, praktikanti_id) VALUES (11112, 50020)
INSERT into MerrPjese (trajnimi_id, praktikanti_id) VALUES (11115, 50010)
INSERT into MerrPjese (trajnimi_id, praktikanti_id) VALUES (11113, 50020)
INSERT into MerrPjese (trajnimi_id, praktikanti_id) VALUES (11111, 50060)
INSERT into MerrPjese (trajnimi_id, praktikanti_id) VALUES (11118, 50070)


insert into Orari(trajnimi_id,koha_mbajtjes,kohezgjatja) values (11111,'12:30','90min')
insert into Orari(trajnimi_id,koha_mbajtjes,kohezgjatja) values (11112,'14:30','90min')
insert into Orari(trajnimi_id,koha_mbajtjes,kohezgjatja) values (11113,'16:30','90min')
insert into Orari(trajnimi_id,koha_mbajtjes,kohezgjatja) values (11114,'18:30','90min')
insert into Orari(trajnimi_id,koha_mbajtjes,kohezgjatja) values (11115,'19:30','90min')
insert into Orari(trajnimi_id,koha_mbajtjes,kohezgjatja) values (11116,'13:30','90min')
insert into Orari(trajnimi_id,koha_mbajtjes,kohezgjatja) values (11117,'17:30','90min')
insert into Orari(trajnimi_id,koha_mbajtjes,kohezgjatja) values (11118,'19:30','90min')
insert into Orari(trajnimi_id,koha_mbajtjes,kohezgjatja) values (11119,'11:30','90min')
insert into Orari(trajnimi_id,koha_mbajtjes,kohezgjatja) values (11110,'12:30','90min')


insert into Salla(salla_id,nr_ulseve,nr_katit) values(555,50,1)
insert into Salla(salla_id,nr_ulseve,nr_katit) values(954,50,2)
insert into Salla(salla_id,nr_ulseve,nr_katit) values(657,100,3)
insert into Salla(salla_id,nr_ulseve,nr_katit) values(222,100,1)
insert into Salla(salla_id,nr_ulseve,nr_katit) values(559,100,2)
insert into Salla(salla_id,nr_ulseve,nr_katit) values(450,20,3)
insert into Salla(salla_id,nr_ulseve,nr_katit) values(554,30,1)
insert into Salla(salla_id,nr_ulseve,nr_katit) values(455,70,3)
insert into Salla(salla_id,nr_ulseve,nr_katit) values(755,50,3)
insert into Salla(salla_id,nr_ulseve,nr_katit) values(855,50,1)


insert into Mbahet(trajnimi_id,salla_id) values (11111,555)
insert into Mbahet(trajnimi_id,salla_id) values (11112,954)
insert into Mbahet(trajnimi_id,salla_id) values (11113,657)
insert into Mbahet(trajnimi_id,salla_id) values (11114,222)
insert into Mbahet(trajnimi_id,salla_id) values (11118,559)
insert into Mbahet(trajnimi_id,salla_id) values (11119,450)
insert into Mbahet(trajnimi_id,salla_id) values (11118,554)
insert into Mbahet(trajnimi_id,salla_id) values (11117,455)
insert into Mbahet(trajnimi_id,salla_id) values (11116,755)
insert into Mbahet(trajnimi_id,salla_id) values (11115,855)
insert into Mbahet(trajnimi_id,salla_id) values (11111,954)
insert into Mbahet(trajnimi_id,salla_id) values (11112,555)
insert into Mbahet(trajnimi_id,salla_id) values (11113,222)
insert into Mbahet(trajnimi_id,salla_id) values (11114,657)
insert into Mbahet(trajnimi_id,salla_id) values (11118,450)
insert into Mbahet(trajnimi_id,salla_id) values (11119,559)
insert into Mbahet(trajnimi_id,salla_id) values (11118,455)
insert into Mbahet(trajnimi_id,salla_id) values (11117,554)
insert into Mbahet(trajnimi_id,salla_id) values (11116,855)
insert into Mbahet(trajnimi_id,salla_id) values (11115,755)
insert into Mbahet(trajnimi_id,salla_id) values (11111,559)
insert into Mbahet(trajnimi_id,salla_id) values (11112,657)
insert into Mbahet(trajnimi_id,salla_id) values (11113,555)
insert into Mbahet(trajnimi_id,salla_id) values (11114,455)
insert into Mbahet(trajnimi_id,salla_id) values (11118,222)



insert into Pajisje(pajisja_id,emri_pajisjes,nr_pajisjeve,prodhuesi,qmimi,stafi_id_mirembajtes,salla_id)values (21111,'Monitor',100,'HP',1200.0000,8009,555)
insert into Pajisje(pajisja_id,emri_pajisjes,nr_pajisjeve,prodhuesi,qmimi,stafi_id_mirembajtes,salla_id)values (21881,'Tastier',100,'HP',1500.0000,9000,954)
insert into Pajisje(pajisja_id,emri_pajisjes,nr_pajisjeve,prodhuesi,qmimi,stafi_id_mirembajtes,salla_id)values (24441,'Laptop',100,'Dell',1800.0000,1004,657)
insert into Pajisje(pajisja_id,emri_pajisjes,nr_pajisjeve,prodhuesi,qmimi,stafi_id_mirembajtes,salla_id)values (21471,'Modem',20,'Lenovo',1300.0000,1003,450)
insert into Pajisje(pajisja_id,emri_pajisjes,nr_pajisjeve,prodhuesi,qmimi,stafi_id_mirembajtes,salla_id)values (23211,'Projektor',25,'Lenovo',1100.0000,2006,554)
insert into Pajisje(pajisja_id,emri_pajisjes,nr_pajisjeve,prodhuesi,qmimi,stafi_id_mirembajtes,salla_id)values (27777,'Shtepiza',100,'HP',2200.0000,1001,455)
insert into Pajisje(pajisja_id,emri_pajisjes,nr_pajisjeve,prodhuesi,qmimi,stafi_id_mirembajtes,salla_id)values (44441,'Altoparlanti',50,'HP',3200.0000,2002,755)
insert into Pajisje(pajisja_id,emri_pajisjes,nr_pajisjeve,prodhuesi,qmimi,stafi_id_mirembajtes,salla_id)values (66661,'USB',20,'HP',4200.0000,4005,855)
insert into Pajisje(pajisja_id,emri_pajisjes,nr_pajisjeve,prodhuesi,qmimi,stafi_id_mirembajtes,salla_id)values (22211,'Mouse',100,'HP',4500.0000,5009,222)
insert into Pajisje(pajisja_id,emri_pajisjes,nr_pajisjeve,prodhuesi,qmimi,stafi_id_mirembajtes,salla_id)values (20001,'CPU',100,'HP',6200.0000,4008,559)


insert into Klienti(klienti_id,emri,mbiemri,nr_leternjoftimit,llogaria_bankes,email,adresa) values (666, 'Arta','Mehaj',	 100200300222, 552225222332, 'arttamehaj@gmail.com', 'Rruga Ali Gashi')
insert into Klienti(klienti_id,emri,mbiemri,nr_leternjoftimit,llogaria_bankes,email,adresa) values (258, 'Fitim','Dila',	 444200300222, 807875222332, 'Fitimd@gmail.com', 'Rruga Selmin Hoxha ')
insert into Klienti(klienti_id,emri,mbiemri,nr_leternjoftimit,llogaria_bankes,email,adresa) values (116, 'Artan','Daka',	 555200300222, 922225265656, 'Artand@gmail.com', 'Rruga Shote Galica')
insert into Klienti(klienti_id,emri,mbiemri,nr_leternjoftimit,llogaria_bankes,email,adresa) values (996, 'Erza','Salihu',	 666200300222, 452225785234, 'Erzasa@gmail.com', 'Rruga Martinet')
insert into Klienti(klienti_id,emri,mbiemri,nr_leternjoftimit,llogaria_bankes,email,adresa) values (336, 'Argjend','Osmanaj',777200300222, 765493222332, 'Argjendo@gmail.com', 'Rruga Bavaria')
insert into Klienti(klienti_id,emri,mbiemri,nr_leternjoftimit,llogaria_bankes,email,adresa) values (746, 'Sara', 'Krasniq',  100888300222, 183225222332, 'Sarakras@gmail.com', 'Rruga Arberesha ')
insert into Klienti(klienti_id,emri,mbiemri,nr_leternjoftimit,llogaria_bankes,email,adresa) values (132, 'Edoni', 'Gashi',   100999300222, 717725222332, 'Edoniga@gmail.com', 'Rruga Behar Begolli')
insert into Klienti(klienti_id,emri,mbiemri,nr_leternjoftimit,llogaria_bankes,email,adresa) values (256, 'Doni', 'Mehaj',    400200000222, 822725222332, 'Donimeh@gmail.com', 'Rruga 23 nentori ')
insert into Klienti(klienti_id,emri,mbiemri,nr_leternjoftimit,llogaria_bankes,email,adresa) values (985, 'Olti', 'Rama',     507200111222, 942825222332, 'Oltira@gmail.com', 'Rruga Ali Sokoli ')
insert into Klienti(klienti_id,emri,mbiemri,nr_leternjoftimit,llogaria_bankes,email,adresa) values (888, 'Redon', 'Janu',    605550300222, 042925222332, 'Redonja@gmail.com', 'Rruga Muharrem Fejza')


insert into Projekti(projekti_id, emri_projektit, kohezgjatja, stafi_id_menaxheri, klienti_id) values (1477,'Cascade','3-muaj',2002,666)
insert into Projekti(projekti_id, emri_projektit, kohezgjatja, stafi_id_menaxheri, klienti_id) values (2771,'Westerners','3-muaj',3007,258)
insert into Projekti(projekti_id, emri_projektit, kohezgjatja, stafi_id_menaxheri, klienti_id) values (3870,'Mercury','6-muaj',5009,116)
insert into Projekti(projekti_id, emri_projektit, kohezgjatja, stafi_id_menaxheri, klienti_id) values (4979,'Ivory','9-muaj',8002,996)
insert into Projekti(projekti_id, emri_projektit, kohezgjatja, stafi_id_menaxheri, klienti_id) values (5078,'Plutonium','3-muaj',9002,336)
insert into Projekti(projekti_id, emri_projektit, kohezgjatja, stafi_id_menaxheri, klienti_id) values (6177,'Rocky Ray','5-muaj',1003,746)
insert into Projekti(projekti_id, emri_projektit, kohezgjatja, stafi_id_menaxheri, klienti_id) values (7276,'Bordeaux','4-muaj',7007,132)
insert into Projekti(projekti_id, emri_projektit, kohezgjatja, stafi_id_menaxheri, klienti_id) values (8375,'Hidden Hook','1-muaj',1005,256)
insert into Projekti(projekti_id, emri_projektit, kohezgjatja, stafi_id_menaxheri, klienti_id) values (9475,'Early First','6-muaj',7008,985)
insert into Projekti(projekti_id, emri_projektit, kohezgjatja, stafi_id_menaxheri, klienti_id) values (1572,'Silverstar','9-muaj',1012,888)


insert into Paga(paga_id, shuma, numri_stafit, id_kompania) values (100,1200.0000,3,10)
insert into Paga(paga_id, shuma, numri_stafit, id_kompania) values (191,1220.0000,2 ,11)
insert into Paga(paga_id, shuma, numri_stafit, id_kompania) values (282,1400.0000,3 ,12)
insert into Paga(paga_id, shuma, numri_stafit, id_kompania) values (373,1500.0000, 4,13)
insert into Paga(paga_id, shuma, numri_stafit, id_kompania) values (464,900.0000, 5 ,14)
insert into Paga(paga_id, shuma, numri_stafit, id_kompania) values (555,800.0000, 2 ,15)
insert into Paga(paga_id, shuma, numri_stafit, id_kompania) values (646,8900.0000, 1 ,16)
insert into Paga(paga_id, shuma, numri_stafit, id_kompania) values (737,1150.0000, 4 ,17)
insert into Paga(paga_id, shuma, numri_stafit, id_kompania) values (828,1700.0000, 3 ,18)
insert into Paga(paga_id, shuma, numri_stafit, id_kompania) values (919,2000.0000, 3 ,19)


INSERT into Pranon (stafi_id, paga_id) VALUES (1001,919)
INSERT into Pranon (stafi_id, paga_id) VALUES (2002,100)
INSERT into Pranon (stafi_id, paga_id) VALUES (3003,282)
INSERT into Pranon (stafi_id, paga_id) VALUES (4004,373)
INSERT into Pranon (stafi_id, paga_id) VALUES (5005,464)
INSERT into Pranon (stafi_id, paga_id) VALUES (6006,555)
INSERT into Pranon (stafi_id, paga_id) VALUES (7007,646)
INSERT into Pranon (stafi_id, paga_id) VALUES (8008,737)
INSERT into Pranon (stafi_id, paga_id) VALUES (9009,828)
INSERT into Pranon (stafi_id, paga_id) VALUES (1002,919)
INSERT into Pranon (stafi_id, paga_id) VALUES (1003,828)
INSERT into Pranon (stafi_id, paga_id) VALUES (2003,737)
INSERT into Pranon (stafi_id, paga_id) VALUES (3004,464)
INSERT into Pranon (stafi_id, paga_id) VALUES (4005,555)
INSERT into Pranon (stafi_id, paga_id) VALUES (5006,737)
INSERT into Pranon (stafi_id, paga_id) VALUES (6007,919)
INSERT into Pranon (stafi_id, paga_id) VALUES (7008,919)
INSERT into Pranon (stafi_id, paga_id) VALUES (8009,646)
INSERT into Pranon (stafi_id, paga_id) VALUES (9000,646)
INSERT into Pranon (stafi_id, paga_id) VALUES (1004,828)
INSERT into Pranon (stafi_id, paga_id) VALUES (1005,737)
INSERT into Pranon (stafi_id, paga_id) VALUES (2006,828)
INSERT into Pranon (stafi_id, paga_id) VALUES (3007,919)
INSERT into Pranon (stafi_id, paga_id) VALUES (4008,919)
INSERT into Pranon (stafi_id, paga_id) VALUES (5009,464)
INSERT into Pranon (stafi_id, paga_id) VALUES (6004,919)
INSERT into Pranon (stafi_id, paga_id) VALUES (7003,646)
INSERT into Pranon (stafi_id, paga_id) VALUES (8002,919)
INSERT into Pranon (stafi_id, paga_id) VALUES (9002,828)
INSERT into Pranon (stafi_id, paga_id) VALUES (1012,737)
INSERT into Pranon (stafi_id, paga_id) VALUES (6751,919)
INSERT into Pranon (stafi_id, paga_id) VALUES (6210,919)
INSERT into Pranon (stafi_id, paga_id) VALUES (6310,646)
INSERT into Pranon (stafi_id, paga_id) VALUES (6410,646)
INSERT into Pranon (stafi_id, paga_id) VALUES (6213,919)
INSERT into Pranon (stafi_id, paga_id) VALUES (6610,737)
INSERT into Pranon (stafi_id, paga_id) VALUES (6710,828)
INSERT into Pranon (stafi_id, paga_id) VALUES (6810,919)
INSERT into Pranon (stafi_id, paga_id) VALUES (6910,919)
INSERT into Pranon (stafi_id, paga_id) VALUES (6101,464)
INSERT into Pranon (stafi_id, paga_id) VALUES (6102,919)
INSERT into Pranon (stafi_id, paga_id) VALUES (6103,646)
INSERT into Pranon (stafi_id, paga_id) VALUES (6104,919)
INSERT into Pranon (stafi_id, paga_id) VALUES (6105,828)
INSERT into Pranon (stafi_id, paga_id) VALUES (6106,737)


insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11111,6007)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11112,6008)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11113,3003)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11114,3004)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11115,9009)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11116,6006)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11117,4005)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11118,5006)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11119,6007)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11110,9009)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11111,6103)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11112,6910)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11113,6810)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11114,6710)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11115,6106)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11116,6105)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11117,6104)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11118,6103)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11119,6102)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11110,6610)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11111,6101)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11114,6910)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11111,6810)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11112,6710)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11113,6106)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11114,6105)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11115,6104)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11116,6103)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11117,6102)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11115,6610)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11111,6410)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11112,6751)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11113,6210)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11114,6213)
insert into Ligjeron (trajnimi_id,stafi_id_punetori) values (11115,6751)


insert into Pagesa(id_kompania, pagesa_id, shuma, pranimi_projektit, klienti_id) values (10, 610, 1300.000, 1, 666)
insert into Pagesa(id_kompania, pagesa_id, shuma, pranimi_projektit, klienti_id) values (17, 620, 1255.000, 1, 985)
insert into Pagesa(id_kompania, pagesa_id, shuma, pranimi_projektit, klienti_id) values (16, 630, 300.000,  1, 888)
insert into Pagesa(id_kompania, pagesa_id, shuma, pranimi_projektit, klienti_id) values (14, 640,     0,  0, 258)
insert into Pagesa(id_kompania, pagesa_id, shuma, pranimi_projektit, klienti_id) values (11, 650, 950.000,  1, 116)
insert into Pagesa(id_kompania, pagesa_id, shuma, pranimi_projektit, klienti_id) values (13, 660, 720.000,  1, 996)
insert into Pagesa(id_kompania, pagesa_id, shuma, pranimi_projektit, klienti_id) values (18, 670, 430.000,  1, 336)
insert into Pagesa(id_kompania, pagesa_id, shuma, pranimi_projektit, klienti_id) values (15, 680, 2563.000, 1, 746)
insert into Pagesa(id_kompania, pagesa_id, shuma, pranimi_projektit, klienti_id) values (19, 690, 789.000,  1, 132)
insert into Pagesa(id_kompania, pagesa_id, shuma, pranimi_projektit, klienti_id) values (12, 600, 1500.000, 1, 256)


insert into Bashkepunoni(praktikanti_id, stafi_id_punetori) values (50000,6007)
insert into Bashkepunoni(praktikanti_id, stafi_id_punetori) values (50010,3003)
insert into Bashkepunoni(praktikanti_id, stafi_id_punetori) values (50060,5005)
insert into Bashkepunoni(praktikanti_id, stafi_id_punetori) values (50070,9009)
insert into Bashkepunoni(praktikanti_id, stafi_id_punetori) values (50020,3004)
insert into Bashkepunoni(praktikanti_id, stafi_id_punetori) values (50030,6008)
insert into Bashkepunoni(praktikanti_id, stafi_id_punetori) values (50040,6006)
insert into Bashkepunoni(praktikanti_id, stafi_id_punetori) values (50080,8009)
insert into Bashkepunoni(praktikanti_id, stafi_id_punetori) values (50090,5006)
insert into Bashkepunoni(praktikanti_id, stafi_id_punetori) values (50050,4005)
insert into Bashkepunoni(praktikanti_id, stafi_id_punetori) values (50000,6008)
insert into Bashkepunoni(praktikanti_id, stafi_id_punetori) values (50010,3004)
insert into Bashkepunoni(praktikanti_id, stafi_id_punetori) values (50060,9009)
insert into Bashkepunoni(praktikanti_id, stafi_id_punetori) values (50070,5005)
insert into Bashkepunoni(praktikanti_id, stafi_id_punetori) values (50020,3003)
insert into Bashkepunoni(praktikanti_id, stafi_id_punetori) values (50030,6007)
insert into Bashkepunoni(praktikanti_id, stafi_id_punetori) values (50040,8009)
insert into Bashkepunoni(praktikanti_id, stafi_id_punetori) values (50080,6006)
insert into Bashkepunoni(praktikanti_id, stafi_id_punetori) values (50090,4005)
insert into Bashkepunoni(praktikanti_id, stafi_id_punetori) values (50050,5006)
insert into Bashkepunoni(praktikanti_id, stafi_id_punetori) values (50000,8009)
insert into Bashkepunoni(praktikanti_id, stafi_id_punetori) values (50010,6006)
insert into Bashkepunoni(praktikanti_id, stafi_id_punetori) values (50060,3004)
insert into Bashkepunoni(praktikanti_id, stafi_id_punetori) values (50070,5006)
insert into Bashkepunoni(praktikanti_id, stafi_id_punetori) values (50020,6007)


insert into Mbikqyr(praktikanti_id, stafi_id_punetori,stafi_id_menaxheri) values (50000,6007,2002)
insert into Mbikqyr(praktikanti_id, stafi_id_punetori,stafi_id_menaxheri) values (50010,3003,3007)
insert into Mbikqyr(praktikanti_id, stafi_id_punetori,stafi_id_menaxheri) values (50060,5005,5009)
insert into Mbikqyr(praktikanti_id, stafi_id_punetori,stafi_id_menaxheri) values (50070,9009,8002)
insert into Mbikqyr(praktikanti_id, stafi_id_punetori,stafi_id_menaxheri) values (50020,3004,9002)
insert into Mbikqyr(praktikanti_id, stafi_id_punetori,stafi_id_menaxheri) values (50030,6008,1003)
insert into Mbikqyr(praktikanti_id, stafi_id_punetori,stafi_id_menaxheri) values (50040,6006,7007)
insert into Mbikqyr(praktikanti_id, stafi_id_punetori,stafi_id_menaxheri) values (50080,8009,1005)
insert into Mbikqyr(praktikanti_id, stafi_id_punetori,stafi_id_menaxheri) values (50090,5006,7008)
insert into Mbikqyr(praktikanti_id, stafi_id_punetori,stafi_id_menaxheri) values (50050,4005,1012)
insert into Mbikqyr(praktikanti_id, stafi_id_punetori,stafi_id_menaxheri) values (50000,6008,1003)
insert into Mbikqyr(praktikanti_id, stafi_id_punetori,stafi_id_menaxheri) values (50010,3004,1005)
insert into Mbikqyr(praktikanti_id, stafi_id_punetori,stafi_id_menaxheri) values (50060,9009,7007)
insert into Mbikqyr(praktikanti_id, stafi_id_punetori,stafi_id_menaxheri) values (50070,5005,1012)
insert into Mbikqyr(praktikanti_id, stafi_id_punetori,stafi_id_menaxheri) values (50020,3003,2002)
insert into Mbikqyr(praktikanti_id, stafi_id_punetori,stafi_id_menaxheri) values (50030,6007,3007)
insert into Mbikqyr(praktikanti_id, stafi_id_punetori,stafi_id_menaxheri) values (50040,8009,1012)
insert into Mbikqyr(praktikanti_id, stafi_id_punetori,stafi_id_menaxheri) values (50080,6006,7007)
insert into Mbikqyr(praktikanti_id, stafi_id_punetori,stafi_id_menaxheri) values (50090,4005,2002)
insert into Mbikqyr(praktikanti_id, stafi_id_punetori,stafi_id_menaxheri) values (50050,5006,1003)
insert into Mbikqyr(praktikanti_id, stafi_id_punetori,stafi_id_menaxheri) values (50000,8009,3007)
insert into Mbikqyr(praktikanti_id, stafi_id_punetori,stafi_id_menaxheri) values (50010,6006,1012)
insert into Mbikqyr(praktikanti_id, stafi_id_punetori,stafi_id_menaxheri) values (50060,3004,7007)
insert into Mbikqyr(praktikanti_id, stafi_id_punetori,stafi_id_menaxheri) values (50070,5005,1003)
insert into Mbikqyr(praktikanti_id, stafi_id_punetori,stafi_id_menaxheri) values (50020,6007,2002)


insert into Kryejn(praktikanti_id, stafi_id_punetori,trajnimi_id) values (50000,6007,11111)
insert into Kryejn(praktikanti_id, stafi_id_punetori,trajnimi_id) values (50010,3003,11112)
insert into Kryejn(praktikanti_id, stafi_id_punetori,trajnimi_id) values (50060,5005,11113)
insert into Kryejn(praktikanti_id, stafi_id_punetori,trajnimi_id) values (50070,9009,11114)
insert into Kryejn(praktikanti_id, stafi_id_punetori,trajnimi_id) values (50020,3004,11116)
insert into Kryejn(praktikanti_id, stafi_id_punetori,trajnimi_id) values (50030,6008,11115)
insert into Kryejn(praktikanti_id, stafi_id_punetori,trajnimi_id) values (50040,6006,11113)
insert into Kryejn(praktikanti_id, stafi_id_punetori,trajnimi_id) values (50080,8009,11112)
insert into Kryejn(praktikanti_id, stafi_id_punetori,trajnimi_id) values (50090,5006,11111)
insert into Kryejn(praktikanti_id, stafi_id_punetori,trajnimi_id) values (50050,4005,11112)
insert into Kryejn(praktikanti_id, stafi_id_punetori,trajnimi_id) values (50000,6008,11113)
insert into Kryejn(praktikanti_id, stafi_id_punetori,trajnimi_id) values (50010,3004,11113)
insert into Kryejn(praktikanti_id, stafi_id_punetori,trajnimi_id) values (50060,9009,11114)
insert into Kryejn(praktikanti_id, stafi_id_punetori,trajnimi_id) values (50070,5005,11115)
insert into Kryejn(praktikanti_id, stafi_id_punetori,trajnimi_id) values (50020,3003,11116)
insert into Kryejn(praktikanti_id, stafi_id_punetori,trajnimi_id) values (50030,6007,11117)
insert into Kryejn(praktikanti_id, stafi_id_punetori,trajnimi_id) values (50040,8009,11118)
insert into Kryejn(praktikanti_id, stafi_id_punetori,trajnimi_id) values (50080,6006,11119)
insert into Kryejn(praktikanti_id, stafi_id_punetori,trajnimi_id) values (50090,4005,11118)
insert into Kryejn(praktikanti_id, stafi_id_punetori,trajnimi_id) values (50050,5006,11117)
insert into Kryejn(praktikanti_id, stafi_id_punetori,trajnimi_id) values (50000,8009,11116)
insert into Kryejn(praktikanti_id, stafi_id_punetori,trajnimi_id) values (50010,6006,11115)
insert into Kryejn(praktikanti_id, stafi_id_punetori,trajnimi_id) values (50060,3004,11114)
insert into Kryejn(praktikanti_id, stafi_id_punetori,trajnimi_id) values (50070,5005,11113)
insert into Kryejn(praktikanti_id, stafi_id_punetori,trajnimi_id) values (50020,6007,11112)


insert into Departamenti(departamenti_id,lloji_departamentit,buxheti,nr_punetoreve,zyre_departamenti) values (31,'Softuer',1000.0000,2,'A001')
insert into Departamenti(departamenti_id,lloji_departamentit,buxheti,nr_punetoreve,zyre_departamenti) values (32,'Ueb',1200.0000,3,'A002')
insert into Departamenti(departamenti_id,lloji_departamentit,buxheti,nr_punetoreve,zyre_departamenti) values (33,'Sis.Info',1000.0000,3,'A003')
insert into Departamenti(departamenti_id,lloji_departamentit,buxheti,nr_punetoreve,zyre_departamenti) values (34,'AI',1000.0000,2,'A004')
insert into Departamenti(departamenti_id,lloji_departamentit,buxheti,nr_punetoreve,zyre_departamenti) values (35,'CyberSecurity',1200.0000,3,'A005')
insert into Departamenti(departamenti_id,lloji_departamentit,buxheti,nr_punetoreve,zyre_departamenti) values (36,'Database',1200.0000,2,'A006')
insert into Departamenti(departamenti_id,lloji_departamentit,buxheti,nr_punetoreve,zyre_departamenti) values (37,'Network',1000.0000,2,'A007')
insert into Departamenti(departamenti_id,lloji_departamentit,buxheti,nr_punetoreve,zyre_departamenti) values (38,'IT e Aplikuar',1000.0000,3,'A008')
insert into Departamenti(departamenti_id,lloji_departamentit,buxheti,nr_punetoreve,zyre_departamenti) values (39,'IT Analyst',1200.0000,3,'A009')
insert into Departamenti(departamenti_id,lloji_departamentit,buxheti,nr_punetoreve,zyre_departamenti) values (41,'Telecommunication',1200.0000,2,'A000')


insert into Dep_Komp_Pun(stafi_id_punetori,departamenti_id,id_kompania) values(6007,31,10)
insert into Dep_Komp_Pun(stafi_id_punetori,departamenti_id,id_kompania) values(6008,31,13)
insert into Dep_Komp_Pun(stafi_id_punetori,departamenti_id,id_kompania) values(3003,32,12)
insert into Dep_Komp_Pun(stafi_id_punetori,departamenti_id,id_kompania) values(5005,32,14)
insert into Dep_Komp_Pun(stafi_id_punetori,departamenti_id,id_kompania) values(9009,32,15)
insert into Dep_Komp_Pun(stafi_id_punetori,departamenti_id,id_kompania) values(3004,33,18)
insert into Dep_Komp_Pun(stafi_id_punetori,departamenti_id,id_kompania) values(6006,33,19)
insert into Dep_Komp_Pun(stafi_id_punetori,departamenti_id,id_kompania) values(8009,33,17)
insert into Dep_Komp_Pun(stafi_id_punetori,departamenti_id,id_kompania) values(5006,34,16)
insert into Dep_Komp_Pun(stafi_id_punetori,departamenti_id,id_kompania) values(4005,34,10)
insert into Dep_Komp_Pun(stafi_id_punetori,departamenti_id,id_kompania) values(6751,35,12)
insert into Dep_Komp_Pun(stafi_id_punetori,departamenti_id,id_kompania) values(6210,35,14)
insert into Dep_Komp_Pun(stafi_id_punetori,departamenti_id,id_kompania) values(6310,35,13)
insert into Dep_Komp_Pun(stafi_id_punetori,departamenti_id,id_kompania) values(6410,36,16)
insert into Dep_Komp_Pun(stafi_id_punetori,departamenti_id,id_kompania) values(6213,36,12)
insert into Dep_Komp_Pun(stafi_id_punetori,departamenti_id,id_kompania) values(6610,37,18)
insert into Dep_Komp_Pun(stafi_id_punetori,departamenti_id,id_kompania) values(6710,37,19)
insert into Dep_Komp_Pun(stafi_id_punetori,departamenti_id,id_kompania) values(6810,38,10)
insert into Dep_Komp_Pun(stafi_id_punetori,departamenti_id,id_kompania) values(6910,38,11)
insert into Dep_Komp_Pun(stafi_id_punetori,departamenti_id,id_kompania) values(6101,38,11)
insert into Dep_Komp_Pun(stafi_id_punetori,departamenti_id,id_kompania) values(6102,39,15)
insert into Dep_Komp_Pun(stafi_id_punetori,departamenti_id,id_kompania) values(6103,39,13)
insert into Dep_Komp_Pun(stafi_id_punetori,departamenti_id,id_kompania) values(6104,41,12)
insert into Dep_Komp_Pun(stafi_id_punetori,departamenti_id,id_kompania) values(6105,41,19)
insert into Dep_Komp_Pun(stafi_id_punetori,departamenti_id,id_kompania) values(6106,31,13)

--1
UPDATE Paga
SET shuma = shuma + 100
WHERE shuma < 1000;
--2
UPDATE Paga
SET shuma = shuma +(shuma * 0.2)
WHERE shuma >= 1400;
--3
update Pajisje 
set nr_pajisjeve = nr_pajisjeve + 10
where qmimi < 1300
--4
UPDATE Pajisje
SET emri_pajisjes = 'Mikrofoni'
WHERE pajisja_id = 44441;
--5
UPDATE Praktikanti
SET emri = 'Anjeza',mbiemri = 'Spahiu'
WHERE praktikanti_id = 50000;
--6
UPDATE Praktikanti
SET lloji_trajnimit = 'Softuer'
WHERE emri = 'Alberta' and mbiemri = 'Rrmoku';
--7
UPDATE Praktikanti
SET lloji_trajnimit = 'Ueb'
WHERE praktikanti_id = 50080;
--8
UPDATE Projekti
SET kohezgjatja = '7-muaj'
WHERE kohezgjatja = '3-muaj';
--9
UPDATE Projekti
SET emri_projektit = 'Neolor'
WHERE emri_projektit = 'Cascade';
--10
UPDATE Sponzori
SET shifra_monetare = '€'
WHERE emri = 'Que-Commerce' 
--11
UPDATE Sponzori
SET lloji_sponzorit = 'Softuer'
WHERE emri = 'River-Commerce' 
--12
UPDATE Pagesa
SET shuma = 0
WHERE pranimi_projektit = 0;
--13
UPDATE Klienti
SET adresa = 'Rruga Bedri Gjinaj'
WHERE emri = 'Arta' and mbiemri = 'Mehaj';
--14
UPDATE Stafi
SET kontrata = '8 vjeqare'
WHERE stafi_id = 2002
--15
UPDATE Stafi
SET kontrata = '6 vjeqare'
WHERE stafi_id = 6004
--16
UPDATE Stafi
SET kontrata = '7 vjeqare'
WHERE emri = 'Arjeta' and mbiemri = 'Istrefi'
--17
UPDATE Praktikanti
SET nr_telefonit = 04943983
WHERE praktikanti_id = 50010;
--18
UPDATE Trajnimi
SET nr_participanteve = 78
WHERE kohezgjatja = '12-muaj';
--19
UPDATE Stafi
SET kontrata = '9 vjeqare'
WHERE emri = 'Dion' and mbiemri = 'Spahiu'
--20
UPDATE Trajnimi
SET nr_participanteve = 200
WHERE emri = 'Cisco'

--1
delete from Sponzori
Where id_sponzorit = 10
--2
delete from Sponzori
where shuma_monetare = 1000
--3
delete from Pajisje
where emri_pajisjes = 'Kufje'
--4
delete from Drejtori
where drejtori_id = 10001
--5
delete from Pajisje
where qmimi = 2200.0000
--6
delete from Drejtori
where emri = 'Anisa' and mbiemri = 'Voca'
--7
delete from Sponzori
where emri = 'Lider-Commerce'
--8
delete from Sponzori
where koha_sponzorit = N'2001-03-12'
--9
delete from Projekti
where kohezgjatja = '9-muaj'
--10
delete from Sponzori
where shuma_monetare = 10000


--/////////////////////////////	   QUERY TE THJESHTA ME NJE TABELE	///////////////////////////////////

---------------------------------------------Rreze------------------------------------------------------
--1.Sa praktikant marrin pjese ne trajnimin e webit?
select count(p.praktikanti_id)[praktikantet_e_Uebit]
from Praktikanti p
where p.lloji_trajnimit = 'Ueb'

--2.Cili sponzor sponzorizon per degen e Softuerit
select s.emri,s.lloji_sponzorit
from Sponzori s
where s.lloji_sponzorit = 'Softuer'

--3.Shkruani totalin e numrit te participanteve qe kane marre pjese ne trajnime qe ishin mbi 50 vete
select sum(t.nr_participanteve)[nr_particpanteve]
from Trajnimi t
where t.nr_participanteve > 50

--4.Shkruani te gjitha pajisjet qe kushtuan me shume se 2000 euro si dhe nese numri i atyre pajisjeve eshte me i vogel se 100
select p.pajisja_id,p.emri_pajisjes,p.nr_pajisjeve,p.qmimi
from Pajisje p
where p.qmimi >= 2000.0000 and p.nr_pajisjeve < 100


---------------------------------ADELINA XHEMA------------------------------------------------------------------------------------

--1.Shfaq klientet te cilet ka bere pagesa me te larta se shuma 950 
select k.emri,k.mbiemri,p.shuma
from Klienti k,Pagesa p
where k.klienti_id = p.klienti_id and p.shuma >950 

--2.Shfaq id e punetoreve qe ligjerojne ne Trajnimin Cisco
select p.stafi_id_punetori,t.emri
from Punetori p,Ligjeron l,Trajnimi t
where p.stafi_id_punetori=l.stafi_id_punetori and l.trajnimi_id=t.trajnimi_id and t.emri='Cisco'


--3.Shfaq stafin qe ka kontrate 5 vjeqare dhe paga eshte mbi 1500
select s.emri,s.mbiemri,s.kontrata,p.shuma
from Stafi s,Paga p,Pranon pr
where s.stafi_id = pr.stafi_id and p.paga_id = pr.paga_id and p.shuma >1500 and s.kontrata='5 Vjeqare'

--4. te gjithe praktikantet te cilet kane marre pjese ne trajnimet me kohezgjatje 6-muaj dhe me numer te pjesemarresve me te lart se 50
select p.emri,p.mbiemri,t.emri,t.kohezgjatja,t.nr_participanteve
from Praktikanti p,MerrPjese mp,Trajnimi t
where p.praktikanti_id=mp.praktikanti_id and t.trajnimi_id=mp.trajnimi_id 
and t.kohezgjatja='6-muaj'and t.nr_participanteve>50

--5.Pajisjet qe kane qmim me te lart se 1800 te radhitura nga me e shtrenjta
select p.emri_pajisjes,p.pajisja_id,p.qmimi
from Pajisje p,Salla s
where p.salla_id=s.salla_id and p.qmimi>1800
order by p.qmimi desc


--///////////////////////////////////	QUERY TE THJESHTA ME ME SHUME TABELA   /////////////////////////////

-----------------------------------------ADELINA XHEMA----------------------------------------

--1.Shfaq sa pagesa jane kryer mbi shumen 500$
select count(p.shuma)[nr pagesave me te larta se 500]
from Pagesa p
where p.shuma >500


--2.Shfaq pagen mesatare te stafit
select AVG(p.shuma)as Mesataraja_E_Pagave
from Paga p


--3.Shfaq sponzoret te cilet spozorojne shumen monetare mbi 2000 euro dhe lloji i sponzorimit eshte per Softuer
select s.emri,s.shuma_monetare,s.lloji_sponzorit
from Sponzori s
where s.shuma_monetare >= 2000.0000 and s.lloji_sponzorit='Softuer'


--4.Shfaq departamentet te cilat ka numer te punetoreve me shume se 2 dhe buxhetin me shume se 1000
select d.departamenti_id,d.lloji_departamentit,d.nr_punetoreve,d.buxheti
from Departamenti d
where d.nr_punetoreve>2 and d.buxheti>1000

--5.Shfaq stafin qe ka kontraten me shume se 7-vjeqare
select s.emri,s.mbiemri,s.stafi_id,s.kontrata
from Stafi s
where s.kontrata>'7 vjeqare'

-----------------------------------------------Rreze-------------------------------------------------------
--1.Selekto stafin qe paguhet me shume se 1200 euro
select s.emri,s.mbiemri,p.shuma
from Paga p,Pranon pr,Stafi s
where p.paga_id = pr.paga_id and s.stafi_id = pr.stafi_id and p.shuma > 1200

--2.Shfaqni katet se ku gjenden sallat ku mbahet trajnimi 'The EdVantage'
select t.emri,s.salla_id,s.nr_katit
from Trajnimi t,Salla s,Mbahet mb
where t.trajnimi_id = mb.trajnimi_id and s.salla_id = mb.salla_id and t.emri = 'The EdVantage'

--3.Te shfaqen id e punetoreve qe bashkepunojne me praktikantin Ardian Selmani
select p.stafi_id_punetori,pr.emri,pr.mbiemri
from Punetori p ,Bashkepunoni b,Praktikanti pr
where p.stafi_id_punetori = b.stafi_id_punetori and pr.praktikanti_id = b.praktikanti_id 
and pr.emri like 'Ardian' and pr.mbiemri like 'Selmani'

--4.Shfaqni klientet qe kerkuan projekte me kohezgjatje 1 muaj
select k.emri,k.mbiemri,p.emri_projektit,p.kohezgjatja
from Klienti k,Projekti p
where k.klienti_id = p.klienti_id and p.kohezgjatja = '1-muaj'



--//////////////////////////////  QUERY TE AVANCUARA   /////////////////////////////////////

----------------------------------------Rreze--------------------------------------------

--1.Selekto punetoret qe ligjerojne ne trajnimin 'EasyLearn'
select p.stafi_id_punetori,t.emri
from Punetori p inner join Ligjeron l 
on p.stafi_id_punetori = l.stafi_id_punetori
inner join Trajnimi t on t.trajnimi_id = l.trajnimi_id
where t.emri = 'EasyLearn'

--2.Selekto punetoret qe punojne ne departamentin 'Network' te kompanise
select p.stafi_id_punetori,d.lloji_departamentit
from Punetori p inner join Dep_Komp_Pun dkp on p.stafi_id_punetori = dkp.stafi_id_punetori
inner join Departamenti d on d.departamenti_id = dkp.departamenti_id
inner join Kompania k on k.id_kompania =dkp.id_kompania
where d.lloji_departamentit = 'Network'

--3.Shkruani te gjithe praktikantet qe nuk marrin pjese ne trajnime
select pr.emri,pr.mbiemri
from Praktikanti pr left join MerrPjese mp
on pr.praktikanti_id = mp.praktikanti_id
where mp.praktikanti_id is null

--4.Trego cili klient nuk e ka pranuar projektin
select k.emri,k.mbiemri,p.pranimi_projektit
from Pagesa p right join Klienti k
on p.klienti_id = k.klienti_id
where p.pranimi_projektit = 0

-----------------------------------------ADELINA XHEMA------------------------------------------------------------------------

--1.Shfaq te gjith praktikatet qe marrin pjese ne trajnimet te cilat startojne pas dates '2020-10-26'
select p.emri,p.mbiemri, p.praktikanti_id,t.emri,t.data_mbajtjes
from Praktikanti p inner join MerrPjese mp
on p.praktikanti_id = mp.praktikanti_id
inner join Trajnimi t on t.trajnimi_id = mp.trajnimi_id
where t.data_mbajtjes>'2020-10-26'


--2.Shfaq te gjith stafin paga e te cileve eshte ne mes shumes 1000 dhe 1500
select s.emri,s.mbiemri,p.shuma
from Stafi s inner join Pranon pr
on s.stafi_id = pr.stafi_id
inner join Paga p on p.paga_id = pr.paga_id
where p.shuma between 1000 and 1500


--3.te shfaqen klientet  te cilet kane bere pages me te lart se 400 dhe emri i tyre fillon me shkronjen a
select k.emri,k.mbiemri,p.shuma
from Klienti k 
inner join Pagesa p
on k.klienti_id=p.klienti_id
where p.shuma >400 and k.Emri like 'a%'


--4.Per secilin klient shfaq numrin e projektev te pranuara
select k.klienti_id, count(*) [numri i projekteve te pranaura]
from Klienti k  join Projekti p
on k.klienti_id=p.klienti_id
group by k.klienti_id
ORDER BY [numri i projekteve te pranaura]


--5.Shfaq klientin i cili nuk ka kryer pagesen
select k.emri,k.mbiemri,p.shuma
from Pagesa p left join Klienti k
on p.klienti_id = k.klienti_id
where p.shuma=0


--6.Shfaq pajisjet qe i mirembane stafi mirembajtes me id me te lart se 4005 dhe ka eksperience me shume se 4 vite
select Distinct sm.stafi_id_mirembajtes,sm.eksperienca,p.emri_pajisjes
from StafiMirembajtes sm inner join Pajisje p
on sm.stafi_id_mirembajtes=p.stafi_id_mirembajtes 
where sm.stafi_id_mirembajtes>4005 and eksperienca>4



--////////////////////////////   SUB-QUERY TE THJESHTE  ////////////////////////////////

---------------------------------ADELINA XHEMA------------------------------------------------------------------------------------

	--1.Shfaq trajnimet ne te cilat merr pjese praktikantja me emrin Arsa Salihu
	select p.emri,p.Mbiemri,t.Emri
	from Praktikanti p 
	inner join Merrpjese mp on p.praktikanti_id=mp.praktikanti_id
	inner join Trajnimi t on t.trajnimi_id=mp.trajnimi_id
	where p.praktikanti_id = 
							(select praktikanti_id 
							from Praktikanti p
							 where p.Emri like'Arsa' and p.Mbiemri like 'Salihu')



--2.Shfaq id-te e punetoreve te cilet ligjerojne ne Trajnimin 'A-List Education'
select p.stafi_id_punetori,T.emri,t.trajnimi_id
from Punetori p,Ligjeron l,Trajnimi t
where p.stafi_id_punetori = l.stafi_id_punetori
and t.trajnimi_id = l.trajnimi_id
and l.trajnimi_id =
					(select t.trajnimi_id
					from Trajnimi t
					where t.emri='A-List Education')


--3.Shfaq te gjithe praktikantet te cilet nuk kane marrpjese ne trajnimin  'Traded Training.'
select p.praktikanti_id,t.emri
from Praktikanti p,Trajnimi t,MerrPjese mp
where p.praktikanti_id=mp.praktikanti_id and t.trajnimi_id = mp.trajnimi_id and mp.trajnimi_id not in
															(select t.trajnimi_id
															 from Trajnimi t
															 where t.emri='Traded Training.')



--4.Pajisjet te cilat kane cmim me ulet se mesatarja e cmimeve te pajisjeve

select p.emri_pajisjes , p.qmimi
from Pajisje p
where p.qmimi < (select avg(p.qmimi)
		from Pajisje p)


--5.Shfaq ato pajisje  qe kane me cmimin me te vogel se mesatarja,
--prodhuesi i tyre eshte HP dhe id e salles eshte me e madhe se 200 dhe me vogel se 700 [duke perdorur View]*/

Create View Cmimi_Mesatar_Pajisjes 
as
(select avg(p.qmimi) as cmimi_mesatar
from Pajisje p)

select p.emri_pajisjes, p.qmimi 
from Pajisje p inner join Salla s
on p.salla_id=s.salla_id, Cmimi_Mesatar_Pajisjes c
where p.qmimi < c.cmimi_mesatar and p.prodhuesi='HP'and p.salla_id between 200 and 700


---------------------------------------------Rreze-------------------------------------------------

--1.Shfaq praktikantet qe bashkepunojne me punetorin me id 3004
select p.stafi_id_punetori,pr.emri,pr.mbiemri
from Punetori p,Bashkepunoni bp,Praktikanti pr
where p.stafi_id_punetori = bp.stafi_id_punetori and pr.praktikanti_id = bp.praktikanti_id
and bp.stafi_id_punetori =(select p.stafi_id_punetori
from Punetori p
where p.stafi_id_punetori = 3004)

--2.Selekto trajnimet te cilat mbahen ne salla me 100 ulese
select s.salla_id,t.trajnimi_id,s.nr_ulseve
from Salla s,Trajnimi t,Mbahet mb
where s.salla_id = mb.salla_id and t.trajnimi_id = mb.trajnimi_id and
mb.salla_id in (select s.salla_id
	from Salla
	where s.nr_ulseve = 100)

--3.Cilet jane punetoret qe punojne ne departamentin 'Softuer' te kompanise
select p.stafi_id_punetori,d.lloji_departamentit
from Departamenti d,Dep_Komp_Pun dkp,Punetori p
where d.departamenti_id = dkp.departamenti_id and p.stafi_id_punetori = dkp.stafi_id_punetori
and dkp.departamenti_id =(select d.departamenti_id
from Departamenti d 
where d.lloji_departamentit = 'Softuer')

--4.Shprehni te gjitha pajisjet te cilat jane nga prodhuesi Lenovo
select id_new,emri_new,prodhuesi_new
from
    (select pajisja_id as id_new,emri_pajisjes as emri_new,prodhuesi as prodhuesi_new
    from Pajisje p)as [pajisjet] 
	where prodhuesi_new = 'Lenovo'


--//////////////////////////  SubQuery Te Avancuara  ////////////////////////////////

---------------------------------------------Rreze---------------------------------------------------
--1.Selekto stafin i cili e kane rrogen me te madhe se mesatarja e te gjitheve
select s.emri,s.mbiemri,p.shuma
from Paga p,Stafi s,Pranon pr
where p.paga_id = pr.paga_id and 
s.stafi_id = pr.stafi_id
and p.shuma > any (select avg(p.shuma) 
from Paga p)


--2.Shfaqni stafin me pagen me te vogel 
select s.emri,s.mbiemri,p.shuma
from Paga p,Stafi s,Pranon pr
where s.stafi_id = pr.stafi_id and p.paga_id = pr.paga_id
and p.shuma = (select min(p.shuma) from Paga p )

--3.Shfaq shumen totale te parave qe jane sponzorizua per degen e UEB
select k.emri, (select sum(s.shuma_monetare)
from Sponzori s,Kompania k
where s.id_kompania= k.id_kompania and s.lloji_sponzorit = 'Web')[totali]
from Kompania k
group by k.emri

--4.Tregoni cili sponzor sponzorizon ne degen e Gjakoves me id 15
select s.id_kompania,s.id_sponzorit,s.emri
from Sponzori s
where exists
(
    select * from Kompania k
    where k.id_kompania = s.id_kompania
    and k.qyteti = 'Gjakove'
);

--5.Shfaqni pajisjet qe kane qmim mesatar me te larte se 5000
select * from (select p.pajisja_id,avg(p.qmimi)avg_qmim
from Pajisje p
group by p.pajisja_id) as tab
where avg_qmim >5000.00

--6.Shfaqni punetoret qe kane bashkepunuar me shume se nje here ne projekte
select p.stafi_id_punetori , (select count(bp.stafi_id_punetori) from Bashkepunoni bp where p.stafi_id_punetori = bp.stafi_id_punetori)[bashkepunimet]
from Punetori p inner join Stafi s
on p.stafi_id_punetori=s.stafi_id
where (select count(bp.stafi_id_punetori) from Bashkepunoni bp where p.stafi_id_punetori = bp.stafi_id_punetori) > 1
group by p.stafi_id_punetori

---------------------------------ADELINA XHEMA------------------------------------------------------------------------------------

--1.Listo id e punetoreve te cilet ligjerojne ne 2 trajnime 
select p.stafi_id_punetori , 
(select count(l.stafi_id_punetori) 
from Ligjeron l where p.stafi_id_punetori = l.stafi_id_punetori)[Ne sa trajnime ligjeron]
from Punetori p inner join Stafi s
on p.stafi_id_punetori=s.stafi_id
where (select count(l.stafi_id_punetori) from Ligjeron l where p.stafi_id_punetori = l.stafi_id_punetori)=2
group by p.stafi_id_punetori



--2.Shfaq te gjithe praktikantet qe jane pranuar ne deget e kompanis te cilat vitin e themelimit e kane me te lart se 2006
select p.emri,p.mbiemri,p.id_kompania
from Praktikanti p
where exists		(select * 
					from Kompania k
				    where k.id_kompania=p.id_kompania
				    and k.viti_themelimit>2006);

--3.Shfaq totalin e shumes per pagesa me te larta se 500
select k.emri,
(select sum(p.shuma)
from Kompania k,Pagesa p
where k.id_kompania=p.id_kompania and p.shuma>500)[Shuma]
from Kompania k
group by k.emri


--4.Shfaq departamentet qe kane buxhetin mesatar me te ulet se 1100
select * 
from (select d.departamenti_id,avg(d.buxheti)mesatare
from Departamenti d
group by d.departamenti_id) as tab
where mesatare <1100.00

	
--5.Shfaq klientet, të cilet kanë bere pagesa më vlere me te ulet se vlera mesatare e pagesave të përgjithshme të klienteve

select k.emri,k.mbiemri, sum(p.shuma) as 'totali shumes'
from Pagesa p, Klienti k
where k.klienti_id=p.klienti_id and p.shuma>0
group BY k.emri,k.mbiemri
HAVING sum(p.shuma)<(SELECT avg(p.shuma)
					FROM Pagesa p)
ORDER BY 'totali shumes';



--//////////////////////////////////  SubQuery me Union,Diference dhe Prerje	////////////////////////////////////

------------------------------------------Rreze-------------------------------------------------

--1.Shkruani emrat e te gjithe stafit dhe punetoreve te kompanise
(select s.stafi_id,s.emri,s.mbiemri
from Stafi s)union(select p.praktikanti_id,p.emri,p.mbiemri
from Praktikanti p)

--2.Shfaqni Punetoret te cilet punojne se bashku me Praktikantet
create view Pun as((select bp.praktikanti_id,bp.stafi_id_punetori
from Bashkepunoni bp)
union(select p.stafi_id_punetori,pr.praktikanti_id
from Punetori p inner join Praktikanti pr
on p.stafi_id_punetori = pr.praktikanti_id))
select * from Pun

--3.Te shfaqet emri i klientit dhe projektit te klientit me llogari bankare 552225222332
(select k.emri,k.mbiemri,k.llogaria_bankes,p.emri_projektit
from Klienti k left join Projekti p
on k.klienti_id = p.klienti_id
where k.llogaria_bankes = 552225222332)
intersect
(select k.emri,k.mbiemri,k.llogaria_bankes,p.emri_projektit
from Klienti k right join Projekti p
on k.klienti_id = p.klienti_id
where k.llogaria_bankes = 552225222332)

--4.Te shfaqet menaxhuesi i perbashket i femrave dhe mashkujve 
(select p.menaxhuesi_id
from Punetori p
where p.gjinia = 'F')
intersect 
(select p.menaxhuesi_id
from Punetori p
where p.gjinia = 'M')

--5.Tregoni cilat sponzor dhe qfar lloj sponzori kryejne ne kompanine me id 15 
(select s.lloji_sponzorit,s.emri
from Sponzori s
where  s.id_kompania= 13)
except
(select s.lloji_sponzorit,s.emri
from Sponzori s
where  s.id_kompania= 15)

----------------------------------------------------ADELINA XHEMA-------------------------------------------------------

--1.Shfaq emrat e te gjithe stafit dhe emrat e drejtoreve te kompanise
(select s.stafi_id,s.emri,s.mbiemri from Stafi s)
union
(select d.drejtori_id,d.emri,d.mbiemri from Drejtori d)


--2.Shfaq emrin,mbiemrin , id e pagesave dhe shumen e pagese  per ata klientet qe kane kryer pagesa
(select k.emri,k.mbiemri,p.pagesa_id,p.shuma
from Klienti k left join Pagesa p
on k.klienti_id = p.klienti_id
where p.shuma>0)
intersect
(select k.emri,k.mbiemri,p.pagesa_id,p.shuma
from Klienti k left join Pagesa p
on k.klienti_id = p.klienti_id
where p.shuma>0)

--3.Trego emrin e pajisjeve te prodhuesit HP
(select p.emri_pajisjes,p.prodhuesi
from Pajisje p
where p.prodhuesi='HP')
except
(select p.emri_pajisjes,p.prodhuesi
from Pajisje p
where p.prodhuesi='Lenovo')

--4.Shfaqen trajnimet qe kane kohezgjatje me shume se 2 muaj dhe numrin e pjesemarresve me te lart se 50
(select t.trajnimi_id ,t.emri
from Trajnimi t
where t.kohezgjatja > '2-muaj')
intersect
(select  t.trajnimi_id, t.emri
from Trajnimi t
where t.nr_participanteve >50)



--/////////////////////////////////////   STORED PROCEDURE   /////////////////////////////////////

--------------------------------------------ADELINA XHEMA------------------------------------------------------------------------------------


/*1. Numri i drejtoreve, gjinia si parameter */

create proc GetNrDrejtorevesipasGjinis
(
@gjinia char,
@nrDrejtorGjinia int =null)

AS
	BEGIN
		if (@gjinia='F')
			begin
				SET @nrDrejtorGjinia=(Select count(*)from Drejtori d where d.gjinia=@gjinia)
					PRINT 'Numri i drejtoreve te gjines femrore eshte: '+convert(varchar,@nrDrejtorGjinia )
			end
	   ELSE if (@gjinia='M')
			begin
				SET @nrDrejtorGjinia=(Select count(*)from Drejtori d where d.gjinia=@gjinia)
					PRINT 'Numri i drejtoreve te gjines mashkullore eshte: '+convert(varchar,@nrDrejtorGjinia )
			end
		else
			PRINT 'Ju nuk keni zgjedhur gjinen : '
END

GetNrDrejtorevesipasGjinis 'M'

--2.Trego nese punetori ligjeron ne nje ose me shume trajnime,id e punetorit te jete parameter input

create proc PunetoretSipasTrajnimit
	@idInput int
	as
	Begin

		declare @trajnimi int;

			select @trajnimi=(select count(*) [trajnimet]
			from Punetori p inner join Ligjeron l
			on p.stafi_id_punetori=l.stafi_id_punetori
			where p.stafi_id_punetori=@idInput)

IF @trajnimi>1
	begin
		Print 'Punetori ligjeron ne me shume se nje trajnim'
	end
ELSE
	begin 
		Print 'Punetori ligjeron ne vetem nje trajnim'
	end
End

PunetoretSipasTrajnimit 6103


--3.Krijoni një procedure e cila tregon përqindjen e personave ne baze te kontrates, varesisht nga  inputit i kontrates.

create proc PerqindjaPersonaveSipasKontratave
@kontrata varchar(255)

as
	begin
		declare @numroStaf int = (select count(*) from Stafi)
		declare @nrPesonatKontrata int = (select count(*) from Stafi
										where @kontrata=kontrata)

print 'Staf me kontrate ' +@kontrata+ ' jane ' +cast((100*@nrPesonatKontrata/@numroStaf) as varchar(255))+ '%'

end

PerqindjaPersonaveSipasKontratave '8 Vjeqare'


--4.Shfaq id e punetorit i cili ligjeron ne trajnimin me id 11117

create proc PunetoriLigjeronTrajnim
(
	@newTrajnimiID int,
	@newStafiId int out
	
)
as begin

select @newStafiId=p.stafi_id_punetori
from Punetori p,Ligjeron l,Trajnimi t
where p.stafi_id_punetori = l.stafi_id_punetori and t.trajnimi_id=l.trajnimi_id
and l.trajnimi_id =(select t.trajnimi_id
from Trajnimi t
where t.trajnimi_id = @newTrajnimiID)

end
declare @IDpunetori int

exec PunetoriLigjeronTrajnim
	11117,
	@IDpunetori out
	

	print 'Punetori me id '+cast(@IDpunetori as varchar(50))+' ligjeron ne trajnimin me id 11117';


--5.Shfaq emrin dhe mbiemrin e praktikantit qe ndjek nje trajnim te caktuar,id e trajnimit te jete input

create proc Praktik
(
	@newId int,
	@newEmri varchar(20) out,
	@newMbiemri varchar(20) out
)
as begin

select @newEmri=pr.emri,@newMbiemri=pr.mbiemri
from Trajnimi t,MerrPjese mp,Praktikanti pr
where t.trajnimi_id = mp.trajnimi_id and pr.praktikanti_id = mp.praktikanti_id
and mp.trajnimi_id =(select t.trajnimi_id
		     from Trajnimi t
	             where t.trajnimi_id = @newId)

end
declare @Emri varchar(20),@Mbiemri varchar(20)

exec Praktik
	11116,
	@Emri out,
	@Mbiemri out

	print 'Praktikanti '+@Emri+' '+@Mbiemri+' ndjek trajnimin me id 11116';


-------------------------------------------Rreze------------------------------------------------

--1.Tregoni cili praktikant bashkepunon me punetorin me id 3004
create proc PunetoriIdd
(
	@newStafiId int,
	@newEmri varchar(20) out,
	@newMbiemri varchar(20) out
)
as begin

select @newEmri=pr.emri,@newMbiemri=pr.mbiemri
from Punetori p,Bashkepunoni bp,Praktikanti pr
where p.stafi_id_punetori = bp.stafi_id_punetori and pr.praktikanti_id = bp.praktikanti_id
and bp.stafi_id_punetori =(select p.stafi_id_punetori
from Punetori p
where p.stafi_id_punetori = @newStafiId)

end
declare @Emmri varchar(20),@Mbiemmri varchar(20)

exec PunetoriIdd
	3004,
	@Emmri out,
	@Mbiemmri out

	print 'Punetori '+@Emmri+' '+@Mbiemmri+' punon me punetorin me id 3004';

--2.Tregoni cili klient nuk ka pranuar projektin
	create proc KlientProjekt
	(
	@newPranimi int,
	@newEmri varchar(20) out,
	@newMbiemri varchar(20) out
	)
	as begin 
	select @newEmri=k.emri,@newMbiemri=k.mbiemri
from Pagesa p right join Klienti k
on p.klienti_id = k.klienti_id
where p.pranimi_projektit = @newPranimi

end
declare @Emmrii varchar(20),@Mbiemmrii varchar(20)

exec KlientProjekt
	0,
	@Emmrii out,
	@Mbiemmrii out

	print 'Klienti '+@Emmrii+' '+@Mbiemmrii+' nuk ka pranuar projektin';

 --///////////////if/else
--1.Sa punetor/e jane femra e sa mashkuj?

create proc NrStafSipasGjinise
(
	@Gjinia char,
	@StudentetGjinia int=''
	)
	as begin
	if (@Gjinia ='F')
	begin
	set @StudentetGjinia = (select count(*) from Punetori p where p.gjinia = @Gjinia)
	print 'Ne kemi '+convert(varchar,@StudentetGjinia)+' punetore femra'

end
else
if(@Gjinia = 'M')
begin 
set @StudentetGjinia = (select count(*) from Punetori p where p.gjinia = @Gjinia)
	print 'Ne kemi '+convert(varchar,@StudentetGjinia)+' punetor meshkuj'
	end
	else 
	print 'Gjinia nuk eshte zgjedhur'
	end

	exec NrStafSipasGjinise 'F'

--2.Sa praktikant marrin pjese ne trajnimin Ueb ose Softuer?
create proc Praktikantet
(
	@Lloji varchar(20),
	@LlojiTrajnimit int = ''
)
as 
begin
if (@Lloji ='Ueb')
begin 
set @LlojiTrajnimit = (select count(*)from Praktikanti p where p.lloji_trajnimit = @Lloji)
print 'Kemi '+convert(varchar,@LlojiTrajnimit)+' praktikant ne Ueb'
end
else 
if(@Lloji = 'Softuer')
begin
set @LlojiTrajnimit = (select count(*)from Praktikanti p where p.lloji_trajnimit = @Lloji)
print 'Kemi '+convert(varchar,@LlojiTrajnimit)+' praktikant ne Softuer'
end
else 
	print 'Trajnimi nuk eshte zgjedhur'
	end

exec Praktikantet 'Softuer'


 




