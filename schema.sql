CREATE DATABASE desafio_bd;

USE desafio_bd;

CREATE TABLE Categoria (
	id_categoria INT PRIMARY KEY AUTO_INCREMENT,
	nome varchar(100)
);

CREATE TABLE Organizador (
    id_organizador INT PRIMARY KEY AUTO_INCREMENT,
    nome varchar (100),
    email varchar (100),
    telefone varchar (100),
    descricao varchar (100)
);

CREATE TABLE Participante (
	id_participante INT PRIMARY KEY AUTO_INCREMENT,	
    nome varchar (100),
    email varchar (100),
    telefone varchar (100),
    cidade varchar (100)
);

CREATE TABLE Evento (
	id_evento INT PRIMARY KEY AUTO_INCREMENT,
    titulo varchar(100),
    descricao varchar (100),
    data_inicio date,
    data_fim date,
    valor double,
    id_categoria int,
    id_organizador int,
    
    foreign key (id_categoria) references Categoria(id_categoria),
    foreign key (id_organizador) references Organizador(id_organizador)
);
    
CREATE TABLE Inscricao (
	id_inscricao INT PRIMARY KEY AUTO_INCREMENT,
	data_inscricao date,
    presenca tinyint,
    id_participante int,
    id_evento int,
    
    foreign key (id_participante) references Participante(id_participante),
    foreign key (id_evento) references Evento(id_evento)
);
    
INSERT INTO Categoria (nome)
values 
('Formatura'),
('Show'),
('Gastronomia');

INSERT INTO Organizador (nome, email, telefone, descricao)
values
('Eduardo', 'eduardo@gmail.com', '111111111', 'Bom em Formatura'),
('Lucas', 'lucas@gmail.com', '222222222', 'Bom em Shows'),
('Luigi', 'luigi@gmail.com', '333333333', 'Bom em Gastronomia');

INSERT INTO Participante (nome, email, telefone, cidade)
values
('Felipe', 'felipe@gmail.com', '444444444', 'Piauí'),
('Joao', 'joao@gmail.com', '555555555', 'Blumenau'),
('Gabriel', 'gabriel@gmail.com', '666666666', 'Casa do Caralho');

INSERT INTO Evento (titulo, descricao, data_inicio, data_fim, valor)
values
('Poly', 'Festa de Formatura', '2026-10-17', '2026-10-18', '35'),
('Matue', 'Show', '2026-10-15', '2026-10-16', '120'),
('Jacquin', 'Culinaria', '2026-10-13', '2026-10-14', '100');

INSERT INTO Inscricao (data_inscricao, presenca)
values
('2026-10-18', '1'),
('2026-10-17', '0');

CREATE USER 'admin'@'localhost'
identified by '123';

GRANT all privileges
on evento.*
to 'admin'@'localhost';

CREATE USER 'organizador'@'localhost'
identified by '123';

GRANT select, insert, update
on evento.*
to 'organizador'@'localhost';

CREATE USER 'convidado'@'localhost'
identified by '123';

GRANT select
on evento.*
to 'convidado'@'localhost';

SELECT * FROM Categoria;
SELECT * FROM Organizador;
SELECT * FROM Participante;
SELECT * FROM Evento;
SELECT * FROM Inscricao;
