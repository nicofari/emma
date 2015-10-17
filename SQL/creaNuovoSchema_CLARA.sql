drop schema if exists Clara;
create schema Clara;
use Clara;

CREATE TABLE IF NOT EXISTS  `Sessione` (
	session_id varchar(40) DEFAULT '0' NOT NULL,
	ip_address varchar(16) DEFAULT '0' NOT NULL,
	user_agent varchar(120) NOT NULL,
	last_activity int(10) unsigned DEFAULT 0 NOT NULL,
	user_data text, -- NOT NULL, -- problema: http://codeigniter.com/forums/viewthread/94940/
	PRIMARY KEY (session_id),
	KEY `last_activity_idx` (`last_activity`)
);

create table IF NOT EXISTS  Profilo
(
  id int not null auto_increment,
  descrizione varchar(50) not null,
  primary key(id)
);
insert into Profilo(id,descrizione) values (1,'Paziente');
insert into Profilo(id,descrizione) values (2,'Operatore');
insert into Profilo(id,descrizione) values (3,'Medico');
insert into Profilo(id,descrizione) values (4,'Amministratore');

create table IF NOT EXISTS Persona
(
  Id int not null auto_increment,
  Cognome varchar(50) not null,
  Nome varchar(50) not null,
  Sesso varchar(1),
  Data_nascita date,
  Codice_fiscale varchar(16),
  Codice_utente varchar(30),
  Parola_chiave varchar(255),
  Marca_temporale timestamp default current_timestamp,
  Profilo_id integer not null,
  primary key(id)  
);
alter table Persona add constraint fk_persona_profilo foreign key(Profilo_id) references Profilo(id);
insert into Persona(id, Cognome, nome, sesso, Codice_utente, Parola_chiave, Profilo_id)
values (1, 'Farina', 'Nicola', 'M', 'farinan', 'farinan', 1);
-- ---------------------------------------  
-- Questionari - struttura
-- ---------------------------------------  
create table IF NOT EXISTS  Questionario
(
  id integer not null auto_increment,
  Descrizione varchar(100) not null,
  Descrizione_breve varchar(50) not null,
  primary key(id)
);
create table IF NOT EXISTS  Questionario_sezione
(
  id integer not null auto_increment,
  Descrizione1 varchar(255) not null,
  Descrizione2 varchar(255),  
  Questionario_id int not null,
  Num_scelte_possibili int,
  primary key(id)
);
alter table Questionario_sezione add constraint fk_Questionario_sezione_Questionario foreign key (Questionario_id) references Questionario(id);
create table IF NOT EXISTS  Questionario_domanda
(
  id integer not null auto_increment,
  Questionario_id integer not null,
  Questionario_sezione_id int not null,
  Testo_domanda varchar(100) not null,
  Path_immagine varchar(255),
  Testo_risposte varchar(255),
  Num_ordine integer,
  primary key(id)
);
alter table Questionario_domanda add constraint fk_Questionario_domande_Questionario foreign key (Questionario_id) references Questionario(id);
alter table Questionario_domanda add constraint fk_Questionario_domande_Sezione foreign key (Questionario_sezione_id) references Questionario_sezione(id);
-- testata del questionario compilato
create table IF NOT EXISTS  Questionario_compilato
(
  id integer not null auto_increment,  
  Questionario_id integer not null,
  Session_id varchar(40) DEFAULT '0',
  Persona_id integer not null,
  Aperto_il timestamp default current_timestamp,
  Chiuso_il timestamp,
  Risultato varchar(255),
  Risultato1 decimal(5,2),
  Risultato2 decimal(5,2),
  Risultato3 decimal(5,2),
  primary key(id)  
);
-- TODO: riabilitare dopo aver compilato struttura
-- alter table Questionario_compilato add constraint fk_Questionario_compilato_Questionario foreign key (Questionario_id) references Questionario(id);
alter table Questionario_compilato add constraint fk_Questionario_compilato_Persona foreign key (Persona_id) references Persona(id);
alter table Questionario_compilato add constraint fk_Questionario_compilato_Sessione foreign key (Session_id) references Sessione(Session_id) on update set null on delete set null;
-- dettaglio del questionario compilato
create table Questionario_Risposta
(
  id integer not null auto_increment,  
  Questionario_compilato_id integer not null,
  Questionario_domanda_id integer not null,
  Scelta integer,
  primary key(id)  
);
alter table Questionario_Risposta add constraint fk_Questionario_Risposta_Compilato foreign key (Questionario_compilato_id) references Questionario_compilato(id);
-- TODO: riabilitare dopo aver compilato struttura
-- alter table Questionario_Risposta add constraint fk_Questionario_Risposta_Domanda foreign key (Questionario_domanda_id) references Questionario_domanda(id);

/************************
insert into a_quest(id, dd_descr_breve, dd_descrizione) 
values (2, 'FAS', 'Fibromyalgia Assessment Status (FAS)');
-- questionari - sezioni
insert into a_quest_sezione(id, ca_quest, dd_descrizione1, dd_descrizione2, nr_num_scelte_possibili) 
values (1, 1, 'Recent-Onset Arthritis Disability (ROAD) Index', 'Nel corso dell''ultima settimana è stato in grado di: ', 5);
insert into a_quest_sezione(id, ca_quest, dd_descrizione1, dd_descrizione2, nr_num_scelte_possibili) 
values (2, 1, 'Autovalutazione articolazioni dolenti', 'Indichi l''entità del dolore che sente attualmente nell''articolazione indicata: ', 4);
insert into a_quest_sezione(id, ca_quest, dd_descrizione1, dd_descrizione2, nr_num_scelte_possibili) 
values (3, 1, 'Stato generale di salute', 'Indichi l''effetto che la malattia ha avuto sul suo stato generale di salute nel corso dell''ultima settimana: ', 11);
-- FAS
insert into a_quest_sezione(id, ca_quest, dd_descrizione1, dd_descrizione2, nr_num_scelte_possibili) 
values (4, 2, 'Indicare in una scala da 0 a 3 quanto è stato forte il suo dolore (nelle sedi articolari e corporee nell''ultima settimana', '', 4);
insert into a_quest_sezione(id, ca_quest, dd_descrizione1, dd_descrizione2, nr_num_scelte_possibili) 
values (5, 2, 'Quanto si è sentito/a stanco/a nell''ultima settimana', '', 11);
insert into a_quest_sezione(id, ca_quest, dd_descrizione1, dd_descrizione2, nr_num_scelte_possibili) 
values (6, 2, 'Quanto si è sentito/a riposato/a al risveglio nell''ultima settimana', '', 11);

-- questionari - domande
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (1, 1, 1, 'Chiudere completamente la mano a pugno?', 'ChiudereLaMano.jpg', 'Senza difficoltà|Con lieve difficoltà|Con qualche difficoltà|Con molta difficoltà|No, è stato impossibile', 1);
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 1, 'Accettare una stretta di mano?', 'StrettaDiMano.jpg', 'Senza difficoltà|Con lieve difficoltà|Con qualche difficoltà|Con molta difficoltà|No, è stato impossibile', 2);
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (3, 1, 1, 'Abbottonarsi gli abiti?', 'Abbottonarsi.jpg', 'Senza difficoltà|Con lieve difficoltà|Con qualche difficoltà|Con molta difficoltà|No, è stato impossibile', 3);
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (4, 1, 1, 'Svitare il barattolo di un coperchio già aperto in precedenza?', 'SvitareBarattolo.jpg', 'Senza difficoltà|Con lieve difficoltà|Con qualche difficoltà|Con molta difficoltà|No, è stato impossibile', 4);
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (5, 1, 1, 'Raggiungere e afferrare un oggetto del peso di circa 2 kg posto sopra la Sua testa?', '', 'Senza difficoltà|Con lieve difficoltà|Con qualche difficoltà|Con molta difficoltà|No, è stato impossibile', 5);
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (6, 1, 1, 'Stare in piedi in posizione eretta?', '', 'Senza difficoltà|Con lieve difficoltà|Con qualche difficoltà|Con molta difficoltà|No, è stato impossibile', 6);
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (7, 1, 1, 'Camminare su un terreno piano?', '', 'Senza difficoltà|Con lieve difficoltà|Con qualche difficoltà|Con molta difficoltà|No, è stato impossibile', 7);
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (8, 1, 1, 'Salire un piano di scale?', '', 'Senza difficoltà|Con lieve difficoltà|Con qualche difficoltà|Con molta difficoltà|No, è stato impossibile', 8);
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (9, 1, 1, 'Salire e scendere dall''automobile?', '', 'Senza difficoltà|Con lieve difficoltà|Con qualche difficoltà|Con molta difficoltà|No, è stato impossibile', 9);
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (10, 1, 1, 'Lavare e asciugare tutto il corpo?', '', 'Senza difficoltà|Con lieve difficoltà|Con qualche difficoltà|Con molta difficoltà|No, è stato impossibile', 10);
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (11, 1, 1, 'Fare attività vigorose quali trasportare oggetti e borse pesanti?', '', 'Senza difficoltà|Con lieve difficoltà|Con qualche difficoltà|Con molta difficoltà|No, è stato impossibile', 11);
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (12, 1, 1, 'Svolgere un lavoro retribuito o attività domestiche?', '', 'Senza difficoltà|Con lieve difficoltà|Con qualche difficoltà|Con molta difficoltà|No, è stato impossibile', 12);
-- sezione 2 - parte sinistra 
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (13, 1, 2, 'Mano sinistra', '', 'Assente|Lieve|Moderato|Forte', 13);
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (14, 1, 2, 'Polso sinistro', '', 'Assente|Lieve|Moderato|Forte', 14);
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (15, 1, 2, 'Gomito sinistro', '', 'Assente|Lieve|Moderato|Forte', 15);
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (16, 1, 2, 'Spalla sinistra', '', 'Assente|Lieve|Moderato|Forte', 16);
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (17, 1, 2, 'Anca sinistra', '', 'Assente|Lieve|Moderato|Forte', 17);
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (18, 1, 2, 'Ginocchio sinistro', '', 'Assente|Lieve|Moderato|Forte', 18);
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (19, 1, 2, 'Caviglia sinistra', '', 'Assente|Lieve|Moderato|Forte', 19);
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (20, 1, 2, 'Piede sinistro', '', 'Assente|Lieve|Moderato|Forte', 20);
-- sezione 2 - parte destra 
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (21, 1, 2, 'Mano destra', '', 'Assente|Lieve|Moderato|Forte', 21);
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (22, 1, 2, 'Polso destro', '', 'Assente|Lieve|Moderato|Forte', 22);
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (23, 1, 2, 'Gomito destro', '', 'Assente|Lieve|Moderato|Forte', 23);
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (24, 1, 2, 'Spalla destra', '', 'Assente|Lieve|Moderato|Forte', 24);
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (25, 1, 2, 'Anca destra', '', 'Assente|Lieve|Moderato|Forte', 25);
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (26, 1, 2, 'Ginocchio destro', '', 'Assente|Lieve|Moderato|Forte', 26);
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (27, 1, 2, 'Caviglia destra', '', 'Assente|Lieve|Moderato|Forte', 27);
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (28, 1, 2, 'Piede destro', '', 'Assente|Lieve|Moderato|Forte', 28);
-- Sezione 3
insert into a_quest_item(id, ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (29, 1, 3, '', '', '0|1|2|3|4|5|6|7|8|9|10', 29);

-- FAS
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Testa', '', '0|1|2|3', 1);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Torace', '', '0|1|2|3', 2);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Braccio sx', '', '0|1|2|3', 3);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Avambr. sx', '', '0|1|2|3', 4);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Gluteo sx', '', '0|1|2|3', 5);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Addome', '', '0|1|2|3', 6);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Coscia sx', '', '0|1|2|3', 7);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Gamba sx', '', '0|1|2|3', 8);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Spalla sx', '', '0|1|2|3', 9);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Gomito sx', '', '0|1|2|3', 10);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Polso sx', '', '0|1|2|3', 11);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Mano sx', '', '0|1|2|3', 12);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Anca sx', '', '0|1|2|3', 13);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Ginocchio sx', '', '0|1|2|3', 14);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Caviglia sx', '', '0|1|2|3', 15);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Piede sx', '', '0|1|2|3', 16);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Collo', '', '0|1|2|3', 17);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Dorso', '', '0|1|2|3', 18);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Braccio dx', '', '0|1|2|3', 19);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Avambr. dx', '', '0|1|2|3', 20);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Schiena', '', '0|1|2|3', 21);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Gluteo dx', '', '0|1|2|3', 22);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Coscia dx', '', '0|1|2|3', 23);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Gamba dx', '', '0|1|2|3', 24);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Spalla dx', '', '0|1|2|3', 25);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Gomito dx', '', '0|1|2|3', 26);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Polso dx', '', '0|1|2|3', 27);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Mano dx', '', '0|1|2|3', 28);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Anca dx', '', '0|1|2|3', 29);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Ginocchio dx', '', '0|1|2|3', 30);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Caviglia dx', '', '0|1|2|3', 31);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 1, 'Piede dx', '', '0|1|2|3', 32);

insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 2, '', '', '0|1|2|3|4|5|6|7|8|9|10', 33);
insert into a_quest_item(ca_quest, ca_quest_sezione, dd_domanda, dd_immagine, dd_risposte, nr_order) 
values (2, 3, '', '', '0|1|2|3|4|5|6|7|8|9|10', 34);
*******************/

