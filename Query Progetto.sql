/*Controllare informazioni relative ad un artista*/
SELECT Nome_arte, Artista.Nome, Cognome, Data_di_Nascita, Biografia, Citta.Nome
FROM Artista JOIN Citta ON Artista.Citta_di_Nascita = Città.idCittà
WHERE Artista.nome_arte = “”;

/*Controllare informazioni relative ad un brano*/
SELECT Titolo, Durata, Testo, Data_di_uscita
WHERE Brano.Titolo = “”;

/*Controllare informazioni relative ad un album*/
SELECT Album.*, Artista.Nome, Brano.Titolo, Brano.Durata, Brano_dell_Album.Numero_Traccia
FROM Album JOIN Artista_dell_Album ON Artista_dell_Album.idArtista = Album.idAlbum JOIN Artista ON Artista.idArtista = Artista_dell_Album.Artista JOIN Etichetta ON Album.Etchetta = Etichetta.idEtichetta JOIN Brano_dell_Album ON Brano_dell_Album.Album = Album.idAlbum JOIN Brano ON Brano.idBrano = Brano_dell_Album.Brano
WHERE Album.Titolo = “”;

/*Controllare informazioni relative ad un concerto*/
SELECT Concerto.Nome, Città.Nome, Concerto.Indirizzo, Data_Evento, Artista.Nome_Arte
FROM Concerto JOIN Concerto_dell_Interprete ON Concerto.idConcerto = Concerto_dell_Interprete.Concerto JOIN Interprete ON Concerto_dell_Interprete.Interprete = Interprete.Artista JOIN Artista ON Artista.idArtista = Interprete.Artista JOIN Citta ON Citta.idCitta = Concerto.Citta
WHERE Concerto.Nome = “”;

/*Calcolare il numero di album nei vari anni*/
SELECT COUNT(*) AS ALBUM_NELL_ANNO
FROM Album
WHERE Data_di_uscita > 01/01/” AND Data_di_uscita < 31/12/”;

/*Controllo dei concerti in un dato periodo*/
SELECT DISTINCT Concerto.Nome, Indirizzo, Citta.Nome
FROM Città JOIN Concerto ON Città.idCitta = Concerto.Città JOIN Concerto_dell_Interprete ON Concerto.idConcerto = Concerto_dell_Interprete.Concerto
WHERE Data_Evento BETWEEN “ AND “;

/*Controllare informazioni relative ad un’etichetta*/
SELECT Nome, Titolo, Immagine_di_copertina
FROM Etichetta JOIN Album ON Etichetta.Codice_Etichetta = Album.Etichetta
WHERE Nome = “;

/*Controllare i brani di un interprete con relativo genere/sottogenere in un determinato periodo*/
SELECT Brano.*, Sottogenere.Nome
FROM Brano JOIN Interprete_dell_Brano ON Interprete_dell_brano.Brano = Brano.idBrano JOIN Interprete ON Interprete.Artista = Interprete_dell_brano.Interprete JOIN Artista ON Interprete.Artista = Artista.idArtista JOIN Sottogenere ON Brano.Sottogenere = Sottogenere.idSottogenere
WHERE Artista.Nome_Arte = “” AND Brano.Data_di_Uscita BETWEEN “ AND “;

/*Controllare tutti gli album orchestrali usciti nell’anno corrente*/
SELECT DISTINCT Album.*
FROM Album JOIN Artista_dell_Album ON Artista_dell_Album.Album = Album.idAlbum JOIN Artista ON Artista.idArtista = Artista_dell_album.Artista JOIN Interprete ON Interprete.Artista = Artista.id_Artista JOIN Orchestra ON Interprete.Artista = Orchestra.Interprete 
WHERE Album.Data_di_Uscita BETWEEN 01/01/2022 AND 31/12/2022;

/*Selezionare le Nazionalità degli Artisti che hanno Pubblicato qualche Album nel 2012 ma nessuno nel 2013.*/
SELECT DISTINCT Stato.Nome 
FROM Stato 
WHERE Stato.idStato IN 
	(SELECT Stato 
	FROM Citta 
	WHERE Città.idCitta IN 
		(SELECT Artista.Citta_di_Nascita 
		FROM Album JOIN Artista_dell_Album ON Artista_dell_Album.Album = Album.idAlbum JOIN Artista ON Artista.idArtista = Artista_dell_Album.idArtista 
		WHERE Citta.idCitta = Artista.Citta_di_Nascita AND Album.Data_di_Uscita Between “01/01/2012” And “31/12/2012”)
AND Stato.idStato NOT IN 
	(SELECT Stato 
	FROM Citta 
	WHERE Città.idCitta IN 
		(SELECT Artista.Citta_di_Nascita 
		FROM Album JOIN Artista_dell_Album  ON Artista_dell_Album.Album = Album.Codice_Album JOIN Artista ON Artista.idArtista = Artista_dell_Album.Artista
		WHERE Citta.Codice = Artista.Citta AND Album.Data_di_uscita Between “01/01/2013” And “31/12/2013”)));

/*Nomi degli Artisti che hanno pubblicato nel 1993 più album di quanti ne avevano pubblicati nel 1992.*/
SELECT Artista.Nome_d_arte 
FROM Album JOIN Artista_dell_Album ON Artista_dell_Album.Album = Album.idAlbum JOIN Artista ON Artista.idArtista = Artista_dell_Album.idArtista AS A
WHERE A.Data_di_uscita Between “01/01/2013” And “31/12/2013”
GROUP BY A.Nome_Arte
HAVING count(*) > 
	(SELECT count(*) 
    FROM Album JOIN Artista_dell_Album ON Artista_dell_Album.Album = Album.idAlbum JOIN Artista ON Artista.idArtista = Artista_dell_Album.idArtista AS A1
	WHERE A1.Nome_d_arte = A.Nome_d_arte AND Anno Between “01/01/1992” And “31/12/1992”);
    
/*VISTA*/
CREATE VIEW NumPerAnno (Nom, Ann, Num) AS
SELECT NomeRegista, Anno, count(*) 
FROM Album JOIN Artista_dell_Album ON Artista_dell_Album.Album = Album.idAlbum JOIN Artista ON Artista.idArtista = Artista_dell_Album.idArtista 
GROUP BY Nome_Arte, Data_di_Uscita;

SELECT Nom AS NomeArtistaCercato FROM NumPerAnno N1 
WHERE Anno Between “01/01/1993” And “31/12/1993” AND Nom NOT IN 
	(SELECT Nom 
	FROM NumPerAnno N2 
	WHERE N2.Ann Between “01/01/1992” And “31/12/1992” AND N1.Num <= N2.Num);

/*I brani di scrittori Romani i quali non sono interpretati da nessun Romano.*/
SELECT Titolo 
FROM Brano JOIN Autore_del_Brano ON Autore_del_Brano.Brano = Brano.idBrano JOIN Autore ON Autore.Artista = Autore_del_Brano.Autore JOIN Artista ON Artista.idArtista = Autore.Artista JOIN Citta ON Artista.Citta_di_Nascita = Citta_idCitta
WHERE Città.Nome = “Roma” AND Brano.idBrano NOT IN 
	(SELECT idBrano 
	FROM Interprete_del_Brano JOIN Interprete ON Interprete.Artista = Interprete_del_brano.Interprete JOIN Artista ON Artista.idArtista = Interprete.Artista JOIN Citta ON Artista.Citta_di_Nascita = Citta_idCitta
	WHERE Città.Nome = “Roma”);
