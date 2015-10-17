use emma;
drop table w_quest_item;
CREATE TABLE w_quest_item
(
  id integer not null auto_increment,  
  cz_sessione char(32) not null,
  ca_quest_item integer not null,
  nr_scelta integer,
  primary key(id)  
);
alter table w_quest_item add constraint fk_w_quest_item_2 foreign key (ca_quest_item) references a_quest_item(id);
alter table w_quest_item add constraint fk_w_quest_item_1 foreign key (cz_sessione) references z_sessione(id);
