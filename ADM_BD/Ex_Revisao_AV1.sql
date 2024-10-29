# -----------------------------------------------  VIEWS  ------------------------------------------------------------------

# QUAIS OS NOMES DOS CLIENTES NAO FIZERAM PEDIDO.
CREATE OR REPLACE VIEW view1 AS
SELECT CLIENTES.idcliente,CLIENTES.NOME FROM CLIENTES
 LEFT JOIN PEDIDOS
ON CLIENTES.IDCLIENTE = PEDIDOS.FK_ID_CLIENTE
WHERE PEDIDOS.FK_ID_CLIENTE is NULL;

SELECT * FROM VIEW1;



# -----------------------------------------------  FUNCTIONS  ------------------------------------------------------------------
/*Imagine um produto cujo preço é R$ 100, e os custos
 e despesas dele somam R$ 80. 
A margem de lucro dele seria: 

[R$ 100 – R$80]  ÷ R$ 100 = 0,2 X 100 = 20% 

A margem de lucro desse item é 20%*/
Delimiter $$
CREATE FUNCTION LucroProduto(id_Produto INT)
RETURNS DOUBLE DETERMINISTIC
BEGIN
Declare pCompra, pVenda,lucro double;
SELECT precoCompra INTO pCompra FROM produtos WHERE idProduto = id_Produto;
SELECT precoVenda INTO pVenda FROM produtos WHERE idProduto = id_Produto;
SET lucro = (pVenda - pCompra)/pVenda*100;

Return lucro;
END $$
Delimiter ;
Select LucroProduto(34) AS "Margem de Lucro";


# -----------------------------------------------  Stored Procedures  ------------------------------------------------------------------

# 2 Exemplo PROCEDURE SIMPLIFICADA
delimiter $$
DROP PROCEDURE IF EXISTS `Compras`;
CREATE PROCEDURE Compras() 
BEGIN 
SELECT pedidos.fk_id_cliente,itemsPedidos.fk_id_pedido FROM pedidos JOIN itemsPedidos 
ON pedidos.idPedido = itemsPedidos.fk_id_pedido group by pedidos.fk_id_cliente,itemsPedidos.fk_id_pedido; 
END$$
delimiter ; 

CALL Compras();

# -----------------------------------------------  TRIGGERS  ------------------------------------------------------------------


DELIMITER $$
CREATE  TRIGGER ET
BEFORE INSERT ON itemspedidos
FOR EACH ROW
BEGIN
 IF (NEW.quantidade <=0) THEN
 SIGNAL SQLSTATE '45000' 
   SET MESSAGE_TEXT = 'Quantidade Inválida';
 END IF;
END$$
DELIMITER ;
DROP TRIGGER ET;


INSERT INTO itemspedidos(fk_id_Pedido,fk_id_Produto,quantidade)
VALUES (10,1,0);




# Qual a descricao dos produtos que nao foram pedidos.
CREATE OR REPLACE VIEW VExRev1 AS
SELECT PROD.descricao FROM PRODUTOS PROD
 LEFT JOIN ITEMSPEDIDOS IP
ON PROD.idProduto = IP.fk_id_Produto
WHERE IP.fk_id_Produto is NULL;

SELECT * FROM VExRev1;

# QUAis enderecos nao sao dos clientes?
CREATE OR REPLACE VIEW VExRev2 AS
SELECT E.* FROM ENDERECOS E
 LEFT JOIN CLIENTES C
ON E.idEndereco = C.fk_id_endereco
WHERE C.fk_id_endereco is NULL OR C.fk_id_endereco != E.idEndereco;

SELECT * FROM VExRev2;

# Qual pagamento ainda nao foi usado em pedidos?
CREATE OR REPLACE VIEW VExRev3 AS
SELECT PAG.* FROM PAGAMENTOS PAG
 LEFT JOIN PEDIDOS P
ON PAG.idPagamento = P.fk_id_pagamento
WHERE P.fk_id_pagamento is NULL;

SELECT * FROM VExRev3;

# Qual fornecedor nao esta na lista?
CREATE OR REPLACE VIEW VExRev4 AS
SELECT F.* FROM FORNECEDORES F
 LEFT JOIN PRODUTOS P
ON F.idFornecedor = P.fk_id_fornecedor
WHERE P.fk_id_fornecedor is NULL;

SELECT * FROM VExRev4;

# Ao receber um pedido novo, atualize o estoque do produto
DELIMITER $$
CREATE TRIGGER TExRev1
AFTER INSERT ON ITEMSPEDIDOS
FOR EACH ROW
BEGIN
	UPDATE PRODUTOS SET estoque = (estoque - NEW.quantidade) WHERE idProduto = NEW.fk_id_Produto;
END$$
DELIMITER ;

INSERT INTO itemspedidos(fk_id_Pedido,fk_id_Produto,quantidade)
VALUES (10,1,0);
SELECT * FROM PRODUTOS WHERE idProduto = 1;
# Apresente o calculo de soma das vendas realizadas em um determinado mes.
# Ao apagar um cliente , crie uma tabela de log no sistema, informando quem apagou, qual nome do cliente
# apagado e qual data foi realizada a operação

