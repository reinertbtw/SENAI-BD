/* CONTEXTUALIZAÇÃO 
    Você foi contratado por uma loja virtual especializada na venda de produtos de tecnologia, como 
    notebooks, periféricos, componentes, acessórios e equipamentos para informática. 
    A empresa precisa de um banco de dados capaz de controlar seus produtos, categorias, fornecedores, 
    clientes, pedidos, itens vendidos, pagamentos, entregas e avaliações realizadas pelos clientes. 
    Atualmente, as informações são armazenadas de forma desorganizada, dificultando o acompanhamento 
    das vendas e a geração de informações para tomada de decisão. 
    Sua missão é projetar e implementar o banco de dados do zero, tomando as decisões necessárias para 
    estruturar corretamente as informações e seus relacionamentos. */

-- Grupo: Lucas Reinert, Luigi Louzada, Eduardo Reis, Arthur Rambo e Gabriel Santos

-- Criação das Tabelas

create database loja_eletronicos;
use loja_eletronicos;

create table Categoria (
    id_categoria int primary key auto_increment,
    nome varchar(45),
    descricao varchar(45)
);

create table Fornecedor (
    id_fornecedor int primary key auto_increment,
    nome varchar(45),
    email varchar(45),
    telefone varchar(45),
    cidade varchar(45)
);

create table Produto (
    id_produto int primary key auto_increment,
    nome varchar(45),
    descricao varchar(45),
    preco double,
    estoque int,
    id_categoria int,
    id_fornecedor int,

    foreign key (id_categoria) references Categoria(id_categoria),
    foreign key (id_fornecedor) references Fornecedor(id_fornecedor)
);

create table Cliente (
    id_cliente int primary key auto_increment,
    nome varchar(45),
    email varchar(45),
    telefone varchar(45),
    cidade varchar(45)
);

create table Pedido (
    id_pedido int primary key auto_increment,
    data_pedido date,
    status enum('Pendente', 
                'Pago', 
                'Enviado', 
                'Entregue', 
                'Cancelado'),
    id_cliente int,

    foreign key (id_cliente) references Cliente(id_cliente)
);

create table ItemPedido (
    id_item_pedido int primary key auto_increment,
    quantidade int,
    preco_unitario double,
    id_pedido int,
    id_produto int,

    foreign key (id_pedido) references Pedido(id_pedido),
    foreign key (id_produto) references Produto(id_produto)
);

create table Pagamento (
    id_pagamento int primary key auto_increment,
    data_pagamento date,
    valor double,
    metodo enum('Pix', 
                'Cartão',
                'Boleto'),
    status enum('Pendente', 
                'Aprovado', 
                'Recusado'),
    id_pedido int,

    foreign key (id_pedido) references Pedido(id_pedido)
);

create table Entrega (
    id_entrega int primary key auto_increment,
    codigo_rastreio varchar(45),
    data_envio date,
    data_entrega date,
    status enum('aguardando_envio', 
                'em_transito', 
                'entregue', 
                'atrasada'),
    id_pedido int,

    foreign key (id_pedido) references Pedido(id_pedido)
);

create table Avaliacao (
    id_avaliacao int primary key auto_increment,
    nota int,
    comentario varchar(255),
    data_avaliacao date,
    id_produto int,
    id_cliente int,

    CHECK (nota BETWEEN 1 AND 5),

    foreign key (id_produto) references Produto(id_produto),
    foreign key (id_cliente) references Cliente(id_cliente)
);

-- População do Banco

INSERT INTO Categoria (nome, descricao) VALUES
('Notebooks', 'Computadores portáteis'),
('Periféricos', 'Periféricos para computadores'),
('Componentes', 'Peças e componentes de hardware'),
('Monitores', 'Monitores para computadores'),
('Acessórios', 'Acessórios eletrônicos');

INSERT INTO Fornecedor (nome, email, telefone, cidade) VALUES
('Tech Distribuidora', 'contato@tech.com', '4733221100', 'Blumenau'),
('Sul Informática', 'vendas@sulinfo.com', '4733332200', 'Joinville'),
('Mega Hardware', 'contato@megahardware.com', '4833445500', 'Florianópolis'),
('Digital Store', 'vendas@digitalstore.com', '4733556600', 'Itajaí'),
('Info Parts', 'contato@infoparts.com', '4733667700', 'Brusque'),
('Eletronic Supply', 'vendas@eletronicsupply.com', '4733778800', 'Gaspar');

INSERT INTO Produto
(nome, descricao, preco, estoque, id_categoria, id_fornecedor)
VALUES
('Notebook Lenovo', 'Notebook Lenovo 15 polegadas', 3200.00, 10, 1, 1),
('Notebook Dell', 'Notebook Dell Inspiron', 4200.00, 8, 1, 2),
('Mouse Logitech', 'Mouse sem fio Logitech', 150.00, 30, 2, 1),
('Teclado Mecânico', 'Teclado mecânico RGB', 280.00, 20, 2, 3),
('Headset Gamer', 'Headset gamer com microfone', 350.00, 15, 2, 4),
('Memória RAM 16GB', 'Memória DDR4 16GB', 320.00, 25, 3, 3),
('SSD 1TB', 'SSD NVMe de 1TB', 450.00, 18, 3, 5),
('Placa de Vídeo', 'Placa de vídeo 8GB', 2200.00, 7, 3, 5),
('Monitor LG 24', 'Monitor Full HD 24 polegadas', 850.00, 12, 4, 2),
('Monitor Samsung 27', 'Monitor Full HD 27 polegadas', 1200.00, 9, 4, 4),
('Webcam Full HD', 'Webcam com resolução Full HD', 230.00, 20, 5, 1),
('Hub USB', 'Hub USB com quatro portas', 90.00, 40, 5, 2);

INSERT INTO Cliente (nome, email, telefone, cidade) VALUES
('Lucas Silva', 'lucas@email.com', '47999990001', 'Blumenau'),
('Gabriel Souza', 'gabriel@email.com', '47999990002', 'Blumenau'),
('Ana Oliveira', 'ana@email.com', '47999990003', 'Joinville'),
('Pedro Santos', 'pedro@email.com', '47999990004', 'Gaspar'),
('Mariana Costa', 'mariana@email.com', '47999990005', 'Blumenau'),
('João Pereira', 'joao@email.com', '47999990006', 'Itajaí'),
('Julia Martins', 'julia@email.com', '47999990007', 'Brusque'),
('Rafael Lima', 'rafael@email.com', '47999990008', 'Blumenau'),
('Beatriz Rocha', 'beatriz@email.com', '47999990009', 'Joinville'),
('Carlos Mendes', 'carlos@email.com', '47999990010', 'Gaspar'),
('Fernanda Alves', 'fernanda@email.com', '47999990011', 'Itajaí'),
('Matheus Ribeiro', 'matheus@email.com', '47999990012', 'Blumenau'),
('Camila Ferreira', 'camila@email.com', '47999990013', 'Brusque'),
('Bruno Cardoso', 'bruno@email.com', '47999990014', 'Blumenau'),
('Larissa Gomes', 'larissa@email.com', '47999990015', 'Joinville');

INSERT INTO Pedido (data_pedido, status, id_cliente) VALUES
('2026-08-01', 'Entregue', 1),
('2026-08-03', 'Entregue', 2),
('2026-08-05', 'Entregue', 3),
('2026-08-08', 'Cancelado', 4),
('2026-08-10', 'Entregue', 5),
('2026-08-15', 'Enviado', 6),
('2026-08-18', 'Pago', 7),
('2026-08-20', 'Pendente', 8),
('2026-08-23', 'Entregue', 9),
('2026-08-25', 'Enviado', 10),
('2026-09-01', 'Entregue', 11),
('2026-09-03', 'Pago', 12),
('2026-09-05', 'Pendente', 13),
('2026-09-08', 'Entregue', 1),
('2026-09-10', 'Enviado', 2),
('2026-09-15', 'Pago', 1),
('2026-09-18', 'Cancelado', 5),
('2026-09-20', 'Entregue', 7),
('2026-09-25', 'Pendente', 9),
('2026-10-01', 'Enviado', 11);

INSERT INTO ItemPedido
(quantidade, preco_unitario, id_pedido, id_produto)
VALUES
(1, 3200.00, 1, 1),
(1, 150.00, 1, 3),
(1, 4200.00, 2, 2),
(1, 280.00, 2, 4),
(2, 150.00, 3, 3),
(1, 350.00, 3, 5),
(1, 320.00, 4, 6),
(1, 450.00, 5, 7),
(1, 230.00, 5, 11),
(1, 2200.00, 6, 8),
(1, 280.00, 6, 4),
(1, 850.00, 7, 9),
(1, 150.00, 7, 3),
(1, 1200.00, 8, 10),
(2, 320.00, 9, 6),
(1, 450.00, 9, 7),
(1, 350.00, 10, 5),
(1, 230.00, 10, 11),
(1, 3200.00, 11, 1),
(1, 850.00, 11, 9),
(1, 280.00, 12, 4),
(1, 150.00, 12, 3),
(1, 450.00, 13, 7),
(1, 4200.00, 14, 2),
(1, 350.00, 14, 5),
(1, 2200.00, 15, 8),
(1, 320.00, 15, 6),
(1, 1200.00, 16, 10),
(1, 230.00, 16, 11),
(1, 150.00, 17, 3),
(1, 850.00, 18, 9),
(1, 280.00, 18, 4),
(1, 320.00, 19, 6),
(1, 450.00, 20, 7),
(1, 350.00, 20, 5);

INSERT INTO Pagamento
(data_pagamento, valor, metodo, status, id_pedido)
VALUES
('2026-08-01', 3350.00, 'Pix', 'Aprovado', 1),
('2026-08-03', 4480.00, 'Cartão', 'Aprovado', 2),
('2026-08-05', 650.00, 'Pix', 'Aprovado', 3),
('2026-08-10', 680.00, 'Boleto', 'Aprovado', 5),
('2026-08-15', 2480.00, 'Cartão', 'Aprovado', 6),
('2026-08-18', 1000.00, 'Pix', 'Aprovado', 7),
('2026-08-23', 1090.00, 'Cartão', 'Aprovado', 9),
('2026-08-25', 580.00, 'Pix', 'Aprovado', 10),
('2026-09-01', 4050.00, 'Boleto', 'Aprovado', 11),
('2026-09-03', 430.00, 'Pix', 'Aprovado', 12),
('2026-09-08', 4550.00, 'Cartão', 'Aprovado', 14),
('2026-09-10', 2520.00, 'Pix', 'Aprovado', 15),
('2026-09-15', 1430.00, 'Boleto', 'Aprovado', 16),
('2026-09-20', 1130.00, 'Cartão', 'Aprovado', 18),
('2026-10-01', 800.00, 'Pix', 'Pendente', 20);

INSERT INTO Entrega
(codigo_rastreio, data_envio, data_entrega, status, id_pedido)
VALUES
('BR000001', '2026-08-02', '2026-08-05', 'entregue', 1),
('BR000002', '2026-08-04', '2026-08-07', 'entregue', 2),
('BR000003', '2026-08-06', '2026-08-10', 'entregue', 3),
('BR000005', '2026-08-11', '2026-08-14', 'entregue', 5),
('BR000006', '2026-08-16', NULL, 'em_transito', 6),
('BR000007', NULL, NULL, 'aguardando_envio', 7),
('BR000009', '2026-08-24', '2026-08-28', 'entregue', 9),
('BR000010', '2026-08-26', NULL, 'atrasada', 10),
('BR000011', '2026-09-02', '2026-09-06', 'entregue', 11),
('BR000012', NULL, NULL, 'aguardando_envio', 12),
('BR000014', '2026-09-09', '2026-09-12', 'entregue', 14),
('BR000015', '2026-09-11', NULL, 'em_transito', 15),
('BR000016', NULL, NULL, 'aguardando_envio', 16),
('BR000018', '2026-09-21', '2026-09-24', 'entregue', 18),
('BR000020', '2026-10-02', NULL, 'em_transito', 20);

INSERT INTO Avaliacao
(nota, comentario, data_avaliacao, id_produto, id_cliente)
VALUES
(5, 'Notebook excelente', '2026-08-07', 1, 1),
(4, 'Mouse muito bom', '2026-08-07', 3, 1),
(5, 'Gostei muito do notebook', '2026-08-10', 2, 2),
(4, 'Teclado muito confortável', '2026-08-11', 4, 2),
(3, 'Headset bom pelo preço', '2026-08-13', 5, 3),
(5, 'SSD muito rápido', '2026-08-17', 7, 5),
(4, 'Monitor com boa imagem', '2026-08-30', 9, 9),
(5, 'Ótima memória RAM', '2026-08-31', 6, 9),
(4, 'Webcam tem boa qualidade', '2026-09-01', 11, 10),
(5, 'Placa de vídeo excelente', '2026-09-15', 8, 2),
(3, 'Monitor poderia ser melhor', '2026-09-16', 10, 3),
(5, 'Produto excelente', '2026-09-25', 9, 7);


-- Consultas SQL


-- QUESTÃO 01 — Produtos e categorias

SELECT
    Produto.nome AS produto,
    Produto.preco,
    Produto.estoque,
    Categoria.nome AS categoria
FROM Produto
JOIN Categoria
    ON Produto.id_categoria = Categoria.id_categoria;


-- QUESTÃO 02 — Produtos e fornecedores


SELECT
    Produto.nome AS produto,
    Produto.preco,
    Fornecedor.nome AS fornecedor,
    Fornecedor.cidade
FROM Produto
JOIN Fornecedor
    ON Produto.id_fornecedor = Fornecedor.id_fornecedor;


-- QUESTÃO 03 — Pedidos e clientes


SELECT
    Pedido.id_pedido,
    Pedido.data_pedido,
    Pedido.status,
    Cliente.nome AS cliente,
    Cliente.cidade
FROM Pedido
JOIN Cliente
    ON Pedido.id_cliente = Cliente.id_cliente
ORDER BY Pedido.data_pedido ASC;


-- QUESTÃO 04 — Itens dos pedidos


SELECT
    Pedido.id_pedido,
    Produto.nome AS produto,
    ItemPedido.quantidade,
    ItemPedido.preco_unitario
FROM Pedido
JOIN ItemPedido
    ON Pedido.id_pedido = ItemPedido.id_pedido
JOIN Produto
    ON ItemPedido.id_produto = Produto.id_produto;


-- QUESTÃO 05 — Pedido completo


SELECT
    Pedido.id_pedido,
    Cliente.nome AS cliente,
    Produto.nome AS produto,
    ItemPedido.quantidade,
    ItemPedido.preco_unitario,
    Pedido.status
FROM Cliente
JOIN Pedido
    ON Cliente.id_cliente = Pedido.id_cliente
JOIN ItemPedido
    ON Pedido.id_pedido = ItemPedido.id_pedido
JOIN Produto
    ON ItemPedido.id_produto = Produto.id_produto;


-- QUESTÃO 06 — Quantidade de pedidos por cliente


SELECT
    Cliente.nome AS cliente,
    COUNT(Pedido.id_pedido) AS quantidade_pedidos
FROM Cliente
LEFT JOIN Pedido
    ON Cliente.id_cliente = Pedido.id_cliente
GROUP BY Cliente.id_cliente, Cliente.nome
ORDER BY quantidade_pedidos DESC;


-- QUESTÃO 07 — Clientes sem pedidos


SELECT
    Cliente.nome,
    Cliente.email,
    Cliente.cidade
FROM Cliente
LEFT JOIN Pedido
    ON Cliente.id_cliente = Pedido.id_cliente
WHERE Pedido.id_pedido IS NULL;


-- QUESTÃO 08 — Quantidade de produtos por categoria


SELECT
    Categoria.nome AS categoria,
    COUNT(Produto.id_produto) AS quantidade_produtos
FROM Categoria
LEFT JOIN Produto
    ON Categoria.id_categoria = Produto.id_categoria
GROUP BY Categoria.id_categoria, Categoria.nome
ORDER BY quantidade_produtos DESC;


-- QUESTÃO 09 — Categoria com mais produtos


SELECT
    Categoria.nome AS categoria,
    COUNT(Produto.id_produto) AS quantidade_produtos
FROM Categoria
LEFT JOIN Produto
    ON Categoria.id_categoria = Produto.id_categoria
GROUP BY Categoria.id_categoria, Categoria.nome
ORDER BY quantidade_produtos DESC
LIMIT 1;


-- QUESTÃO 10 — Fornecedores cadastrados


SELECT
    Fornecedor.nome AS fornecedor,
    COUNT(Produto.id_produto) AS quantidade_produtos
FROM Fornecedor
LEFT JOIN Produto
    ON Fornecedor.id_fornecedor = Produto.id_fornecedor
GROUP BY Fornecedor.id_fornecedor, Fornecedor.nome
ORDER BY quantidade_produtos DESC;


-- QUESTÃO 11 — Fornecedores sem produtos


SELECT
    Fornecedor.nome,
    Fornecedor.email,
    Fornecedor.cidade
FROM Fornecedor
LEFT JOIN Produto
    ON Fornecedor.id_fornecedor = Produto.id_fornecedor
WHERE Produto.id_produto IS NULL;


-- QUESTÃO 12 — Produto mais caro


SELECT
    Produto.nome AS produto,
    Produto.preco,
    Categoria.nome AS categoria
FROM Produto
JOIN Categoria
    ON Produto.id_categoria = Categoria.id_categoria
WHERE Produto.preco = (
    SELECT MAX(preco)
    FROM Produto
);


-- QUESTÃO 13 — Produtos sem vendas


SELECT
    Produto.nome AS produto,
    Categoria.nome AS categoria,
    Produto.preco
FROM Produto
JOIN Categoria
    ON Produto.id_categoria = Categoria.id_categoria
LEFT JOIN ItemPedido
    ON Produto.id_produto = ItemPedido.id_produto
WHERE ItemPedido.id_item_pedido IS NULL;


-- QUESTÃO 14 — Quantidade de itens por pedido


SELECT
    Pedido.id_pedido,
    Cliente.nome AS cliente,
    COUNT(ItemPedido.id_item_pedido) AS quantidade_itens
FROM Pedido
JOIN Cliente
    ON Pedido.id_cliente = Cliente.id_cliente
LEFT JOIN ItemPedido
    ON Pedido.id_pedido = ItemPedido.id_pedido
GROUP BY Pedido.id_pedido, Cliente.nome
ORDER BY quantidade_itens DESC;


-- QUESTÃO 15 — Produtos vendidos


SELECT
    Produto.nome AS produto,
    COUNT(ItemPedido.id_item_pedido) AS vezes_vendido
FROM Produto
JOIN ItemPedido
    ON Produto.id_produto = ItemPedido.id_produto
GROUP BY Produto.id_produto, Produto.nome
ORDER BY vezes_vendido DESC;


-- QUESTÃO 16 — Pedidos e pagamentos


SELECT
    Pedido.id_pedido,
    Cliente.nome AS cliente,
    Pedido.status AS status_pedido,
    Pagamento.valor,
    Pagamento.metodo,
    Pagamento.status AS status_pagamento
FROM Cliente
JOIN Pedido
    ON Cliente.id_cliente = Pedido.id_cliente
JOIN Pagamento
    ON Pedido.id_pedido = Pagamento.id_pedido;


-- QUESTÃO 17 — Pedidos sem pagamento


SELECT
    Pedido.id_pedido,
    Pedido.data_pedido,
    Cliente.nome AS cliente,
    Pedido.status
FROM Pedido
JOIN Cliente
    ON Pedido.id_cliente = Cliente.id_cliente
LEFT JOIN Pagamento
    ON Pedido.id_pedido = Pagamento.id_pedido
WHERE Pagamento.id_pagamento IS NULL;


-- QUESTÃO 18 — Pedidos e entregas


SELECT
    Pedido.id_pedido,
    Cliente.nome AS cliente,
    Pedido.status AS status_pedido,
    Entrega.codigo_rastreio,
    Entrega.status AS status_entrega
FROM Pedido
JOIN Cliente
    ON Pedido.id_cliente = Cliente.id_cliente
JOIN Entrega
    ON Pedido.id_pedido = Entrega.id_pedido;


-- QUESTÃO 19 — Pedidos sem entrega


SELECT
    Pedido.id_pedido,
    Cliente.nome AS cliente,
    Pedido.data_pedido,
    Pedido.status
FROM Pedido
JOIN Cliente
    ON Pedido.id_cliente = Cliente.id_cliente
LEFT JOIN Entrega
    ON Pedido.id_pedido = Entrega.id_pedido
WHERE Entrega.id_entrega IS NULL;


-- QUESTÃO 20 — Avaliações dos produtos


SELECT
    Produto.nome AS produto,
    Cliente.nome AS cliente,
    Avaliacao.nota,
    Avaliacao.comentario
FROM Avaliacao
JOIN Produto
    ON Avaliacao.id_produto = Produto.id_produto
JOIN Cliente
    ON Avaliacao.id_cliente = Cliente.id_cliente;


-- QUESTÃO 21 — Média de avaliação por produto


SELECT
    Produto.nome AS produto,
    AVG(Avaliacao.nota) AS media_avaliacoes
FROM Produto
JOIN Avaliacao
    ON Produto.id_produto = Avaliacao.id_produto
GROUP BY Produto.id_produto, Produto.nome
ORDER BY media_avaliacoes DESC;


-- QUESTÃO 22 — Quantidade de avaliações por produto


SELECT
    Produto.nome AS produto,
    COUNT(Avaliacao.id_avaliacao) AS quantidade_avaliacoes
FROM Produto
LEFT JOIN Avaliacao
    ON Produto.id_produto = Avaliacao.id_produto
GROUP BY Produto.id_produto, Produto.nome
ORDER BY quantidade_avaliacoes DESC;


-- QUESTÃO 23 — Valor total de cada pedido


SELECT
    Pedido.id_pedido,
    Cliente.nome AS cliente,
    SUM(ItemPedido.quantidade * ItemPedido.preco_unitario) AS valor_total
FROM Pedido
JOIN Cliente
    ON Pedido.id_cliente = Cliente.id_cliente
JOIN ItemPedido
    ON Pedido.id_pedido = ItemPedido.id_pedido
GROUP BY Pedido.id_pedido, Cliente.nome
ORDER BY valor_total DESC;


-- QUESTÃO 24 — Valor total dos pedidos por cliente


SELECT
    Cliente.nome AS cliente,
    COUNT(DISTINCT Pedido.id_pedido) AS quantidade_pedidos,
    SUM(ItemPedido.quantidade * ItemPedido.preco_unitario) AS valor_total
FROM Cliente
JOIN Pedido
    ON Cliente.id_cliente = Pedido.id_cliente
JOIN ItemPedido
    ON Pedido.id_pedido = ItemPedido.id_pedido
GROUP BY Cliente.id_cliente, Cliente.nome
ORDER BY valor_total DESC;


-- QUESTÃO 25 — Análise completa de clientes


SELECT
    Cliente.nome,
    Cliente.cidade,
    COUNT(DISTINCT Pedido.id_pedido) AS quantidade_pedidos,
    COALESCE(SUM(ItemPedido.quantidade), 0) AS quantidade_itens
FROM Cliente
LEFT JOIN Pedido
    ON Cliente.id_cliente = Pedido.id_cliente
LEFT JOIN ItemPedido
    ON Pedido.id_pedido = ItemPedido.id_pedido
GROUP BY Cliente.id_cliente, Cliente.nome, Cliente.cidade
ORDER BY quantidade_pedidos DESC;


-- QUESTÃO 26 — Clientes com alto volume de pedidos


SELECT
    Cliente.nome AS cliente,
    COUNT(Pedido.id_pedido) AS quantidade_pedidos
FROM Cliente
JOIN Pedido
    ON Cliente.id_cliente = Pedido.id_cliente
GROUP BY Cliente.id_cliente, Cliente.nome
HAVING COUNT(Pedido.id_pedido) > 2
ORDER BY quantidade_pedidos DESC;


-- QUESTÃO 27 — Categorias com maior quantidade de produtos


SELECT
    Categoria.nome AS categoria,
    COUNT(Produto.id_produto) AS quantidade_produtos
FROM Categoria
JOIN Produto
    ON Categoria.id_categoria = Produto.id_categoria
GROUP BY Categoria.id_categoria, Categoria.nome
HAVING COUNT(Produto.id_produto) > 2
ORDER BY quantidade_produtos DESC;


-- QUESTÃO 28 — Produtos com boas avaliações


SELECT
    Produto.nome AS produto,
    AVG(Avaliacao.nota) AS media_avaliacoes,
    COUNT(Avaliacao.id_avaliacao) AS quantidade_avaliacoes
FROM Produto
JOIN Avaliacao
    ON Produto.id_produto = Avaliacao.id_produto
GROUP BY Produto.id_produto, Produto.nome
HAVING AVG(Avaliacao.nota) >= 4
ORDER BY media_avaliacoes DESC;


-- Questão 29 — Clientes e valor de compras


SELECT
    Cliente.nome AS cliente,
    COUNT(DISTINCT Pedido.id_pedido) AS quantidade_pedidos,
    SUM(ItemPedido.quantidade * ItemPedido.preco_unitario) AS valor_total
FROM Cliente
JOIN Pedido
    ON Cliente.id_cliente = Pedido.id_cliente
JOIN ItemPedido
    ON Pedido.id_pedido = ItemPedido.id_pedido
GROUP BY Cliente.id_cliente, Cliente.nome
HAVING SUM(ItemPedido.quantidade * ItemPedido.preco_unitario) > 1000
ORDER BY valor_total DESC;


-- Questão 30 — Relatório geral da Empresa


SELECT
    Cliente.nome,
    Cliente.cidade,
    COUNT(DISTINCT Pedido.id_pedido) AS quantidade_pedidos,
    SUM(ItemPedido.quantidade) AS quantidade_itens_comprados,
    SUM(ItemPedido.quantidade * ItemPedido.preco_unitario) AS valor_total_compras
FROM Cliente
JOIN Pedido
    ON Cliente.id_cliente = Pedido.id_cliente
JOIN ItemPedido
    ON Pedido.id_pedido = ItemPedido.id_pedido
GROUP BY Cliente.id_cliente, Cliente.nome, Cliente.cidade
ORDER BY valor_total_compras DESC;
