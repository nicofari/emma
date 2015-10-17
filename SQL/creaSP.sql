use Emma;

DROP PROCEDURE IF EXISTS CalcolaLettera;
DROP FUNCTION IF EXISTS CalcolaRisultato;
DROP FUNCTION IF EXISTS getRandomIdPaziente;
DROP FUNCTION IF EXISTS getRandomIdUtenteMedico;
DROP FUNCTION IF EXISTS insertMQuest;
DROP PROCEDURE IF EXISTS generaQuest;
DROP FUNCTION IF EXISTS getRandomDate;
DROP FUNCTION IF EXISTS getTestata;
DROP PROCEDURE IF EXISTS setTestata;
DROP FUNCTION IF EXISTS getLettera;
DROP PROCEDURE IF EXISTS setLettera;
DROP FUNCTION IF EXISTS getMailAddressMedico;
DROP FUNCTION IF EXISTS getNomeMedicoConSaluto;
DROP FUNCTION IF EXISTS getNomePazienteConSaluto;
DROP FUNCTION IF EXISTS getDescrSezione1;
DROP FUNCTION IF EXISTS getDescrSezione2;
DROP FUNCTION IF EXISTS getDescrQuest;
DROP FUNCTION IF EXISTS getDescrBreveQuest;

DELIMITER $$

CREATE FUNCTION getDescrQuest(idQuest int)
returns varchar(100)
DETERMINISTIC
begin
  declare sResult varchar(100);
  
  select aq.dd_descrizione
    into sResult
    from a_quest aq
   where aq.id = idQuest;
   
  return sResult;    
end
$$

CREATE FUNCTION getDescrBreveQuest(idQuest int)
returns varchar(50)
DETERMINISTIC
begin
  declare sResult varchar(50);
  
  select aq.dd_descr_breve
    into sResult
    from a_quest aq
   where aq.id = idQuest;
   
  return sResult;    
end
$$

CREATE FUNCTION getDescrSezione1(idSezione int)
returns varchar(255)
DETERMINISTIC
begin
  declare sResult varchar(255);
  
  select aqs.dd_descrizione1
    into sResult
    from a_quest_sezione aqs
   where aqs.id = idSezione;
   
  return sResult;    
end
$$

CREATE FUNCTION getDescrSezione2(idSezione int)
returns varchar(255)
DETERMINISTIC
begin
  declare sResult varchar(255);
  
  select aqs.dd_descrizione2
    into sResult
    from a_quest_sezione aqs
   where aqs.id = idSezione;
   
  return sResult;    
end
$$

CREATE FUNCTION getNomePazienteConSaluto(idMQuest int)
returns varchar(255)
DETERMINISTIC
begin
  declare sResult varchar(255);
  declare cdSesso varchar(1);
  declare ddNome varchar(50);
  declare ddCognome varchar(50);
  
  select ap.cd_sesso, ap.dd_cognome, ap.dd_nome
    into cdSesso, ddCognome, ddNome
    from a_paziente ap, m_quest mq
   where mq.id = idMQuest 
     and mq.ca_paziente = ap.id;
   
  if cdSesso = 'F' then
    select concat('sig.a ', ddNome, ' ', ddCognome)
      into sResult;
  else
    select concat('sig. ', ddNome, ' ', ddCognome)
      into sResult;
  end if;
  return sResult;    
end
$$

CREATE FUNCTION getNomeMedicoConSaluto(idMQuest int, iIncludiSaluto int)
returns varchar(255)
DETERMINISTIC
begin
  declare sResult varchar(255);
  
  if iIncludiSaluto = 1 then
    select concat(ap.dd_medico_saluto, ' ', ap.dd_medico_nome, ' ', ap.dd_medico_cognome)
      into sResult
      from a_paziente ap, m_quest mq
     where mq.id = idMQuest 
       and mq.ca_paziente = ap.id;
  else
    select concat(ap.dd_medico_nome, ' ', ap.dd_medico_cognome)
      into sResult
      from a_paziente ap, m_quest mq
     where mq.id = idMQuest 
       and mq.ca_paziente = ap.id;
  end if;
  return sResult;    
end
$$

CREATE FUNCTION getMailAddressMedico(idMQuest int)
returns varchar(50)
DETERMINISTIC
begin
  declare sResult varchar(50);
  
  select ap.dd_medico_email
    into sResult
    from a_paziente ap, m_quest mq
   where mq.id = idMQuest 
     and mq.ca_paziente = ap.id;
  return sResult;    
end
$$

CREATE FUNCTION getLettera(idMQuest int)
returns text
DETERMINISTIC
begin
  declare blTesto text;
  
  select bl_lettera
    into blTesto
    from m_quest
   where id = idMQuest;
  
  return blTesto;
end
$$

CREATE PROCEDURE setLettera(idMQuest int, blLettera text)
DETERMINISTIC
begin
  update m_quest
     set bl_lettera = blLettera
   where id = idMQuest;
end
$$

CREATE FUNCTION getTestata(idUtente int)
returns text
DETERMINISTIC
begin
  declare blTesto text;
  
  select bl_testo
    into blTesto
    from z_utente_testata_lettera
   where cz_utente = idUtente;
  
  return blTesto;
end
$$

CREATE PROCEDURE setTestata(idUtente int, blTesto text)
DETERMINISTIC
begin
  declare iCtr int;
  
  -- Verifica se esiste già il record per idUtente
  select count(*)
    into iCtr
    from z_utente_testata_lettera
   where cz_utente = idUtente;

  if iCtr = 0 then
    insert into z_utente_testata_lettera(cz_utente, bl_testo)
         values (idUtente, blTesto);
  else
    update z_utente_testata_lettera
       set bl_testo = blTesto
     where cz_utente = idUtente;
  end if;
  
end
$$

CREATE FUNCTION CalcolaRisultato (idMQuest int)
returns varchar(255)
DETERMINISTIC
begin
  declare rCoeff float;
  declare sResult varchar(255);
  declare iResult int;
  declare i int;
  set i = 1;
  set sResult = '';
  while i <= 3 
  do
    select sum(mqi.nr_scelta)
      into iResult
      from m_quest_item mqi, a_quest_item aqi
     where mqi.cm_quest = idMQuest 
       and mqi.ca_quest_item = aqi.id
       and aqi.ca_quest_sezione = i;
    
    -- L'ultima sezione si divide per 3
    if i = 3 then
      set rCoeff = iResult / 3;  
    else
    select nr_coeff
      into rCoeff
      from z_normalizza
     where id = iResult;
    end if;
    
    set sResult = concat(sResult, ' ', cast(rCoeff as char(10)));
    
    -- aggiorna i tre risultati delle tre sezioni del PRO-CLARA
    case i
      when 1 then
        update m_quest mq
           set mq.nr_risultato1 = rCoeff
         where mq.id = idMQuest;
      when 2 then
        update m_quest mq
           set mq.nr_risultato2 = rCoeff
         where mq.id = idMQuest;
      when 3 then
        update m_quest mq
           set mq.nr_risultato3 = rCoeff
         where mq.id = idMQuest;
    end case;
    set i = i + 1;   
  end while;
  return sResult;
END
$$

CREATE PROCEDURE CalcolaLettera (idMQuest int, idUtente int)
DETERMINISTIC
begin
  declare tempLettera text;
  declare cdSesso varchar(1);
  declare ddNome varchar(50);
  declare ddCognome varchar(50);
  declare ddMedicoNome varchar(50);
  declare ddMedicoCognome varchar(50);
  declare ddMedicoSaluto varchar(50);
  declare iAnnoCorr int;
  declare iAnnoNascita int;
  declare nrRisultato1 float;
  declare nrRisultato2 float;
  declare nrRisultato3 float;
  declare dtTest date;
  declare idAQuest int;  -- sarebbe una costante (1 il pro-clara)
  
  set idAQuest = 1;
  
  set tempLettera = '';
  
  -- Calcola età e saluto (sig. o sig.a)   
  select extract(year from dt_nascita), year(curdate()), cd_sesso, dd_nome, dd_cognome, 
         ifNull(dd_medico_nome, ''), ifNull(dd_medico_cognome,''), ifNull(dd_medico_saluto,'')
    into iAnnoNascita, iAnnoCorr, cdSesso, ddNome, ddCognome, 
         ddMedicoNome, ddMedicoCognome, ddMedicoSaluto
    from a_paziente ap, m_quest mq
   where mq.id = idMQuest
     and mq.ca_paziente = ap.id;

  -- Legge risultati test
  select dt_now, nr_risultato1, nr_risultato2, nr_risultato3
    into dtTest, nrRisultato1, nrRisultato2, nrRisultato3
    from m_quest
   where id = idMQuest;
   
  set tempLettera = concat(tempLettera, '\n\r\n\r', trim(ddMedicoSaluto), ' ', trim(ddMedicoCognome), '\n\r\n\r');
  set tempLettera = concat(tempLettera, 'In data ', date_format(dtTest, '%e/%m/%Y'), ' ho sottoposto ');
    
  if cdSesso = 'M' then
    set tempLettera = concat(tempLettera, ' il sig. ');
  else
    set tempLettera = concat(tempLettera, ' la sig. a ');
  end if;  
  -- Nome e cognome e età del paziente
  set tempLettera = concat(tempLettera, ddNome, ' ', ddCognome, ' di ', iAnnoCorr - iAnnoNascita, ' anni ');   
  
  -- Risultati test
  set tempLettera = concat(tempLettera, '\n\r\n\r',  
  'al test ', getDescrBreveQuest(idAQuest), '(', getDescrQuest(idAQuest), ') e i risultati sono stati i seguenti : ', '\n\r\n\r');
  
  set tempLettera = concat(tempLettera, 'sezione 1 (', getDescrSezione1(1), ') : ', cast(nrRisultato1 as char(10)), '\n\r\n\r');
  set tempLettera = concat(tempLettera, 'sezione 2 (', getDescrSezione1(2), ') : ', cast(nrRisultato2 as char(10)), '\n\r\n\r');
  set tempLettera = concat(tempLettera, 'sezione 3 (', getDescrSezione1(3), ') : ', cast(nrRisultato3 as char(10)), '\n\r\n\r');
  
  -- Salva lettera costruita in m_quest
  update m_quest
     set bl_lettera = tempLettera
   where id = idMQuest;
end
$$

CREATE FUNCTION getRandomIdPaziente() returns int
begin
  declare idResult int;
  
  select id 
    into idResult
    from a_paziente
   order by rand() limit 1;
  return idResult;
end
$$

CREATE FUNCTION getRandomIdUtenteMedico() returns int
begin
  declare idResult int;
  
  select id 
    into idResult
    from z_utente
   where id <= 4 -- prende solo utenti "medici"
   order by rand() limit 1;
  return idResult;
end
$$

-- Crea nuovo record in M_QUEST e ritorna l'id generato
CREATE FUNCTION insertMQuest(caQuest int, caPaziente int, czUtente int, dtQuest datetime) returns int
begin
  declare idLast int;
  insert into m_quest(ca_quest, ca_paziente, dt_now, cz_utente) 
       values (caQuest, caPaziente, dtQuest, czUtente);
  select last_insert_id()
    into idLast;
  return idLast;
end
$$

-- Costruisce una data partendo dall'1/1 dell'anno corrente
-- e aggiungendo un giorno random
CREATE FUNCTION getRandomDate() returns datetime
begin
  declare iDd int;
  declare dtFirst datetime;
  declare dtResult datetime;
  
  set iDd = floor(rand()*365);
  select date_format(now(), '%Y-1-1')
    into dtFirst;
  
  select date_add(dtFirst, interval iDd day)
    into dtResult;
  return dtResult;
end
$$

-- Genera iNumQuest questionari scegliendo un paziente e un utente random (e random anche le risposte)
CREATE PROCEDURE generaQuest(iNumQuest int, idAQuest int)
begin
  declare i int;
  declare idPaziente int;
  declare idUtente int;
  declare idMQuest int;
  declare iSezione int;
  declare nrScelte int;
  declare ddRisultato varchar(255);
  
  set i = 1;
  
  while i <= iNumQuest
  do
    -- Determina id paziente
    select getRandomIdPaziente() into idPaziente;
    -- Id utente
    select getRandomIdUtenteMedico() into idUtente;
    -- Genera testata questionario
    select insertMQuest(idAQuest, idPaziente, idUtente, getRandomDate()) into idMQuest;

    set iSezione = 1;
    
    -- Loop sulle sezioni del questionario Clara per inserire le risposte
    while iSezione <= 3 
    do
      select nr_num_scelte_possibili
        into nrScelte
        from a_quest_sezione
       where id = iSezione;
         
      insert into m_quest_item(cm_quest, ca_quest_item, nr_scelta) 
      select idMQuest, id, floor(rand() * nrScelte)
        from a_quest_item
       where ca_quest = idAQuest and ca_quest_sezione = iSezione;
      
      set iSezione = iSezione + 1;
    end while; 
  
    -- Calcola i risultati
    select CalcolaRisultato(idMQuest)
      into ddRisultato;
      
    update m_quest 
    set dd_risultato = ddRisultato
    where id = idMQuest;
    
    -- Costruisce la lettera 
    call CalcolaLettera(idMQuest, idUtente);
    
    -- Passa al questionario successivo
    set i = i + 1;
  end while;
end
$$

DELIMITER ;
