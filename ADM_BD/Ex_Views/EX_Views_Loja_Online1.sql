# -- Views
# 1 Crie uma view que apresente o total de pedidos do dia 2024-08-21
CREATE OR REPLACE VIEW VEX1 AS
SELECT COUNT(pedidos.idPedido) AS NUMERO_PEDIDOS
FROM pedidos WHERE pedidos.dataped = '2024/08/21';
SELECT * FROM vex1;
# 2 Crie uma view que apresente o total de pedidos já realizados(total)
CREATE OR REPLACE VIEW VEX2 AS
SELECT COUNT(pedidos.idPedido) AS Todos_Pedidos
from pedidos;
SELECT * FROM vex2;
# 3 Crie uma view que apresente o nome dos clientes que ja fizeram um pedido
CREATE OR REPLACE VIEW VEX3 AS
SELECT C.nome
FROM clientes AS C
JOIN pedidos AS P
ON (C.idCliente = P.fk_id_Cliente);
SELECT * FROM VEX3;
# 4 Crie uma view que apresente os produtos que já foram PEDIDOS
CREATE OR REPLACE VIEW VEX4 AS
SELECT PRO.idProduto,PRO.descricao, PRO.tipo, PED.dataped
FROM pedidos AS PED
JOIN itemspedidos AS ITPED
ON (PED.idPedido = ITPED.fk_id_Pedido)
JOIN produtos AS PRO
ON (ITPED.fk_id_Produto = PRO.idProduto);
SELECT * FROM VEX4;

# 5 Crie uma view que apresente o lucro que rendeu um produto qualquer
CREATE OR REPLACE VIEW VEX5 (ID_Pedido, Lucro) AS
SELECT P.idPedido, (PROD.precoVenda - PROD.precoCompra)*I.quantidade
FROM ITEMSPEDIDOS I
JOIN PEDIDOS P
ON P.idPedido = I.fk_id_Pedido
JOIN PRODUTOS PROD
ON PROD.idProduto = I.fk_id_Produto;
SELECT * FROM VEX5;

# 6 Crie uma view que apresente qual o maior pedido em valor
CREATE OR REPLACE VIEW VEX6 AS
SELECT *
FROM PEDIDOS
WHERE valorTotalPedido = (SELECT MAX(valorTotalPedido) FROM PEDIDOS);
SELECT * FROM VEX6;

# 7 Crie uma view que apresente qual o menor pedido em valor
CREATE OR REPLACE VIEW VEX7 AS
SELECT *
FROM PEDIDOS
WHERE valorTotalPedido = (SELECT MIN(valorTotalPedido) FROM PEDIDOS);
SELECT * FROM VEX7;

# 8 Crie uma view que apresente qual o endereco do cliente Teclaudio
CREATE OR REPLACE VIEW VEX8 AS
SELECT C.nome, E.*
FROM CLIENTES C
JOIN ENDERECOS E
ON E.idEndereco = C.fk_id_endereco
WHERE C.nome = 'Tecláudio Screen';
SELECT * FROM VEX8;

# 9 Crie uma view que apresente qual endereco dos clientes que ja fizeram compras
CREATE OR REPLACE VIEW VEX9 AS
SELECT C.nome, E.*
FROM CLIENTES C 
JOIN PEDIDOS P 
ON C.idCliente = P.fk_id_Cliente
JOIN ENDERECOS E
ON E.idEndereco = C.fk_id_endereco;
SELECT * FROM VEX9;

# 10 Crie uma view que apresente quais pedidos foram pagos em pix
CREATE OR REPLACE VIEW VEX10 (ID_Pedido, Tipo_Pagamento) AS
SELECT PED.idPedido, PAG.forma_pagamento
FROM PEDIDOS PED
JOIN PAGAMENTOS PAG
ON PAG.idPagamento = PED.fk_id_pagamento
WHERE PAG.idPagamento = 1;
SELECT * FROM VEX10;

# 11 Crie uma view que apresente quais pedidos foram pagos em cartao
CREATE OR REPLACE VIEW VEX11 (ID_Pedido, Tipo_Pagamento) AS
SELECT PED.idPedido, PAG.forma_pagamento
FROM PEDIDOS PED
JOIN PAGAMENTOS PAG
ON PAG.idPagamento = PED.fk_id_pagamento
WHERE PAG.idPagamento = 2;
SELECT * FROM VEX11;

# 12 Crie uma view que apresente quais itens foram pedidos no pedido do Marta Castro
CREATE OR REPLACE VIEW VEX12 (Produto) AS
SELECT PROD.descricao
FROM PRODUTOS PROD
JOIN ITEMSPEDIDOS I
ON PROD.idProduto = I.fk_id_Produto
JOIN PEDIDOS PED
ON I.fk_id_Pedido = PED.idPedido
JOIN CLIENTES C
ON PED.fk_id_Cliente = C.idCliente
WHERE C.nome = 'Marta Castro';
SELECT * FROM VEX12;

# 13 Crie uma view que apresente qual fornecedor fabricou os produtos do pedido da Helena Carla
CREATE OR REPLACE VIEW VEX13 (Fornecedor) AS
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
SELECT * FROM VEX13;

# 14 Crie uma view que apresente qual o nome do fornecedor que fabrica as Camisas comercializadas pela loja
CREATE OR REPLACE VIEW VEX14 (Fornecedor) AS
SELECT F.nome
FROM FORNECEDORES F
JOIN PRODUTOS PROD
ON F.idFornecedor = PROD.fk_id_fornecedor
WHERE PROD.descricao LIKE '%Camisa%';
SELECT * FROM VEX14;

# 15 Crie uma view que apresente qual a quantidade em estoque do produto comprado pela Maria de Almeida
CREATE OR REPLACE VIEW VEX15 (Produto, Quantidade) AS
SELECT PROD.descricao, SUM(I.quantidade)
FROM PRODUTOS PROD
JOIN ITEMSPEDIDOS I
ON PROD.idProduto = I.fk_id_Produto
JOIN PEDIDOS PED
ON I.fk_id_Pedido = PED.idPedido
JOIN CLIENTES C
ON PED.fk_id_Cliente = C.idCliente
WHERE C.nome = 'Maria de Almeida'
GROUP BY PROD.descricao;
SELECT * FROM VEX15;

# 16 Crie uma view que apresente o total de produtos fabricados pela Marte Roupas
CREATE OR REPLACE VIEW VEX16 (Produtos) AS
SELECT PROD.descricao
FROM PRODUTOS PROD
JOIN FORNECEDORES F
ON PROD.fk_id_fornecedor = F.idFornecedor
WHERE F.nome = 'Marte Roupas';
SELECT * FROM VEX16;