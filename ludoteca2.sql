-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mar 22, 2021 alle 17:31
-- Versione del server: 10.4.17-MariaDB
-- Versione PHP: 8.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ludoteca2`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `animatore`
--

CREATE TABLE `animatore` (
  `id_animatore` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `animatore`
--

INSERT INTO `animatore` (`id_animatore`) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8);

-- --------------------------------------------------------

--
-- Struttura della tabella `catering`
--

CREATE TABLE `catering` (
  `id_catering` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `catering`
--

INSERT INTO `catering` (`id_catering`) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7);

-- --------------------------------------------------------

--
-- Struttura della tabella `cliente`
--

CREATE TABLE `cliente` (
  `cod_fiscale` varchar(25) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `cognome` varchar(50) NOT NULL,
  `indirizzo` varchar(100) NOT NULL,
  `citta` varchar(100) NOT NULL,
  `cap` varchar(6) NOT NULL,
  `n_cellulare` varchar(15) NOT NULL,
  `pagamento` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `cliente`
--

INSERT INTO `cliente` (`cod_fiscale`, `nome`, `cognome`, `indirizzo`, `citta`, `cap`, `n_cellulare`, `pagamento`) VALUES
('BGHJDK3429FGJ', 'FILIPPO', 'forte', 'via garibaldi', 'agrigento', '92100', '32456432', 'contanti'),
('bllndr00s29b602f', 'andrea', 'bellomo', 'via petrone', 'racalmuto', '92020', '3291730161', 'contanti'),
('CRLBRS04P03L736K', 'boris', 'carella', 'cortile manta', 'favara', '92100', '32456432', 'contanti'),
('GRSBDT02B67F839P', 'benedetta', 'grossi', 'via della vittoria', 'favara', '92100', '32456432', 'contanti'),
('MRNRNG07P60A662M', 'arcangela', 'mariana', 'cortile magenda', 'grotte', '92100', '32456432', 'contanti'),
('PRCRLD04B14D612K', 'rinaldo', 'porcu', 'via della vittoria', 'favara', '92100', '32456432', 'contanti'),
('SCCGTN09A03A662S', 'gaetano', 'sacco', 'via della vittoria', 'favara', '92100', '32456432', 'contanti');

-- --------------------------------------------------------

--
-- Struttura della tabella `festa`
--

CREATE TABLE `festa` (
  `id_festa` int(11) NOT NULL,
  `num_partecipanti` int(11) NOT NULL,
  `prenota` int(11) NOT NULL,
  `pacchetto` varchar(50) NOT NULL,
  `festa_finita` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `festa`
--

INSERT INTO `festa` (`id_festa`, `num_partecipanti`, `prenota`, `pacchetto`, `festa_finita`) VALUES
(1, 300, 1, 'P3', 0),
(2, 300, 7, 'P4', 0),
(4, 567, 5, 'P1', 0),
(234, 300, 6, 'P5', 1),
(1234, 300, 2, 'P4', 0);

--
-- Trigger `festa`
--
DELIMITER $$
CREATE TRIGGER `t1` BEFORE UPDATE ON `festa` FOR EACH ROW if( new.festa_finita = true and EXISTS(select*
from prenotazione
where id_prenotazione = new.id_festa and prenotazione.conto_totale is null
))
THEN
update prenotazione
set conto_totale = (( select costo_totale from pacchetto
where codice = new.pacchetto) + 
(select costo
from sala, prenotazione 
where sala.codice_sala = prenotazione.sala and prenotazione.id_prenotazione = new.id_festa) +

(select costo
from gioco,sala, prenotazione
where gioco.sala = sala.codice_sala and sala.codice_sala = prenotazione.sala and prenotazione.id_prenotazione = new.id_festa));
END IF
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `t2` BEFORE UPDATE ON `festa` FOR EACH ROW if( new.festa_finita = true and EXISTS(select*
from prenotazione
where id_prenotazione = new.id_festa))
THEN
update sale
set disponibile = true;
END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `giochi`
--

CREATE TABLE `giochi` (
  `id_gioco` int(11) NOT NULL,
  `eta_minima` int(11) NOT NULL,
  `tipologia` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `giochi`
--

INSERT INTO `giochi` (`id_gioco`, `eta_minima`, `tipologia`) VALUES
(1, 8, 'scivolo'),
(2, 5, 'casetta'),
(3, 8, 'bolle'),
(4, 11, 'freccette'),
(5, 3, 'bambole');

-- --------------------------------------------------------

--
-- Struttura della tabella `gioco`
--

CREATE TABLE `gioco` (
  `num_gioco` int(11) NOT NULL,
  `tipologia` int(11) NOT NULL,
  `sala` int(11) NOT NULL,
  `disponibile` tinyint(1) NOT NULL,
  `costo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `invitati`
--

CREATE TABLE `invitati` (
  `cod_fiscale` varchar(50) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `cognome` varchar(50) NOT NULL,
  `indirizzo` varchar(50) NOT NULL,
  `citta` varchar(50) NOT NULL,
  `cap` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `invitati`
--

INSERT INTO `invitati` (`cod_fiscale`, `nome`, `cognome`, `indirizzo`, `citta`, `cap`) VALUES
('bdlfrv00s23b605f', 'gianni', 'celeste', 'via petrone', 'napoli', '92020'),
('BGHJDK3429FGJ', 'FILIPPO', 'forte', 'via garibaldi', 'agrigento', '92100'),
('bllflv09p65432m', 'gaetano', 'sacco', 'via della vittoria', 'favara', '92100'),
('brLBRS04P03L736K', 'boris', 'carella', 'cortile manta', 'favara', '92100'),
('CRLBRS04P03L736K', 'boris', 'carella', 'cortile manta', 'favara', '92100'),
('frCRLD04B14D612K', 'rinaldo', 'porcu', 'via della vittoria', 'favara', '92100'),
('gnrfdt032f9b2f', 'arcangela', 'mariana', 'cortile magenda', 'grotte', '92100'),
('GRSBDT02B67F839P', 'benedetta', 'grossi', 'via della vittoria', 'favara', '92100'),
('ltzgtn08a0662e', 'FILIPPO', 'forte', 'via garibaldi', 'agrigento', '92100'),
('MRNRNG07P60A662M', 'arcangela', 'mariana', 'cortile magenda', 'grotte', '92100'),
('PRCRLD04B14D612K', 'rinaldo', 'porcu', 'via della vittoria', 'favara', '92100'),
('SCCGTN09A03A662S', 'gaetano', 'sacco', 'via della vittoria', 'favara', '92100'),
('TSBDT02B67F839P', 'benedetta', 'grossi', 'via della vittoria', 'favara', '92100');

-- --------------------------------------------------------

--
-- Struttura della tabella `pacchetto`
--

CREATE TABLE `pacchetto` (
  `codice` varchar(50) NOT NULL,
  `costo_totale` int(11) NOT NULL,
  `animatore` int(11) NOT NULL,
  `catering` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `pacchetto`
--

INSERT INTO `pacchetto` (`codice`, `costo_totale`, `animatore`, `catering`) VALUES
('P1', 300, 1, 2),
('P2', 400, 4, 2),
('P3', 450, 3, 6),
('P4', 678, 4, 2),
('P5', 345, 3, 2),
('P6', 656, 4, 3);

-- --------------------------------------------------------

--
-- Struttura della tabella `partecipano`
--

CREATE TABLE `partecipano` (
  `festa` int(11) NOT NULL,
  `invitato` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `partecipano`
--

INSERT INTO `partecipano` (`festa`, `invitato`) VALUES
(1, 'brLBRS04P03L736K'),
(2, 'MRNRNG07P60A662M'),
(4, 'bdlfrv00s23b605f'),
(234, 'CRLBRS04P03L736K'),
(1234, 'BGHJDK3429FGJ');

-- --------------------------------------------------------

--
-- Struttura della tabella `prenotazione`
--

CREATE TABLE `prenotazione` (
  `id_prenotazione` int(11) NOT NULL,
  `ora_inizio` int(11) NOT NULL,
  `ora_fine` int(11) NOT NULL,
  `conto_totale` int(11) DEFAULT NULL,
  `data` int(11) NOT NULL,
  `cliente` varchar(25) NOT NULL,
  `sala` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `prenotazione`
--

INSERT INTO `prenotazione` (`id_prenotazione`, `ora_inizio`, `ora_fine`, `conto_totale`, `data`, `cliente`, `sala`) VALUES
(1, 1700, 1900, NULL, 20112000, 'MRNRNG07P60A662M', 1),
(2, 1700, 1900, NULL, 23122000, 'MRNRNG07P60A662M', 1),
(5, 900, 1000, NULL, 19022000, 'PRCRLD04B14D612K', 3),
(6, 1200, 1400, NULL, 17052000, 'PRCRLD04B14D612K', 4),
(7, 900, 1000, NULL, 19022000, 'PRCRLD04B14D612K', 3),
(8, 1200, 1400, NULL, 17052000, 'PRCRLD04B14D612K', 4);

-- --------------------------------------------------------

--
-- Struttura della tabella `sale`
--

CREATE TABLE `sale` (
  `codice_sala` int(11) NOT NULL,
  `capacita` int(11) NOT NULL,
  `disponibile` tinyint(1) NOT NULL,
  `costo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `sale`
--

INSERT INTO `sale` (`codice_sala`, `capacita`, `disponibile`, `costo`) VALUES
(1, 400, 1, 250),
(2, 200, 0, 150),
(3, 50, 1, 100),
(4, 150, 0, 200),
(5, 500, 1, 300),
(6, 800, 0, 400);

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `animatore`
--
ALTER TABLE `animatore`
  ADD PRIMARY KEY (`id_animatore`);

--
-- Indici per le tabelle `catering`
--
ALTER TABLE `catering`
  ADD PRIMARY KEY (`id_catering`);

--
-- Indici per le tabelle `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`cod_fiscale`);

--
-- Indici per le tabelle `festa`
--
ALTER TABLE `festa`
  ADD PRIMARY KEY (`id_festa`),
  ADD UNIQUE KEY `prenota` (`prenota`),
  ADD KEY `pacchetto` (`pacchetto`);

--
-- Indici per le tabelle `giochi`
--
ALTER TABLE `giochi`
  ADD PRIMARY KEY (`id_gioco`);

--
-- Indici per le tabelle `gioco`
--
ALTER TABLE `gioco`
  ADD PRIMARY KEY (`num_gioco`),
  ADD KEY `tipologia` (`tipologia`),
  ADD KEY `sala` (`sala`);

--
-- Indici per le tabelle `invitati`
--
ALTER TABLE `invitati`
  ADD PRIMARY KEY (`cod_fiscale`);

--
-- Indici per le tabelle `pacchetto`
--
ALTER TABLE `pacchetto`
  ADD PRIMARY KEY (`codice`),
  ADD KEY `animatore` (`animatore`),
  ADD KEY `catering` (`catering`);

--
-- Indici per le tabelle `partecipano`
--
ALTER TABLE `partecipano`
  ADD PRIMARY KEY (`festa`,`invitato`),
  ADD KEY `invitato` (`invitato`);

--
-- Indici per le tabelle `prenotazione`
--
ALTER TABLE `prenotazione`
  ADD PRIMARY KEY (`id_prenotazione`,`ora_inizio`,`ora_fine`),
  ADD KEY `cliente` (`cliente`),
  ADD KEY `sala` (`sala`);

--
-- Indici per le tabelle `sale`
--
ALTER TABLE `sale`
  ADD PRIMARY KEY (`codice_sala`);

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `festa`
--
ALTER TABLE `festa`
  ADD CONSTRAINT `festa_ibfk_1` FOREIGN KEY (`pacchetto`) REFERENCES `pacchetto` (`codice`),
  ADD CONSTRAINT `festa_ibfk_2` FOREIGN KEY (`prenota`) REFERENCES `prenotazione` (`id_prenotazione`);

--
-- Limiti per la tabella `gioco`
--
ALTER TABLE `gioco`
  ADD CONSTRAINT `gioco_ibfk_1` FOREIGN KEY (`tipologia`) REFERENCES `giochi` (`id_gioco`),
  ADD CONSTRAINT `gioco_ibfk_2` FOREIGN KEY (`sala`) REFERENCES `sale` (`codice_sala`);

--
-- Limiti per la tabella `pacchetto`
--
ALTER TABLE `pacchetto`
  ADD CONSTRAINT `pacchetto_ibfk_1` FOREIGN KEY (`animatore`) REFERENCES `animatore` (`id_animatore`),
  ADD CONSTRAINT `pacchetto_ibfk_2` FOREIGN KEY (`catering`) REFERENCES `catering` (`id_catering`);

--
-- Limiti per la tabella `partecipano`
--
ALTER TABLE `partecipano`
  ADD CONSTRAINT `partecipano_ibfk_1` FOREIGN KEY (`festa`) REFERENCES `festa` (`id_festa`),
  ADD CONSTRAINT `partecipano_ibfk_2` FOREIGN KEY (`invitato`) REFERENCES `invitati` (`cod_fiscale`);

--
-- Limiti per la tabella `prenotazione`
--
ALTER TABLE `prenotazione`
  ADD CONSTRAINT `prenotazione_ibfk_1` FOREIGN KEY (`cliente`) REFERENCES `cliente` (`cod_fiscale`),
  ADD CONSTRAINT `prenotazione_ibfk_2` FOREIGN KEY (`sala`) REFERENCES `sale` (`codice_sala`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
