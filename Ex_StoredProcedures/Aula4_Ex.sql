#---------------------------EXEMPLO 1 ---------------------------------------------------------------
# 1 Exemplo PROCEDURE SIMPLIFICADA
# 1 - ALTERANDO DELIMITADOR
DELIMITER $$ 
CREATE PROCEDURE EXEMPLO1() # 2 - CRIANDO A PROCEDURE
BEGIN # 3 - INICIANDO BLOCO DE CÓDIGO
SELECT country.LifeExpectancy FROM world.country
         WHERE name = "Brazil";
         # 4 - FIM DA PROCEDURE E ENCERRANDO O DELIMITADOR
END$$ 
# 5 - VOLTANDO O DELIMITADOR PARA O NORMAL
DELIMITER ; 

#CALL EXEMPLO1(); # 6 - CHAMANDO A PROCEDURE

#---------------------------EXEMPLO 2 ------------------------------------------------------------------
# 2 Exemplo PROCEDURE SIMPLIFICADA
delimiter // 
CREATE PROCEDURE Exemplo2() 
BEGIN 
SELECT country.Name, country.LifeExpectancy FROM country;
       
END//
delimiter ; 

#CALL Exemplo2();

#---------------------------EXEMPLO 3 ------------------------------------------------------------------
# 1 Exemplo PROCEDURE COM ENTRADA E SAÍDA
# CONTAGEM DE QUANTAS CIDADES POSSUEM NO SISTEMA COM O PAÍS BRASIL
# 1  - MUDA O DELIMITADOR
delimiter // 
# 2 - IN PARAMETRO DE ENTRADA
# 3 - OUT PARAMETRO DE SAÍDA
CREATE PROCEDURE citycount (IN country CHAR(3), OUT cities INT)  
       BEGIN # 4 - INICIO BLOCO DE CÓDIGO 
         SELECT COUNT(*) INTO cities FROM world.city
         WHERE CountryCode = country;
          # 5 - FIM BLOCO DE CODIGO E FIM DO DELIMITADOR
       END//
# 6 - VOLTANDO DELIMITER PARA ;
delimiter ; 


# CALL citycount('BRA', @cities); # 7 - CHAMANDA DA PROCEDURE USANDO OS PARAMETROS DE ENTRADA E SAÍDA
# SELECT @cities; # 8 - CHAMANDO A SAÍDA

#---------------------------EXEMPLO 4 ------------------------------------------------------------------
-- Criação de procedure com multiplos resultados	
delimiter $$
	CREATE PROCEDURE MuitosResultados() 
	BEGIN
		SELECT  * FROM CITY LIMIT 10;
		SELECT  * FROM COUNTRY LIMIT 10;
	END$$
delimiter ;
-- Execução de procedure			
#	CALL MuitosResultados();

#---------------------------EXEMPLO 5 ------- IN -----------------------------------------------------------
-- Criação de procedure com passagem de parametro
delimiter $$	
	CREATE PROCEDURE sp_passagem_parametro_simples(IN numCity char(4)) 
	BEGIN
		SELECT * FROM city
		WHERE ID =numCity;
	END$$
    delimiter ;
-- Execução de procedure	
	#CALL sp_passagem_parametro_simples(1); 
#---------------------------EXEMPLO 6  ----------------------------------------------------------

DELIMITER $$
 CREATE PROCEDURE sp_data_20seg()

BEGIN
SELECT SLEEP(20);
SELECT "AFTER SLEEPING 20 SECONDS, BYE!!!";
END$$
DELIMITER ;

#CALL sp_data_20seg();

#---------------------------EXEMPLO 7  ----------------------------------------------------------
DELIMITER $$
CREATE procedure new_employee(
    _ID INT,
    _Name char(100),
    _CountryCode char(3),
    _District char(20),
    _Population INT 
    )
BEGIN
    INSERT INTO CITY (ID,Name,CountryCode,District,Population) 
    VALUES (_ID, _Name,_CountryCode,_District,_Population);
END$$
DELIMITER ;

#call new_employee(26234,"teste", "BRA", "teste",123);

#---------------------------EXEMPLO 8 --- OUT ---------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE sp_Variaveis(OUT resultado INT)
BEGIN
    DECLARE var1, var2 int;
    SET var1 = (SELECT count(*) FROM countrylanguage WHERE CountryCode = "BRA" );
    SET var2 = (SELECT count(*) FROM countrylanguage WHERE CountryCode = "AUS" );
    SET resultado = var1 + var2;
END$$
DELIMITER ;
# call sp_Variaveis(@resultado);

#Select @resultado;

#---------------------------EXEMPLO 9 --- OUT -----------------------------------------------------------

DELIMITER $$
CREATE PROCEDURE sp_VerificaNumero(IN numero INT, OUT resultado char(10))
BEGIN
    DECLARE var1 int;
   IF MOD(numero,2) = 0 THEN
    SET resultado = "PAR";
    ELSE
    SET resultado = "IMPAR";
   END IF; 
END$$
DELIMITER ;

# CALL sp_VerificaNumero(3,@RESULTADO);
# SELECT @RESULTADO;
#---------------------------EXEMPLO 10 ---JOIN -----------------------------------------------------------
delimiter $$
CREATE PROCEDURE sp_join()
BEGIN
   SELECT country.name,city.name FROM CITY join country
   on country.Code = city.CountryCode GROUP BY country.name,city.name ;
END$$
delimiter ;
# call sp_join();
#----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
#---------------------------EXEMPLO 11 ---NAO EXECUTA!!!!!! ------------------

# delimiter $$
# CREATE PROCEDURE sp_TotalVendas()
# BEGIN
#    DECLARE total double;
#    SET total = (SELECT SUM(valorTotalPedido) from pedidos);
#    
# END$$
# delimiter ;

# call sp_TotalVendas();

#----SOLUÇÃO--------EXEMPLO 11 ---NAO EXECUTA!!!!!! ------------------------

# delimiter $$
# CREATE PROCEDURE sp_TotalVendas1(OUT total double)
# BEGIN
#    SET total = (SELECT SUM(valorTotalPedido) from pedidos);
# END$$
# delimiter ;
# call sp_TotalVendas1(@total);
# SELECT @total;
#----------EXEMPLO 12 ---------------------------
delimiter $$
CREATE PROCEDURE sp_Estoque(INOUT total double)
BEGIN

   SET total = (SELECT SUM(precoCompra*estoque) from produtos);
END$$
delimiter ;
# call sp_Estoque(@total);
# SELECT @total;

#----------EXEMPLO 13 ---------------------------
delimiter $$
CREATE PROCEDURE sp_EstoqueLucro(INOUT total double)
BEGIN
   SET total = (SELECT SUM(precoVenda*estoque)-SUM(precoCompra*estoque) from produtos);
END$$
delimiter ;
# call sp_EstoqueLucro(@total);
# SELECT @total;

#----------EXEMPLO 14 ---------------------------
DELIMITER $$
CREATE PROCEDURE sp_Lucro(IN valor INT,OUT message varchar(255))
BEGIN
    DECLARE codigoProduto INT;
    SET codigoProduto = (SELECT idProduto FROM produtos WHERE (precoVenda-precoCompra <valor));
    IF codigoProduto = null THEN
        SET message = "Nenhum produto encontrado";
    ELSE
        SET message = concat("O produto é código: ",codigoProduto);
    END IF;
    
END$$
DELIMITER ;

# call sp_Lucro (20,@message);
# SELECT @message;



#----------EXEMPLO 15 ---------------------------
DELIMITER $$
CREATE PROCEDURE sp_CTabela()
BEGIN
CREATE TABLE TESTE(id int primary key auto_increment,nome varchar(50));
END$$
DELIMITER ;

# call sp_CTabela ();

#----------EXEMPLO 16 ---------------------------
DELIMITER $$
CREATE PROCEDURE sp_ITabela()
BEGIN
INSERT INTO TESTE(nome)VALUES
('ANA'),
('MARIA'),
('TECLAUDIO');
END$$
DELIMITER ;

# call sp_ITabela ();




/* Exercicio 1
Crie uma Stored Procedure que calcule a média de quatro números 
inteiros informados como parâmetro. Retorne o resultado da 
operação e armazene os números e o resultado em uma tabela. 
Além dos números a tabela deve ter um ID como chave primaria, 
conter a data e o usuário que realizou a operação.
*/
DELIMITER $$
CREATE PROCEDURE SP_EX01(
	IN valor1 INT, 
    IN valor2 INT, 
    IN valor3 INT, 
    IN valor4 INT, 
    OUT result DOUBLE)
BEGIN
	SET result = (valor1 + valor2 + valor3 + valor4)/4;
    
	CREATE TABLE IF NOT EXISTS TABLE_SP_EX01 (
		id INT AUTO_INCREMENT PRIMARY KEY,
        valor1 INT NOT NULL,
		valor2 INT NOT NULL,
        valor3 INT NOT NULL,
        valor4 INT NOT NULL,
        media DOUBLE NOT NULL,
        dataOp date NOT NULL,
        usuario VARCHAR(90) NOT NULL
    );
    
    INSERT INTO TABLE_SP_EX01 VALUES (NULL, valor1, valor2, valor3, valor4, result, CURDATE(), USER());
    
END$$
DELIMITER ;

CALL SP_EX01(1, 2, 3, 4, @media);
SELECT @media;

/* Exercicio 2
Crie uma Stored Procedure que some quantos clientes tem no 
cadastro da loja_online  e quantos fornecedores tambem estão
cadastrados. Crie a tabela colaboradores e insira 5 tuplas. 

*/
DELIMITER $$
CREATE PROCEDURE SP_EX02()
BEGIN
    SELECT COUNT(clientes.idCliente) AS Clientes FROM clientes;
    SELECT COUNT(fornecedores.idFornecedor) AS fornecedores FROM fornecedores;
    
    CREATE TABLE IF NOT EXISTS colaboradores (
		idColaboradores INT AUTO_INCREMENT PRIMARY KEY,
        nome VARCHAR(60) NOT NULL,
        dataOp date NOT NULL,
        usuario VARCHAR(90) NOT NULL
    );
    
    INSERT INTO colaboradores 
    VALUES	(null, 'RAFAEL', CURDATE(), USER()), 
			(null, 'VITOR', CURDATE(), USER()),
			(null, 'ELENA', CURDATE(), USER()),
			(null, 'GABRIEL', CURDATE(), USER()),
			(null, 'ANA', CURDATE(), USER());
END$$
DELIMITER ;

CALL SP_EX02();
/* Exercicio 3
Crie uma Stored Procedure para resolver o problema de Mariana, 
ela quis usar uma fita para embrulhar um pacote. Após uma rápida 
medição notou que bastavam 45cm (quarenta e cinto centímetros) 
para embrulhar tal pacote. A papelaria aonde ela foi só vendia a fita por 
4.00 reais a cada metro. Quanto Mariana teve que pagar para ter o tamanho necessário de fita?  
Observe a tabela abaixo:
Metro Decímetro Centímetro Milímetro 
m        dm        cm         mm 
1m       0,1m     0,01m      0,001m
*/
DELIMITER $$
CREATE PROCEDURE SP_EX03(OUT result DOUBLE)
BEGIN
	DECLARE cm DOUBLE;
    DECLARE valor DOUBLE;
    
    SET valor = 4/100;
    SET cm = 45;
    
    SET result = valor*cm;
END$$
DELIMITER ;

CALL SP_EX03(@result);
SELECT @result;

/* Exercicio 4
 Crie uma Stored Procedure que leia um número e calcule o seu 
quadrado, ou seja, o produto de um número por si mesmo depois 
acrescente a esse numero a raiz quadrada de 81. Obs: deve-se 
fazer a conta da raiz quadrada na procedure também. 
*/
DELIMITER $$
CREATE PROCEDURE SP_EX04(IN valor INT, OUT result DOUBLE)
BEGIN
    SET result = POW(valor, 2) + SQRT(81);
END$$
DELIMITER ;

CALL SP_EX04(8, @result);
SELECT @result;

/* Exercicio 5
 No Brasil a taxa de imposto de um determinado carro é de 52%, na 
Argentina 21%, Crie uma Stored Procedure que apresente o custo 
total do carro em ambos os países. OBS: os valores apresentados 
são em reais para ambos os países.  
 Dados para calcular os valores: 
                   BRASIL                  ARGENTINA 
CUSTO TOTAL          ?                        ? 
CUSTO FABRICA      11000                    8000 
IMPOSTOS %          52                       21 
DISTRIBUIÇÃO_CUSTO 2450                     1100 
CONCESSIONÁRIA %    3.5                      1.5

*/
DELIMITER $$
CREATE PROCEDURE SP_EX05(OUT resultArg DOUBLE, OUT resultBra DOUBLE)
BEGIN
    SET resultArg = (8000 * 1.21 + 1100) * 1.015;
    SET resultBra = (11000 * 1.52 + 2450) * 1.035;
END$$
DELIMITER ;

CALL SP_EX05(@resultArg, @resultBra);
SELECT @resultArg AS "Preço(Argentina)", @resultBra AS "Preço(Brasil)";

/* Exercicio 6

Crie uma stored procedure onde se deve criar a tabela de 
Cardápio com os preços abaixo, crie também uma tabela consumo. 
Crie outra stored procedure que insere o consumo do cliente. Leia o 
código do cliente, código do produto o preço unitário a quantidade 
desse produto consumida e soma total de consumo do cliente. 
Exemplo id=1,cliente= joao , quantidade=2 refrigerantes, 
precounitario = 3 totalconsumido=6 
Cardapio: 
Hambúrguer................. R$ 3,00 
Cheeseburger.............. R$ 2,50 
Fritas............................ R$ 2,50 
Refrigerante................. R$ 1,00 
Milkshake..................... R$ 3,00 

*/
DELIMITER $$
CREATE PROCEDURE SP_EX06_01()
BEGIN
    CREATE TABLE IF NOT EXISTS cardapio (
		idCardapio INT AUTO_INCREMENT PRIMARY KEY,
        descricao VARCHAR(60) NOT NULL,
        preco DOUBLE NOT NULL
    );
    
    INSERT INTO cardapio 
    VALUES	(null, 'Hambúrguer', 3.0),
			(null, 'Cheeseburger', 2.5),
			(null, 'Fritas', 2.5),
			(null, 'Refrigerante', 1.0),
			(null, 'Milkshake', 3.0);
            
	CREATE TABLE IF NOT EXISTS consumocliente (
		idConsumoCliente INT AUTO_INCREMENT PRIMARY KEY,
        quantidade INT NOT NULL,
        fk_idCardapio INT NOT NULL,
        fk_idCliente INT NOT NULL,
        
        FOREIGN KEY (`fk_idCardapio`) REFERENCES `cardapio` (`idCardapio`),
		FOREIGN KEY (`fk_idCliente`) REFERENCES `clientes` (`idCliente`)
    );
      
	INSERT INTO consumocliente (quantidade, fk_idCardapio, fk_idCliente) VALUES
    (2, 1, 1),
    (1, 3, 2),
    (3, 4, 3),
    (1, 5, 4),
    (5, 2, 5);
END$$
DELIMITER ;

CALL SP_EX06_01();

DELIMITER $$
CREATE PROCEDURE SP_EX06_02(IN var_idCliente INT, IN var_idCardapio INT)
BEGIN
    SELECT CLI.idCliente, CLI.nome, CON.quantidade, CAR.descricao, CAR.preco, (CAR.preco * CON.quantidade) 
    FROM clientes AS CLI 
    JOIN consumocliente AS CON ON CLI.idCliente = CON.fk_idCliente 
    JOIN cardapio AS CAR ON CON.fk_idCardapio = CAR.idCardapio 
    WHERE CLI.idCliente = var_idCliente AND CAR.idCardapio = var_idCardapio;
END$$
DELIMITER ;

CALL SP_EX06_02(1, 1);