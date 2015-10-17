DROP FUNCTION IF EXISTS apriQuestionario;
DROP PROCEDURE IF EXISTS chiudiQuestionario;
DROP PROCEDURE IF EXISTS insertRisposta;
DROP FUNCTION IF EXISTS contaQuestionariChiusiOggi;

DELIMITER $$

-- Crea nuovo record in M_QUEST e ritorna l'id generato
CREATE FUNCTION apriQuestionario(Questionario_id int, Session_id varchar(40), Persona_id int) returns int
begin
  declare idLast int;
  insert into Questionario_compilato(Questionario_id, Session_id, Persona_id) 
       values (Questionario_id, Session_id, Persona_id);
  select last_insert_id()
    into idLast;
  return idLast;
end
$$

create procedure chiudiQuestionario(Questionario_compilato_id int)
begin
  update Questionario_compilato
     set Chiuso_il = current_timestamp
   where Questionario_compilato_id = Questionario_compilato_id;
end
$$

CREATE FUNCTION contaQuestionariChiusiOggi(
  Questionario_id int, 
  Persona_id int
) returns int
begin
  declare ctr int;
  
  select count(*)
    into ctr
    from Questionario_compilato
   where Persona_id = Persona_id
     and Questionario_id = Questionario_id
     and date(Aperto_il) = curdate() 
     and Chiuso_il is not null;
  return ctr;
end
$$

create procedure insertRisposta(
  Questionario_compilato_id int,
  Questionario_domanda_id int,
  Scelta int
)
begin
  insert into Questionario_Risposta(Questionario_compilato_id, Questionario_domanda_id, Scelta) 
       values (Questionario_compilato_id, Questionario_domanda_id, Scelta);
end
$$

DELIMITER ;