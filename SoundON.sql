CREATE SCHEMA IF NOT EXISTS `SoundON`;
USE `SoundON`;



CREATE TABLE IF NOT EXISTS `SoundON`.`Stato` (
	`idStato` INT AUTO_INCREMENT PRIMARY KEY,
	`Nome` VARCHAR(45) NOT NULL
);



CREATE TABLE IF NOT EXISTS `SoundON`.`Città` (
	`idCittà` INT AUTO_INCREMENT PRIMARY KEY,
	`Nome` VARCHAR(45) NOT NULL,
	`Stato` INT NOT NULL,
	FOREIGN KEY (`Stato`) REFERENCES `SoundON`.`Stato` (`idStato`)
);



CREATE TABLE IF NOT EXISTS `SoundON`.`Artista` (
	`idArtista` INT AUTO_INCREMENT PRIMARY KEY,
	`Nome` VARCHAR(45) NULL,
	`Cognome` VARCHAR(45) NULL,
	`Data_di_Nascita` DATE NULL,
	`Biografia` VARCHAR(45) NOT NULL,
	`Nome_arte` VARCHAR(45) NULL,
	`Città_di_Nascita` INT NOT NULL,
	FOREIGN KEY (`Città_di_Nascita`) REFERENCES `SoundON`.`Città` (`idCittà`)
);



CREATE TABLE IF NOT EXISTS `SoundON`.`Concerto` (
	`idConcerto` INT AUTO_INCREMENT PRIMARY KEY,
	`Indirizzo` VARCHAR(45) NOT NULL,
	`Città` INT NOT NULL,
 	FOREIGN KEY (`Città`) REFERENCES `SoundON`.`Città` (`idCittà`)
);



CREATE TABLE IF NOT EXISTS `SoundON`.`Genere` (
	`idGenere` INT AUTO_INCREMENT PRIMARY KEY,
	`Nome` VARCHAR(45) NOT NULL
);



CREATE TABLE IF NOT EXISTS `SoundON`.`Sottogenere` (
	`idSottogenere` INT AUTO_INCREMENT PRIMARY KEY,
	`Nome` VARCHAR(45) NOT NULL,
	`Genere` INT NOT NULL,
	FOREIGN KEY (`Genere`) REFERENCES `SoundON`.`Genere`(`idGenere`)
);



CREATE TABLE IF NOT EXISTS `SoundON`.`Brano` (
	`idBrano` INT AUTO_INCREMENT PRIMARY KEY,
	`Titolo` VARCHAR(45) NOT NULL,
	`Durata` TIME NOT NULL,
	`Testo` LONGTEXT NULL,
	`Data_di_uscita` DATE NOT NULL,
	`Sottogenere` INT NOT NULL,
 	FOREIGN KEY (`Sottogenere`) REFERENCES `SoundON`.`Sottogenere`(`idSottogenere`)
);



CREATE TABLE IF NOT EXISTS `SoundON`.`Tipo_Album` (
	`idTipo` INT AUTO_INCREMENT PRIMARY KEY,
	`Nome` VARCHAR(45) NOT NULL
);



CREATE TABLE IF NOT EXISTS `SoundON`.`Etichetta` (
	`idEtichetta` INT AUTO_INCREMENT PRIMARY KEY,
	`Nome` VARCHAR(45) NOT NULL
);



CREATE TABLE IF NOT EXISTS `SoundON`.`Album` (
	`idAlbum` INT AUTO_INCREMENT PRIMARY KEY,
	`Titolo` VARCHAR(45) NOT NULL,
	`Data_di_uscita` DATE NOT NULL,
	`Immagine_di_copertina` BLOB NOT NULL,
	`Tipo_Album` INT NOT NULL,
	`Etichetta` INT NOT NULL,
	FOREIGN KEY (`Tipo_Album`) REFERENCES `SoundON`.`Tipo_Album`(`idTipo`),
	FOREIGN KEY (`Etichetta`) REFERENCES `SoundON`.`Etichetta`(`idEtichetta`)
);



CREATE TABLE IF NOT EXISTS `SoundON`.`Brano_dell_Album` (
	`Album` INT,
	`Brano` INT,
	`Numero_Traccia` INT NOT NULL,
	PRIMARY KEY (`Album`, `Brano`),
	FOREIGN KEY (`Album`) REFERENCES `SoundON`.`Album` (`idAlbum`),
	FOREIGN KEY (`Brano`) REFERENCES `SoundON`.`Brano` (`idBrano`)
);



CREATE TABLE IF NOT EXISTS `SoundON`.`Compositore` (
	`Artista` INT PRIMARY KEY,
	FOREIGN KEY (`Artista`) REFERENCES `SoundON`.`Artista`(`idArtista`)
);



CREATE TABLE IF NOT EXISTS `SoundON`.`Autore` (
	`Artista` INT PRIMARY KEY,
	FOREIGN KEY (`Artista`) REFERENCES `SoundON`.`Artista`(`idArtista`)
);


CREATE TABLE IF NOT EXISTS `SoundON`.`Interprete` (
	`Artista` INT PRIMARY KEY,
	FOREIGN KEY (`Artista`) REFERENCES `SoundON`.`Artista`(`idArtista`)
);


CREATE TABLE IF NOT EXISTS `SoundON`.`Solista` (
	`Interprete_Artista` INT PRIMARY KEY, 
	FOREIGN KEY (`Interprete_Artista`) REFERENCES `SoundON`.`Interprete`(`Artista`)
);


CREATE TABLE IF NOT EXISTS `SoundON`.`Gruppo` (
	`Interprete_Artista` INT PRIMARY KEY,
    `Elementi` INT NOT NULL,
	FOREIGN KEY (`Interprete_Artista`) REFERENCES `SoundON`.`Interprete`(`Artista`)
);



CREATE TABLE IF NOT EXISTS `SoundON`.`Solista` (
	`Interprete_Artista` INT PRIMARY KEY, 
    `Direttore` VARCHAR(45) NOT NULL,
  	`Elementi` INT NOT NULL,
	FOREIGN KEY (`Interprete_Artista`) REFERENCES `SoundON`.`Interprete`(`Artista`)
);


CREATE TABLE IF NOT EXISTS `SoundON`.`Artista_dell_Album` (
	`Album` INT,
	`Artista` INT,
	PRIMARY KEY (`Album`, `Artista`),
	FOREIGN KEY (`Album`) REFERENCES `SoundON`.`Album`(`idAlbum`),
	FOREIGN KEY (`Artista`) REFERENCES `SoundON`.`Artista`(`idArtista`)
);



CREATE TABLE IF NOT EXISTS `SoundON`.`Interprete_del_Brano` (
`Interprete` INT,
  	`Brano` INT,
  	PRIMARY KEY (`Interprete`, `Brano`),
	FOREIGN KEY (`Interprete`) REFERENCES `SoundON`.`Interprete` (`Artista`),
	FOREIGN KEY (`Brano`) REFERENCES `SoundON`.`Brano` (`idBrano`)
);


CREATE TABLE IF NOT EXISTS `SoundON`.`Featuring` (
	`Interprete` INT,
  	`Brano` INT,
  	PRIMARY KEY (`Interprete`, `Brano`),
	FOREIGN KEY (`Interprete`) REFERENCES `SoundON`.`Interprete`(`Artista`),
	FOREIGN KEY (`Brano`) REFERENCES `SoundON`.`Brano`(`idBrano`)
);



CREATE TABLE IF NOT EXISTS `SoundON`.`Autore_del_Brano` (
	`Autore` INT,
  	`Brano` INT,
  	PRIMARY KEY (`Autore`, `Brano`),
	FOREIGN KEY (`Autore`) REFERENCES `SoundON`.`Autore`(`Artista`),
	FOREIGN KEY (`Brano`) REFERENCES `SoundON`.`Brano`(`idBrano`)
);



CREATE TABLE IF NOT EXISTS `SoundON`.`Compositore_del_Brano` (
	`Compositore` INT,
  	`Brano` INT,
  	PRIMARY KEY (`Compositore`, `Brano`),
	FOREIGN KEY (`Compositore`) REFERENCES `SoundON`.`Compositore`(`Artista`),
	FOREIGN KEY (`Brano`) REFERENCES `SoundON`.`Brano`(`idBrano`)
);



CREATE TABLE IF NOT EXISTS `SoundON`.`Concerto_dell_Interprete` (
	`Interprete` INT,
  	`Concerto` INT,
  	`Data_Evento` DATE NOT NULL,
  	PRIMARY KEY (`Interprete`, `Concerto`),
	FOREIGN KEY (`Interprete`) REFERENCES `SoundON`.`Interprete`(`Artista`),
	FOREIGN KEY (`Concerto`) REFERENCES `SoundON`.`Concerto` (`idConcerto`)
);


USE `SoundON`;

DELIMITER $$
USE `SoundON`$$
CREATE TRIGGER `SoundON`.`Check_data_d'uscita` BEFORE INSERT ON `Brano_dell_Album` FOR EACH ROW
BEGIN
	DECLARE data_brano date; 
 	DECLARE data_album date;

 	SET data_artista = (SELECT Data_di_uscita FROM Album WHERE Album.idAlbum = new.Album_idAlbum);
 	SET data_album = (SELECT Data_di_Nascita FROM Artista WHERE Artista.idArtista = new.Artista.idArtista);

 	IF (data_artista < data_album) THEN
 		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: la data del album è successiva alla data di nascita di questo artista';
 	END IF;

END$$

CREATE TRIGGER `SoundON`.`Check_Solista` BEFORE INSERT ON `Solista` FOR EACH ROW
BEGIN
	IF (new.Interprete_Artista in (select Interprete_Artista from Orchestra) or new.Interprete_Artista in (select Interprete_Artist from Gruppo)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: questo interprete è gia stato identificato come altro';
 	END IF;
END;$$

CREATE TRIGGER `SoundON`.`Check_Gruppo` BEFORE INSERT ON `Gruppo` FOR EACH ROW
BEGIN
	IF (new.Interprete_Artista in (select Interprete_Artista from Solista) or new.Interprete_Artista_idArtista in (select Interprete_Artista from Orchestra)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: questo interprete è gia stato identificato come altro';
 	END IF;
END$$

CREATE TRIGGER `SoundON`.`Check_Orchestra` BEFORE INSERT ON `Orchestra` FOR EACH ROW
BEGIN
	IF (new.Interprete_Artista in (select Interprete_Artista from Solista) or new.Interprete_Artista_idArtista in (select Interprete_Artista from Gruppo)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: questo interprete è gia stato identificato come altro';
 	END IF;
END$$

CREATE TRIGGER `SoundON`.`Check_data_di_nascita` BEFORE INSERT ON `Artista_dell_Album` FOR EACH ROW
BEGIN
	DECLARE data_artista date; 
 	DECLARE data_album date;

 	SET data_artista = (SELECT Data_di_uscita FROM Album WHERE Album.idAlbum = new.Album_idAlbum);
 	SET data_album = (SELECT Data_di_Nascita FROM Artista WHERE Artista.idArtista = new.Artista.idArtista);

 	IF (data_artista < data_album) THEN
 		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: la data del album è successiva alla data di nascita di questo artista';
 	END IF;

END$$

CREATE TRIGGER `SoundON`.`Check_Interprete` BEFORE INSERT ON `Interprete_del_Brano` FOR EACH ROW
BEGIN
	DECLARE data_brano date; 
 	DECLARE data_interprete date;

 	SET data_brano = (SELECT Data_di_uscita FROM Brano WHERE Brano.idBrano = new.Brano.idBrano);
 	SET data_interprete = (SELECT Data_di_Nascita FROM Artista WHERE Artista.idBrano = new.Artista);

 	IF (data_brano < data_interprete) THEN
 		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: la data del brano è successiva alla data di nascita dell interprete';
	END IF;
END$$

CREATE TRIGGER `SoundON`.`Check_Collaborazione` BEFORE INSERT ON `Featuring` FOR EACH ROW
BEGIN
	DECLARE data_brano date; 
 	DECLARE data_interprete date;

 	SET data_brano = (SELECT Data_di_uscita FROM Brano WHERE Brano.idBrano = new.Brano.idBrano);
 	SET data_interprete = (SELECT Data_di_Nascita FROM Artista WHERE Artista.idBrano = new.Artista);

 	IF (data_brano < data_interprete) THEN
 		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: la data del brano è successiva alla data di nascita del featuring';
	END IF;
END$$

CREATE TRIGGER `SoundON`.`Check_Autore` BEFORE INSERT ON `Autore_del_Brano` FOR EACH ROW
BEGIN
	DECLARE data_brano date; 
 	DECLARE data_autore date;

 	SET data_brano = (SELECT Data_di_uscita FROM Brano WHERE Brano.idBrano = new.Brano.idBrano);
 	SET data_autore = (SELECT Data_di_Nascita FROM Artista WHERE Artista.idBrano = new.Artista);

 	IF (data_brano < data_autore) THEN
 		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: la data del brano è successiva alla data di nascita dell autore';
	END IF;
END$$

CREATE TRIGGER `SoundON`.`Check_Compositore` BEFORE INSERT ON `Compositore_del_Brano` FOR EACH ROW
BEGIN
	DECLARE data_brano date; 
 	DECLARE data_compositore date;

 	SET data_brano = (SELECT Data_di_uscita FROM Brano WHERE Brano.idBrano = new.Brano.idBrano);
 	SET data_compositore = (SELECT Data_di_Nascita FROM Artista WHERE Artista.idBrano = new.Artista);

 	IF (data_brano < data_compositore) THEN
 		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: la data del brano è successiva alla data di nascita del compositore';
	END IF;
END$$

CREATE TRIGGER `SoundON`.`Check_concerto` BEFORE INSERT ON `Concerto_dell_Interprete` FOR EACH ROW
BEGIN
	DECLARE data_artista date; 
    
    SET data_artista = (SELECT Data_di_Nascita FROM Artista WHERE Artista.idArtista = new.Artista);
    
	IF (new.Data_Evento < data_artista) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: la data dell evento è precedente alla data di nascita di questo artista';
 	END IF;
END;$$ 

DELIMITER ;