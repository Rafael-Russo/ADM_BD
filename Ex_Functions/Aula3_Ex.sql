# ----------Exemplo 1---Retira pontos de um texto------------------------------------
Delimiter $$
CREATE FUNCTION Retira_Caracter1 (retira VARCHAR(60))
RETURNS VARCHAR(60) 
BEGIN
   RETURN REPLACE(retira,'.','');
END $$
Delimiter ;
 #SET GLOBAL log_bin_trust_function_creators = 1;
SELECT Retira_Caracter1("Ad.mi.nis.tração d.e B-a-n-c-o de D/a/d/o/s");
#----------Exemplo 2---Retira pontos, traços e barras de um texto----------------------- 
Delimiter $$
CREATE FUNCTION Retira_Caracter2 (retira VARCHAR(60))
RETURNS VARCHAR(60) Deterministic
BEGIN
   RETURN (REPLACE(REPLACE(REPLACE(retira,'.',''),'-',''),'/',''));
END $$
Delimiter ;
 
SELECT Retira_Caracter2("Ad.mi.nis.tração d.e B-a-n-c-o de D/a/d/o/s");
#----------Exemplo 3---Texto em Minúsculo-----------------------------------------------
Delimiter %
CREATE FUNCTION Funcao_Lower (texto VARCHAR(50))
RETURNS VARCHAR(50) deterministic
BEGIN
set texto =( LOWER(texto));
   RETURN texto;
END %
Delimiter ;
SELECT Funcao_Lower('Marcelo') AS MINUSCULO;


#------Exemplo 4----Texto em Maiusculo------------------------------------

Delimiter $$
CREATE FUNCTION Funcao_Upper (texto VARCHAR(50))
RETURNS VARCHAR(50) deterministic
BEGIN
set texto =( UPPER(texto));
   RETURN texto;
END $$
Delimiter ;
SELECT Funcao_Upper('Marcelo') AS MAIÚSCULO;
#-------Exemplo 5----Texto ao Contrario-------------------------------------- 
Delimiter $$
CREATE FUNCTION Funcao_CONTRARIO (texto VARCHAR(50))
RETURNS VARCHAR(50) deterministic
BEGIN
set texto =( REVERSE(texto));
   RETURN texto;
END $$
Delimiter ;
SELECT Funcao_CONTRARIO('MARCELO') AS CONTRÁRIO;

#---------Exemplo 6------Raiz Quadrada------------------------------------
Delimiter $$
CREATE Function Raiz_Quadrada (numero int)
Returns int deterministic
 Begin
  Declare raiz Int;
  -- funcão dentro de uma função
  Set raiz= SQRT(numero);
  Return (raiz);
 End $$
Delimiter ;
Select Raiz_Quadrada (9) AS RAIZ_É;
#---------Exemplo 7------Quadrado de um Numero------------------------------------
Delimiter $$
CREATE FUNCTION Quadrado_Numero (numero INT)
RETURNS INT deterministic
BEGIN
IF(numero<10)THEN
set numero = numero*numero;
ELSE
SET numero=0;
END  IF;
RETURN numero;
END $$ 
 Delimiter ;
SELECT Quadrado_Numero(13) AS QUADRADO;
#---------Exemplo 8------Conta Caracteres em um texto------------------------------------
Delimiter $$
CREATE FUNCTION Tamanho_Palavra(Palavra Varchar(100))
RETURNS int deterministic
BEGIN
Declare Tamanho int;
SET Palavra = REPLACE(Palavra,' ','');
Set Tamanho = length(Palavra);
Return Tamanho;
END $$
Delimiter ;
Select Tamanho_Palavra ('Administracao de Banco de Dados')AS Tamanho_Palavra;




#---------Exemplo 9------Aumentar Limite Credito------------------------------------
Delimiter $$
CREATE FUNCTION Limite_Credito(id_Cliente INT, aumentoLimite double)
RETURNS double 
BEGIN
Declare lcn, resultado double;
SELECT limiteCredito INTO lcn FROM Clientes WHERE idCliente = id_Cliente;
SET resultado = lcn + (lcn * aumentoLimite / 100);
#UPDATE clientes SET limiteCredito = resultado WHERE idCliente = id_Cliente;
Return resultado;
END $$
Delimiter ;
Select Limite_Credito(5,10) AS "Novo Limite";

DROP FUNCTION Limite_Credito;

# usando a funcao que acabamos de criar

SELECT concat(nome," ",cpf) AS "Nome _CPF",
limiteCredito AS "Limite Antigo",
Limite_Credito(idCliente,10) AS "Limite Novo"
FROM clientes;
# -----   Exercicios Funcoes  ----
# 1 Crie uma Função que : pesquise um nome que termine com a letra S na tabela Fornecedores
Delimiter $$
CREATE FUNCTION Function1()
RETURNS VARCHAR(120)
BEGIN
	RETURN (
        SELECT nome
        FROM FORNECEDORES
        WHERE nome LIKE '%S'
    );
END $$
Delimiter ;
Select Function1() AS "Fornecedores terminando com S";

# 2 Crie uma Função que : Retire os seguintes caracteres do texto abaixo : * . - !
#   Ta*lvez v.ocê ain*da n.ão saiba o que é *SQL. Ma.s, -provavelm-ente, ente-nde que lidar com 
#   o gerenciamento é super importante.
#   d-e da-dos t+em se to+rna.do um d!!esafio cada vez maior
Delimiter $$
CREATE FUNCTION Function2(Texto TEXT)
RETURNS TEXT
BEGIN
	RETURN (
        Replace(Replace(Replace(Replace(Texto, '*', ''), '.', ''), '-', ''), '!', '')
    );
END $$
Delimiter ;
Select Function2("Ta*lvez v.ocê ain*da n.ão saiba o que é *SQL. Ma.s, -provavelm-ente, ente-nde que lidar com 
o gerenciamento é super importante.
d-e da-dos t+em se to+rna.do um d!!esafio cada vez maior") AS "Retirando * . - ! do texto";

# 3 Crie uma Função que : Calcule a média de 3 valores
Delimiter $$
CREATE FUNCTION Function3(Valor1 DOUBLE, Valor2 DOUBLE, Valor3 DOUBLE)
RETURNS DOUBLE
BEGIN
	RETURN (
        (Valor1 + Valor2 + Valor3)/3
    );
END $$
Delimiter ;
Select Function3(2, 3, 1) AS "Média dos 3 valores";

# 4 Crie uma Função que : Calcule a expressao : x+2(y-1)*5+x;
Delimiter $$
CREATE FUNCTION Function4(x DOUBLE, y DOUBLE)
RETURNS DOUBLE
BEGIN
	RETURN (
        x+2*(y-1)*5+x
    );
END $$
Delimiter ;
Select Function4(5, 6) AS "Calculando a expressao : x+2(y-1)*5+x";

# 5 Crie uma Função que : apresente um texto com palavras escritas ao contrario. 
#   precisam ser 3 palavras e todas devem ser palímdromos
Delimiter $$
CREATE FUNCTION Function5()
RETURNS DOUBLE
BEGIN
	RETURN (
        CONCAT(REVERSE('ovo'), ' ', REVERSE('arara'), ' ', REVERSE('radar'))
    );
END $$
Delimiter ;
Select Function5() AS "Palavras ao contrario";

# 6 Crie uma Função que : dê 5% de denconto em uma venda realizada.
Delimiter $$
CREATE FUNCTION Function6(ID_Venda INT)
RETURNS DOUBLE
BEGIN
	Declare resultado double;
	SELECT valorTotalPedido INTO resultdo FROM Pedidos WHERE idPedido = ID_Venda;
	SET resultado = resultado * 0.95;
	UPDATE PEDIDOS SET valorTotalPedido = resultado WHERE idPedido = ID_Venda;
	RETURN (
        SELECT valorTotalPedido INTO resultdo FROM Pedidos WHERE idPedido = ID_Venda
    );
END $$
Delimiter ;
Select Function6() AS "Aplicando 5% a uma venda";