# -- Views
# 1 Crie uma view que apresente o total de pedidos do dia 2024-08-21
CREATE OR REPLACE VIEW View1 (Numero_Pedidos, Total_Pedidos) AS
SELECT COUNT(dataped), SUM(valorTotalPedido)
FROM PEDIDOS P 
WHERE dataped = '2024-08-21';

# 2 Crie uma view que apresente o total de pedidos já realizados
CREATE OR REPLACE VIEW View2 (Numero_Pedidos, Total_Pedidos) AS
SELECT COUNT(dataped), SUM(valorTotalPedido)
FROM PEDIDOS P;

# 3 Crie uma view que apresente o nome dos clientes que ja fizeram uma compra
CREATE OR REPLACE VIEW View3 (Nome_Cliente, Total_Pedidos) AS
SELECT C.nome, P.valorTotalPedido
FROM CLIENTES C 
JOIN PEDIDOS P 
ON C.idCliente = P.fk_id_Cliente;

# 4 Crie uma view que apresente os produtos que já foram comprados
CREATE OR REPLACE VIEW View4 (Produtos, Quantidade) AS
SELECT P.descricao, I.quantidade
FROM PRODUTOS P
JOIN ITEMSPEDIDOS I
ON P.idProduto = I.fk_id_Produto;

# 5 Crie uma view que apresente quais produtos os clientes compraram
CREATE OR REPLACE VIEW View5 (Nome_Cliente, Produto, Quantidade) AS
SELECT C.nome, PROD.descricao, I.quantidade
FROM ITEMSPEDIDOS I
JOIN PEDIDOS P
ON P.idPedido = I.fk_id_Pedido
JOIN CLIENTES C
ON C.idCliente = P.fk_id_Cliente
JOIN PRODUTOS PROD
ON PROD.idProduto = I.fk_id_Produto;

# 6 Crie uma view que apresente o ticket media dos valores dos pedidos
CREATE OR REPLACE VIEW View6 (Ticket_Medio) AS
SELECT AVG(valorTotalPedido)
FROM PEDIDOS;

# 7 Crie uma view que apresente o lucro que rendeu um pedido qualquer
CREATE OR REPLACE VIEW View7 (ID_Pedido, Lucro) AS
SELECT P.idPedido, (PROD.precoVenda - PROD.precoCompra)*I.quantidade
FROM ITEMSPEDIDOS I
JOIN PEDIDOS P
ON P.idPedido = I.fk_id_Pedido
JOIN PRODUTOS PROD
ON PROD.idProduto = I.fk_id_Produto
GROUP BY P.idPedido;

# 8 Crie uma view que apresente quantos pedidos já foram feitos
CREATE OR REPLACE VIEW View8 (Numero_Pedidos, Total_Pedidos) AS
SELECT COUNT(dataped), SUM(valorTotalPedido)
FROM PEDIDOS P
GROUP BY P.idPedido;

# 9 Crie uma view que apresente qual o maior pedido em valor
CREATE OR REPLACE VIEW View9 (ID_Pedido, Valor_Pedido) AS
SELECT P.idPedido, MAX(valorTotalPedido)
FROM PEDIDOS P;

# 10 Crie uma view que apresente qual o menor pedido em valor
CREATE OR REPLACE VIEW View10 (ID_Pedido, Valor_Pedido) AS
SELECT P.idPedido, MIN(valorTotalPedido)
FROM PEDIDOS P;

# 11 Crie uma view que apresente qual o endereco do cliente Teclaudio
CREATE OR REPLACE VIEW View11 AS
SELECT C.nome, E.*
FROM CLIENTES C
JOIN ENDERECOS E
ON E.idEndereco = C.fk_id_endereco
WHERE C.nome = 'Tecláudio Screen';

# 12 Crie uma view que apresente qual endereco dos clientes que ja fizeram compras
CREATE OR REPLACE VIEW View12 AS
SELECT C.nome, E.*
FROM CLIENTES C 
JOIN PEDIDOS P 
ON C.idCliente = P.fk_id_Cliente
JOIN ENDERECOS E
ON E.idEndereco = C.fk_id_endereco;

# 13 Crie uma view que apresente quais pedidos foram pagos em pix
CREATE OR REPLACE VIEW View13 (ID_Pedido, Tipo_Pagamento) AS
SELECT PED.idPedido, PAG.forma_pagamento
FROM PEDIDOS PED
JOIN PAGAMENTOS PAG
ON PAG.idPagamento = PED.fk_id_pagamento
WHERE PAG.idPagamento = 1;

# 14 Crie uma view que apresente quais pedidos foram pagos em cartao
CREATE OR REPLACE VIEW View14 (ID_Pedido, Tipo_Pagamento) AS
SELECT PED.idPedido, PAG.forma_pagamento
FROM PEDIDOS PED
JOIN PAGAMENTOS PAG
ON PAG.idPagamento = PED.fk_id_pagamento
WHERE PAG.idPagamento = 2;

# 15 Crie uma view que apresente quais itens foram pedidos no pedido do Marta Castro
CREATE OR REPLACE VIEW View15 (Produto) AS
SELECT PROD.descricao
FROM PRODUTOS PROD
JOIN ITEMSPEDIDOS I
ON PROD.idProduto = I.fk_id_Produto
JOIN PEDIDOS PED
ON I.fk_id_Pedido = PED.idPedido
JOIN CLIENTES C
ON PED.fk_id_Cliente = C.idCliente
WHERE C.nome = 'Marta Castro';

# 16 Crie uma view que apresente qual fornecedor fabricou os produtos do pedido da Helena Carla
CREATE OR REPLACE VIEW View16 (Fornecedor) AS
SELECT F.nome
FROM FORNECEDORES F
JOIN PRODUTOS PROD
ON F.idFornecedor = PROD.fk_id_fornecedor
JOIN ITEMSPEDIDOS I
ON PROD.idProduto = I.fk_id_Produto
JOIN PEDIDOS PED
ON I.fk_id_Pedido = PED.idPedido
JOIN CLIENTES C
ON PED.fk_id_Cliente = C.idCliente
WHERE C.nome = 'Helena Carla';

# 17 Crie uma view que apresente qual fornecedor fabrica as Camisas comercializadas
CREATE OR REPLACE VIEW View17 (Fornecedor) AS
SELECT F.nome
FROM FORNECEDORES F
JOIN PRODUTOS PROD
ON F.idFornecedor = PROD.fk_id_fornecedor
WHERE PROD.descricao LIKE '%Camisa%';

# 18 Crie uma view que apresente qual a quantidade em estoque do produto comprado pela Maria de Almeida
CREATE OR REPLACE VIEW View18 (Produto, Quantidade) AS
SELECT PROD.descricao, SUM(I.quantidade)
FROM PRODUTOS PROD
JOIN ITEMSPEDIDOS I
ON PROD.idProduto = I.fk_id_Produto
JOIN PEDIDOS PED
ON I.fk_id_Pedido = PED.idPedido
JOIN CLIENTES C
ON PED.fk_id_Cliente = C.idCliente
WHERE C.nome = 'Maria de Almeida';

# 19 Crie uma view que apresente o total de produtos fabricados pela Marte Roupas
CREATE OR REPLACE VIEW View19 (Produtos) AS
SELECT PROD.descricao
FROM PRODUTOS PROD
JOIN FORNECEDORES F
ON PROD.fk_id_fornecedor = F.idFornecedor
WHERE F.nome = 'Marte Roupas';