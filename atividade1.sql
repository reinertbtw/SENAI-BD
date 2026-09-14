/* Criação do Banco */

CREATE DATABASE IF NOT EXISTS Biblioteca;
USE Biblioteca;

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE livros (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    ano_publicacao INT NOT NULL,
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE alunos (
    id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE funcionarios (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE emprestimos (
    id_emprestimo INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT NOT NULL,
    id_funcionario INT NOT NULL,
    id_livro INT NOT NULL,
    data_emprestimo DATE NOT NULL,

    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno),
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario),
    
    FOREIGN KEY (id_livro) REFERENCES livros(id_livro)
);

/* Inserção de dados */

INSERT INTO categorias (nome) VALUES
('Fantasia'),
('Romance'),
('Terror'),
('Aventura');

INSERT INTO livros (titulo, ano_publicacao, id_categoria) VALUES
('O Hobbit', 1937, 1),
('Harry Potter', 1997, 1),
('O Senhor dos Anéis', 1954, 1),
('Dom Casmurro', 1899, 2),
('Orgulho e Preconceito', 1813, 2),
('It', 1986, 3),
('Drácula', 1897, 3),
('A Ilha do Tesouro', 1883, 4);

INSERT INTO alunos (nome) VALUES
('Lucas'),
('Maria'),
('João'),
('Ana'),
('Pedro');

INSERT INTO funcionarios (nome) VALUES
('Carlos'),
('Fernanda'),
('Roberto'),
('Juliana');

INSERT INTO emprestimos
(id_aluno, id_livro, id_funcionario, data_emprestimo)
VALUES
(1, 1, 1, '2026-09-01'),
(1, 3, 1, '2026-09-03'),
(1, 5, 2, '2026-09-05'),
(2, 2, 2, '2026-09-06'),
(2, 4, 1, '2026-09-07'),
(3, 6, 3, '2026-09-08');

/* Questão 1 */

SELECT
    categorias.nome AS categoria,
    COUNT(livros.id_livro) AS quantidade_livros
FROM categorias
LEFT JOIN livros
    ON categorias.id_categoria = livros.id_categoria
GROUP BY categorias.id_categoria, categorias.nome
ORDER BY quantidade_livros DESC;

/* Questão 2 */

SELECT
    COUNT(*) AS quantidade_alunos
FROM alunos;

/* Questão 3 */

SELECT
    titulo,
    ano_publicacao
FROM livros
ORDER BY ano_publicacao ASC
LIMIT 1;

/* Questão 4 */

SELECT
    funcionarios.nome
FROM funcionarios
LEFT JOIN emprestimos
    ON funcionarios.id_funcionario = emprestimos.id_funcionario
WHERE emprestimos.id_emprestimo IS NULL;

/* Questão 5 */

SELECT
    alunos.nome,
    COUNT(emprestimos.id_emprestimo) AS quantidade_emprestimos
FROM alunos
LEFT JOIN emprestimos
    ON alunos.id_aluno = emprestimos.id_aluno
GROUP BY alunos.id_aluno, alunos.nome
ORDER BY quantidade_emprestimos DESC;
