-- profili
insert into z_profilo(id,dd_descrizione) values (1,'Paziente');
insert into z_profilo(id,dd_descrizione) values (2,'Operatore');
insert into z_profilo(id,dd_descrizione) values (3,'Medico');
insert into z_profilo(id,dd_descrizione) values (4,'Amministratore');
-- utenti
insert into z_utente(id, dd_login, dd_password, dd_nome, dd_cognome, cz_profilo) 
values (1, 'farinan', 'farinan', 'Nicola', 'Farina', 4);
insert into z_utente(id, dd_login, dd_password, dd_nome, dd_cognome, cz_profilo) 
values (2, 'montesid', 'montesid', 'Danilo', 'Montesi', 3);
insert into z_utente(id, dd_login, dd_password, dd_nome, dd_cognome, cz_profilo) 
values (3, 'farinas', 'farinas', 'Stefano', 'Farina', 3);
insert into z_utente(id, dd_login, dd_password, dd_nome, dd_cognome, cz_profilo) 
values (4, 'salaffif', 'salaffif', 'Fausto', 'Salaffi', 3);
insert into z_utente(id, dd_login, dd_password, dd_nome, dd_cognome, cz_profilo) 
values (5, 'rossim', 'rossim', 'Mario', 'Rossi', 2);
insert into z_utente(id, dd_login, dd_password, dd_nome, dd_cognome, cz_profilo) 
values (6, 'guest', 'guest', 'Utente', 'Ospite', 1);
-- testata lettera
insert into z_utente_testata_lettera(id, cz_utente, bl_testo)
values (1, 1, concat_ws('\n', 'Dott. Manlio Scordabattaglia \nProfessore Associato di Reumatologia\n', 
'Clinica Reumatologica \- Scuola di Specializzazione in Reumatologia',
'Ospedale A. Zamboni ASLBO Zona Centrale 1',
'Via Mura Anteo Zamboni 13 \- 44100 Bologna (BO)',
'tel 051 123424 - 123123 - 123123 - Fax 051 123123'
));
insert into z_utente_testata_lettera(id, cz_utente, bl_testo)
values (2, 2, concat_ws('\n', 'Dott. Danilo Montesi \nProfessore Associato di Reumatologia\n', 
'Clinica Reumatologica \- Scuola di Specializzazione in Reumatologia',
'Ospedale A. Zamboni ASLBO Zona Centrale 1',
'Via Mura Anteo Zamboni 13 \- 44100 Bologna (BO)',
'tel 051 123424 - 123123 - 123123 - Fax 051 123123'
));
insert into z_utente_testata_lettera(id, cz_utente, bl_testo)
values (3, 3, concat_ws('\n', 'Dott. Stefano Farina \nProfessore Associato di Reumatologia\n', 
'Clinica Reumatologica \- Scuola di Specializzazione in Reumatologia',
'Ospedale A. Zamboni ASLBO Zona Centrale 1',
'Via Mura Anteo Zamboni 13 \- 44100 Bologna (BO)',
'tel 051 123424 - 123123 - 123123 - Fax 051 123123'
));
insert into z_utente_testata_lettera(id, cz_utente, bl_testo)
values (4, 4, concat_ws('\n', 'Dott. Fausto Salaffi \nProfessore Associato di Reumatologia\n', 
'Clinica Reumatologica \- Scuola di Specializzazione in Reumatologia',
'Ospedale A. Murri ASUR Zona Territoriale 5',
'Via dei Colli, 52 - 60035 Jesi (AN)',
'tel 051 123424 - 123123 - 123123 - Fax 051 123123'
));

-- funzioni
-- cz_profilo è il profilo minimo per cui la funzione è visibile
insert into z_funzione(id, dd_descrizione, dd_descr_breve, dd_url, cz_profilo, id_parent) 
values (1, 'Root', 'Root', '', 1, -1);
insert into z_funzione(id, dd_descrizione, dd_descr_breve, dd_url, cz_profilo, id_parent) 
values (2, 'Home', 'Home', '~/Default.aspx', 1, -1);
insert into z_funzione(id, dd_descrizione, dd_descr_breve, dd_url, cz_profilo, id_parent) 
values (3, 'About', 'About', '~/About.aspx', 1, -1);
-- tabelle
insert into z_funzione(id, dd_descrizione, dd_descr_breve, dd_url, cz_profilo) 
values (4, 'Tabelle', 'Tabelle', '', 3);
insert into z_funzione(id, dd_descrizione, dd_descr_breve, dd_url, cz_profilo, id_parent) 
values (5, 'Pazienti', 'Pazienti', '~/Tabelle/FmPazienti.aspx', 3, 4);
insert into z_funzione(id, dd_descrizione, dd_descr_breve, dd_url, cz_profilo, id_parent) 
values (6, 'Titoli di studio', 'TitoliDiStudio', '~/Tabelle/FmTitoliDiStudio.aspx', 2, 4);
insert into z_funzione(id, dd_descrizione, dd_descr_breve, dd_url, cz_profilo, id_parent) 
values (7, 'Stato civile', 'StatoCivile', '~/Tabelle/FmStatoCivile.aspx', 2, 4);
-- questionari
insert into z_funzione(id, dd_descrizione, dd_descr_breve, dd_url, cz_profilo) 
values (8, 'Questionari', 'Questionari', '', 3);
insert into z_funzione(id, dd_descrizione, dd_descr_breve, dd_url, cz_profilo, id_parent) 
values (9, 'Somministra', 'Somministra', '~/Questionari/FmCompila.aspx', 2, 8);
insert into z_funzione(id, dd_descrizione, dd_descr_breve, dd_url, cz_profilo, id_parent) 
values (10, 'Archivio', 'Archivio', '~/Questionari/FmArchivio.aspx', 2, 8);
insert into z_funzione(id, dd_descrizione, dd_descr_breve, dd_url, cz_profilo, id_parent) 
values (11, 'Struttura', 'Struttura', '~/Questionari/FmStruttura.aspx', 3, 8);
-- Amministrazione
insert into z_funzione(id, dd_descrizione, dd_descr_breve, dd_url, cz_profilo) 
values (12, 'Amministrazione', 'Amministrazione', '', 4);
insert into z_funzione(id, dd_descrizione, dd_descr_breve, dd_url, cz_profilo, id_parent) 
values (13, 'Utenti', 'Utenti', '~/Amministrazione/FmUtenti.aspx', 4, 12);
-- insert into z_funzione(id, dd_descrizione, dd_descr_breve, dd_url, cz_profilo, id_parent) 
-- values (14, 'Profili', 'Profili', '~/Amministrazione/FmProfili.aspx', 4, 12);
insert into z_funzione(id, dd_descrizione, dd_descr_breve, dd_url, cz_profilo, id_parent) 
values (15, 'Log', 'Log', '~/Amministrazione/FmLog.aspx', 4, 12);
-- patologia
insert into t_patologia(id, dd_descrizione) values (1, 'Artrite reumatoide');
insert into t_patologia(id, dd_descrizione) values (2, 'Fibromialgia');
insert into t_patologia(id, dd_descrizione) values (3, 'Gonartrosi sintomatica');
-- stato civile
insert into t_stato_civile(id, dd_descrizione) values (1, 'Nubile/Celibe');
insert into t_stato_civile(id, dd_descrizione) values (2, 'Coniugata/Coniugato');
-- titolo di studio
insert into t_titolo(id, dd_descrizione) values (1, 'Nessuno');
insert into t_titolo(id, dd_descrizione) values (2, 'Licenza elementare');
insert into t_titolo(id, dd_descrizione) values (3, 'Licenza media inferiore');
insert into t_titolo(id, dd_descrizione) values (4, 'Licenza media superiore');
insert into t_titolo(id, dd_descrizione) values (5, 'Laurea');
insert into t_titolo(id, dd_descrizione) values (6, 'Specializzazione post/laurea');
-- pazienti
insert into a_paziente(id,cd_sesso,dd_cognome,dd_nome,ct_titolo,dt_nascita,cd_fiscale,ct_stato_civile,
dd_medico_nome, dd_medico_cognome, dd_medico_email, dd_medico_saluto, dd_foto)
values (1,'F','Marzano','Michela','6','1968-04-23T00:00:00','MRZMCH12F25G123A','2',
'Danilo', 'Montesi', 'danilo.montesi@gmail.com', 'Caro Dott. ', 'MichelaMarzano.jpeg');
insert into a_paziente(id,cd_sesso,dd_cognome,dd_nome,ct_titolo,dt_nascita,cd_fiscale,ct_stato_civile,
dd_medico_nome, dd_medico_cognome, dd_medico_email, dd_medico_saluto, dd_foto)
values (2,'M','Pollini','Maurizio','3','1956-09-24T00:00:00','PLLMRZ56F12G512A','2',
'Danilo', 'Montesi', 'danilo.montesi@gmail.com', 'Caro Dott. ', 'MaurizioPollini.jpeg');
insert into a_paziente(id,cd_sesso,dd_cognome,dd_nome,ct_titolo,dt_nascita,cd_fiscale,ct_stato_civile,
dd_medico_nome, dd_medico_cognome, dd_medico_email, dd_medico_saluto, dd_foto)
values (3,'F','Argerich','Martha','2','1957-11-14T00:00:00','ARGMRT57A14G452A','2',
'Danilo', 'Montesi', 'danilo.montesi@gmail.com', 'Caro Dott. ', 'MarthaArgerich.jpeg');
insert into a_paziente(id,cd_sesso,dd_cognome,dd_nome,ct_titolo,dt_nascita,cd_fiscale,ct_stato_civile,
dd_medico_nome, dd_medico_cognome, dd_medico_email, dd_medico_saluto, dd_foto)
values (4,'M','Ciccolini','Aldo','3','1982-12-27T00:00:00','CLNALD82A23G532A','1',
'Stefano', 'Farina', 'nicola.farina@teletu.it', 'Caro Dott. ', 'AldoCiccolini.jpeg');
insert into a_paziente(id,cd_sesso,dd_cognome,dd_nome,ct_titolo,dt_nascita,cd_fiscale,ct_stato_civile,
dd_medico_nome, dd_medico_cognome, dd_medico_email, dd_medico_saluto, dd_foto)
values (5,'F','Saraceno','Chiara','4','1964-05-22T00:00:00','SRCCHR64S23G532A','1',
'Stefano', 'Farina', 's.farina@hcrema.it', 'Caro Dott. ', 'ChiaraSaraceno.jpeg');
insert into a_paziente(id,cd_sesso,dd_cognome,dd_nome,ct_titolo,dt_nascita,cd_fiscale,ct_stato_civile,
dd_medico_nome, dd_medico_cognome, dd_medico_email, dd_medico_saluto, dd_foto)
values (6,'F','Hewitt','Angela','1','1980-08-09T00:00:00','HWTANG80A12G231A','1',
'Stefano', 'Farina', 'nicola.farina@teletu.it', 'Caro Dott. ', 'AngelaHewitt.jpeg');
insert into a_paziente(id,cd_sesso,dd_cognome,dd_nome,ct_titolo,dt_nascita,cd_fiscale,ct_stato_civile,
dd_medico_nome, dd_medico_cognome, dd_medico_email, dd_medico_saluto, dd_foto)
values (7,'F','Urbinati','Nadia','5','1984-05-18T00:00:00','URBNDI84A12G424D','2',
'Stefano', 'Farina', 'nicola.farina@teletu.it', 'Caro Dott. ', 'NadiaUrbinati.jpeg');

-- questionari - testata
insert into a_quest(id, dd_descr_breve, dd_descrizione) 
values (1, 'PRO-CLARA', 'PRO-Clinical Arthritis Activity (CLARA) Index');
-- questionari - sezioni
insert into a_quest_sezione(id, ca_quest, dd_descrizione1, dd_descrizione2, nr_num_scelte_possibili) 
values (1, 1, 'Recent-Onset Arthritis Disability (ROAD) Index', 'Nel corso dell''ultima settimana è stato in grado di: ', 5);
insert into a_quest_sezione(id, ca_quest, dd_descrizione1, dd_descrizione2, nr_num_scelte_possibili) 
values (2, 1, 'Autovalutazione articolazioni dolenti', 'Indichi l''entità del dolore che sente attualmente nell''articolazione indicata: ', 4);
insert into a_quest_sezione(id, ca_quest, dd_descrizione1, dd_descrizione2, nr_num_scelte_possibili) 
values (3, 1, 'Stato generale di salute', 'Indichi l''effetto che la malattia ha avuto sul suo stato generale di salute nel corso dell''ultima settimana: ', 11);
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
-- normalizza per risultati questionario
insert into z_normalizza(id, nr_coeff) 
values (1, 0.2);
insert into z_normalizza(id, nr_coeff) 
values (2, 0.4);
insert into z_normalizza(id, nr_coeff) 
values (3, 0.6);
insert into z_normalizza(id, nr_coeff) 
values (4, 0.8);
insert into z_normalizza(id, nr_coeff) 
values (5, 1.0);
insert into z_normalizza(id, nr_coeff) 
values (6, 1.3);
insert into z_normalizza(id, nr_coeff) 
values (7, 1.5);
insert into z_normalizza(id, nr_coeff) 
values (8, 1.7);
insert into z_normalizza(id, nr_coeff) 
values (9, 1.9);
insert into z_normalizza(id, nr_coeff) 
values (10, 2.1);
insert into z_normalizza(id, nr_coeff) 
values (11, 2.3);
insert into z_normalizza(id, nr_coeff) 
values (12, 2.5);
insert into z_normalizza(id, nr_coeff) 
values (13, 2.7);
insert into z_normalizza(id, nr_coeff) 
values (14, 2.9);
insert into z_normalizza(id, nr_coeff) 
values (15, 3.1);
insert into z_normalizza(id, nr_coeff) 
values (16, 3.3);
insert into z_normalizza(id, nr_coeff) 
values (17, 3.5);
insert into z_normalizza(id, nr_coeff) 
values (18, 3.8);
insert into z_normalizza(id, nr_coeff) 
values (19, 4.0);
insert into z_normalizza(id, nr_coeff) 
values (20, 4.2);
insert into z_normalizza(id, nr_coeff) 
values (21, 4.4);
insert into z_normalizza(id, nr_coeff) 
values (22, 4.6);
insert into z_normalizza(id, nr_coeff) 
values (23, 4.8);
insert into z_normalizza(id, nr_coeff) 
values (24, 5.0);
insert into z_normalizza(id, nr_coeff) 
values (25, 5.2);
insert into z_normalizza(id, nr_coeff) 
values (26, 5.4);
insert into z_normalizza(id, nr_coeff) 
values (27, 5.6);
insert into z_normalizza(id, nr_coeff) 
values (28, 5.8);
insert into z_normalizza(id, nr_coeff) 
values (29, 6.0);
insert into z_normalizza(id, nr_coeff) 
values (30, 6.3);
insert into z_normalizza(id, nr_coeff) 
values (31, 6.5);
insert into z_normalizza(id, nr_coeff) 
values (32, 6.7);
insert into z_normalizza(id, nr_coeff) 
values (33, 6.9);
insert into z_normalizza(id, nr_coeff) 
values (34, 7.1);
insert into z_normalizza(id, nr_coeff) 
values (35, 7.3);
insert into z_normalizza(id, nr_coeff) 
values (36, 7.5);
insert into z_normalizza(id, nr_coeff) 
values (37, 7.7);
insert into z_normalizza(id, nr_coeff) 
values (38, 7.9);
insert into z_normalizza(id, nr_coeff) 
values (39, 8.1);
insert into z_normalizza(id, nr_coeff) 
values (40, 8.3);
insert into z_normalizza(id, nr_coeff) 
values (41, 8.5);
insert into z_normalizza(id, nr_coeff) 
values (42, 8.8);
insert into z_normalizza(id, nr_coeff) 
values (43, 9.0);
insert into z_normalizza(id, nr_coeff) 
values (44, 9.2);
insert into z_normalizza(id, nr_coeff) 
values (45, 9.4);
insert into z_normalizza(id, nr_coeff) 
values (46, 9.6);
insert into z_normalizza(id, nr_coeff) 
values (47, 9.8);
insert into z_normalizza(id, nr_coeff) 
values (48, 10);





