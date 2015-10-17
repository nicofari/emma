drop schema Emma;
create schema Emma;
use Emma;
-- ---------------------------------------  
-- Amministrazione e utenti
-- ---------------------------------------  
create table z_profilo
(
  id int not null auto_increment,
  dd_descrizione varchar(50) not null,
  primary key(id)
);
create table z_utente
(
  id int not null auto_increment,
  dd_login varchar(50) not null,
  dd_password varchar(100) not null,
  dd_nome varchar(50) not null,
  dd_cognome varchar(100) not null,
  dd_mail varchar(50),
  cz_profilo int not null,
  primary key(id),
  foreign key(cz_profilo) references z_profilo(id)
);
create unique index IU_Z_UTENTE_0 on z_utente(dd_login);
create table z_funzione
(
  id int not null auto_increment,
  dd_descrizione varchar(100) not null,
  dd_descr_breve varchar(50) not null,
  dd_url varchar(100) not null,
  cz_profilo int not null,
  id_parent int not null default -1,
  foreign key(cz_profilo) references z_profilo(id),
  primary key(id)
);
-- Log
create table z_log
(
  id int not null auto_increment,
  dd_op varchar(40) not null,
  dd_msg varchar(255),
  cz_utente int not null,
  dt_now datetime,
  primary key(id)
);
-- join di z_log con z_utente
create or replace view v_log as
select zl.id, zl.dd_op, zl.dd_msg, zl.dt_now, zl.cz_utente, zu.dd_login
  from z_log zl, z_utente zu
 where zl.cz_utente = zu.id;
-- join utenti e profilo corrispondente 
create or replace view v_utenti_profilo as
select zu.id, zu.dd_login, zu.dd_mail, zu.dd_password, zu.dd_nome, zu.dd_cognome, zu.cz_profilo, zp.dd_descrizione dd_profilo
  from z_utente zu, z_profilo zp
 where zu.cz_profilo = zp.id;
 -- Intestazione lettera personalizzata per utente
create table z_utente_testata_lettera
(
  id int not null auto_increment,
  bl_testo text,
  cz_utente int not null,
  primary key (id),
  foreign key (cz_utente) references z_utente(id)
);

-- ---------------------------------------  
-- Tabelle
-- ---------------------------------------  
create table t_titolo
(
  id int not null auto_increment,
  dd_descrizione varchar(50) not null,
  primary key(id)  
);
create table t_stato_civile
(
  ID int not null auto_increment,
  dd_descrizione varchar(50) not null,
  primary key(id)  
);
create table t_patologia
(
  ID int not null auto_increment,
  dd_descrizione varchar(50) not null,
  primary key(id)  
);

-- ---------------------------------------  
-- tabella pazienti
-- ---------------------------------------  
create table a_paziente
(
  id int not null auto_increment,
  dd_cognome varchar(50) not null,
  dd_nome varchar(50) not null,
  ct_titolo int,
  cd_sesso varchar(1),
  dt_nascita date,
  cd_fiscale varchar(16),
  ct_stato_civile int,
  dd_medico_nome varchar(50),
  dd_medico_cognome varchar(50),
  dd_medico_email varchar(50),
  dd_medico_saluto varchar(50),
  dd_foto varchar(100),
  bl_nota text,
  cz_utente int,
  ts_now timestamp,
  primary key(id)  
);
alter table a_paziente add constraint fk_a_paziente_titolo foreign key (ct_titolo) references t_titolo(id);
alter table a_paziente add constraint fk_a_paziente_stato_civile foreign key (ct_stato_civile) references t_stato_civile(id);
alter table a_paziente add constraint fk_a_paziente_utente foreign key (cz_utente) references z_utente(id);

-- vista pazienti
create or replace view v_a_paziente as
select 
  ap.id, ap.dd_cognome, ap.dd_nome, ap.cd_sesso, 
  date_format(ap.dt_nascita, '%d/%m/%Y') dt_nascita, ap.cd_fiscale,
  ap.ct_titolo, tt.dd_descrizione dd_titolo,
  ap.ct_stato_civile, tsc.dd_descrizione dd_stato_civile, 
  ap.dd_medico_nome, ap.dd_medico_cognome, ap.dd_medico_email, dd_foto,
  bl_nota
from 
  a_paziente ap 
  left outer join t_titolo tt on ap.ct_titolo = tt.id
  left outer join t_stato_civile tsc on ap.ct_stato_civile = tsc.id;
  
-- ---------------------------------------  
-- Questionari - struttura
-- ---------------------------------------  
create table a_quest
(
  id integer not null auto_increment,
  dd_descrizione varchar(100) not null,
  dd_descr_breve varchar(50) not null,
  primary key(id)
);
create table a_quest_sezione
(
  id integer not null auto_increment,
  dd_descrizione1 varchar(255) not null,
  dd_descrizione2 varchar(255),  
  ca_quest int not null,
  nr_num_scelte_possibili int,
  primary key(id)
);
alter table a_quest_sezione add constraint fk_a_quest_sezione_1 foreign key (ca_quest) references a_quest(id);
create table a_quest_item
(
  id integer not null auto_increment,
  ca_quest integer not null,
  ca_quest_sezione int not null,
  dd_domanda varchar(100) not null,
  dd_immagine varchar(255),
  dd_risposte varchar(255),
  nr_order integer,
  primary key(id)
);
alter table a_quest_item add constraint fk_a_quest_item_1 foreign key (ca_quest) references a_quest(id);
alter table a_quest_item add constraint fk_a_quest_item_2 foreign key (ca_quest_sezione) references a_quest_sezione(id);
-- testata del questionario compilato
create table m_quest
(
  id integer not null auto_increment,  
  ca_quest integer not null,
  ca_paziente integer not null,
  dt_now datetime,
  dd_risultato varchar(255),
  bl_lettera text,
  cz_utente int not null,
  nr_risultato1 decimal(5,2),
  nr_risultato2 decimal(5,2),
  nr_risultato3 decimal(5,2),
  primary key(id)  
);
alter table m_quest add constraint fk_m_quest_1 foreign key (ca_quest) references a_quest(id);
alter table m_quest add constraint fk_m_quest_2 foreign key (ca_paziente) references a_paziente(id);
alter table m_quest add constraint fk_m_quest_3 foreign key (cz_utente) references z_utente(id);
-- dettaglio del questionario compilato
create table m_quest_item
(
  id integer not null auto_increment,  
  cm_quest integer not null,
  ca_quest_item integer not null,
  nr_scelta integer,
  primary key(id)  
);
alter table m_quest_item add constraint fk_m_quest_item_1 foreign key (cm_quest) references m_quest(id);
alter table m_quest_item add constraint fk_m_quest_item_2 foreign key (ca_quest_item) references a_quest_item(id);
-- Tabella di coefficienti per calcolo risultati test
create table z_normalizza
(
  id integer not null,
  nr_coeff decimal(5,2),
  primary key (id)
);
-- Viste varie su questionari
create or replace view v_a_quest as
select id, dd_descrizione, dd_descr_breve, concat(dd_descr_breve, ' ', dd_descrizione) dd_descr_completa
  from a_quest;
create or replace view v_m_quest_item as
select 
  mqi.id IdMQuestItem, aqi.id IdAQuestItem, mqi.cm_quest CmQuest,
  aqi.dd_domanda, aqi.dd_risposte, mqi.nr_scelta, aqi.nr_order
from 
  m_quest_item mqi, a_quest_item aqi
where 
  mqi.ca_quest_item = aqi.id
order by aqi.nr_order;
-- Aggiunta decodifica di cz_utente in modo ordinare per utente
create or replace view v_m_quest as
select 
  mq.id IdMQuest, mq.ca_paziente IdPaziente, aq.id IdAQuest, 
  aq.dd_descrizione Questionario, date_format(mq.dt_now, '%d/%m/%Y') Data, ap.dd_cognome Cognome, ap.dd_nome Nome,
  mq.dd_risultato Risultato, mq.nr_risultato1, mq.nr_risultato2, mq.nr_risultato3,
  Concat(ap.dd_medico_cognome, ' ', ap.dd_medico_nome) dd_medico_famiglia, ap.dd_medico_email,
  Concat(zu.dd_cognome, ' ', zu.dd_nome) dd_utente, ap.dd_medico_cognome, ap.dd_medico_nome,
  zu.dd_cognome dd_utente_cognome, zu.dd_nome dd_utente_nome
from 
  m_quest mq, a_quest aq, a_paziente ap, z_utente zu
where 
  mq.ca_quest = aq.id and 
  mq.ca_paziente = ap.id and
  mq.cz_utente = zu.id;
-- Domande in join con sezioni   
create or replace view v_a_quest_item as
select 
  aqi.id,
  aqi.ca_quest,
  aqi.ca_quest_sezione,
  aqi.dd_domanda,
  aqi.dd_immagine,
  aqi.dd_risposte,
  aqi.nr_order,
  aqs.dd_descrizione1 dd_sezione_descr1,
  aqs.dd_descrizione2 dd_sezione_descr2,
  aqs.nr_num_scelte_possibili
from 
  a_quest_item aqi, a_quest_sezione aqs
where
  aqi.ca_quest_sezione = aqs.id;


  