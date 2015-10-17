DROP FUNCTION IF EXISTS insertTestataFAS;
DROP PROCEDURE IF EXISTS insertRigaFAS;
DROP PROCEDURE IF EXISTS insertWRigaFAS;
DROP FUNCTION IF EXISTS contaFASdiOggi;

DELIMITER $$

CREATE FUNCTION contaFASdiOggi(
  caPaziente int
) returns int
begin
  declare ctr int;
  
  select count(*)
    into ctr
    from m_quest
   where ca_paziente = caPaziente
     and date(dt_now) = curdate(); 
  return ctr;
end
$$

CREATE FUNCTION insertTestataFAS(
  caPaziente int, 
  czUtente int
) returns int
begin
  declare idMQuestFas int;
  declare idQuestFas int;
  set idQuestFas = 2;
  
  -- Genera testata questionario
  select insertMQuest(idQuestFas, caPaziente, czUtente, now()) 
    into idMQuestFas;
    
  return idMQuestFas;
end
$$

create procedure insertRigaFAS(
  idTestata int,
  idDomanda int,
  iRisposta int
)
begin
  insert into m_quest_item(cm_quest, ca_quest_item, nr_scelta) 
       values (idTestata, idDomanda, iRisposta);
end
$$

create procedure insertWRigaFAS(
  czSessione char(32),
  idDomanda int,
  iRisposta int
)
begin
  insert into w_quest_item(cz_sessione, ca_quest_item, nr_scelta) 
       values (czSessione, idDomanda, iRisposta);
end
$$

create procedure saveWFAS(
)
begin
end
$$

DELIMITER ;