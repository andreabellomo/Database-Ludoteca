-- Struttura della tabella animatore

CREATE TABLE animatore (
  id_animatore int(11) NOT NULL,
   PRIMARY KEY (id_animatore)
);

-- Struttura della tabella catering

CREATE TABLE catering (
  id_catering int(11) NOT NULL,
 PRIMARY KEY (id_catering)
);

-- Struttura della tabella cliente

CREATE TABLE cliente (
  cod_fiscale varchar(25) NOT NULL,
  nome varchar(50) NOT NULL,
  cognome varchar(50) NOT NULL,
  indirizzo varchar(100) NOT NULL,
  citta varchar(100) NOT NULL,
  cap varchar(6) NOT NULL,
  n_cellulare varchar(15) NOT NULL,
  pagamento varchar(50) NOT NULL,
   PRIMARY KEY (cod_fiscale)
) 

-- Struttura della tabella festa

CREATE TABLE festa (
  id_festa int(11) NOT NULL,
  num_partecipanti int(11) NOT NULL,
  prenota int(11) NOT NULL,
  pacchetto varchar(50) NOT NULL,
  PRIMARY KEY (id_festa),
  FOREIGN KEY (pacchetto) REFERENCES pacchetto (codice),
  FOREIGN KEY (prenota) REFERENCES prenotazione (id_prenotazione)

)

-- Struttura della tabella giochi

CREATE TABLE giochi (
  id_gioco int(11) NOT NULL,
  eta_minima int(11) NOT NULL,
  tipologia varchar(50) NOT NULL
   PRIMARY KEY (id_gioco)
)

-- Struttura della tabella gioco

CREATE TABLE gioco (
  num_gioco int(11) NOT NULL,
  tipologia int(11) NOT NULL,
  sala int(11) NOT NULL,
  disponibile tinyint(1) NOT NULL,
  costo int(11) NOT NULL,
  PRIMARY KEY (num_gioco),
  FOREIGN KEY (tipologia) REFERENCES giochi (id_gioco),
  FOREIGN KEY (sala) REFERENCES sale (codice_sala)
) 

-- Struttura della tabella invitati

CREATE TABLE invitati (
  cod_fiscale varchar(50) NOT NULL,
  nome varchar(50) NOT NULL,
  cognome varchar(50) NOT NULL,
  indirizzo varchar(50) NOT NULL,
  citta varchar(50) NOT NULL,
  cap varchar(6) NOT NULL,
PRIMARY KEY (cod_fiscale)
) 

-- Struttura della tabella pacchetto

CREATE TABLE pacchetto (
  codice varchar(50) NOT NULL,
  costo_totale int(11) NOT NULL,
  animatore int(11) NOT NULL,
  catering int(11) NOT NULL,
  PRIMARY KEY (codice),
  FOREIGN KEY (animatore) REFERENCES animatore (id_animatore),
  FOREIGN KEY (catering) REFERENCES catering (id_catering)
) 

-- Struttura della tabella partecipano

CREATE TABLE partecipano (
  festa int(11) NOT NULL,
  invitato varchar(50) NOT NULL,
  PRIMARY KEY (festa,invitato),
  FOREIGN KEY (festa) REFERENCES festa (id_festa),
  FOREIGN KEY (invitato) REFERENCES invitati (cod_fiscale)
) 

-- Struttura della tabella prenotazione

CREATE TABLE prenotazione (
  id_prenotazione int(11) NOT NULL,
  ora_inizio int(11) NOT NULL,
  ora_fine int(11) NOT NULL,
  conto_totale int(11),
  data int(11) NOT NULL,
  cliente varchar(25) NOT NULL,
  sala int(11) NOT NULL,
  PRIMARY KEY (id_prenotazione,ora_inizio,ora_fine),
  FOREIGN KEY (cliente) REFERENCES cliente (cod_fiscale),
  FOREIGN KEY (sala) REFERENCES sale (codice_sala);
) 

-- Struttura della tabella sale

CREATE TABLE sale (
  codice_sala int(11) NOT NULL,
  capacita int(11) NOT NULL,
  disponibile tinyint(1) NOT NULL,
  costo int(11) NOT NULL,
  PRIMARY KEY (codice_sala);
) 

ALTER TABLE festa
ADD UNIQUE KEY prenota (prenota)

OP1:
INSERT INTO cliente (cod_fiscale,nome,cognome ,indirizzo ,citta ,cap ,n_cellulare ,pagamento)
VALUES ('bllndr00s29b602f','andrea','bellomo','via petrone','racalmuto','92020','3291731161','contanti');


OP2 : 
UPDATE cliente
set n_cellulare = '3291730161' 
where cod_fiscale = 'bllndr00s29b602f'


OP3 : 
select id_festa
from festa , pacchetto
where  festa.pacchetto = pacchetto.codice AND
       pacchetto.animatore is not null AND pacchetto.catering is not null

OP4 : 
select num_partecipanti
from festa 
where id_festa = 1234

OP5:
INSERT INTO invitati (cod_fiscale,nome,cognome ,indirizzo ,citta ,cap)
VALUES ('bdlfrv00s23b605f','gianni','celeste','via petrone','napoli','92020');

06 : 
select prenotazione.conto_totale , festa.id_festa
from prenotazione, festa
where prenotazione.id_prenotazione = festa.id_festa 

07




trigger

create trigger 
after update on festa
FOR EACH ROW
begin

if( new.festa_finita == true and not exist(select*
from prenotazione
where id_prenotazione = new.id_festa and prenotazione.conto_totale is null
))
update on prenotazione
set conto_totale = ( select costo_totale from pacchetto
                     where codice = new.pacchetto) + (select costo
						       from sala , prenotazione 
							where sala.codice_sala = prenotazione.sala and prenotazione.id_prenotazione = new.id_festa)+

select costo
from gioco,sala, prenotazione
where gioco.sala = sala.codice_sala and sala.codice_sala = prenotazione.sala and prenotazione.id_prenotazione = new.id_festa)







POPOLATO

INSERT INTO cliente (cod_fiscale,nome,cognome ,indirizzo ,citta ,cap ,n_cellulare ,pagamento)
VALUES ('BGHJDK3429FGJ','FILIPPO','forte','via garibaldi','agrigento','92100','32456432','contanti');

INSERT INTO cliente (cod_fiscale,nome,cognome ,indirizzo ,citta ,cap ,n_cellulare ,pagamento)
VALUES ('SCCGTN09A03A662S','gaetano','sacco','via della vittoria','favara','92100','32456432','contanti');

INSERT INTO cliente (cod_fiscale,nome,cognome ,indirizzo ,citta ,cap ,n_cellulare ,pagamento)
VALUES ('MRNRNG07P60A662M','arcangela','mariana','cortile magenda','grotte','92100','32456432','contanti');

INSERT INTO cliente (cod_fiscale,nome,cognome ,indirizzo ,citta ,cap ,n_cellulare ,pagamento)
VALUES ('CRLBRS04P03L736K','boris','carella','cortile manta','favara','92100','32456432','contanti');

INSERT INTO cliente (cod_fiscale,nome,cognome ,indirizzo ,citta ,cap ,n_cellulare ,pagamento)
VALUES ('PRCRLD04B14D612K','rinaldo','porcu','via della vittoria','favara','92100','32456432','contanti');

INSERT INTO cliente (cod_fiscale,nome,cognome ,indirizzo ,citta ,cap ,n_cellulare ,pagamento)
VALUES ('GRSBDT02B67F839P','benedetta','grossi','via della vittoria','favara','92100','32456432','contanti');
 






INSERT INTO invitati (cod_fiscale,nome,cognome ,indirizzo ,citta ,cap )
VALUES ('BGHJDK3429FGJ','FILIPPO','forte','via garibaldi','agrigento','92100');

INSERT INTO invitati (cod_fiscale,nome,cognome ,indirizzo ,citta ,cap )
VALUES ('SCCGTN09A03A662S','gaetano','sacco','via della vittoria','favara','92100');

INSERT INTO invitati(cod_fiscale,nome,cognome ,indirizzo ,citta ,cap )
VALUES ('MRNRNG07P60A662M','arcangela','mariana','cortile magenda','grotte','92100');

INSERT INTO invitati(cod_fiscale,nome,cognome ,indirizzo ,citta ,cap )
VALUES ('CRLBRS04P03L736K','boris','carella','cortile manta','favara','92100');

INSERT INTO invitati(cod_fiscale,nome,cognome ,indirizzo ,citta ,cap )
VALUES ('PRCRLD04B14D612K','rinaldo','porcu','via della vittoria','favara','92100');

INSERT INTO invitati (cod_fiscale,nome,cognome ,indirizzo ,citta ,cap )
VALUES ('GRSBDT02B67F839P','benedetta','grossi','via della vittoria','favara','92100');
 

INSERT INTO invitati (cod_fiscale,nome,cognome ,indirizzo ,citta ,cap )
VALUES ('ltzgtn08a0662e','FILIPPO','forte','via garibaldi','agrigento','92100');

INSERT INTO invitati (cod_fiscale,nome,cognome ,indirizzo ,citta ,cap ,)
VALUES ('bllflv09p65432m','gaetano','sacco','via della vittoria','favara','92100');

INSERT INTO invitati(cod_fiscale,nome,cognome ,indirizzo ,citta ,cap )
VALUES ('gnrfdt032f9b2f','arcangela','mariana','cortile magenda','grotte','92100');

INSERT INTO invitati(cod_fiscale,nome,cognome ,indirizzo ,citta ,cap )
VALUES ('brLBRS04P03L736K','boris','carella','cortile manta','favara','92100');

INSERT INTO invitati(cod_fiscale,nome,cognome ,indirizzo ,citta ,cap )
VALUES ('frCRLD04B14D612K','rinaldo','porcu','via della vittoria','favara','92100');

INSERT INTO invitati (cod_fiscale,nome,cognome ,indirizzo ,citta ,cap )
VALUES ('TSBDT02B67F839P','benedetta','grossi','via della vittoria','favara','92100');



INSERT INTO sale (codice_sala,capacita ,disponibile ,costo)
VALUES (1, 400 , 1 , 250 );

INSERT INTO sale (codice_sala,capacita ,disponibile ,costo)
VALUES (2, 200 , 0 , 150 );

INSERT INTO sale (codice_sala,capacita ,disponibile ,costo)
VALUES (3, 50 , 1 , 100 );

INSERT INTO sale (codice_sala,capacita ,disponibile ,costo)
VALUES (4, 150 , 0 , 200 );

INSERT INTO sale (codice_sala,capacita ,disponibile ,costo)
VALUES (5, 500 , 1 , 300 );

INSERT INTO sale (codice_sala,capacita ,disponibile ,costo)
VALUES (6, 800 , 0 , 400 );





INSERT INTO giochi (id_gioco, eta_minima, tipologia)
VALUES (1, 8, 'scivolo');
 
INSERT INTO giochi (id_gioco, eta_minima, tipologia)
VALUES (2, 5, 'casetta');

INSERT INTO giochi (id_gioco, eta_minima, tipologia)
VALUES (3, 8, 'bolle');

INSERT INTO giochi (id_gioco, eta_minima, tipologia)
VALUES (4, 11, 'freccette');

INSERT INTO giochi (id_gioco, eta_minima, tipologia)
VALUES (5, 3, 'bambole');



INSERT INTO animatore (id_animatore)
VALUES (01);
INSERT INTO animatore (id_animatore)
VALUES (02);
INSERT INTO animatore (id_animatore)
VALUES (03);
INSERT INTO animatore (id_animatore)
VALUES (04);
INSERT INTO animatore (id_animatore)
VALUES (05);
INSERT INTO animatore (id_animatore)
VALUES (06);
INSERT INTO animatore (id_animatore)
VALUES (07);
INSERT INTO animatore (id_animatore)
VALUES (08);
 

INSERT INTO catering (id_catering)
VALUES (01);
INSERT INTO catering (id_catering)
VALUES (02);
INSERT INTO catering (id_catering)
VALUES (03);
INSERT INTO catering (id_catering)
VALUES (04);
INSERT INTO catering (id_catering)
VALUES (05);
INSERT INTO catering (id_catering)
VALUES (06);
INSERT INTO catering (id_catering)
VALUES (07);



INSERT INTO prenotazione ( id_prenotazione ,ora_inizio ,ora_fine ,conto_totale ,data,cliente ,sala)
VALUES (01, 1700, 1900, null,20112000,'MRNRNG07P60A662M',1)

INSERT INTO prenotazione ( id_prenotazione ,ora_inizio ,ora_fine ,conto_totale ,data,cliente ,sala)
VALUES (02, 1700, 1900, null,23122000,'MRNRNG07P60A662M',1)

INSERT INTO prenotazione ( id_prenotazione ,ora_inizio ,ora_fine ,conto_totale ,data,cliente ,sala)
VALUES (04, 1700, 1900, null,24082000,'bllflv09p65432m',4)


INSERT INTO prenotazione ( id_prenotazione ,ora_inizio ,ora_fine ,conto_totale ,data,cliente ,sala)
VALUES (05, 0900, 1000, null,19022000,'PRCRLD04B14D612K',3)

INSERT INTO prenotazione ( id_prenotazione ,ora_inizio ,ora_fine ,conto_totale ,data,cliente ,sala)
VALUES (06, 1200, 1400, null,17052000,'PRCRLD04B14D612K',4)


INSERT INTO prenotazione ( id_prenotazione ,ora_inizio ,ora_fine ,conto_totale ,data,cliente ,sala)
VALUES (07, 0900, 1000, null,19022000,'PRCRLD04B14D612K',3)

INSERT INTO prenotazione ( id_prenotazione ,ora_inizio ,ora_fine ,conto_totale ,data,cliente ,sala)
VALUES (08, 1200, 1400, null,17052000,'PRCRLD04B14D612K',4)



CREATE TRIGGER `t1` BEFORE UPDATE ON `festa` FOR EACH ROW if( new.festa_finita = true and EXISTS(select* from prenotazione where id_prenotazione = new.id_festa and prenotazione.conto_totale is null )) THEN update prenotazione set conto_totale = (( select costo_totale from pacchetto where codice = new.pacchetto) + (select costo from sala, prenotazione where sala.codice_sala = prenotazione.sala and prenotazione.id_prenotazione = new.id_festa) + (select costo from gioco,sala, prenotazione where gioco.sala = sala.codice_sala and sala.codice_sala = prenotazione.sala and prenotazione.id_prenotazione = new.id_festa)); END IF



