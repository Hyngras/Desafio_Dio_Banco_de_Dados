CREATE DATABASE [Filmes]
GO
USE [Filmes]
GO

-- Criação das tabelas
CREATE TABLE Filmes (
    FilmeID INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(255),
    Ano INT,
    Duracao INT
);

CREATE TABLE Atores (
    AtorID INT PRIMARY KEY IDENTITY(1,1),
    PrimeiroNome VARCHAR(255),
    UltimoNome VARCHAR(255),
    Genero VARCHAR(50)
);

CREATE TABLE Generos (
    GeneroID INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(255)
);

CREATE TABLE ElencoFilme (
    FilmeID INT,
    AtorID INT,
    Papel VARCHAR(255),
    FOREIGN KEY (FilmeID) REFERENCES Filmes(FilmeID),
    FOREIGN KEY (AtorID) REFERENCES Atores(AtorID)
);

CREATE TABLE FilmesGenero (
    FilmeID INT,
    GeneroID INT,
    FOREIGN KEY (FilmeID) REFERENCES Filmes(FilmeID),
    FOREIGN KEY (GeneroID) REFERENCES Generos(GeneroID)
);

-- Inserção dos dados
INSERT INTO Filmes (Nome, Ano, Duracao) VALUES ('De Volta para o Futuro', 1985, 116);
INSERT INTO Filmes (Nome, Ano, Duracao) VALUES ('Titanic', 1997, 195);
-- Insira mais dados de filmes aqui

INSERT INTO Atores (PrimeiroNome, UltimoNome, Genero) VALUES ('James', 'Stewart', 'M');
INSERT INTO Atores (PrimeiroNome, UltimoNome, Genero) VALUES ('Deborah', 'Kerr', 'F');
-- Insira mais dados de atores aqui

INSERT INTO Generos (Nome) VALUES ('Ação');
INSERT INTO Generos (Nome) VALUES ('Aventura');
-- Insira mais dados de gêneros aqui

INSERT INTO ElencoFilme (FilmeID, AtorID, Papel) VALUES (1, 1, 'John Scottie Ferguson');
INSERT INTO ElencoFilme (FilmeID, AtorID, Papel) VALUES (2, 2, 'Miss Giddens');
-- Insira mais dados de elenco de filmes aqui

INSERT INTO FilmesGenero (FilmeID, GeneroID) VALUES (1, 1);
INSERT INTO FilmesGenero (FilmeID, GeneroID) VALUES (2, 2);
-- Insira mais dados de relacionamento entre filmes e gêneros aqui

-- Consultas solicitadas

-- 1. Buscar o nome e ano dos filmes
SELECT Nome, Ano FROM Filmes;

-- 2. Buscar o nome e ano dos filmes, ordenados por ordem crescente pelo ano
SELECT Nome, Ano FROM Filmes ORDER BY Ano;

-- 3. Buscar pelo filme de volta para o futuro, trazendo o nome, ano e a duração
SELECT Nome, Ano, Duracao FROM Filmes WHERE Nome = 'De Volta para o Futuro';

-- 4. Buscar os filmes lançados em 1997
SELECT Nome FROM Filmes WHERE Ano = 1997;

-- 5. Buscar os filmes lançados APÓS o ano 2000
SELECT Nome FROM Filmes WHERE Ano > 2000;

-- 6. Buscar os filmes com a duração maior que 100 e menor que 150, ordenando pela duração em ordem crescente
SELECT Nome, Duracao FROM Filmes WHERE Duracao > 100 AND Duracao < 150 ORDER BY Duracao;

-- 7. Buscar a quantidade de filmes lançadas no ano, agrupando por ano, ordenando pela duracao em ordem decrescente
SELECT Ano, COUNT(*) AS Quantidade_Filmes FROM Filmes GROUP BY Ano ORDER BY Quantidade_Filmes DESC;

-- 8. Buscar os Atores do gênero masculino, retornando o PrimeiroNome, UltimoNome
SELECT PrimeiroNome, UltimoNome FROM Atores WHERE Genero = 'M';

-- 9. Buscar os Atores do gênero feminino, retornando o PrimeiroNome, UltimoNome, e ordenando pelo PrimeiroNome
SELECT PrimeiroNome, UltimoNome FROM Atores WHERE Genero = 'F' ORDER BY PrimeiroNome;

-- 10. Buscar o nome do filme e o gênero
SELECT f.Nome, g.Nome AS Genero
FROM Filmes f
JOIN FilmesGenero fg ON f.FilmeID = fg.FilmeID
JOIN Generos g ON fg.GeneroID = g.GeneroID;

-- 11. Buscar o nome do filme e o gênero do tipo "Mistério"
SELECT f.Nome, g.Nome AS Genero
FROM Filmes f
JOIN FilmesGenero fg ON f.FilmeID = fg.FilmeID
JOIN Generos g ON fg.GeneroID = g.GeneroID
WHERE g.Nome = 'Mistério';

-- 12. Buscar o nome do filme e os atores, trazendo o PrimeiroNome, UltimoNome e seu Papel
SELECT f.Nome AS NomeFilme, a.PrimeiroNome, a.UltimoNome, ef.Papel
FROM Filmes f
JOIN ElencoFilme ef ON f.FilmeID = ef.FilmeID
JOIN Atores a ON ef.AtorID = a.AtorID;
